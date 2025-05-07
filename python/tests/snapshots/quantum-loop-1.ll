; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

define void @__hugr__.main.1() #0 {
alloca_block:
  br label %cond_exit_173

cond_exit_173:                                    ; preds = %cond_exit_71, %alloca_block
  %"19_1.0.reg2mem.0.reg2mem.0" = phi i64 [ 10, %alloca_block ], [ %24, %cond_exit_71 ]
  %"19_0.0.reg2mem.0.reg2mem.0" = phi i64 [ 0, %alloca_block ], [ %23, %cond_exit_71 ]
  %0 = icmp slt i64 %"19_0.0.reg2mem.0.reg2mem.0", %"19_1.0.reg2mem.0.reg2mem.0"
  %1 = insertvalue { i1, i64, i64 } { i1 true, i64 poison, i64 poison }, i64 %"19_0.0.reg2mem.0.reg2mem.0", 1
  %2 = insertvalue { i1, i64, i64 } %1, i64 %"19_1.0.reg2mem.0.reg2mem.0", 2
  %"059.0" = select i1 %0, { i1, i64, i64 } %2, { i1, i64, i64 } { i1 false, i64 poison, i64 poison }
  %3 = extractvalue { i1, i64, i64 } %"059.0", 0
  br i1 %3, label %7, label %cond_exit_30

cond_56_case_1:                                   ; preds = %16
  call void @abort()
  br label %cond_exit_56

cond_71_case_1:                                   ; preds = %18
  %4 = extractvalue { i1, { { i64, i64 }, i64 } } %"1.0", 1
  %.reload173.fca.0.0.extract = extractvalue { { i64, i64 }, i64 } %4, 0, 0
  %.reload173.fca.0.1.extract = extractvalue { { i64, i64 }, i64 } %4, 0, 1
  %.reload173.fca.1.extract = extractvalue { { i64, i64 }, i64 } %4, 1
  br label %cond_exit_71

cond_exit_30:                                     ; preds = %cond_exit_173, %7
  %"053.0.reg2mem.sroa.0.0.reg2mem.0" = phi i1 [ %.reload169.fca.0.extract, %7 ], [ false, %cond_exit_173 ]
  %"053.0.reg2mem.sroa.3.0.reg2mem.0" = phi i64 [ %.reload169.fca.1.0.0.extract, %7 ], [ poison, %cond_exit_173 ]
  %"053.0.reg2mem.sroa.6.0.reg2mem.0" = phi i64 [ %.reload169.fca.1.0.1.extract, %7 ], [ poison, %cond_exit_173 ]
  %"053.0.reg2mem.sroa.9.0.reg2mem.0" = phi i64 [ %.reload169.fca.1.1.extract, %7 ], [ poison, %cond_exit_173 ]
  %"053.0.reload.fca.0.insert" = insertvalue { i1, { { i64, i64 }, i64 } } poison, i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", 0
  %"053.0.reload.fca.1.0.0.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.0.insert", i64 %"053.0.reg2mem.sroa.3.0.reg2mem.0", 1, 0, 0
  %"053.0.reload.fca.1.0.1.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.0.0.insert", i64 %"053.0.reg2mem.sroa.6.0.reg2mem.0", 1, 0, 1
  %"053.0.reload.fca.1.1.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.0.1.insert", i64 %"053.0.reg2mem.sroa.9.0.reg2mem.0", 1, 1
  %5 = extractvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.1.insert", 1
  %6 = insertvalue { i1, { { i64, i64 }, i64 } } { i1 true, { { i64, i64 }, i64 } poison }, { { i64, i64 }, i64 } %5, 1
  %"1.0" = select i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", { i1, { { i64, i64 }, i64 } } %6, { i1, { { i64, i64 }, i64 } } { i1 false, { { i64, i64 }, i64 } poison }
  br i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", label %18, label %16

