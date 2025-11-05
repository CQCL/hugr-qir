; ModuleID = 'hugr-qir'
source_filename = "hugr-qir"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%Qubit = type opaque
%Result = type opaque

@0 = private unnamed_addr constant [38 x i8] c"No more qubits available to allocate.\00", align 1
@1 = private unnamed_addr constant [38 x i8] c"No more qubits available to allocate.\00", align 1
@2 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@3 = private unnamed_addr constant [2 x i8] c"b\00", align 1

define dso_local void @__hugr__.main.1() #0 {
alloca_block:
  %"20_0" = alloca { i1, i1 }, align 8
  %"20_1" = alloca %Qubit*, align 8
  %"36_0" = alloca { i1, i1 }, align 8
  %"36_1" = alloca %Qubit*, align 8
  %"41_0" = alloca { i1, i1 }, align 8
  %"47_0" = alloca { i1, i1 }, align 8
  %"47_1" = alloca { i1, i1 }, align 8
  %"51_0" = alloca { i1, i1 }, align 8
  %"51_1" = alloca { i1, i1 }, align 8
  %"55_0" = alloca { i1, i1 }, align 8
  %"55_1" = alloca { i1, i1 }, align 8
  %"17_0" = alloca i1, align 1
  %"65_0" = alloca { i1, i1 }, align 8
  %"11_1" = alloca %Qubit*, align 8
  %"15_0" = alloca { i1, i1 }, align 8
  %"0" = alloca i1, align 1
  %"117_0" = alloca i1, align 1
  %"03" = alloca i1, align 1
  %"119_0" = alloca i1, align 1
  %"13_0" = alloca {}, align 8
  %"8_0" = alloca %Qubit*, align 8
  %"228_0" = alloca { i1, %Qubit* }, align 8
  %"229_0" = alloca %Qubit*, align 8
  %"07" = alloca %Qubit*, align 8
  %"235_0" = alloca { i32, i8* }, align 8
  %"236_0" = alloca %Qubit*, align 8
  %"011" = alloca %Qubit*, align 8
  %"237_0" = alloca %Qubit*, align 8
  %"9_0" = alloca %Qubit*, align 8
  %"215_0" = alloca { i1, %Qubit* }, align 8
  %"216_0" = alloca %Qubit*, align 8
  %"016" = alloca %Qubit*, align 8
  %"222_0" = alloca { i32, i8* }, align 8
  %"223_0" = alloca %Qubit*, align 8
  %"020" = alloca %Qubit*, align 8
  %"224_0" = alloca %Qubit*, align 8
  %"10_0" = alloca { %Qubit*, %Qubit* }, align 8
  %"11_0" = alloca %Qubit*, align 8
  %"12_0" = alloca %Qubit*, align 8
  %"203_0" = alloca %Qubit*, align 8
  %"210_0" = alloca double, align 8
  %"208_0" = alloca double, align 8
  %"211_0" = alloca %Qubit*, align 8
  %"206_0" = alloca double, align 8
  %"212_0" = alloca %Qubit*, align 8
  %"14_0" = alloca { i1, i1 }, align 8
  %"96_0" = alloca %Qubit*, align 8
  %"98_0" = alloca i1, align 1
  %"99_0" = alloca { i1, i1 }, align 8
  %"65_1" = alloca { i1, i1 }, align 8
  %"039" = alloca { i1, i1 }, align 8
  %"1" = alloca { i1, i1 }, align 8
  %"042" = alloca i1, align 1
  %"101_0" = alloca i1, align 1
  %"104_0" = alloca { i1, i1 }, align 8
  %"103_0" = alloca { i1, i1 }, align 8
  %"048" = alloca i1, align 1
  %"106_0" = alloca i1, align 1
  %"108_0" = alloca i1, align 1
  %"108_1" = alloca i1, align 1
  %"111_0" = alloca i1, align 1
  %"113_0" = alloca i1, align 1
  %"113_1" = alloca i1, align 1
  %"110_0" = alloca { i1, i1 }, align 8
  %"109_0" = alloca { i1, i1 }, align 8
  %"123_0" = alloca { i1, i1 }, align 8
  %"125_0" = alloca i1, align 1
  %"060" = alloca i1, align 1
  %"062" = alloca i1, align 1
  %"128_0" = alloca i1, align 1
  %"065" = alloca i1, align 1
  %"130_0" = alloca i1, align 1
  %"132_0" = alloca i1, align 1
  %"26_0" = alloca { i1, { i1, i1 }, { i1, i1 } }, align 8
  %"23_0" = alloca {}, align 8
  %"22_0" = alloca %Qubit*, align 8
  %"193_0" = alloca %Qubit*, align 8
  %"200_0" = alloca double, align 8
  %"198_0" = alloca double, align 8
  %"201_0" = alloca %Qubit*, align 8
  %"196_0" = alloca double, align 8
  %"202_0" = alloca %Qubit*, align 8
  %"24_0" = alloca { i1, i1 }, align 8
  %"133_0" = alloca %Qubit*, align 8
  %"135_0" = alloca i1, align 1
  %"136_0" = alloca { i1, i1 }, align 8
  %"64_0" = alloca { i1, i1 }, align 8
  %"64_1" = alloca { i1, i1 }, align 8
  %"090" = alloca { i1, i1 }, align 8
  %"191" = alloca { i1, i1 }, align 8
  %"094" = alloca i1, align 1
  %"138_0" = alloca i1, align 1
  %"141_0" = alloca { i1, i1 }, align 8
  %"140_0" = alloca { i1, i1 }, align 8
  %"0100" = alloca i1, align 1
  %"143_0" = alloca i1, align 1
  %"145_0" = alloca i1, align 1
  %"145_1" = alloca i1, align 1
  %"148_0" = alloca i1, align 1
  %"150_0" = alloca i1, align 1
  %"150_1" = alloca i1, align 1
  %"147_0" = alloca { i1, i1 }, align 8
  %"146_0" = alloca { i1, i1 }, align 8
  %"25_0" = alloca i1, align 1
  %"152_0" = alloca { i1, i1 }, align 8
  %"154_0" = alloca i1, align 1
  %"0112" = alloca i1, align 1
  %"0114" = alloca i1, align 1
  %"157_0" = alloca i1, align 1
  %"0117" = alloca i1, align 1
  %"159_0" = alloca i1, align 1
  %"161_0" = alloca i1, align 1
  %"0125" = alloca { i1, { i1, i1 }, { i1, i1 } }, align 8
  %"0127" = alloca { i1, i1 }, align 8
  %"1128" = alloca { i1, i1 }, align 8
  %"28_0" = alloca { i1, i1 }, align 8
  %"28_1" = alloca { i1, i1 }, align 8
  %"30_0" = alloca { i1, { i1, i1 }, { i1, i1 } }, align 8
  %"0134" = alloca { i1, i1 }, align 8
  %"1135" = alloca { i1, i1 }, align 8
  %"32_0" = alloca { i1, i1 }, align 8
  %"32_1" = alloca { i1, i1 }, align 8
  %"0139" = alloca i1, align 1
  %"188_0" = alloca i1, align 1
  %"0141" = alloca i1, align 1
  %"190_0" = alloca i1, align 1
  %"34_0" = alloca { i1, { i1, i1 }, { i1, i1 } }, align 8
  %"39_0" = alloca {}, align 8
  %"38_0" = alloca { i1, i1 }, align 8
  %"162_0" = alloca %Qubit*, align 8
  %"164_0" = alloca i1, align 1
  %"165_0" = alloca { i1, i1 }, align 8
  %"45_0" = alloca {}, align 8
  %"43_0" = alloca { i1, i1 }, align 8
  %"49_0" = alloca {}, align 8
  %"53_0" = alloca {}, align 8
  %"63_0" = alloca {}, align 8
  %"62_0" = alloca {}, align 8
  %"60_0" = alloca i1, align 1
  %"176_0" = alloca { i1, i1 }, align 8
  %"178_0" = alloca i1, align 1
  %"0187" = alloca i1, align 1
  %"0189" = alloca i1, align 1
  %"181_0" = alloca i1, align 1
  %"0192" = alloca i1, align 1
  %"183_0" = alloca i1, align 1
  %"185_0" = alloca i1, align 1
  %"59_0" = alloca {}, align 8
  %"57_0" = alloca i1, align 1
  %"166_0" = alloca { i1, i1 }, align 8
  %"168_0" = alloca i1, align 1
  %"0199" = alloca i1, align 1
  %"0201" = alloca i1, align 1
  %"171_0" = alloca i1, align 1
  %"0204" = alloca i1, align 1
  %"173_0" = alloca i1, align 1
  %"175_0" = alloca i1, align 1
  br label %entry_block

