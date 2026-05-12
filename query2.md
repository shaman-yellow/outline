
你这么跟 AI 说：

用 R 语言为我提供一个函数，要求，可以以质谱文件 file (.mgf) 为输入，
过滤 feature。另外的重要参数输入是 mz_range。函数构造为：

filter_mgf_file <- function(file_mgf, file_output, mz_range) {
  # ...
}

要求，在最后直接帮我输出过滤后的 mgf 为 file_output。

这是我的 mgf 文件的前一些行的格式示例：
(我想，你需要根据 BEGIN IONS 和 END IONS 来拆分列表，然后匹配 MSLEVEL=1 ，以及对应的 mz 行来过滤mgf)


BEGIN IONS
FEATURE_ID=gnps1234
PEPMASS=468.29557911617
CHARGE=+1
MSLEVEL=1
468.29557911617 100
468.296127684 100
469.299482524 27.0393207318306
END IONS

BEGIN IONS
FEATURE_ID=gnps1234
PEPMASS=468.29557911617
CHARGE=+1
RTINSECONDS=
MSLEVEL=2
98.09702 10
108.08202 140
109.06539 10
109.08675 10
110.09711 10
450.28592 110
451.28784 40
468.29736 1000
469.00955 10
469.30069 440
470.30188 60
END IONS

BEGIN IONS
FEATURE_ID=gnps1537
PEPMASS=610.35991070517
CHARGE=+1
MSLEVEL=1
610.35991070517 100
610.360459256001 100
611.363814096001 35.6919033660164
END IONS

BEGIN IONS
FEATURE_ID=gnps1537
PEPMASS=610.35991070517
CHARGE=+1
RTINSECONDS=
MSLEVEL=2
115.05286 20
117.05775 40
126.05202 30
128.04988 20
609.8269 10
610.35895 1000
610.53015 10
611.3631 400
612.36377 90
613.3584 30
END IONS

BEGIN IONS
FEATURE_ID=gnps1539
PEPMASS=610.35991070517
CHARGE=+1
MSLEVEL=1
610.35991070517 100
610.360459256002 100
611.363814096002 35.6919033660164
END IONS

BEGIN IONS
FEATURE_ID=gnps1539
PEPMASS=610.35991070517
CHARGE=+1
RTINSECONDS=
MSLEVEL=2
112.07596 100
117.05638 30
580.34412 100
581.34662 20
582.36426 50
583.36426 20
610.36102 1000
611.36279 370
612.36426 80
END IONS


要求代码风格：

1. 不写 library, require 等加载包，而是要显式写名包来源！——但是，ggplot2 不用写！
2. 不要用管道符号！！！
3. 代码中的注释要用英文！！！
4. 对于任意 interger 参数，要显式写明是 1L 2L 这种！！！
5. 尽可能简洁！用 apply 家族 (apply, sapply 等等都行)，而不是 for 循环！
6. 逗号、等号等地方，一定要保留空格！！！
7. 不要一行代码一行空行！至少要 5 行才能空一次！尽量按功能切分！！
8. 函数命名标准，如果是分析数据，请以动词开头，例如 run。
   如果是可视化函数，请以 plot 开头。而函数的后缀，假如涉及了某些很特殊的结构为输入，即，非 data.frame list vector
   等类型的数据为主输入，则需要以 class 为后缀。示例：.plot_feature_seurat。
9. 矩阵操作尽量用 dplyr 系列包。
10. 遇到性能问题的时候，可以用 data.table!!
11. 运行过程中，要以 glue::glue 为基础，以 message 打印出预料之外的情况，或者某些关键节点的运行状况，让我有所了解情况。
12. 变量命名规则，data.frame 类型前缀为 data_，list 前缀为 lst_，以此类推，
    对于类似数据，需要以对象的类型为前缀，便于直接判断。特殊情况，如数值类型，参数指定 top 多少，或者多少个这种情况，
    需要命名为 n_top 这种情况。也就是说，重点类型 (辨识类型) 要放在最前面！！！这与自然语言顺序可以相反！要用倒装！

