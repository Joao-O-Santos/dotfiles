# Coding Style

These conventions govern all R code produced in this workflow. They
ensure consistency and readability across scripts and analysis pipelines.

When these rules conflict with the Tidyverse style guide referenced
below, follow these rules.

## Tooling

Formatting, linting, and prose wrapping are enforced by three tools:

- **air** — R code formatter (tabs, indent-width 4, line-width 80)
- **jarl** — R linter (55+ rules, auto-fix support, faster than lintr)
- **panache** — Markdown/Quarto formatter (72-char hard-wrap, reflow
  mode, delegates R blocks to air/jarl)

Install with `yay -S air jarl panache` (or equivalent). Config files
are at `~/.config/air.toml` and `~/.config/panache/config.toml`.

When running jarl or air, always fix any issues they flag. If
auto-fix breaks the code, fix it manually — the agent is responsible
for ensuring code runs after linting.


## Importing Data

Import data using relative paths so scripts are portable and can run
without user intervention. Avoid IDE-specific data import features.
Leave a comment specifying which directory should be the working
directory (i.e., `setwd()`).


## Core Style

Follow the [Tidyverse style guide](https://style.tidyverse.org/syntax.html)
except where explicitly overridden below.



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


### Functions

Always use explicit `return()` at the end of functions. This makes
the output explicit and avoids ambiguity.

Target function body length: ~24 lines. Hard limit: ~48 lines.

## Concrete Examples

### Piping style

**Wrong** (magrittr pipes, continuation at line start):

```r
result <- ds %>%
  filter(grupo == "experimental") %>%
  summarise(mean = mean(score), sd = sd(score))
```

**Right** (base pipes, dataset as argument, not piped):

```r
result <- filter(ds, grupo == "experimental") |>
  summarise(mean = mean(score), sd = sd(score))
```

### Indentation: tabs for structure, spaces for alignment

**Right** (tabs for indent level, spaces to align parameters):

```r
ds <- filter_out(ds, codigo_pessoal %in% duplicates) |>
      pivot_longer(starts_with("leq_"),
                   names_pattern = "leq_(\\d+)_(\\w+)",
                   names_to = c("Item", "Scale"),
                   values_to = "Score") |>
      pivot_wider(names_from = c("Scale", "Item"),
                  values_from = "Score")
```

Note: the `|>` pipe continuation uses one tab (same level as the
preceding `filter_out` call), and the function parameters are
aligned with spaces.

### Function calls with many arguments

**Right** (each argument on its own line, aligned):

```r
leq_emm <- emmeans(leq_m,
                   list(pairwise ~ subescala,
                        pairwise ~ genero | subescala,
                        pairwise ~ momento | subescala,
                        pairwise ~ momento | grupo * subescala))
```

### Simple helper functions

**Right**:

```r
avg_score <- function(...) { rowMeans(pick(...), na.rm = TRUE) }
```

### Object naming

```r
ds           # main dataset
voi          # values of interest (subset)
m_label      # model fits
aov_label    # ANOVA models
emm_label    # estimated marginal means
mc_label     # multiple comparisons
```

### Column selection

Use `matches()` or tidyverse `select()` for column selection instead of
creating a `coi` (columns of interest) vector:

**Wrong** (creating a separate column vector):

```r
coi <- c("col1", "col2", "col3")
ds <- ds[, coi]
```

**Right** (using tidyverse selection):

```r
ds <- ds |>
  select(matches("pattern1|pattern2"))
```

```r
ds <- ds |>
  select(starts_with("leq_"), ends_with("_score"))
```
