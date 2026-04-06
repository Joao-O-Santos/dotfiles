# Coding Style

Having a uniform coding styles eases collaboration and code readability.
Still, when not working on "official"/shared RUGGED projects, group
members should feel free to use whichever style they prefer, as long as
they are consistent. Notwithstanding, if you are just starting out with
`R` do not worry too much about your coding style as you develop your
preferences with time.

**Regardless of your preferred style, please try and comply with the
requests regarding data importing described below, especially if you are
presenting in an RUGGED session.** If you have any questions or
difficulties following the data importing recommendations below, feel
free to ask for help. More importantly, do not allow that to discourage
you from presenting in a session. **Please interpret the request as
*best* practices one should learn to follow over time, not as
*requirements* for participation.**


## Importing Data

**Please try to import data in a way other group members can
replicate, and run automatically.** For instance, avoid using
`RStudio`'s data import feature as it will not register the relative
path to your dataset in the script, and it will stop you from being able
to run your script without user-intervention. Try to write the paths to
your data files relative to a project directory other people can clone
into their machines. Then, leave a comment specifying which directory
should people set their working directory to (i.e., `setwd()`).


## Actual Coding Style

We suggest you adhere to [Tidyverse's style
guide](https://style.tidyverse.org/syntax.html) except when explicitly
stated below.

This means you can automatically check your code for adherence with the
[lintr](https://github.com/jimhester/lintr) `R` package.
To check your code while preventing warnings about indentation with tabs
run:

<pre class="code-block">
library(lintr)
lint(filename = "file_to_check.R", with_defaults(no_tab_linter = NULL))
</pre>
See below to check if you should ignore any errors raised by `lintr`.



## Exceptions


### Indent with Tabs Align with Spaces

As per the [suckless coding style](http://suckless.org/coding_style/):
> Use tabs for indentation and spaces for alignment. This ensures
> everything will line up independent of tab size. This means:

>	* No tabs except beginning of line.
>	* Use spaces - not tabs - for multiline macros as the indentation
>	  level is 0, where the #define began.

This means you can always indent functions, if else statements, etc...
with tabs but align function parameters with spaces.

If a tab = `|----|` and a space = `.` then this means:

<pre class="code-block">
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
</pre>


### Tab Size

We suggest a tab size of four characters long not two. A tab size of
four is closer to its usual value of eight (see [Linux kernel coding
style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html))
and still allows for more indentation, without exceeding line length, in
a scripting language such as R.

Regardless, you can set your preferences in your editor/IDE as indenting
with tabs and aligning with spaces ensures alignment regardless of tab
size.


### Line Length

Our line length limit suggestion is of 80 characters except when
complying with the limit impairs code readability.

**"However, never break user-visible strings", per the [kernel's coding
style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html).**

Moreover, the **suggested line length limit for prose is 72
characters.** This means the line length for code comments and markdown
files is 72 characters.


### Spacing

We suggest you place a space **before** the comma if the row value is
intentionally left blank.

This makes it clearer the object in question has two dimensions and the
row value is intentionally missing.

If you lint your code with `lintr` it will raise warnings about these
blank space in the row value. Please ignore those errors.


### Functions

**We suggest you always use explicit returns in functions.**
This makes the code clearer for the reader (specially for programmers
with more experience in other languages) and makes you more aware of
what your function should output while you're writing it.

Try to keep each functions' line length to 24 lines. However, you may
push the limit to 48 lines if it significantly improves readability or
code structure.
