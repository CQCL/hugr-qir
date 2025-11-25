; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [4 x i8] c"q_0\00", align 1
@1 = private unnamed_addr constant [4 x i8] c"q_1\00", align 1
@2 = private unnamed_addr constant [4 x i8] c"q_2\00", align 1
@3 = private unnamed_addr constant [4 x i8] c"q_3\00", align 1
@4 = private unnamed_addr constant [4 x i8] c"q_4\00", align 1
@5 = private unnamed_addr constant [4 x i8] c"q_5\00", align 1
@6 = private unnamed_addr constant [4 x i8] c"q_6\00", align 1
@7 = private unnamed_addr constant [4 x i8] c"q_7\00", align 1
@8 = private unnamed_addr constant [4 x i8] c"q_8\00", align 1
@9 = private unnamed_addr constant [4 x i8] c"q_9\00", align 1
@10 = private unnamed_addr constant [5 x i8] c"q_10\00", align 1
@11 = private unnamed_addr constant [5 x i8] c"q_11\00", align 1
@12 = private unnamed_addr constant [5 x i8] c"q_12\00", align 1
@13 = private unnamed_addr constant [5 x i8] c"q_13\00", align 1
@14 = private unnamed_addr constant [5 x i8] c"q_14\00", align 1
@15 = private unnamed_addr constant [5 x i8] c"q_15\00", align 1
@16 = private unnamed_addr constant [5 x i8] c"q_16\00", align 1
@17 = private unnamed_addr constant [5 x i8] c"q_17\00", align 1
@18 = private unnamed_addr constant [5 x i8] c"q_18\00", align 1
@19 = private unnamed_addr constant [5 x i8] c"q_19\00", align 1
@20 = private unnamed_addr constant [5 x i8] c"q2_0\00", align 1
@21 = private unnamed_addr constant [5 x i8] c"q2_1\00", align 1
@22 = private unnamed_addr constant [5 x i8] c"q2_2\00", align 1
@23 = private unnamed_addr constant [5 x i8] c"q2_3\00", align 1
@24 = private unnamed_addr constant [5 x i8] c"q2_4\00", align 1
@25 = private unnamed_addr constant [5 x i8] c"q2_5\00", align 1
@26 = private unnamed_addr constant [5 x i8] c"q2_6\00", align 1
@27 = private unnamed_addr constant [5 x i8] c"q2_7\00", align 1
@28 = private unnamed_addr constant [5 x i8] c"q2_8\00", align 1
@29 = private unnamed_addr constant [5 x i8] c"q2_9\00", align 1
@30 = private unnamed_addr constant [6 x i8] c"q2_10\00", align 1
@31 = private unnamed_addr constant [6 x i8] c"q2_11\00", align 1
@32 = private unnamed_addr constant [6 x i8] c"q2_12\00", align 1
@33 = private unnamed_addr constant [6 x i8] c"q2_13\00", align 1
@34 = private unnamed_addr constant [6 x i8] c"q2_14\00", align 1
@35 = private unnamed_addr constant [6 x i8] c"q2_15\00", align 1
@36 = private unnamed_addr constant [6 x i8] c"q2_16\00", align 1
@37 = private unnamed_addr constant [6 x i8] c"q2_17\00", align 1
@38 = private unnamed_addr constant [6 x i8] c"q2_18\00", align 1
@39 = private unnamed_addr constant [6 x i8] c"q2_19\00", align 1

