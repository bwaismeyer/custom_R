# Author: Brian Waismeyer
# Contact: bwaismeyer@gmail.com

# Date created: 2/9/2015
# Date updated:

###############################################################################
## SCRIPT OVERVIEW
# goal: Define a simple function that reads an R script and counts how many
#       lines of "code" it has. What counts as a line of code is a bit
#       arbitrary - I mostly just skip comments and blank lines.

# sketch of script
# - define the function:
#       - read a given R file
#       - count the total lines
#       - count the "lines of code" with regex
#       - return the results to the user

###############################################################################
## DEFINE THE FUNCTION
# location_name should be a string specifying the location and name of the file
# I'll eventually want to make this function at least a little robust to crazy
# input...

simple_code_counter <- function(location_name) {
    # read the R file
    my_file <- readLines(location_name)
    
    # count the total number of lines
    total_lines <- length(my_file)
    
    # count the lines that are blank or are comments
    blank_lines <- sum(my_file == "")
    comment_lines <- sum(grepl("^#", my_file))
    
    # return the total lines minus the blanks/comments
    return(total_lines - blank_lines - comment_lines)
}

###############################################################################
## END OF SCRIPT
###############################################################################