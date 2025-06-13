; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@1 = private unnamed_addr constant [2 x i8] c"b\00", align 1

define void @__hugr__.main.1() #0 {
alloca_block:
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  call void @__quantum__qis__mz__body(%Qubit* null, %Result* inttoptr (i64 2 to %Result*))
  %0 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 2 to %Result*))
  %1 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %0, 1
  %2 = extractvalue { i1, i1 } %1, 0
  %3 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %0, 1
  %4 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %0, 1
  %5 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %0, 1
  %6 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %0, 1
  %"039.0" = select i1 %2, { i1, i1 } %6, { i1, i1 } %4
  %"1.0" = select i1 %2, { i1, i1 } %5, { i1, i1 } %3
  %7 = extractvalue { i1, i1 } %"039.0", 0
  %8 = extractvalue { i1, i1 } %"039.0", 1
  %9 = extractvalue { i1, i1 } %"039.0", 1
  %"060.0" = select i1 %7, i1 %9, i1 %8
  br i1 %"060.0", label %cond_exit_65, label %10

cond_exit_178:                                    ; preds = %cond_exit_65, %10
  %"55_1.0.reg2mem.sroa.3.0.reg2mem.0" = phi i1 [ %"51_1.0.reload.fca.1.extract", %cond_exit_65 ], [ %11, %10 ]
  %"55_0.0.reg2mem.sroa.3.0.reg2mem.0" = phi i1 [ %"51_0.0.reload.fca.1.extract", %cond_exit_65 ], [ %"1.0.reload.fca.1.extract", %10 ]
  call void @__quantum__rt__bool_record_output(i1 %"55_0.0.reg2mem.sroa.3.0.reg2mem.0", i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0))
  call void @__quantum__rt__bool_record_output(i1 %"55_1.0.reg2mem.sroa.3.0.reg2mem.0", i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0))
  ret void

10:                                               ; preds = %alloca_block
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* inttoptr (i64 1 to %Result*))
  %11 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 1 to %Result*))
  %"1.0.reload.fca.1.extract" = extractvalue { i1, i1 } %"1.0", 1
  br label %cond_exit_178

cond_exit_65:                                     ; preds = %alloca_block
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* null)
  %12 = call i1 @__quantum__qis__read_result__body(%Result* null)
  %13 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %12, 1
  %14 = extractvalue { i1, i1 } %13, 0
  %15 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %12, 1
  %16 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %12, 1
  %17 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %12, 1
  %18 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %12, 1
  %"090.0" = select i1 %14, { i1, i1 } %18, { i1, i1 } %16
  %"191.0" = select i1 %14, { i1, i1 } %17, { i1, i1 } %15
  %19 = extractvalue { i1, i1 } %"090.0", 0
  %20 = extractvalue { i1, i1 } %"090.0", 1
  %21 = extractvalue { i1, i1 } %"090.0", 1
  %"0112.0" = select i1 %19, i1 %21, i1 %20
  %22 = insertvalue { i1, { i1, i1 }, { i1, i1 } } { i1 false, { i1, i1 } poison, { i1, i1 } poison }, { i1, i1 } %"1.0", 1
  %23 = insertvalue { i1, { i1, i1 }, { i1, i1 } } %22, { i1, i1 } %"191.0", 2
  %24 = insertvalue { i1, { i1, i1 }, { i1, i1 } } { i1 true, { i1, i1 } poison, { i1, i1 } poison }, { i1, i1 } %"1.0", 1
  %"0125.0" = select i1 %"0112.0", { i1, { i1, i1 }, { i1, i1 } } %24, { i1, { i1, i1 }, { i1, i1 } } %23
  %25 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"0125.0", 0
  %26 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"0125.0", 1
  %27 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"0125.0", 2
  %28 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"0125.0", 1
  %"51_1.0" = select i1 %25, { i1, i1 } zeroinitializer, { i1, i1 } %27
  %"51_0.0" = select i1 %25, { i1, i1 } %28, { i1, i1 } %26
  %"51_0.0.reload.fca.1.extract" = extractvalue { i1, i1 } %"51_0.0", 1
  %"51_1.0.reload.fca.1.extract" = extractvalue { i1, i1 } %"51_1.0", 1
  br label %cond_exit_178
}

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*)

declare void @__quantum__qis__rz__body(double, %Qubit*)

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__rt__bool_record_output(i1, i8*)

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="2" "required_num_results"="3" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