define dso_local void @__hugr__.main.1() local_unnamed_addr #0 {
alloca_block:
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* null)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* null)
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* null, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* null)
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0xBFDE28C731EB6950, %Qubit* null, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x3FDE28C731EB6950, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*), %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*), %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*), %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*), %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0xBFDE28C731EB6950, %Qubit* nonnull inttoptr (i64 4 to %Qubit*), %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x3FDE28C731EB6950, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*), %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*), %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*), %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*), %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0xBFDE28C731EB6950, %Qubit* nonnull inttoptr (i64 8 to %Qubit*), %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x3FDE28C731EB6950, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*), %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*), %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*), %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*), %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0xBFDE28C731EB6950, %Qubit* nonnull inttoptr (i64 12 to %Qubit*), %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x3FDE28C731EB6950, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*), %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*), %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*), %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*), %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0xBFDE28C731EB6950, %Qubit* nonnull inttoptr (i64 16 to %Qubit*), %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x3FDE28C731EB6950, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*), %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 19 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*), %Qubit* nonnull inttoptr (i64 19 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 19 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 19 to %Qubit*))
  tail call void @___random_seed(i64 12)
  %rintb = tail call i32 @___random_int_bounded(i32 4)
  %Pivot6181 = icmp slt i32 %rintb, 2
  br i1 %Pivot6181, label %NodeBlock, label %NodeBlock6178

NodeBlock6178:                                    ; preds = %alloca_block
  br label %NodeBlock6231

NodeBlock6231:                                    ; preds = %NodeBlock6178
  %Pivot = icmp slt i32 %rintb, 3
  br i1 %Pivot, label %cond_exit_3706.sink.split, label %LeafBlock

LeafBlock:                                        ; preds = %NodeBlock6231
  %SwitchLeaf = icmp eq i32 %rintb, 3
  br i1 %SwitchLeaf, label %cond_exit_3706.sink.split.fold.split, label %NewDefault

NodeBlock:                                        ; preds = %alloca_block
  br label %NodeBlock6235

NodeBlock6235:                                    ; preds = %NodeBlock
  %Pivot6236 = icmp slt i32 %rintb, 1
  br i1 %Pivot6236, label %LeafBlock6233, label %cond_exit_3706.sink.split

LeafBlock6233:                                    ; preds = %NodeBlock6235
  %SwitchLeaf6234 = icmp eq i32 %rintb, 0
  br i1 %SwitchLeaf6234, label %cond_exit_3706.sink.split.fold.split6226, label %NewDefault6232

cond_exit_3706.sink.split.fold.split:             ; preds = %LeafBlock
  br label %cond_exit_3706.sink.split

cond_exit_3706.sink.split.fold.split6226:         ; preds = %LeafBlock6233
  br label %cond_exit_3706.sink.split

cond_exit_3706.sink.split:                        ; preds = %NodeBlock6235, %NodeBlock6231, %cond_exit_3706.sink.split.fold.split6226, %cond_exit_3706.sink.split.fold.split
  %.sink6167 = phi %Qubit* [ inttoptr (i64 21 to %Qubit*), %NodeBlock6235 ], [ inttoptr (i64 22 to %Qubit*), %NodeBlock6231 ], [ inttoptr (i64 23 to %Qubit*), %cond_exit_3706.sink.split.fold.split ], [ inttoptr (i64 20 to %Qubit*), %cond_exit_3706.sink.split.fold.split6226 ]
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull %.sink6167)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull %.sink6167)
  br label %cond_exit_3706

NewDefault:                                       ; preds = %LeafBlock
  br label %cond_exit_3706

NewDefault6232:                                   ; preds = %LeafBlock6233
  br label %cond_exit_3706

cond_exit_3706:                                   ; preds = %NewDefault6232, %NewDefault, %cond_exit_3706.sink.split
  %rintb1259 = tail call i32 @___random_int_bounded(i32 4)
  %Pivot6192 = icmp slt i32 %rintb1259, 2
  br i1 %Pivot6192, label %NodeBlock6185, label %NodeBlock6189

NodeBlock6189:                                    ; preds = %cond_exit_3706
  br label %NodeBlock6240

NodeBlock6240:                                    ; preds = %NodeBlock6189
  %Pivot6241 = icmp slt i32 %rintb1259, 3
  br i1 %Pivot6241, label %cond_exit_3510.sink.split, label %LeafBlock6238

LeafBlock6238:                                    ; preds = %NodeBlock6240
  %SwitchLeaf6239 = icmp eq i32 %rintb1259, 3
  br i1 %SwitchLeaf6239, label %cond_exit_3510.sink.split.fold.split, label %NewDefault6237

NodeBlock6185:                                    ; preds = %cond_exit_3706
  br label %NodeBlock6245

