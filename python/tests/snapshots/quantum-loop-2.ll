; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@1 = private unnamed_addr constant [2 x i8] c"1\00", align 1

define void @__hugr__.main.1() #0 {
alloca_block:
  br label %cond_exit_309

cond_exit_309:                                    ; preds = %cond_exit_259._crit_edge, %alloca_block
  %"19_1.0.reg2mem.0.reg2mem.0" = phi i64 [ 10, %alloca_block ], [ %28, %cond_exit_259._crit_edge ]
  %"19_0.0.reg2mem.0.reg2mem.0" = phi i64 [ 0, %alloca_block ], [ %27, %cond_exit_259._crit_edge ]
  %0 = icmp slt i64 %"19_0.0.reg2mem.0.reg2mem.0", %"19_1.0.reg2mem.0.reg2mem.0"
  %1 = insertvalue { i1, i64, i64 } { i1 true, i64 poison, i64 poison }, i64 %"19_0.0.reg2mem.0.reg2mem.0", 1
  %2 = insertvalue { i1, i64, i64 } %1, i64 %"19_1.0.reg2mem.0.reg2mem.0", 2
  %"076.0" = select i1 %0, { i1, i64, i64 } %2, { i1, i64, i64 } { i1 false, i64 poison, i64 poison }
  %3 = extractvalue { i1, i64, i64 } %"076.0", 0
  br i1 %3, label %10, label %cond_exit_30

cond_59_case_1:                                   ; preds = %19
  call void @abort()
  br label %cond_exit_59

cond_74_case_1:                                   ; preds = %21
  %4 = extractvalue { i1, { { i64, i64 }, i64 } } %"1112.0", 1
  %.reload319.fca.0.0.extract = extractvalue { { i64, i64 }, i64 } %4, 0, 0
  %.reload319.fca.0.1.extract = extractvalue { { i64, i64 }, i64 } %4, 0, 1
  %.reload319.fca.1.extract = extractvalue { { i64, i64 }, i64 } %4, 1
  br label %cond_exit_259

cond_exit_259._crit_edge:                         ; preds = %cond_exit_259, %29
  br label %cond_exit_309

cond_exit_30:                                     ; preds = %cond_exit_309, %10
  %"053.0.reg2mem.sroa.0.0.reg2mem.0" = phi i1 [ %.reload315.fca.0.extract, %10 ], [ false, %cond_exit_309 ]
  %"053.0.reg2mem.sroa.3.0.reg2mem.0" = phi i64 [ %.reload315.fca.1.0.0.extract, %10 ], [ poison, %cond_exit_309 ]
  %"053.0.reg2mem.sroa.6.0.reg2mem.0" = phi i64 [ %.reload315.fca.1.0.1.extract, %10 ], [ poison, %cond_exit_309 ]
  %"053.0.reg2mem.sroa.9.0.reg2mem.0" = phi i64 [ %.reload315.fca.1.1.extract, %10 ], [ poison, %cond_exit_309 ]
  %"053.0.reload.fca.0.insert" = insertvalue { i1, { { i64, i64 }, i64 } } poison, i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", 0
  %"053.0.reload.fca.1.0.0.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.0.insert", i64 %"053.0.reg2mem.sroa.3.0.reg2mem.0", 1, 0, 0
  %"053.0.reload.fca.1.0.1.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.0.0.insert", i64 %"053.0.reg2mem.sroa.6.0.reg2mem.0", 1, 0, 1
  %"053.0.reload.fca.1.1.insert" = insertvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.0.1.insert", i64 %"053.0.reg2mem.sroa.9.0.reg2mem.0", 1, 1
  %5 = extractvalue { i1, { { i64, i64 }, i64 } } %"053.0.reload.fca.1.1.insert", 1
  %6 = insertvalue { i1, { { i64, i64 }, i64 } } { i1 true, { { i64, i64 }, i64 } poison }, { { i64, i64 }, i64 } %5, 1
  %"0111.0" = select i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", { i1, i1 } { i1 false, i1 true }, { i1, i1 } zeroinitializer
  %"1112.0" = select i1 %"053.0.reg2mem.sroa.0.0.reg2mem.0", { i1, { { i64, i64 }, i64 } } %6, { i1, { { i64, i64 }, i64 } } { i1 false, { { i64, i64 }, i64 } poison }
  %7 = extractvalue { i1, i1 } %"0111.0", 0
  %8 = extractvalue { i1, i1 } %"0111.0", 1
  %9 = extractvalue { i1, i1 } %"0111.0", 1
  %"0124.0" = select i1 %7, i1 %9, i1 %8
  br i1 %"0124.0", label %21, label %19

