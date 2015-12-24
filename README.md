## custom_R
This is a simple repository for storing and sharing my R creations that are too small or narrow in scope for a package.

Although I've been working with R for a while, I have only recently begun trying to produce robust, stranger-friendly code. Please approach with a critical eye. Suggestions for improvement are always welcome!

### Table of Contents
* [general script template](#general-script-template) 
* [robust packages loader](#robust-packages-loader)
* [simple code line counter](#simple-code-line-counter)

<a id = "general-script-template"></a>
#### general script template - 2-7-2015.R


This is simply the general-purpose script template I've been using for a while. I made minor edits on 2-7-2015 and added the date to the title to distinguish it from previous drafts (and the scripts built on those drafts).

I am prone to stuffing my scripts with too much structure but I think this template strikes a nice balance between capturing key details, getting you started, and getting out of way when you need to start coding.

<a id = "robust-packages-loader"></a>
#### robust packages loader.R

I often find myself sharing short R snippets with friends, colleagues, and clients who are unfamiliar with R. Or I dig up one of my snippets on a strange computer. Or I just want to load a bunch of packages quickly. 

I wrote up a duo of functions that try to load a set of packages, install missing packages, and give a status report. 

Simply source the .R script and you'll find yourself with two new functions, built entirely from the base R libraries. 

robust_single_loader() was a built as a support function - I recommend you avoid using it directly.

robust_packages_loader() takes a character vector of package names, runs the robust_single_loader on each, and returns a simple data frame reporting the results. 

- The "names" column returns the given package names.
- The "load_succeeded" column returns TRUE if the package loaded succesfully and FALSE if otherwise. It can be tested to verify that all packages loaded successfully (e.g., with `all(function_output$load_succeeded)`).
- The "notes" column gives a short description of the package status. "Already installed" means the package was already available on the local device and was loaded successfully. "Installed then loaded" means the package was not available but was installed. "Load and/or install failed" means that the function could not resolve the issue. This will most often be because it has been given an incorrect package name (e.g., "gplot2" instead of "ggplot2") but can occur for other reasons. The user should investigate.

Example call that would load (and install if needed) the awesome ggplot2 and lubridate libraries and would return a fail report for the non-existent cats library.
```R
package_names <- c("ggplot2", "lubridate", "cats")

robust_packages_loader(package_names)
```

<a id = "simple-code-line-counter"></a>
#### simple code line counter.R
I regularly track how long various tasks take me to complete. This is both a motivational tool for staying focused and a nifty way to generate data for predicting future task completion time.

This script simply tries to count the number of lines of functional code in a given R script. This is an early, quick-and-dirty draft of the script and makes no effort to be smart.

It counts all the lines then removes the number of lines that are blank or that are comments. If a "line" of code is broken across multiple lines in the R script, it is counted multiple times.

Code is not robust - invalid input WILL make it explode, errors are not handled, messages not given, etc.

Example call that would count the lines in a local R script.
```R
simple_code_counter("./my_R_script.R")
```