NodeBlock6245:                                    ; preds = %NodeBlock6185
  %Pivot6246 = icmp slt i32 %rintb1259, 1
  br i1 %Pivot6246, label %LeafBlock6243, label %cond_exit_3510.sink.split

LeafBlock6243:                                    ; preds = %NodeBlock6245
  %SwitchLeaf6244 = icmp eq i32 %rintb1259, 0
  br i1 %SwitchLeaf6244, label %cond_exit_3510.sink.split.fold.split6227, label %NewDefault6242

cond_exit_3510.sink.split.fold.split:             ; preds = %LeafBlock6238
  br label %cond_exit_3510.sink.split

cond_exit_3510.sink.split.fold.split6227:         ; preds = %LeafBlock6243
  br label %cond_exit_3510.sink.split

cond_exit_3510.sink.split:                        ; preds = %NodeBlock6245, %NodeBlock6240, %cond_exit_3510.sink.split.fold.split6227, %cond_exit_3510.sink.split.fold.split
  %.sink6169 = phi %Qubit* [ inttoptr (i64 25 to %Qubit*), %NodeBlock6245 ], [ inttoptr (i64 26 to %Qubit*), %NodeBlock6240 ], [ inttoptr (i64 27 to %Qubit*), %cond_exit_3510.sink.split.fold.split ], [ inttoptr (i64 24 to %Qubit*), %cond_exit_3510.sink.split.fold.split6227 ]
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull %.sink6169)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull %.sink6169)
  br label %cond_exit_3510

NewDefault6237:                                   ; preds = %LeafBlock6238
  br label %cond_exit_3510

NewDefault6242:                                   ; preds = %LeafBlock6243
  br label %cond_exit_3510

cond_exit_3510:                                   ; preds = %NewDefault6242, %NewDefault6237, %cond_exit_3510.sink.split
  %rintb1629 = tail call i32 @___random_int_bounded(i32 4)
  %Pivot6203 = icmp slt i32 %rintb1629, 2
  br i1 %Pivot6203, label %NodeBlock6196, label %NodeBlock6200

NodeBlock6200:                                    ; preds = %cond_exit_3510
  br label %NodeBlock6250

NodeBlock6250:                                    ; preds = %NodeBlock6200
  %Pivot6251 = icmp slt i32 %rintb1629, 3
  br i1 %Pivot6251, label %cond_exit_3314.sink.split, label %LeafBlock6248

LeafBlock6248:                                    ; preds = %NodeBlock6250
  %SwitchLeaf6249 = icmp eq i32 %rintb1629, 3
  br i1 %SwitchLeaf6249, label %cond_exit_3314.sink.split.fold.split, label %NewDefault6247

NodeBlock6196:                                    ; preds = %cond_exit_3510
  br label %NodeBlock6255

NodeBlock6255:                                    ; preds = %NodeBlock6196
  %Pivot6256 = icmp slt i32 %rintb1629, 1
  br i1 %Pivot6256, label %LeafBlock6253, label %cond_exit_3314.sink.split

LeafBlock6253:                                    ; preds = %NodeBlock6255
  %SwitchLeaf6254 = icmp eq i32 %rintb1629, 0
  br i1 %SwitchLeaf6254, label %cond_exit_3314.sink.split.fold.split6228, label %NewDefault6252

cond_exit_3314.sink.split.fold.split:             ; preds = %LeafBlock6248
  br label %cond_exit_3314.sink.split

cond_exit_3314.sink.split.fold.split6228:         ; preds = %LeafBlock6253
  br label %cond_exit_3314.sink.split

cond_exit_3314.sink.split:                        ; preds = %NodeBlock6255, %NodeBlock6250, %cond_exit_3314.sink.split.fold.split6228, %cond_exit_3314.sink.split.fold.split
  %.sink6171 = phi %Qubit* [ inttoptr (i64 29 to %Qubit*), %NodeBlock6255 ], [ inttoptr (i64 30 to %Qubit*), %NodeBlock6250 ], [ inttoptr (i64 31 to %Qubit*), %cond_exit_3314.sink.split.fold.split ], [ inttoptr (i64 28 to %Qubit*), %cond_exit_3314.sink.split.fold.split6228 ]
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull %.sink6171)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull %.sink6171)
  br label %cond_exit_3314

