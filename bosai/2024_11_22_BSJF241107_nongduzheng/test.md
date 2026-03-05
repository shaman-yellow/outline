我有个问题想要请教一下，如何指定让 `R.nvim` 建立某个 R 包的补全呢？
能否通过一个函数，例如 `build.completion('mypackage')` 完成这个目标？

我研究了 `nvimcom` 包，注意到确实有这么一个函数：`nvim.build.cmplls`
但这个 `nvim.build.cmplls` 不支持参数传入，而只会对 `installed.packages()` 中的包进行补全。

而且这个函数总是会删除我额外创建的补全文件，例如我创建的：

/home/echo/.cache/R.nvim/objls_utils.tool_0.0.0.9000
/home/echo/.cache/R.nvim/args_utils.tool

我试过了，确实可以通过创建以上两种文件，让 R.nvim 对我需要补全的R 包进行额外的补全，例如 `devtools::load_all`
加载的R包。但是这不会马上生效，我需要退出 nvim，重新打开，创建的补全才会生效，然而，补全文件很快就会被
`nvim.build.cmplls` 的检查功能删除掉了。

能否有一个 nvim 的函数，让 nvim 及时更新我创建的补全文件？并且避免让我创建的补全文件被删除？


