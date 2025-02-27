import pyqir

x = pyqir.Module.from_ir(pyqir.Context(), """; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"

%QUBIT = type opaque
%RESULT = type opaque

@0 = private unnamed_addr constant [2 x i8] c"0\00", align 1

define void @__hugr__.main.1() {
alloca_block:
  %"15_0" = alloca { {} }, align 8
  %"14_0" = alloca { {} }, align 8
  %"11_0" = alloca { {} }, align 8
  %"9_0" = alloca %QUBIT*, align 8
  %"10_0" = alloca %QUBIT*, align 8
  %"12_0" = alloca { i32, {}, {} }, align 8
  br label %entry_block

entry_block:                                      ; preds = %alloca_block
  br label %0

0:                                                ; preds = %entry_block
  store { {} } undef, { {} }* %"15_0", align 1
  %"15_01" = load { {} }, { {} }* %"15_0", align 1
  store { {} } %"15_01", { {} }* %"15_0", align 1
  store { {} } undef, { {} }* %"14_0", align 1
  store { {} } undef, { {} }* %"11_0", align 1
  %1 = call %QUBIT* @__quantum__rt__qubit_allocate()
  store %QUBIT* %1, %QUBIT** %"9_0", align 8
  %"9_02" = load %QUBIT*, %QUBIT** %"9_0", align 8
  call void @__quantum__qis__h__body(%QUBIT* %"9_02")
  store %QUBIT* %"9_02", %QUBIT** %"10_0", align 8
  %"10_03" = load %QUBIT*, %QUBIT** %"10_0", align 8
  %2 = call %RESULT* @__quantum__qis__m__body(%QUBIT* %"10_03")
  %3 = call i1 @__quantum__qis__read_result__body(%RESULT* %2)
  call void @__quantum__rt__qubit_release(%QUBIT* %"10_03")
  %4 = select i1 %3, { i32, {}, {} } { i32 1, {} poison, {} undef }, { i32, {}, {} } { i32 0, {} undef, {} poison }
  store { i32, {}, {} } %4, { i32, {}, {} }* %"12_0", align 4
  %"12_04" = load { i32, {}, {} }, { i32, {}, {} }* %"12_0", align 4
  %5 = extractvalue { i32, {}, {} } %"12_04", 0
  %6 = trunc i32 %5 to i1
  call void @__quantum__rt__bool_record_output(i1 %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0))
  %"15_05" = load { {} }, { {} }* %"15_0", align 1
  switch i32 0, label %7 [
  ]

7:                                                ; preds = %0
  %8 = extractvalue { {} } %"15_05", 0
  br label %9

9:                                                ; preds = %7
  ret void
}

declare %QUBIT* @__quantum__rt__qubit_allocate()

declare void @__quantum__qis__h__body(%QUBIT*)

declare %RESULT* @__quantum__qis__m__body(%QUBIT*)

declare i1 @__quantum__qis__read_result__body(%RESULT*)

declare void @__quantum__rt__qubit_release(%QUBIT*)

declare void @__quantum__rt__bool_record_output(i1, i8*)""")