NewDefault6247:                                   ; preds = %LeafBlock6248
  br label %cond_exit_3314

NewDefault6252:                                   ; preds = %LeafBlock6253
  br label %cond_exit_3314

cond_exit_3314:                                   ; preds = %NewDefault6252, %NewDefault6247, %cond_exit_3314.sink.split
  %rintb1999 = tail call i32 @___random_int_bounded(i32 4)
  %Pivot6214 = icmp slt i32 %rintb1999, 2
  br i1 %Pivot6214, label %NodeBlock6207, label %NodeBlock6211

NodeBlock6211:                                    ; preds = %cond_exit_3314
  br label %NodeBlock6260

NodeBlock6260:                                    ; preds = %NodeBlock6211
  %Pivot6261 = icmp slt i32 %rintb1999, 3
  br i1 %Pivot6261, label %cond_exit_3118.sink.split, label %LeafBlock6258

LeafBlock6258:                                    ; preds = %NodeBlock6260
  %SwitchLeaf6259 = icmp eq i32 %rintb1999, 3
  br i1 %SwitchLeaf6259, label %cond_exit_3118.sink.split.fold.split, label %NewDefault6257

NodeBlock6207:                                    ; preds = %cond_exit_3314
  br label %NodeBlock6265

NodeBlock6265:                                    ; preds = %NodeBlock6207
  %Pivot6266 = icmp slt i32 %rintb1999, 1
  br i1 %Pivot6266, label %LeafBlock6263, label %cond_exit_3118.sink.split

LeafBlock6263:                                    ; preds = %NodeBlock6265
  %SwitchLeaf6264 = icmp eq i32 %rintb1999, 0
  br i1 %SwitchLeaf6264, label %cond_exit_3118.sink.split.fold.split6229, label %NewDefault6262

cond_718_case_1.sink.split.fold.split:            ; preds = %LeafBlock6268
  br label %cond_718_case_1.sink.split

cond_718_case_1.sink.split.fold.split6230:        ; preds = %LeafBlock6273
  br label %cond_718_case_1.sink.split

cond_718_case_1.sink.split:                       ; preds = %NodeBlock6275, %NodeBlock6270, %cond_718_case_1.sink.split.fold.split6230, %cond_718_case_1.sink.split.fold.split
  %.sink6173 = phi %Qubit* [ inttoptr (i64 37 to %Qubit*), %NodeBlock6275 ], [ inttoptr (i64 38 to %Qubit*), %NodeBlock6270 ], [ inttoptr (i64 39 to %Qubit*), %cond_718_case_1.sink.split.fold.split ], [ inttoptr (i64 36 to %Qubit*), %cond_718_case_1.sink.split.fold.split6230 ]
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull %.sink6173)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull %.sink6173)
  br label %cond_718_case_1

NewDefault6267:                                   ; preds = %LeafBlock6268
  br label %cond_718_case_1

NewDefault6272:                                   ; preds = %LeafBlock6273
  br label %cond_718_case_1

