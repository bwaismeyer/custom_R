# Author: Brian Waismeyer
# Contact: bwaismeyer@gmail.com

# Date created: 2/6/2015
# Date updated: 2/10/2015

###############################################################################
## SCRIPT OVERVIEW

# goal: Load a given set of packages, installing any missing packages.
#       Return a dataframe that can be tested to verify that named packages
#       were loaded successfully.
#
#       Where possible, minimize the noisy output that usually comes with
#       package loading.

# sketch of function
# - input: vector of package names to load

# - big function: runs little function on each name, captures attempt results,
#   organizes results into table and prints the table

# - little function: attempts to load package by given name, tries to resolve
#   any load failures, reports on actions taken and attempts to explain
#   any failures

# - output: return a data frame object including input package names
#   and the load status of each - can be tested to assess group load success

###############################################################################
## defining the little function

robust_single_loader <- function(package_name) {
    # we want to track the package name and the outcome of the load attempt
    # here we define a simple list to capture these elements
    check_list <- list(package_name,
                       FALSE,
                       "No attempt to load.")
    names(check_list) <- c("Package Name", 
                           "Load Success",
                           "Notes")
    
    
    # attempt to load the package
    is_installed <- require(package_name, 
                            character.only = TRUE,
                            quietly = TRUE)
    
    if(is_installed) {

        # if successful, update the status to indicate success
        check_list["Load Success"] <- TRUE
        check_list["Notes"] <- "Already installed."
        
    } else {
        
        # if unsuccessful, attempt to install the package and load
        # note: the capture.output simply catches the noisy "print" statements
        #       usually produced by install.packages
        capture.output(install.packages(package_name, quiet = TRUE))
        was_installed <- require(package_name, 
                                 character.only = TRUE,
                                 quietly = TRUE)
        
        # if installation/load succeeds, update status to indicate install/load
        if(was_installed) {
        
            check_list["Load Success"] <- TRUE
            check_list["Notes"] <- "Installed then loaded."
            
        } else {
            
            # if installation/load fails, leave status as FAIL
            check_list["Notes"] <- "Load and/or install failed."
            
        }
    
    }    

    # return the status report - it is a list object
    return(check_list)
}

###############################################################################
# defining the big function

robust_packages_loader <- function(vector_of_names = NULL) {
    # verify that input is a vector of strings; terminate if not
    if(is.character(vector_of_names) == FALSE) {
        stop(paste0("Please enter a package name or vector of package names.",
                    "\n\t\tEach name needs to be a character string."
            ))
    }
    
    # the robust_single_loader function will attempt to load each name
    # as a package and will give a report on each attempt
    # here we define empty vectors to catch the "Load Success" and "Notes"
    load_success_collection <- c()
    notes_collection <- c()
    
    # loop over the vector of names with the robust_single_loader function
    for(i in vector_of_names) {
        # Note: warnings suppressed in favor of reporting warnings/errors
        #       in the output dataframe itself
        current_load_report <- suppressWarnings(robust_single_loader(i))
        load_success_collection <- c(load_success_collection,
                                    current_load_report[["Load Success"]])
        notes_collection <- c(notes_collection, 
                              current_load_report[["Notes"]])
    }
    
    # combine the package names with their Load Success/Notes for a final report
    report <- cbind(vector_of_names, load_success_collection, notes_collection)
    report <- data.frame(report)
    names(report) <- c("package_name", "load_succeeded", "notes")
    return(report)
}