entry_block:                                      ; preds = %alloca_block
  br label %0

0:                                                ; preds = %entry_block
  store { i1, i1 } zeroinitializer, { i1, i1 }* %"15_0", align 1
  %"15_01" = load { i1, i1 }, { i1, i1 }* %"15_0", align 1
  %1 = extractvalue { i1, i1 } %"15_01", 0
  switch i1 %1, label %2 [
    i1 true, label %4
  ]

2:                                                ; preds = %0
  %3 = extractvalue { i1, i1 } %"15_01", 1
  store i1 %3, i1* %"0", align 1
  br label %cond_114_case_0

4:                                                ; preds = %0
  %5 = extractvalue { i1, i1 } %"15_01", 1
  store i1 %5, i1* %"03", align 1
  br label %cond_114_case_1

6:                                                ; preds = %66
  %"20_076" = load { i1, i1 }, { i1, i1 }* %"20_0", align 1
  %"20_177" = load %Qubit*, %Qubit** %"20_1", align 8
  store { i1, i1 } %"20_076", { i1, i1 }* %"20_0", align 1
  store %Qubit* %"20_177", %Qubit** %"20_1", align 8
  store {} undef, {}* %"23_0", align 1
  %"20_178" = load %Qubit*, %Qubit** %"20_1", align 8
  store %Qubit* %"20_178", %Qubit** %"193_0", align 8
  store double 0xBFF921FB54442D18, double* %"200_0", align 8
  store double 0x3FF921FB54442D18, double* %"198_0", align 8
  %"193_079" = load %Qubit*, %Qubit** %"193_0", align 8
  %"198_080" = load double, double* %"198_0", align 8
  %"200_081" = load double, double* %"200_0", align 8
  call void @__quantum__qis__phasedx__body(double %"198_080", double %"200_081", %Qubit* %"193_079")
  store %Qubit* %"193_079", %Qubit** %"201_0", align 8
  store double 0x400921FB54442D18, double* %"196_0", align 8
  %"201_082" = load %Qubit*, %Qubit** %"201_0", align 8
  %"196_083" = load double, double* %"196_0", align 8
  call void @__quantum__qis__rz__body(double %"196_083", %Qubit* %"201_082")
  store %Qubit* %"201_082", %Qubit** %"202_0", align 8
  %"202_084" = load %Qubit*, %Qubit** %"202_0", align 8
  store %Qubit* %"202_084", %Qubit** %"22_0", align 8
  %"22_085" = load %Qubit*, %Qubit** %"22_0", align 8
  store %Qubit* %"22_085", %Qubit** %"133_0", align 8
  %"133_086" = load %Qubit*, %Qubit** %"133_0", align 8
  call void @__quantum__qis__mz__body(%Qubit* %"133_086", %Result* null)
  %7 = call i1 @__quantum__qis__read_result__body(%Result* null)
  %8 = select i1 %7, i1 true, i1 false
  store i1 %8, i1* %"135_0", align 1
  %"135_087" = load i1, i1* %"135_0", align 1
  %9 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"135_087", 1
  store { i1, i1 } %9, { i1, i1 }* %"136_0", align 1
  %"136_088" = load { i1, i1 }, { i1, i1 }* %"136_0", align 1
  store { i1, i1 } %"136_088", { i1, i1 }* %"24_0", align 1
  %"24_089" = load { i1, i1 }, { i1, i1 }* %"24_0", align 1
  %10 = extractvalue { i1, i1 } %"24_089", 0
  switch i1 %10, label %11 [
    i1 true, label %13
  ]

11:                                               ; preds = %6
  %12 = extractvalue { i1, i1 } %"24_089", 1
  store i1 %12, i1* %"094", align 1
  br label %cond_64_case_0

13:                                               ; preds = %6
  %14 = extractvalue { i1, i1 } %"24_089", 1
  store i1 %14, i1* %"0100", align 1
  br label %cond_64_case_1