cond_718_case_1:                                  ; preds = %NewDefault6272, %NewDefault6267, %cond_718_case_1.sink.split
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 19 to %Qubit*), %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 19 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*), %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 18 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*), %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 17 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*), %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 16 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*), %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 15 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*), %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 14 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*), %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 13 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*), %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 12 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*), %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 11 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*), %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 10 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*), %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 9 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*), %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 8 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*), %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 7 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*), %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 6 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*), %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 5 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*), %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 4 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*), %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 3 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*), %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 2 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*), %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 1 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  tail call void @__quantum__qis__phasedx__body(double 0xBFF921FB54442D18, double 0x3FF921FB54442D18, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  tail call void @__quantum__qis__rzz__body(double 0x3FF921FB54442D18, %Qubit* null, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* null)
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* null, %Result* null)
  %0 = tail call i1 @__quantum__qis__read_result__body(%Result* null)
  tail call void @__quantum__rt__bool_record_output(i1 %0, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @0, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 1 to %Qubit*), %Result* nonnull inttoptr (i64 1 to %Result*))
  %1 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 1 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %1, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @1, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 2 to %Qubit*), %Result* nonnull inttoptr (i64 2 to %Result*))
  %2 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 2 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %2, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @2, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 3 to %Qubit*), %Result* nonnull inttoptr (i64 3 to %Result*))
  %3 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 3 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %3, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @3, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 4 to %Qubit*), %Result* nonnull inttoptr (i64 4 to %Result*))
  %4 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 4 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %4, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @4, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 5 to %Qubit*), %Result* nonnull inttoptr (i64 5 to %Result*))
  %5 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 5 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %5, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @5, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 6 to %Qubit*), %Result* nonnull inttoptr (i64 6 to %Result*))
  %6 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 6 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %6, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @6, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 7 to %Qubit*), %Result* nonnull inttoptr (i64 7 to %Result*))
  %7 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 7 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %7, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @7, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 8 to %Qubit*), %Result* nonnull inttoptr (i64 8 to %Result*))
  %8 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 8 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %8, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @8, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 9 to %Qubit*), %Result* nonnull inttoptr (i64 9 to %Result*))
  %9 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 9 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %9, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @9, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 10 to %Qubit*), %Result* nonnull inttoptr (i64 10 to %Result*))
  %10 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 10 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %10, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @10, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 11 to %Qubit*), %Result* nonnull inttoptr (i64 11 to %Result*))
  %11 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 11 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @11, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 12 to %Qubit*), %Result* nonnull inttoptr (i64 12 to %Result*))
  %12 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 12 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %12, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @12, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 13 to %Qubit*), %Result* nonnull inttoptr (i64 13 to %Result*))
  %13 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 13 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %13, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @13, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 14 to %Qubit*), %Result* nonnull inttoptr (i64 14 to %Result*))
  %14 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 14 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %14, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @14, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 15 to %Qubit*), %Result* nonnull inttoptr (i64 15 to %Result*))
  %15 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 15 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %15, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @15, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 16 to %Qubit*), %Result* nonnull inttoptr (i64 16 to %Result*))
  %16 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 16 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %16, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @16, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 17 to %Qubit*), %Result* nonnull inttoptr (i64 17 to %Result*))
  %17 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 17 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %17, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @17, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 18 to %Qubit*), %Result* nonnull inttoptr (i64 18 to %Result*))
  %18 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 18 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %18, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @18, i64 0, i64 0))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 19 to %Qubit*), %Result* nonnull inttoptr (i64 19 to %Result*))
  %19 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 19 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %19, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @19, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 40 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 40 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 40 to %Qubit*), %Result* nonnull inttoptr (i64 20 to %Result*))
  %20 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 20 to %Result*))
  br i1 %20, label %24, label %cond_2675_case_1

cond_exit_3118.sink.split.fold.split:             ; preds = %LeafBlock6258
  br label %cond_exit_3118.sink.split

cond_exit_3118.sink.split.fold.split6229:         ; preds = %LeafBlock6263
  br label %cond_exit_3118.sink.split

cond_exit_3118.sink.split:                        ; preds = %NodeBlock6265, %NodeBlock6260, %cond_exit_3118.sink.split.fold.split6229, %cond_exit_3118.sink.split.fold.split
  %.sink6175 = phi %Qubit* [ inttoptr (i64 33 to %Qubit*), %NodeBlock6265 ], [ inttoptr (i64 34 to %Qubit*), %NodeBlock6260 ], [ inttoptr (i64 35 to %Qubit*), %cond_exit_3118.sink.split.fold.split ], [ inttoptr (i64 32 to %Qubit*), %cond_exit_3118.sink.split.fold.split6229 ]
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull %.sink6175)
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull %.sink6175)
  br label %cond_exit_3118

NewDefault6257:                                   ; preds = %LeafBlock6258
  br label %cond_exit_3118

NewDefault6262:                                   ; preds = %LeafBlock6263
  br label %cond_exit_3118

