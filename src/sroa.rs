use std::{collections::HashMap, marker::PhantomData, slice};

use anyhow::Result;
use clap::error::KindFormatter;
use hugr_llvm::inkwell::{self, builder::Builder, module::Module, types::StructType, values::{AnyValueEnum, AsValueRef as _, BasicValue, BasicValueEnum, InstructionOpcode, InstructionValue, StructValue}};
use itertools::Itertools as _;

fn llvm_get_indices(i: InstructionValue) -> Vec<usize> {
    let n = unsafe { inkwell::llvm_sys::core::LLVMGetNumIndices(i.as_value_ref()) };
    let indices = unsafe { inkwell::llvm_sys::core::LLVMGetIndices(i.as_value_ref()) };
    unsafe { slice::from_raw_parts(indices, n as usize) }.iter().map(|&x| x as usize).collect()
}

fn replace_all_uses_with<'c>(builder: &Builder<'c>, i: InstructionValue<'c>, v: impl BasicValue<'c>) -> Result<()>{
    let v = v.as_basic_value_enum();
    let replacement = v.as_instruction_value().unwrap();
    // not sure if this is actually required
    // } else {
    //     let bb = builder.get_insert_block().unwrap();
    //     let first_bb = bb.get_parent().unwrap().get_first_basic_block().unwrap();
    //     if let Some(first_instruction) = first_bb.get_first_instruction() {
    //         builder.position_before(&first_instruction);
    //     } else {
    //         builder.position_at_end(first_bb);
    //     }
    //     let alloca = builder.build_alloca(v.get_type(), "sroa_temp")?;
    //     builder.build_store(alloca, v)?;
    //     builder.position_at_end(bb);
    //     builder.build_load(alloca, "sroa_temp_load")?.as_instruction_value().unwrap() // pretty sure this will work
    // };
    i.replace_all_uses_with(&replacement);
    i.erase_from_basic_block();
    Ok(())

}

#[derive(Clone, Debug)]
enum Node<'c> {
    Leaf(BasicValueEnum<'c>),
    Branch(StructType<'c>, Vec<Node<'c>>),
}

impl<'c> Node<'c> {
    pub fn try_from_const(agg: StructValue<'c>) -> Option<Self> {
        if !agg.is_const() {
            None?
        }
        let children = agg.get_fields().map(|x| {
            match x.try_into().ok() {
                Some(struct_value) => Self::try_from_const(struct_value).unwrap(),
                None => Self::Leaf(x)
            }
        }).collect();
        Some(Self::Branch(agg.get_type(), children))
    }

    pub fn lookup(&self, indices: &[usize]) -> Result<BasicValueEnum<'c>> {
        match self {
            Self::Leaf(value) => {
                assert!(indices.is_empty());
                Ok(*value)
            }
            Node::Branch(ty, children) => {
                if !indices.is_empty() {
                    children[indices[0]].lookup(&indices[1..])
                } else {
                    let mut result = ty.get_poison();
                    for (i, child) in children.iter().enumerate() {
                        // result = builder.build_insert_value(result, child.lookup(builder, &[])?, i as u32, "sroa_insert")?.into_struct_value();
                    }
                    Ok(result.as_basic_value_enum())
                }
            }
        }
    }

    pub fn set(&mut self, indices: &[usize], node: Self) {
        if indices.is_empty() {
            *self = node;
            return
        }
        match self {
            Node::Branch(_, children) => {
                children[indices[0]].set(&indices[1..], node);
            }
            _ => {
                panic!("indicies must be empty for leaf nodes");
            }
        }
    }

    pub fn unwrap_leaf(self) -> BasicValueEnum<'c> {
        match self {
            Node::Leaf(value) => value,
            _ => panic!("Node is not a leaf"),
        }
    }
}


struct Sroa<'c> {
    struct_values: HashMap<StructValue<'c>, Node<'c>>,
}

impl<'c> Sroa<'c> {
    pub fn new() -> Self {
        Sroa {
            struct_values: Default::default(),
        }
    }

    pub fn set(&mut self, op: StructValue<'c>, agg: StructValue<'c>, inserted_value: BasicValueEnum<'c>, indices: impl AsRef<[usize]>) {
        let mut node = Node::try_from_const(agg).unwrap_or_else(|| {
            self.struct_values.get(&agg).unwrap().clone()
        });

        let insert_node = StructValue::try_from(inserted_value).ok().and_then(|s| self.struct_values.get(&s).cloned()).unwrap_or(Node::Leaf(inserted_value));

        node.set(&indices.as_ref(), insert_node);
        let overwritten = self.struct_values.insert(op, node).is_some();
        assert!(!overwritten);
    }

    // pub fn lookup(&self, agg: StructValue<'c>, indices: impl AsRef<[usize]>) -> Option<BasicValueEnum<'c>> {
    //     Some(self.struct_values.get(&agg)?.lookup(indices).clone().unwrap_leaf())
    // }
}

pub fn sroa<'c>(module: &Module<'c>) -> Result<()> {
    let builder = module.get_context().create_builder();
    let mut state = Sroa::new();
    for function in module.get_functions() {
        for bb in function.get_basic_blocks() {
            for instruction in bb.get_instructions() {
                match instruction.get_opcode() {
                    InstructionOpcode::ExtractValue if !instruction.get_type().is_struct_type() => {
                        // let Some(agg) = instruction.get_operand(0).unwrap().unwrap_left().try_into().ok() else {
                        //     continue;
                        // };
                        // let Some(replacement_value) = state.lookup(agg, llvm_get_indices(instruction)) else {
                        //     continue;
                        // };
                        // replace_all_uses_with(&builder, instruction, replacement_value)?;
                    }
                    InstructionOpcode::InsertValue => {
                        // let Some(agg) = instruction.get_operand(0).unwrap().unwrap_left().try_into().ok() else {
                        //     continue;
                        // };
                        // let inserted_value = instruction.get_operand(1).unwrap().unwrap_left();
                        // sroa.set(instruction, agg, inserted_value, llvm_get_indices(instruction));
                    }

                    _ => ()

                }

            }
        }
    }
    Ok(())
}