15:                                               ; preds = %65
  %"36_0148" = load { i1, i1 }, { i1, i1 }* %"36_0", align 1
  %"36_1149" = load %Qubit*, %Qubit** %"36_1", align 8
  store { i1, i1 } %"36_0148", { i1, i1 }* %"36_0", align 1
  store %Qubit* %"36_1149", %Qubit** %"36_1", align 8
  store {} undef, {}* %"39_0", align 1
  %"36_1150" = load %Qubit*, %Qubit** %"36_1", align 8
  store %Qubit* %"36_1150", %Qubit** %"162_0", align 8
  %"162_0151" = load %Qubit*, %Qubit** %"162_0", align 8
  call void @__quantum__qis__mz__body(%Qubit* %"162_0151", %Result* inttoptr (i64 1 to %Result*))
  %16 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 1 to %Result*))
  %17 = select i1 %16, i1 true, i1 false
  store i1 %17, i1* %"164_0", align 1
  %"164_0152" = load i1, i1* %"164_0", align 1
  %18 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"164_0152", 1
  store { i1, i1 } %18, { i1, i1 }* %"165_0", align 1
  %"165_0153" = load { i1, i1 }, { i1, i1 }* %"165_0", align 1
  store { i1, i1 } %"165_0153", { i1, i1 }* %"38_0", align 1
  %"39_0154" = load {}, {}* %"39_0", align 1
  %"36_0155" = load { i1, i1 }, { i1, i1 }* %"36_0", align 1
  %"38_0156" = load { i1, i1 }, { i1, i1 }* %"38_0", align 1
  store {} %"39_0154", {}* %"39_0", align 1
  store { i1, i1 } %"36_0155", { i1, i1 }* %"36_0", align 1
  store { i1, i1 } %"38_0156", { i1, i1 }* %"38_0", align 1
  %"39_0157" = load {}, {}* %"39_0", align 1
  %"36_0158" = load { i1, i1 }, { i1, i1 }* %"36_0", align 1
  %"38_0159" = load { i1, i1 }, { i1, i1 }* %"38_0", align 1
  switch i1 false, label %19 [
  ]

19:                                               ; preds = %15
  store { i1, i1 } %"36_0158", { i1, i1 }* %"55_0", align 1
  store { i1, i1 } %"38_0159", { i1, i1 }* %"55_1", align 1
  br label %26

20:                                               ; preds = %90
  %"41_0160" = load { i1, i1 }, { i1, i1 }* %"41_0", align 1
  store { i1, i1 } %"41_0160", { i1, i1 }* %"41_0", align 1
  store {} undef, {}* %"45_0", align 1
  store { i1, i1 } zeroinitializer, { i1, i1 }* %"43_0", align 1
  %"45_0161" = load {}, {}* %"45_0", align 1
  %"41_0162" = load { i1, i1 }, { i1, i1 }* %"41_0", align 1
  %"43_0163" = load { i1, i1 }, { i1, i1 }* %"43_0", align 1
  store {} %"45_0161", {}* %"45_0", align 1
  store { i1, i1 } %"41_0162", { i1, i1 }* %"41_0", align 1
  store { i1, i1 } %"43_0163", { i1, i1 }* %"43_0", align 1
  %"45_0164" = load {}, {}* %"45_0", align 1
  %"41_0165" = load { i1, i1 }, { i1, i1 }* %"41_0", align 1
  %"43_0166" = load { i1, i1 }, { i1, i1 }* %"43_0", align 1
  switch i1 false, label %21 [
  ]

21:                                               ; preds = %20
  store { i1, i1 } %"41_0165", { i1, i1 }* %"51_0", align 1
  store { i1, i1 } %"43_0166", { i1, i1 }* %"51_1", align 1
  br label %24

22:                                               ; preds = %87
  %"47_0167" = load { i1, i1 }, { i1, i1 }* %"47_0", align 1
  %"47_1168" = load { i1, i1 }, { i1, i1 }* %"47_1", align 1
  store { i1, i1 } %"47_0167", { i1, i1 }* %"47_0", align 1
  store { i1, i1 } %"47_1168", { i1, i1 }* %"47_1", align 1
  store {} undef, {}* %"49_0", align 1
  %"49_0169" = load {}, {}* %"49_0", align 1
  %"47_0170" = load { i1, i1 }, { i1, i1 }* %"47_0", align 1
  %"47_1171" = load { i1, i1 }, { i1, i1 }* %"47_1", align 1
  store {} %"49_0169", {}* %"49_0", align 1
  store { i1, i1 } %"47_0170", { i1, i1 }* %"47_0", align 1
  store { i1, i1 } %"47_1171", { i1, i1 }* %"47_1", align 1
  %"49_0172" = load {}, {}* %"49_0", align 1
  %"47_0173" = load { i1, i1 }, { i1, i1 }* %"47_0", align 1
  %"47_1174" = load { i1, i1 }, { i1, i1 }* %"47_1", align 1
  switch i1 false, label %23 [
  ]

23:                                               ; preds = %22
  store { i1, i1 } %"47_0173", { i1, i1 }* %"51_0", align 1
  store { i1, i1 } %"47_1174", { i1, i1 }* %"51_1", align 1
  br label %24

24:                                               ; preds = %23, %21
  %"51_0175" = load { i1, i1 }, { i1, i1 }* %"51_0", align 1
  %"51_1176" = load { i1, i1 }, { i1, i1 }* %"51_1", align 1
  store { i1, i1 } %"51_0175", { i1, i1 }* %"51_0", align 1
  store { i1, i1 } %"51_1176", { i1, i1 }* %"51_1", align 1
  store {} undef, {}* %"53_0", align 1
  %"53_0177" = load {}, {}* %"53_0", align 1
  %"51_0178" = load { i1, i1 }, { i1, i1 }* %"51_0", align 1
  %"51_1179" = load { i1, i1 }, { i1, i1 }* %"51_1", align 1
  store {} %"53_0177", {}* %"53_0", align 1
  store { i1, i1 } %"51_0178", { i1, i1 }* %"51_0", align 1
  store { i1, i1 } %"51_1179", { i1, i1 }* %"51_1", align 1
  %"53_0180" = load {}, {}* %"53_0", align 1
  %"51_0181" = load { i1, i1 }, { i1, i1 }* %"51_0", align 1
  %"51_1182" = load { i1, i1 }, { i1, i1 }* %"51_1", align 1
  switch i1 false, label %25 [
  ]

