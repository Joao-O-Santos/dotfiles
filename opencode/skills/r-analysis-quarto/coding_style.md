# Coding Style

These conventions govern all R code produced in this workflow. They
ensure consistency and readability across scripts and analysis pipelines.

When these rules conflict with the Tidyverse style guide referenced
below, follow these rules.


## Importing Data

Import data using relative paths so scripts are portable and can run
without user intervention. Avoid IDE-specific data import features.
Leave a comment specifying which directory should be the working
directory (i.e., `setwd()`).


## Core Style

Follow the [Tidyverse style guide](https://style.tidyverse.org/syntax.html)
except where explicitly overridden below.

Check code adherence with the
[lintr](https://github.com/jimhester/lintr) R package:

```r
library(lintr)
lint(filename = "file_to_check.R",
     with_defaults(no_tab_linter = NULL))
```

See below for `lintr` warnings that should be ignored.



## Exceptions


### Indent with Tabs Align with Spaces

Use tabs for indentation and spaces for alignment (per the
[suckless coding style](http://suckless.org/coding_style/)):

> Use tabs for indentation and spaces for alignment. This ensures
> everything will line up independent of tab size. This means:
> - No tabs except beginning of line.
> - Use spaces — not tabs — for multiline macros as the indentation
>   level is 0, where the #define began.

Indent functions, if-else statements, etc. with tabs. Align function
parameters with spaces.

If a tab = `|----|` and a space = `.`:

```r
example_fun <- function(argument) {
|----|t <- 3
|----|m <- mean(argument)
|----|if (argument > 2) {
|----||----|argument <- t + argument
|----||----|m <- long_function(long_argument1 = t,
|----||----|...................long_argument2 = t + 1)
|----||----|...................long_argument3 = t + 2)
|----|}
}
```


### Tab Size

Use a tab size of four characters, not two. A tab size of four is
closer to its usual value of eight (see [Linux kernel coding
style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html))
and still allows for deeper indentation without exceeding line length.


### Line Length

Code line length limit: **80 characters**, except when complying would
impair readability.

**"However, never break user-visible strings"**, per the [kernel coding
style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html).

Prose line length limit (code comments and markdown): **72 characters**.


### Spacing

Place a space **before** the comma when the row index is intentionally
left blank. This makes it clear the object has two dimensions and the
row value is intentionally missing.

Note: `lintr` will warn about this spacing. Ignore those warnings.


### Functions

Always use explicit `return()` at the end of functions. This makes
the output explicit and avoids ambiguity.

Target function body length: ~24 lines. Hard limit: ~48 lines.