10:                                               ; preds = %cond_exit_309
  %11 = extractvalue { i1, i64, i64 } %"076.0", 1
  %12 = extractvalue { i1, i64, i64 } %"076.0", 2
  %13 = add i64 %11, 1
  %14 = insertvalue { i64, i64 } poison, i64 %13, 0
  %15 = insertvalue { i64, i64 } %14, i64 %12, 1
  %16 = insertvalue { { i64, i64 }, i64 } poison, i64 %11, 1
  %17 = insertvalue { { i64, i64 }, i64 } %16, { i64, i64 } %15, 0
  %18 = insertvalue { i1, { { i64, i64 }, i64 } } { i1 true, { { i64, i64 }, i64 } poison }, { { i64, i64 }, i64 } %17, 1
  %.reload315.fca.0.extract = extractvalue { i1, { { i64, i64 }, i64 } } %18, 0
  %.reload315.fca.1.0.0.extract = extractvalue { i1, { { i64, i64 }, i64 } } %18, 1, 0, 0
  %.reload315.fca.1.0.1.extract = extractvalue { i1, { { i64, i64 }, i64 } } %18, 1, 0, 1
  %.reload315.fca.1.1.extract = extractvalue { i1, { { i64, i64 }, i64 } } %18, 1, 1
  br label %cond_exit_30

19:                                               ; preds = %cond_exit_30
  %20 = extractvalue { i1, { { i64, i64 }, i64 } } %"1112.0", 0
  br i1 %20, label %cond_59_case_1, label %cond_exit_59

21:                                               ; preds = %cond_exit_30
  %22 = extractvalue { i1, { { i64, i64 }, i64 } } %"1112.0", 0
  br i1 %22, label %cond_74_case_1, label %cond_74_case_0

cond_exit_59:                                     ; preds = %19, %cond_59_case_1
  call void @__quantum__qis__mz__body(%Qubit* null, %Result* null)
  %23 = call i1 @__quantum__qis__read_result__body(%Result* null)
  call void @__quantum__rt__bool_record_output(i1 %23, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* inttoptr (i64 1 to %Result*))
  %24 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 1 to %Result*))
  call void @__quantum__rt__bool_record_output(i1 %24, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0))
  ret void

cond_74_case_0:                                   ; preds = %21
  call void @abort()
  br label %cond_exit_259

cond_exit_259:                                    ; preds = %cond_74_case_1, %cond_74_case_0
  %"0198.0.reg2mem.sroa.0.0.reg2mem.0" = phi i64 [ %.reload319.fca.0.0.extract, %cond_74_case_1 ], [ 0, %cond_74_case_0 ]
  %"0198.0.reg2mem.sroa.3.0.reg2mem.0" = phi i64 [ %.reload319.fca.0.1.extract, %cond_74_case_1 ], [ 0, %cond_74_case_0 ]
  %"0198.0.reg2mem.sroa.6.0.reg2mem.0" = phi i64 [ %.reload319.fca.1.extract, %cond_74_case_1 ], [ 0, %cond_74_case_0 ]
  %"0198.0.reload.fca.0.0.insert" = insertvalue { { i64, i64 }, i64 } poison, i64 %"0198.0.reg2mem.sroa.0.0.reg2mem.0", 0, 0
  %"0198.0.reload.fca.0.1.insert" = insertvalue { { i64, i64 }, i64 } %"0198.0.reload.fca.0.0.insert", i64 %"0198.0.reg2mem.sroa.3.0.reg2mem.0", 0, 1
  %"0198.0.reload.fca.1.insert" = insertvalue { { i64, i64 }, i64 } %"0198.0.reload.fca.0.1.insert", i64 %"0198.0.reg2mem.sroa.6.0.reg2mem.0", 1
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Result* inttoptr (i64 2 to %Result*))
  %25 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 2 to %Result*))
  %26 = extractvalue { { i64, i64 }, i64 } %"0198.0.reload.fca.1.insert", 0
  %27 = extractvalue { i64, i64 } %26, 0
  %28 = extractvalue { i64, i64 } %26, 1
  br i1 %25, label %29, label %cond_exit_259._crit_edge

29:                                               ; preds = %cond_exit_259
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  br label %cond_exit_259._crit_edge
}

declare void @abort()

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__rt__bool_record_output(i1, i8*)

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*)

declare void @__quantum__qis__rz__body(double, %Qubit*)

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="3" "required_num_results"="3" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