25:                                               ; preds = %24
  store { i1, i1 } %"51_0181", { i1, i1 }* %"55_0", align 1
  store { i1, i1 } %"51_1182", { i1, i1 }* %"55_1", align 1
  br label %26

26:                                               ; preds = %25, %19
  %"55_0183" = load { i1, i1 }, { i1, i1 }* %"55_0", align 1
  %"55_1184" = load { i1, i1 }, { i1, i1 }* %"55_1", align 1
  store { i1, i1 } %"55_0183", { i1, i1 }* %"55_0", align 1
  store { i1, i1 } %"55_1184", { i1, i1 }* %"55_1", align 1
  store {} undef, {}* %"63_0", align 1
  store {} undef, {}* %"62_0", align 1
  %"55_1185" = load { i1, i1 }, { i1, i1 }* %"55_1", align 1
  store { i1, i1 } %"55_1185", { i1, i1 }* %"176_0", align 1
  %"176_0186" = load { i1, i1 }, { i1, i1 }* %"176_0", align 1
  %27 = extractvalue { i1, i1 } %"176_0186", 0
  switch i1 %27, label %28 [
    i1 true, label %30
  ]

28:                                               ; preds = %26
  %29 = extractvalue { i1, i1 } %"176_0186", 1
  store i1 %29, i1* %"0189", align 1
  br label %cond_178_case_0

30:                                               ; preds = %26
  %31 = extractvalue { i1, i1 } %"176_0186", 1
  store i1 %31, i1* %"0192", align 1
  br label %cond_178_case_1

32:                                               ; preds = %100
  ret void

cond_114_case_0:                                  ; preds = %2
  %"02" = load i1, i1* %"0", align 1
  store i1 %"02", i1* %"117_0", align 1
  br label %cond_exit_114

cond_114_case_1:                                  ; preds = %4
  %"04" = load i1, i1* %"03", align 1
  store i1 %"04", i1* %"119_0", align 1
  %"119_05" = load i1, i1* %"119_0", align 1
  br label %cond_exit_114

cond_exit_114:                                    ; preds = %cond_114_case_1, %cond_114_case_0
  store {} undef, {}* %"13_0", align 1
  %33 = insertvalue { i1, %Qubit* } { i1 true, %Qubit* poison }, %Qubit* null, 1
  store { i1, %Qubit* } %33, { i1, %Qubit* }* %"228_0", align 8
  %"228_06" = load { i1, %Qubit* }, { i1, %Qubit* }* %"228_0", align 8
  %34 = extractvalue { i1, %Qubit* } %"228_06", 0
  switch i1 %34, label %35 [
    i1 true, label %36
  ]

35:                                               ; preds = %cond_exit_114
  br label %cond_229_case_0

36:                                               ; preds = %cond_exit_114
  %37 = extractvalue { i1, %Qubit* } %"228_06", 1
  store %Qubit* %37, %Qubit** %"011", align 8
  br label %cond_229_case_1

cond_229_case_0:                                  ; preds = %35
  store { i32, i8* } { i32 1, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @0, i32 0, i32 0) }, { i32, i8* }* %"235_0", align 8
  %"235_09" = load { i32, i8* }, { i32, i8* }* %"235_0", align 8
  call void @abort()
  store %Qubit* null, %Qubit** %"236_0", align 8
  %"236_010" = load %Qubit*, %Qubit** %"236_0", align 8
  store %Qubit* %"236_010", %Qubit** %"07", align 8
  br label %cond_exit_229

cond_229_case_1:                                  ; preds = %36
  %"012" = load %Qubit*, %Qubit** %"011", align 8
  store %Qubit* %"012", %Qubit** %"237_0", align 8
  %"237_013" = load %Qubit*, %Qubit** %"237_0", align 8
  store %Qubit* %"237_013", %Qubit** %"07", align 8
  br label %cond_exit_229

cond_exit_229:                                    ; preds = %cond_229_case_1, %cond_229_case_0
  %"08" = load %Qubit*, %Qubit** %"07", align 8
  store %Qubit* %"08", %Qubit** %"229_0", align 8
  %"229_014" = load %Qubit*, %Qubit** %"229_0", align 8
  store %Qubit* %"229_014", %Qubit** %"8_0", align 8
  %38 = insertvalue { i1, %Qubit* } { i1 true, %Qubit* poison }, %Qubit* inttoptr (i64 1 to %Qubit*), 1
  store { i1, %Qubit* } %38, { i1, %Qubit* }* %"215_0", align 8
  %"215_015" = load { i1, %Qubit* }, { i1, %Qubit* }* %"215_0", align 8
  %39 = extractvalue { i1, %Qubit* } %"215_015", 0
  switch i1 %39, label %40 [
    i1 true, label %41
  ]

40:                                               ; preds = %cond_exit_229
  br label %cond_216_case_0

41:                                               ; preds = %cond_exit_229
  %42 = extractvalue { i1, %Qubit* } %"215_015", 1
  store %Qubit* %42, %Qubit** %"020", align 8
  br label %cond_216_case_1

cond_216_case_0:                                  ; preds = %40
  store { i32, i8* } { i32 1, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @1, i32 0, i32 0) }, { i32, i8* }* %"222_0", align 8
  %"222_018" = load { i32, i8* }, { i32, i8* }* %"222_0", align 8
  call void @abort()
  store %Qubit* null, %Qubit** %"223_0", align 8
  %"223_019" = load %Qubit*, %Qubit** %"223_0", align 8
  store %Qubit* %"223_019", %Qubit** %"016", align 8
  br label %cond_exit_216

cond_216_case_1:                                  ; preds = %41
  %"021" = load %Qubit*, %Qubit** %"020", align 8
  store %Qubit* %"021", %Qubit** %"224_0", align 8
  %"224_022" = load %Qubit*, %Qubit** %"224_0", align 8
  store %Qubit* %"224_022", %Qubit** %"016", align 8
  br label %cond_exit_216