cond_exit_3118:                                   ; preds = %NewDefault6262, %NewDefault6257, %cond_exit_3118.sink.split
  %rintb2369 = tail call i32 @___random_int_bounded(i32 4)
  %Pivot6225 = icmp slt i32 %rintb2369, 2
  br i1 %Pivot6225, label %NodeBlock6218, label %NodeBlock6222

NodeBlock6222:                                    ; preds = %cond_exit_3118
  br label %NodeBlock6270

NodeBlock6270:                                    ; preds = %NodeBlock6222
  %Pivot6271 = icmp slt i32 %rintb2369, 3
  br i1 %Pivot6271, label %cond_718_case_1.sink.split, label %LeafBlock6268

LeafBlock6268:                                    ; preds = %NodeBlock6270
  %SwitchLeaf6269 = icmp eq i32 %rintb2369, 3
  br i1 %SwitchLeaf6269, label %cond_718_case_1.sink.split.fold.split, label %NewDefault6267

NodeBlock6218:                                    ; preds = %cond_exit_3118
  br label %NodeBlock6275

NodeBlock6275:                                    ; preds = %NodeBlock6218
  %Pivot6276 = icmp slt i32 %rintb2369, 1
  br i1 %Pivot6276, label %LeafBlock6273, label %cond_718_case_1.sink.split

LeafBlock6273:                                    ; preds = %NodeBlock6275
  %SwitchLeaf6274 = icmp eq i32 %rintb2369, 0
  br i1 %SwitchLeaf6274, label %cond_718_case_1.sink.split.fold.split6230, label %NewDefault6272

cond_2675_case_1:                                 ; preds = %cond_718_case_1, %24
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 20 to %Qubit*), %Result* nonnull inttoptr (i64 21 to %Result*))
  %21 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 21 to %Result*))
  br i1 %21, label %25, label %cond_1004_case_1

cond_1004_case_1:                                 ; preds = %cond_2675_case_1, %25
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 21 to %Qubit*), %Result* nonnull inttoptr (i64 22 to %Result*))
  %22 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 22 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %21, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @20, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %22, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @21, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 41 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 41 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 41 to %Qubit*), %Result* nonnull inttoptr (i64 23 to %Result*))
  %23 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 23 to %Result*))
  br i1 %23, label %29, label %cond_2538_case_1

24:                                               ; preds = %cond_718_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 20 to %Qubit*))
  br label %cond_2675_case_1

25:                                               ; preds = %cond_2675_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 21 to %Qubit*))
  br label %cond_1004_case_1

cond_2538_case_1:                                 ; preds = %cond_1004_case_1, %29
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 22 to %Qubit*), %Result* nonnull inttoptr (i64 24 to %Result*))
  %26 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 24 to %Result*))
  br i1 %26, label %30, label %cond_1024_case_1

cond_1024_case_1:                                 ; preds = %cond_2538_case_1, %30
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 23 to %Qubit*), %Result* nonnull inttoptr (i64 25 to %Result*))
  %27 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 25 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %26, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @22, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %27, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @23, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 42 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 42 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 42 to %Qubit*), %Result* nonnull inttoptr (i64 26 to %Result*))
  %28 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 26 to %Result*))
  br i1 %28, label %34, label %cond_2401_case_1

29:                                               ; preds = %cond_1004_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 22 to %Qubit*))
  br label %cond_2538_case_1

30:                                               ; preds = %cond_2538_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 23 to %Qubit*))
  br label %cond_1024_case_1

cond_2401_case_1:                                 ; preds = %cond_1024_case_1, %34
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 24 to %Qubit*), %Result* nonnull inttoptr (i64 27 to %Result*))
  %31 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 27 to %Result*))
  br i1 %31, label %35, label %cond_1044_case_1

cond_1044_case_1:                                 ; preds = %cond_2401_case_1, %35
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 25 to %Qubit*), %Result* nonnull inttoptr (i64 28 to %Result*))
  %32 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 28 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %31, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @24, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %32, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @25, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 43 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 43 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 43 to %Qubit*), %Result* nonnull inttoptr (i64 29 to %Result*))
  %33 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 29 to %Result*))
  br i1 %33, label %39, label %cond_2264_case_1

