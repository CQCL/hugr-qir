; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [2 x i8] c"1\00", align 1

define void @__hugr__.main.20() #0 {
alloca_block:
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x4012D97C7F3321D2, %Qubit* null)
  call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  call void @__quantum__qis__mz__body(%Qubit* null, %Result* null)
  %0 = call i1 @__quantum__qis__read_result__body(%Result* null)
  call void @__quantum__rt__bool_record_output(i1 %0, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0))
  ret void
}

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*)

declare void @__quantum__qis__rz__body(double, %Qubit*)

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__rt__bool_record_output(i1, i8*)

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="1" "required_num_results"="1" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