cond_exit_216:                                    ; preds = %cond_216_case_1, %cond_216_case_0
  %"017" = load %Qubit*, %Qubit** %"016", align 8
  store %Qubit* %"017", %Qubit** %"216_0", align 8
  %"216_023" = load %Qubit*, %Qubit** %"216_0", align 8
  store %Qubit* %"216_023", %Qubit** %"9_0", align 8
  %"8_024" = load %Qubit*, %Qubit** %"8_0", align 8
  %"9_025" = load %Qubit*, %Qubit** %"9_0", align 8
  %43 = insertvalue { %Qubit*, %Qubit* } poison, %Qubit* %"8_024", 0
  %44 = insertvalue { %Qubit*, %Qubit* } %43, %Qubit* %"9_025", 1
  store { %Qubit*, %Qubit* } %44, { %Qubit*, %Qubit* }* %"10_0", align 8
  %"10_026" = load { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %"10_0", align 8
  %45 = extractvalue { %Qubit*, %Qubit* } %"10_026", 0
  %46 = extractvalue { %Qubit*, %Qubit* } %"10_026", 1
  store %Qubit* %45, %Qubit** %"11_0", align 8
  store %Qubit* %46, %Qubit** %"11_1", align 8
  %"11_027" = load %Qubit*, %Qubit** %"11_0", align 8
  store %Qubit* %"11_027", %Qubit** %"203_0", align 8
  store double 0xBFF921FB54442D18, double* %"210_0", align 8
  store double 0x3FF921FB54442D18, double* %"208_0", align 8
  %"203_028" = load %Qubit*, %Qubit** %"203_0", align 8
  %"208_029" = load double, double* %"208_0", align 8
  %"210_030" = load double, double* %"210_0", align 8
  call void @__quantum__qis__phasedx__body(double %"208_029", double %"210_030", %Qubit* %"203_028")
  store %Qubit* %"203_028", %Qubit** %"211_0", align 8
  store double 0x400921FB54442D18, double* %"206_0", align 8
  %"211_031" = load %Qubit*, %Qubit** %"211_0", align 8
  %"206_032" = load double, double* %"206_0", align 8
  call void @__quantum__qis__rz__body(double %"206_032", %Qubit* %"211_031")
  store %Qubit* %"211_031", %Qubit** %"212_0", align 8
  %"212_033" = load %Qubit*, %Qubit** %"212_0", align 8
  store %Qubit* %"212_033", %Qubit** %"12_0", align 8
  %"12_034" = load %Qubit*, %Qubit** %"12_0", align 8
  store %Qubit* %"12_034", %Qubit** %"96_0", align 8
  %"96_035" = load %Qubit*, %Qubit** %"96_0", align 8
  call void @__quantum__qis__mz__body(%Qubit* %"96_035", %Result* inttoptr (i64 2 to %Result*))
  %47 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 2 to %Result*))
  %48 = select i1 %47, i1 true, i1 false
  store i1 %48, i1* %"98_0", align 1
  %"98_036" = load i1, i1* %"98_0", align 1
  %49 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"98_036", 1
  store { i1, i1 } %49, { i1, i1 }* %"99_0", align 1
  %"99_037" = load { i1, i1 }, { i1, i1 }* %"99_0", align 1
  store { i1, i1 } %"99_037", { i1, i1 }* %"14_0", align 1
  %"14_038" = load { i1, i1 }, { i1, i1 }* %"14_0", align 1
  %50 = extractvalue { i1, i1 } %"14_038", 0
  switch i1 %50, label %51 [
    i1 true, label %53
  ]

51:                                               ; preds = %cond_exit_216
  %52 = extractvalue { i1, i1 } %"14_038", 1
  store i1 %52, i1* %"042", align 1
  br label %cond_65_case_0

53:                                               ; preds = %cond_exit_216
  %54 = extractvalue { i1, i1 } %"14_038", 1
  store i1 %54, i1* %"048", align 1
  br label %cond_65_case_1

cond_65_case_0:                                   ; preds = %51
  %"043" = load i1, i1* %"042", align 1
  store i1 %"043", i1* %"101_0", align 1
  %"101_044" = load i1, i1* %"101_0", align 1
  %55 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %"101_044", 1
  store { i1, i1 } %55, { i1, i1 }* %"104_0", align 1
  %"101_045" = load i1, i1* %"101_0", align 1
  %56 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %"101_045", 1
  store { i1, i1 } %56, { i1, i1 }* %"103_0", align 1
  %"103_046" = load { i1, i1 }, { i1, i1 }* %"103_0", align 1
  %"104_047" = load { i1, i1 }, { i1, i1 }* %"104_0", align 1
  store { i1, i1 } %"103_046", { i1, i1 }* %"039", align 1
  store { i1, i1 } %"104_047", { i1, i1 }* %"1", align 1
  br label %cond_exit_65

cond_65_case_1:                                   ; preds = %53
  %"049" = load i1, i1* %"048", align 1
  store i1 %"049", i1* %"106_0", align 1
  %"106_050" = load i1, i1* %"106_0", align 1
  store i1 %"106_050", i1* %"111_0", align 1
  %"111_051" = load i1, i1* %"111_0", align 1
  store i1 %"111_051", i1* %"113_0", align 1
  store i1 %"111_051", i1* %"113_1", align 1
  %"113_052" = load i1, i1* %"113_0", align 1
  %"113_153" = load i1, i1* %"113_1", align 1
  store i1 %"113_052", i1* %"108_0", align 1
  store i1 %"113_153", i1* %"108_1", align 1
  %"108_154" = load i1, i1* %"108_1", align 1
  %57 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"108_154", 1
  store { i1, i1 } %57, { i1, i1 }* %"110_0", align 1
  %"108_055" = load i1, i1* %"108_0", align 1
  %58 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"108_055", 1
  store { i1, i1 } %58, { i1, i1 }* %"109_0", align 1
  %"109_056" = load { i1, i1 }, { i1, i1 }* %"109_0", align 1
  %"110_057" = load { i1, i1 }, { i1, i1 }* %"110_0", align 1
  store { i1, i1 } %"109_056", { i1, i1 }* %"039", align 1
  store { i1, i1 } %"110_057", { i1, i1 }* %"1", align 1
  br label %cond_exit_65

