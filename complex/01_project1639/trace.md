
我在一个 R 包中放置了很多的工具，很杂。但是每一次工作的时候不是所有的函数或工具都会被用到的。
有没有办法在，每次执行的时候做一个记录，就是记录哪些函数——反正是这个 R 包里的东西被调用的——包括隐性的内部调用。
都完整记录下来，方便我后续裁剪不必要的。同时，也是为了代码的保密性，因为我的每次工作执行都要上交代码，
通过只上交必要的代码，可以让我的R包保持一定的“不可用性”。
我的 R包都是通过 devtools::load_all 加载使用的，也就是说，R 包框架是基本完整的

--------------

你可以通过动态追踪（tracing）的方式，记录 R 包中所有函数（包括未导出的内部函数）在运行时的调用情况，然后根据日志提取实际被使用的函数，最终构建一个精简的包。下面是一种可行的方案。

---

### 1. 准备工作：获取包中所有函数

首先，你需要获取包中所有函数的名称和对应的函数对象。假设你的包名为 `mypkg`，并使用 `devtools::load_all()` 加载了开发版本，此时包的环境（包括命名空间）已可用。

```r
# 获取包命名空间
ns <- asNamespace("mypkg")

# 获取所有对象名（包括导出和非导出）
all_objs <- ls(ns, all.names = TRUE)

# 筛选出函数（排除非函数对象）
funcs <- Filter(function(x) is.function(get(x, envir = ns)), all_objs)
```

### 2. 为所有函数添加调用追踪

使用 `trace()` 为每个函数添加一个 `tracer`，该 `tracer` 会将调用信息写入日志文件。注意要避免递归调用时日志过多，可以简单记录函数名和调用时的参数（可选）。

```r
log_file <- "call_log.txt"

# 清空日志文件
cat("", file = log_file)

# 定义 tracer 函数
tracer <- function() {
  # 获取被调用的函数名（trace 会修改调用栈，需要小心）
  # 可以使用 sys.call() 或 .traceback()，但最简单的是通过赋值给某个全局变量
  # 这里我们通过直接捕获调用信息，但需注意 trace 中的环境
  call <- sys.call(-1)   # 获取上一级调用（即原始调用）
  func_name <- as.character(call[[1]])[1]  # 可能是符号或函数名
  # 写入日志，包含时间戳和调用
  cat(as.character(Sys.time()), ": ", deparse(call), "\n", 
      file = log_file, append = TRUE)
}

# 为每个函数添加 trace
for (f in funcs) {
  # 对于 S3 泛型，可能需要特别处理，但直接 trace 函数对象通常也能工作
  # 注意：如果函数已经 trace 过，会报错，所以先检查
  if (!is.null(trace::is_traced(f, where = ns))) next
  trace(f, tracer = tracer, where = ns, print = FALSE)
}
```

**注意**：
- `trace()` 会修改函数本身，如果后续需要恢复，可以调用 `untrace()`。
- 对于 S3 方法，它们也存储在命名空间中（如 `myfun.default`），所以同样会被捕获。
- 对于 S4 方法，`trace()` 不一定能直接作用于方法，可能需要 `traceMethod` 或其他手段。如果包中大量使用 S4，可以暂不考虑，或使用 `methods::trace`。

### 3. 运行你的工作代码

此时，所有包内函数被调用时都会记录到 `call_log.txt`。直接执行你的工作流程即可。

```r
# 你的工作代码，例如：
source("your_workflow.R")
```

### 4. 移除追踪

运行结束后，移除所有追踪：

```r
for (f in funcs) {
  if (trace::is_traced(f, where = ns)) {
    untrace(f, where = ns)
  }
}
```

### 5. 分析日志，提取被调用的函数

日志文件包含每一行调用记录，你需要从中解析出被调用的函数名（即调用表达式中的第一个符号）。注意可能有重复，去重后得到被调用函数列表。

```r
log_lines <- readLines(log_file)
# 提取函数名：假设格式是 "时间: 函数名(...)"
# 用正则匹配括号前的部分
call_funcs <- sapply(log_lines, function(line) {
  # 去掉时间戳，取冒号后的部分
  call_str <- sub("^[^:]+: ", "", line)
  # 提取第一个符号（可能包含命名空间，如 mypkg::fun）
  func_name <- strsplit(call_str, "\\(")[[1]][1]
  # 去掉可能的命名空间前缀
  func_name <- sub("^[^:]+::", "", func_name)
  func_name
})
used_funcs <- unique(call_funcs)
```

但上述正则比较粗糙，更稳健的做法是使用 `parse()` 解析调用表达式，但需注意调用可能包含复杂语法。简单场景下，可以直接取第一个词。

另外，如果包内有函数通过 `:::` 或 `::` 被调用，也会被记录（但 `:::` 通常不会出现在包内部调用中）。

### 6. 提取函数定义并构建精简包

根据 `used_funcs` 列表，从原包中提取函数定义，并写入一个新包的 `R/` 目录下。