34:                                               ; preds = %cond_1024_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 24 to %Qubit*))
  br label %cond_2401_case_1

35:                                               ; preds = %cond_2401_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 25 to %Qubit*))
  br label %cond_1044_case_1

cond_2264_case_1:                                 ; preds = %cond_1044_case_1, %39
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 26 to %Qubit*), %Result* nonnull inttoptr (i64 30 to %Result*))
  %36 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 30 to %Result*))
  br i1 %36, label %40, label %cond_1064_case_1

cond_1064_case_1:                                 ; preds = %cond_2264_case_1, %40
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 27 to %Qubit*), %Result* nonnull inttoptr (i64 31 to %Result*))
  %37 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 31 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %36, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @26, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %37, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @27, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 44 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 44 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 44 to %Qubit*), %Result* nonnull inttoptr (i64 32 to %Result*))
  %38 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 32 to %Result*))
  br i1 %38, label %44, label %cond_2127_case_1

39:                                               ; preds = %cond_1044_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 26 to %Qubit*))
  br label %cond_2264_case_1

40:                                               ; preds = %cond_2264_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 27 to %Qubit*))
  br label %cond_1064_case_1

cond_2127_case_1:                                 ; preds = %cond_1064_case_1, %44
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 28 to %Qubit*), %Result* nonnull inttoptr (i64 33 to %Result*))
  %41 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 33 to %Result*))
  br i1 %41, label %45, label %cond_1084_case_1

cond_1084_case_1:                                 ; preds = %cond_2127_case_1, %45
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 29 to %Qubit*), %Result* nonnull inttoptr (i64 34 to %Result*))
  %42 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 34 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %41, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @28, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %42, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @29, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 45 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 45 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 45 to %Qubit*), %Result* nonnull inttoptr (i64 35 to %Result*))
  %43 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 35 to %Result*))
  br i1 %43, label %49, label %cond_1990_case_1

44:                                               ; preds = %cond_1064_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 28 to %Qubit*))
  br label %cond_2127_case_1

45:                                               ; preds = %cond_2127_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 29 to %Qubit*))
  br label %cond_1084_case_1

cond_1990_case_1:                                 ; preds = %cond_1084_case_1, %49
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 30 to %Qubit*), %Result* nonnull inttoptr (i64 36 to %Result*))
  %46 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 36 to %Result*))
  br i1 %46, label %50, label %cond_1104_case_1

cond_1104_case_1:                                 ; preds = %cond_1990_case_1, %50
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 31 to %Qubit*), %Result* nonnull inttoptr (i64 37 to %Result*))
  %47 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 37 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %46, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @30, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %47, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @31, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 46 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 46 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 46 to %Qubit*), %Result* nonnull inttoptr (i64 38 to %Result*))
  %48 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 38 to %Result*))
  br i1 %48, label %54, label %cond_1853_case_1

49:                                               ; preds = %cond_1084_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 30 to %Qubit*))
  br label %cond_1990_case_1

50:                                               ; preds = %cond_1990_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 31 to %Qubit*))
  br label %cond_1104_case_1

cond_1853_case_1:                                 ; preds = %cond_1104_case_1, %54
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 32 to %Qubit*), %Result* nonnull inttoptr (i64 39 to %Result*))
  %51 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 39 to %Result*))
  br i1 %51, label %55, label %cond_1124_case_1

cond_1124_case_1:                                 ; preds = %cond_1853_case_1, %55
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 33 to %Qubit*), %Result* nonnull inttoptr (i64 40 to %Result*))
  %52 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 40 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %51, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @32, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %52, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @33, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 47 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 47 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 47 to %Qubit*), %Result* nonnull inttoptr (i64 41 to %Result*))
  %53 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 41 to %Result*))
  br i1 %53, label %59, label %cond_1716_case_1

54:                                               ; preds = %cond_1104_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 32 to %Qubit*))
  br label %cond_1853_case_1