cond_exit_65:                                     ; preds = %cond_65_case_1, %cond_65_case_0
  %"040" = load { i1, i1 }, { i1, i1 }* %"039", align 1
  %"141" = load { i1, i1 }, { i1, i1 }* %"1", align 1
  store { i1, i1 } %"040", { i1, i1 }* %"65_0", align 1
  store { i1, i1 } %"141", { i1, i1 }* %"65_1", align 1
  %"65_158" = load { i1, i1 }, { i1, i1 }* %"65_1", align 1
  store { i1, i1 } %"65_158", { i1, i1 }* %"123_0", align 1
  %"123_059" = load { i1, i1 }, { i1, i1 }* %"123_0", align 1
  %59 = extractvalue { i1, i1 } %"123_059", 0
  switch i1 %59, label %60 [
    i1 true, label %62
  ]

60:                                               ; preds = %cond_exit_65
  %61 = extractvalue { i1, i1 } %"123_059", 1
  store i1 %61, i1* %"062", align 1
  br label %cond_125_case_0

62:                                               ; preds = %cond_exit_65
  %63 = extractvalue { i1, i1 } %"123_059", 1
  store i1 %63, i1* %"065", align 1
  br label %cond_125_case_1

cond_125_case_0:                                  ; preds = %60
  %"063" = load i1, i1* %"062", align 1
  store i1 %"063", i1* %"128_0", align 1
  %"128_064" = load i1, i1* %"128_0", align 1
  store i1 %"128_064", i1* %"060", align 1
  br label %cond_exit_125

cond_125_case_1:                                  ; preds = %62
  %"066" = load i1, i1* %"065", align 1
  store i1 %"066", i1* %"130_0", align 1
  %"130_067" = load i1, i1* %"130_0", align 1
  %64 = select i1 %"130_067", i1 true, i1 false
  store i1 %64, i1* %"132_0", align 1
  %"132_068" = load i1, i1* %"132_0", align 1
  store i1 %"132_068", i1* %"060", align 1
  br label %cond_exit_125

cond_exit_125:                                    ; preds = %cond_125_case_1, %cond_125_case_0
  %"061" = load i1, i1* %"060", align 1
  store i1 %"061", i1* %"125_0", align 1
  %"125_069" = load i1, i1* %"125_0", align 1
  store i1 %"125_069", i1* %"17_0", align 1
  %"17_070" = load i1, i1* %"17_0", align 1
  %"65_071" = load { i1, i1 }, { i1, i1 }* %"65_0", align 1
  %"11_172" = load %Qubit*, %Qubit** %"11_1", align 8
  store i1 %"17_070", i1* %"17_0", align 1
  store { i1, i1 } %"65_071", { i1, i1 }* %"65_0", align 1
  store %Qubit* %"11_172", %Qubit** %"11_1", align 8
  %"17_073" = load i1, i1* %"17_0", align 1
  %"65_074" = load { i1, i1 }, { i1, i1 }* %"65_0", align 1
  %"11_175" = load %Qubit*, %Qubit** %"11_1", align 8
  switch i1 %"17_073", label %65 [
    i1 true, label %66
  ]

65:                                               ; preds = %cond_exit_125
  store { i1, i1 } %"65_074", { i1, i1 }* %"36_0", align 1
  store %Qubit* %"11_175", %Qubit** %"36_1", align 8
  br label %15

66:                                               ; preds = %cond_exit_125
  store { i1, i1 } %"65_074", { i1, i1 }* %"20_0", align 1
  store %Qubit* %"11_175", %Qubit** %"20_1", align 8
  br label %6

cond_64_case_0:                                   ; preds = %11
  %"095" = load i1, i1* %"094", align 1
  store i1 %"095", i1* %"138_0", align 1
  %"138_096" = load i1, i1* %"138_0", align 1
  %67 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %"138_096", 1
  store { i1, i1 } %67, { i1, i1 }* %"141_0", align 1
  %"138_097" = load i1, i1* %"138_0", align 1
  %68 = insertvalue { i1, i1 } { i1 false, i1 poison }, i1 %"138_097", 1
  store { i1, i1 } %68, { i1, i1 }* %"140_0", align 1
  %"140_098" = load { i1, i1 }, { i1, i1 }* %"140_0", align 1
  %"141_099" = load { i1, i1 }, { i1, i1 }* %"141_0", align 1
  store { i1, i1 } %"140_098", { i1, i1 }* %"090", align 1
  store { i1, i1 } %"141_099", { i1, i1 }* %"191", align 1
  br label %cond_exit_64

cond_64_case_1:                                   ; preds = %13
  %"0101" = load i1, i1* %"0100", align 1
  store i1 %"0101", i1* %"143_0", align 1
  %"143_0102" = load i1, i1* %"143_0", align 1
  store i1 %"143_0102", i1* %"148_0", align 1
  %"148_0103" = load i1, i1* %"148_0", align 1
  store i1 %"148_0103", i1* %"150_0", align 1
  store i1 %"148_0103", i1* %"150_1", align 1
  %"150_0104" = load i1, i1* %"150_0", align 1
  %"150_1105" = load i1, i1* %"150_1", align 1
  store i1 %"150_0104", i1* %"145_0", align 1
  store i1 %"150_1105", i1* %"145_1", align 1
  %"145_1106" = load i1, i1* %"145_1", align 1
  %69 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"145_1106", 1
  store { i1, i1 } %69, { i1, i1 }* %"147_0", align 1
  %"145_0107" = load i1, i1* %"145_0", align 1
  %70 = insertvalue { i1, i1 } { i1 true, i1 poison }, i1 %"145_0107", 1
  store { i1, i1 } %70, { i1, i1 }* %"146_0", align 1
  %"146_0108" = load { i1, i1 }, { i1, i1 }* %"146_0", align 1
  %"147_0109" = load { i1, i1 }, { i1, i1 }* %"147_0", align 1
  store { i1, i1 } %"146_0108", { i1, i1 }* %"090", align 1
  store { i1, i1 } %"147_0109", { i1, i1 }* %"191", align 1
  br label %cond_exit_64

cond_exit_64:                                     ; preds = %cond_64_case_1, %cond_64_case_0
  %"092" = load { i1, i1 }, { i1, i1 }* %"090", align 1
  %"193" = load { i1, i1 }, { i1, i1 }* %"191", align 1
  store { i1, i1 } %"092", { i1, i1 }* %"64_0", align 1
  store { i1, i1 } %"193", { i1, i1 }* %"64_1", align 1
  %"64_0110" = load { i1, i1 }, { i1, i1 }* %"64_0", align 1
  store { i1, i1 } %"64_0110", { i1, i1 }* %"152_0", align 1
  %"152_0111" = load { i1, i1 }, { i1, i1 }* %"152_0", align 1
  %71 = extractvalue { i1, i1 } %"152_0111", 0
  switch i1 %71, label %72 [
    i1 true, label %74
  ]