```r
# 创建新包目录（假设已通过 usethis::create_package 或手动创建）
new_pkg_dir <- "mypkg_minimal"
dir.create(new_pkg_dir, showWarnings = FALSE)
dir.create(file.path(new_pkg_dir, "R"), showWarnings = FALSE)

# 复制函数定义
for (f in used_funcs) {
  # 获取函数对象
  fun_obj <- get(f, envir = ns)
  # 生成 R 文件内容（可以使用 dput 或直接写代码）
  dump(f, file = file.path(new_pkg_dir, "R", paste0(f, ".R")), envir = ns)
}
```

**注意**：
- 如果函数依赖于其他未在 `used_funcs` 中的内部函数（例如，被调用函数内部调用了另一个包内函数），那这个内部函数也会出现在日志中，因为调用会被记录。所以 `used_funcs` 应该是完整的。
- 如果包中有 S3 方法，需要确保泛型和方法都被保留。通常泛型和方法都会在调用时被记录（因为调用泛型时会分派到方法，方法调用也会被 trace），所以都会被包含。
- 对于数据集、内部类等非函数对象，如果需要保留，可以类似处理，但通常不需要。

### 7. 处理依赖和命名空间

精简包可能需要原包的依赖（如 `Imports`），但你可以从原包的 `DESCRIPTION` 中复制必要的依赖，或者只保留实际使用的包依赖（可通过分析函数调用得到，但较为复杂）。简单的做法是保留原包的所有依赖，因为精简包中可能使用了某些外部包的函数，但那些函数是通过 `::` 调用的，也会被日志记录，但依赖关系仍需要手动梳理。

### 8. 自动化脚本

你可以将上述步骤封装成一个函数，例如：

```r
trace_pkg_usage <- function(pkg_name, code_expr, log_file = "call_log.txt") {
  # 加载包
  devtools::load_all(".")
  ns <- asNamespace(pkg_name)
  
  # 获取所有函数
  funcs <- Filter(is.function, mget(ls(ns, all.names = TRUE), envir = ns))
  
  # 清空日志
  cat("", file = log_file)
  
  # 定义 tracer
  tracer <- function() {
    call <- sys.call(-1)
    func_name <- as.character(call[[1]])[1]
    cat(as.character(Sys.time()), ": ", deparse(call), "\n", 
        file = log_file, append = TRUE)
  }
  
  # 添加 trace
  for (f in names(funcs)) {
    if (!trace::is_traced(f, where = ns)) {
      trace(f, tracer = tracer, where = ns, print = FALSE)
    }
  }
  
  # 运行用户代码
  eval(code_expr, envir = globalenv())
  
  # 移除 trace
  for (f in names(funcs)) {
    if (trace::is_traced(f, where = ns)) {
      untrace(f, where = ns)
    }
  }
  
  # 分析日志
  log_lines <- readLines(log_file)
  if (length(log_lines) == 0) return(character(0))
  call_funcs <- sub("^[^:]+: ", "", log_lines)
  call_funcs <- sub("\\(", "", call_funcs)
  call_funcs <- sub("^[^:]+::", "", call_funcs)  # 去除命名空间前缀
  used <- unique(call_funcs)
  
  # 返回被调用的函数列表
  return(used)
}

# 使用示例
used <- trace_pkg_usage("mypkg", quote({
  # 你的代码
  myfunc1()
  myfunc2(1,2)
}))
```

### 9. 注意事项

- **性能**：为每个函数添加 trace 会影响运行速度，尤其是高频调用的函数。但用于裁剪包通常是一次性的，可以接受。
- **S4 方法**：上述方法无法追踪 S4 方法，因为 S4 方法不是普通的函数对象。如果你使用了 S4，可以考虑使用 `methods::trace` 或直接忽略（S4 方法通常以泛型函数形式调用，泛型被 trace 后会记录调用，但内部的方法分发可能不会记录具体的方法函数）。如果包中大量使用 S4，可能需要更专业的工具（如 `codetools` 结合运行时分析）。
- **闭包和函数工厂**：如果包中有返回函数的函数，这些动态生成的函数可能不会被提前 trace。但通常这类函数在定义时也是函数对象，如果它们被调用，调用表达式中的符号可能不是直接的函数名，记录可能不准确。但大多数情况下，这种模式较少。
- **外部调用**：如果你的代码中通过 `::` 调用了其他包函数，不会被记录，因为你只 trace 了自己的包。这没关系，因为只关心自己包内的函数。

### 10. 进一步简化：使用 `covr` 替代

另一种方案是使用 `covr::file_coverage()` 运行你的代码，然后查看哪些文件的行被覆盖，从而推断被调用的函数。这可以避免手动 trace，但需要安装 `covr`，并且输出是行级别的，需要解析出函数名。

```r
library(covr)
cov <- file_coverage("R/", code = your_code)
# cov 是 coverage 对象，可以查看哪些行被覆盖，然后提取所在函数的名称
```

但这种方式可能不如 trace 直接，且需要解析每个文件的行和函数边界。

---

### 总结

通过为包中所有函数添加调用追踪，你可以精确记录实际运行中使用的函数，然后基于此提取函数定义构建精简包。这样既实现了代码裁剪，又通过只上交必要的函数保持了包的“不可用性”。

请根据你的包复杂度调整上述方法，特别是处理 S4 和特殊函数时可能需要额外的代码。如果你需要更详细的实现或遇到具体问题，欢迎进一步询问。