7:                                                ; preds = %cond_exit_173
  %8 = extractvalue { i1, i64, i64 } %"059.0", 1
  %9 = extractvalue { i1, i64, i64 } %"059.0", 2
  %10 = add i64 %8, 1
  %11 = insertvalue { i64, i64 } poison, i64 %10, 0
  %12 = insertvalue { i64, i64 } %11, i64 %9, 1
  %13 = insertvalue { { i64, i64 }, i64 } poison, i64 %8, 1
  %14 = insertvalue { { i64, i64 }, i64 } %13, { i64, i64 } %12, 0
  %15 = insertvalue { i1, { { i64, i64 }, i64 } } { i1 true, { { i64, i64 }, i64 } poison }, { { i64, i64 }, i64 } %14, 1
  %.reload169.fca.0.extract = extractvalue { i1, { { i64, i64 }, i64 } } %15, 0
  %.reload169.fca.1.0.0.extract = extractvalue { i1, { { i64, i64 }, i64 } } %15, 1, 0, 0
  %.reload169.fca.1.0.1.extract = extractvalue { i1, { { i64, i64 }, i64 } } %15, 1, 0, 1
  %.reload169.fca.1.1.extract = extractvalue { i1, { { i64, i64 }, i64 } } %15, 1, 1
  br label %cond_exit_30

16:                                               ; preds = %cond_exit_30
  %17 = extractvalue { i1, { { i64, i64 }, i64 } } %"1.0", 0
  br i1 %17, label %cond_56_case_1, label %cond_exit_56

18:                                               ; preds = %cond_exit_30
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  %19 = extractvalue { i1, { { i64, i64 }, i64 } } %"1.0", 0
  br i1 %19, label %cond_71_case_1, label %cond_71_case_0

cond_exit_56:                                     ; preds = %16, %cond_56_case_1
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* null)
  %20 = call i1 @__quantum__qis__read_result__body(%Result* null)
  call void @__quantum__qis__mz__body(%Qubit* null, %Result* inttoptr (i64 1 to %Result*))
  %21 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 1 to %Result*))
  call void @__quantum__rt__bool_record_output(i1 %20, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0))
  call void @__quantum__rt__bool_record_output(i1 %21, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0))
  ret void

cond_71_case_0:                                   ; preds = %18
  call void @abort()
  br label %cond_exit_71

cond_exit_71:                                     ; preds = %cond_71_case_1, %cond_71_case_0
  %"0140.0.reg2mem.sroa.0.0.reg2mem.0" = phi i64 [ %.reload173.fca.0.0.extract, %cond_71_case_1 ], [ 0, %cond_71_case_0 ]
  %"0140.0.reg2mem.sroa.3.0.reg2mem.0" = phi i64 [ %.reload173.fca.0.1.extract, %cond_71_case_1 ], [ 0, %cond_71_case_0 ]
  %"0140.0.reg2mem.sroa.6.0.reg2mem.0" = phi i64 [ %.reload173.fca.1.extract, %cond_71_case_1 ], [ 0, %cond_71_case_0 ]
  %"0140.0.reload.fca.0.0.insert" = insertvalue { { i64, i64 }, i64 } poison, i64 %"0140.0.reg2mem.sroa.0.0.reg2mem.0", 0, 0
  %"0140.0.reload.fca.0.1.insert" = insertvalue { { i64, i64 }, i64 } %"0140.0.reload.fca.0.0.insert", i64 %"0140.0.reg2mem.sroa.3.0.reg2mem.0", 0, 1
  %"0140.0.reload.fca.1.insert" = insertvalue { { i64, i64 }, i64 } %"0140.0.reload.fca.0.1.insert", i64 %"0140.0.reg2mem.sroa.6.0.reg2mem.0", 1
  %22 = extractvalue { { i64, i64 }, i64 } %"0140.0.reload.fca.1.insert", 0
  %23 = extractvalue { i64, i64 } %22, 0
  %24 = extractvalue { i64, i64 } %22, 1
  br label %cond_exit_173
}

declare void @abort()

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__rt__bool_record_output(i1, i8*)

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*)

declare void @__quantum__qis__rz__body(double, %Qubit*)

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="2" "required_num_results"="2" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