72:                                               ; preds = %cond_exit_64
  %73 = extractvalue { i1, i1 } %"152_0111", 1
  store i1 %73, i1* %"0114", align 1
  br label %cond_154_case_0

74:                                               ; preds = %cond_exit_64
  %75 = extractvalue { i1, i1 } %"152_0111", 1
  store i1 %75, i1* %"0117", align 1
  br label %cond_154_case_1

cond_154_case_0:                                  ; preds = %72
  %"0115" = load i1, i1* %"0114", align 1
  store i1 %"0115", i1* %"157_0", align 1
  %"157_0116" = load i1, i1* %"157_0", align 1
  store i1 %"157_0116", i1* %"0112", align 1
  br label %cond_exit_154

cond_154_case_1:                                  ; preds = %74
  %"0118" = load i1, i1* %"0117", align 1
  store i1 %"0118", i1* %"159_0", align 1
  %"159_0119" = load i1, i1* %"159_0", align 1
  %76 = select i1 %"159_0119", i1 true, i1 false
  store i1 %76, i1* %"161_0", align 1
  %"161_0120" = load i1, i1* %"161_0", align 1
  store i1 %"161_0120", i1* %"0112", align 1
  br label %cond_exit_154

cond_exit_154:                                    ; preds = %cond_154_case_1, %cond_154_case_0
  %"0113" = load i1, i1* %"0112", align 1
  store i1 %"0113", i1* %"154_0", align 1
  %"154_0121" = load i1, i1* %"154_0", align 1
  store i1 %"154_0121", i1* %"25_0", align 1
  %"25_0122" = load i1, i1* %"25_0", align 1
  %"20_0123" = load { i1, i1 }, { i1, i1 }* %"20_0", align 1
  %"64_1124" = load { i1, i1 }, { i1, i1 }* %"64_1", align 1
  switch i1 %"25_0122", label %77 [
    i1 true, label %78
  ]

77:                                               ; preds = %cond_exit_154
  store { i1, i1 } %"20_0123", { i1, i1 }* %"0127", align 1
  store { i1, i1 } %"64_1124", { i1, i1 }* %"1128", align 1
  br label %cond_26_case_0

78:                                               ; preds = %cond_exit_154
  store { i1, i1 } %"20_0123", { i1, i1 }* %"0134", align 1
  store { i1, i1 } %"64_1124", { i1, i1 }* %"1135", align 1
  br label %cond_26_case_1

cond_26_case_0:                                   ; preds = %77
  %"0129" = load { i1, i1 }, { i1, i1 }* %"0127", align 1
  %"1130" = load { i1, i1 }, { i1, i1 }* %"1128", align 1
  store { i1, i1 } %"0129", { i1, i1 }* %"28_0", align 1
  store { i1, i1 } %"1130", { i1, i1 }* %"28_1", align 1
  %"28_0131" = load { i1, i1 }, { i1, i1 }* %"28_0", align 1
  %"28_1132" = load { i1, i1 }, { i1, i1 }* %"28_1", align 1
  %79 = insertvalue { i1, { i1, i1 }, { i1, i1 } } { i1 false, { i1, i1 } poison, { i1, i1 } poison }, { i1, i1 } %"28_0131", 1
  %80 = insertvalue { i1, { i1, i1 }, { i1, i1 } } %79, { i1, i1 } %"28_1132", 2
  store { i1, { i1, i1 }, { i1, i1 } } %80, { i1, { i1, i1 }, { i1, i1 } }* %"30_0", align 1
  %"30_0133" = load { i1, { i1, i1 }, { i1, i1 } }, { i1, { i1, i1 }, { i1, i1 } }* %"30_0", align 1
  store { i1, { i1, i1 }, { i1, i1 } } %"30_0133", { i1, { i1, i1 }, { i1, i1 } }* %"0125", align 1
  br label %cond_exit_26

cond_26_case_1:                                   ; preds = %78
  %"0136" = load { i1, i1 }, { i1, i1 }* %"0134", align 1
  %"1137" = load { i1, i1 }, { i1, i1 }* %"1135", align 1
  store { i1, i1 } %"0136", { i1, i1 }* %"32_0", align 1
  store { i1, i1 } %"1137", { i1, i1 }* %"32_1", align 1
  %"32_1138" = load { i1, i1 }, { i1, i1 }* %"32_1", align 1
  %81 = extractvalue { i1, i1 } %"32_1138", 0
  switch i1 %81, label %82 [
    i1 true, label %84
  ]

82:                                               ; preds = %cond_26_case_1
  %83 = extractvalue { i1, i1 } %"32_1138", 1
  store i1 %83, i1* %"0139", align 1
  br label %cond_151_case_0

84:                                               ; preds = %cond_26_case_1
  %85 = extractvalue { i1, i1 } %"32_1138", 1
  store i1 %85, i1* %"0141", align 1
  br label %cond_151_case_1

cond_exit_26:                                     ; preds = %cond_exit_151, %cond_26_case_0
  %"0126" = load { i1, { i1, i1 }, { i1, i1 } }, { i1, { i1, i1 }, { i1, i1 } }* %"0125", align 1
  store { i1, { i1, i1 }, { i1, i1 } } %"0126", { i1, { i1, i1 }, { i1, i1 } }* %"26_0", align 1
  %"26_0146" = load { i1, { i1, i1 }, { i1, i1 } }, { i1, { i1, i1 }, { i1, i1 } }* %"26_0", align 1
  store { i1, { i1, i1 }, { i1, i1 } } %"26_0146", { i1, { i1, i1 }, { i1, i1 } }* %"26_0", align 1
  %"26_0147" = load { i1, { i1, i1 }, { i1, i1 } }, { i1, { i1, i1 }, { i1, i1 } }* %"26_0", align 1
  %86 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"26_0147", 0
  switch i1 %86, label %87 [
    i1 true, label %90
  ]