55:                                               ; preds = %cond_1853_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 33 to %Qubit*))
  br label %cond_1124_case_1

cond_1716_case_1:                                 ; preds = %cond_1124_case_1, %59
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 34 to %Qubit*), %Result* nonnull inttoptr (i64 42 to %Result*))
  %56 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 42 to %Result*))
  br i1 %56, label %60, label %cond_1144_case_1

cond_1144_case_1:                                 ; preds = %cond_1716_case_1, %60
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 35 to %Qubit*), %Result* nonnull inttoptr (i64 43 to %Result*))
  %57 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 43 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %56, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @34, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %57, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @35, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 48 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 48 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 48 to %Qubit*), %Result* nonnull inttoptr (i64 44 to %Result*))
  %58 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 44 to %Result*))
  br i1 %58, label %64, label %cond_1579_case_1

59:                                               ; preds = %cond_1124_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 34 to %Qubit*))
  br label %cond_1716_case_1

60:                                               ; preds = %cond_1716_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 35 to %Qubit*))
  br label %cond_1144_case_1

cond_1579_case_1:                                 ; preds = %cond_1144_case_1, %64
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 36 to %Qubit*), %Result* nonnull inttoptr (i64 45 to %Result*))
  %61 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 45 to %Result*))
  br i1 %61, label %65, label %cond_1164_case_1

cond_1164_case_1:                                 ; preds = %cond_1579_case_1, %65
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 37 to %Qubit*), %Result* nonnull inttoptr (i64 46 to %Result*))
  %62 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 46 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %61, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @36, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %62, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @37, i64 0, i64 0))
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 49 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 49 to %Qubit*))
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 49 to %Qubit*), %Result* nonnull inttoptr (i64 47 to %Result*))
  %63 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 47 to %Result*))
  br i1 %63, label %68, label %cond_1442_case_1

64:                                               ; preds = %cond_1144_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 36 to %Qubit*))
  br label %cond_1579_case_1

65:                                               ; preds = %cond_1579_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 37 to %Qubit*))
  br label %cond_1164_case_1

cond_1442_case_1:                                 ; preds = %cond_1164_case_1, %68
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 38 to %Qubit*), %Result* nonnull inttoptr (i64 48 to %Result*))
  %66 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 48 to %Result*))
  br i1 %66, label %69, label %cond_1184_case_1

cond_1184_case_1:                                 ; preds = %cond_1442_case_1, %69
  tail call void @__quantum__qis__mz__body(%Qubit* nonnull inttoptr (i64 39 to %Qubit*), %Result* nonnull inttoptr (i64 49 to %Result*))
  %67 = tail call i1 @__quantum__qis__read_result__body(%Result* nonnull inttoptr (i64 49 to %Result*))
  tail call void @__quantum__rt__bool_record_output(i1 %66, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @38, i64 0, i64 0))
  tail call void @__quantum__rt__bool_record_output(i1 %67, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @39, i64 0, i64 0))
  ret void

68:                                               ; preds = %cond_1164_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 38 to %Qubit*))
  br label %cond_1442_case_1

69:                                               ; preds = %cond_1442_case_1
  tail call void @__quantum__qis__phasedx__body(double 0x3FF921FB54442D18, double 0xBFF921FB54442D18, %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  tail call void @__quantum__qis__rz__body(double 0x400921FB54442D18, %Qubit* nonnull inttoptr (i64 39 to %Qubit*))
  br label %cond_1184_case_1
}

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*) local_unnamed_addr

declare void @__quantum__qis__rz__body(double, %Qubit*) local_unnamed_addr

declare void @__quantum__qis__rzz__body(double, %Qubit*, %Qubit*) local_unnamed_addr

declare void @___random_seed(i64) local_unnamed_addr

declare i32 @___random_int_bounded(i32) local_unnamed_addr

declare void @__quantum__qis__mz__body(%Qubit*, %Result*) local_unnamed_addr

declare i1 @__quantum__qis__read_result__body(%Result*) local_unnamed_addr

declare void @__quantum__rt__bool_record_output(i1, i8*) local_unnamed_addr

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="50" "required_num_results"="50" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
