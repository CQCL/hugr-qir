use hugr::hugr::hugrmut::HugrMut;
use hugr::Node;
use anyhow::{Result, anyhow};
use hugr::algorithms::call_graph::{CallGraph, CallGraphEdge};
use hugr::hugr::rewrite::inline_call::InlineCall;
use petgraph::algo::toposort;
use petgraph::visit::{EdgeFiltered, IntoEdges};

pub fn inline(hugr: &mut impl HugrMut, nodes: Vec<Node>) -> Result<()> {
    for node in &nodes {
        if !hugr.get_optype(*node).is_call(){
            return Err(anyhow!("node type mismatch"));
        }
    }
    let call_graph = CallGraph::new(hugr);
    let filtered_call_graph = EdgeFiltered::from_fn(call_graph.graph(), |e| match e.weight() {
        CallGraphEdge::Call(n) => nodes.contains(&n),
        _ => false,
    });
    let to_inline = toposort(&filtered_call_graph, None).unwrap();
    for func_index in to_inline.iter().rev(){
           for call in filtered_call_graph.edges(*func_index) {
               match call.weight() {
                   CallGraphEdge::Call(n) => {
                       let rewrite = InlineCall::new(*n);
                       hugr.apply_rewrite(rewrite)?;
                   }
                   _ => {}
               }
           }
    }
    Ok(())
}