87:                                               ; preds = %cond_exit_26
  %88 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"26_0147", 1
  %89 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"26_0147", 2
  store { i1, i1 } %88, { i1, i1 }* %"47_0", align 1
  store { i1, i1 } %89, { i1, i1 }* %"47_1", align 1
  br label %22

90:                                               ; preds = %cond_exit_26
  %91 = extractvalue { i1, { i1, i1 }, { i1, i1 } } %"26_0147", 1
  store { i1, i1 } %91, { i1, i1 }* %"41_0", align 1
  br label %20

cond_151_case_0:                                  ; preds = %82
  %"0140" = load i1, i1* %"0139", align 1
  store i1 %"0140", i1* %"188_0", align 1
  br label %cond_exit_151

cond_151_case_1:                                  ; preds = %84
  %"0142" = load i1, i1* %"0141", align 1
  store i1 %"0142", i1* %"190_0", align 1
  %"190_0143" = load i1, i1* %"190_0", align 1
  br label %cond_exit_151

cond_exit_151:                                    ; preds = %cond_151_case_1, %cond_151_case_0
  %"32_0144" = load { i1, i1 }, { i1, i1 }* %"32_0", align 1
  %92 = insertvalue { i1, { i1, i1 }, { i1, i1 } } { i1 true, { i1, i1 } poison, { i1, i1 } poison }, { i1, i1 } %"32_0144", 1
  store { i1, { i1, i1 }, { i1, i1 } } %92, { i1, { i1, i1 }, { i1, i1 } }* %"34_0", align 1
  %"34_0145" = load { i1, { i1, i1 }, { i1, i1 } }, { i1, { i1, i1 }, { i1, i1 } }* %"34_0", align 1
  store { i1, { i1, i1 }, { i1, i1 } } %"34_0145", { i1, { i1, i1 }, { i1, i1 } }* %"0125", align 1
  br label %cond_exit_26

cond_178_case_0:                                  ; preds = %28
  %"0190" = load i1, i1* %"0189", align 1
  store i1 %"0190", i1* %"181_0", align 1
  %"181_0191" = load i1, i1* %"181_0", align 1
  store i1 %"181_0191", i1* %"0187", align 1
  br label %cond_exit_178

cond_178_case_1:                                  ; preds = %30
  %"0193" = load i1, i1* %"0192", align 1
  store i1 %"0193", i1* %"183_0", align 1
  %"183_0194" = load i1, i1* %"183_0", align 1
  %93 = select i1 %"183_0194", i1 true, i1 false
  store i1 %93, i1* %"185_0", align 1
  %"185_0195" = load i1, i1* %"185_0", align 1
  store i1 %"185_0195", i1* %"0187", align 1
  br label %cond_exit_178

cond_exit_178:                                    ; preds = %cond_178_case_1, %cond_178_case_0
  %"0188" = load i1, i1* %"0187", align 1
  store i1 %"0188", i1* %"178_0", align 1
  %"178_0196" = load i1, i1* %"178_0", align 1
  store i1 %"178_0196", i1* %"60_0", align 1
  store {} undef, {}* %"59_0", align 1
  %"55_0197" = load { i1, i1 }, { i1, i1 }* %"55_0", align 1
  store { i1, i1 } %"55_0197", { i1, i1 }* %"166_0", align 1
  %"166_0198" = load { i1, i1 }, { i1, i1 }* %"166_0", align 1
  %94 = extractvalue { i1, i1 } %"166_0198", 0
  switch i1 %94, label %95 [
    i1 true, label %97
  ]

95:                                               ; preds = %cond_exit_178
  %96 = extractvalue { i1, i1 } %"166_0198", 1
  store i1 %96, i1* %"0201", align 1
  br label %cond_168_case_0

97:                                               ; preds = %cond_exit_178
  %98 = extractvalue { i1, i1 } %"166_0198", 1
  store i1 %98, i1* %"0204", align 1
  br label %cond_168_case_1

cond_168_case_0:                                  ; preds = %95
  %"0202" = load i1, i1* %"0201", align 1
  store i1 %"0202", i1* %"171_0", align 1
  %"171_0203" = load i1, i1* %"171_0", align 1
  store i1 %"171_0203", i1* %"0199", align 1
  br label %cond_exit_168

cond_168_case_1:                                  ; preds = %97
  %"0205" = load i1, i1* %"0204", align 1
  store i1 %"0205", i1* %"173_0", align 1
  %"173_0206" = load i1, i1* %"173_0", align 1
  %99 = select i1 %"173_0206", i1 true, i1 false
  store i1 %99, i1* %"175_0", align 1
  %"175_0207" = load i1, i1* %"175_0", align 1
  store i1 %"175_0207", i1* %"0199", align 1
  br label %cond_exit_168

cond_exit_168:                                    ; preds = %cond_168_case_1, %cond_168_case_0
  %"0200" = load i1, i1* %"0199", align 1
  store i1 %"0200", i1* %"168_0", align 1
  %"168_0208" = load i1, i1* %"168_0", align 1
  store i1 %"168_0208", i1* %"57_0", align 1
  %"57_0209" = load i1, i1* %"57_0", align 1
  call void @__quantum__rt__bool_record_output(i1 %"57_0209", i8* getelementptr inbounds ([2 x i8], [2 x i8]* @2, i32 0, i32 0))
  %"60_0210" = load i1, i1* %"60_0", align 1
  call void @__quantum__rt__bool_record_output(i1 %"60_0210", i8* getelementptr inbounds ([2 x i8], [2 x i8]* @3, i32 0, i32 0))
  %"63_0211" = load {}, {}* %"63_0", align 1
  store {} %"63_0211", {}* %"63_0", align 1
  %"63_0212" = load {}, {}* %"63_0", align 1
  switch i1 false, label %100 [
  ]

100:                                              ; preds = %cond_exit_168
  br label %32
}

declare %Qubit* @__quantum__rt__qubit_allocate()

declare void @abort()

declare void @__quantum__qis__phasedx__body(double, double, %Qubit*)

declare void @__quantum__qis__rz__body(double, %Qubit*)

declare %Result* @__QIR__CONV_Qubit_TO_Result(%Qubit*)

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__rt__bool_record_output(i1, i8*)

attributes #0 = { "entry_point" "output_labeling_schema" "qir_profiles"="custom" "required_num_qubits"="2" "required_num_results"="3" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"qir_major_version", i32 1}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
