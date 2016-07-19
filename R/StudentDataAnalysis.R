# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function(name) {
  print(paste0("Hi there ",name));
}

bye <- function(name) {
  print(paste0("Good-bye ",name));
}

extractchoices <- function(csvFile) {
  wise <- read.csv(csvFile, header=TRUE);
  library(rjson);

  wise$studentData <- as.character(wise$student.data)

  #wise$response <- as.character(sapply(wise$studentData,function(r){rl <- fromJSON(r); return(ifelse(length(rl)>0&&!is.null(rl$response),rl$response,""))}))

  i <- 1
  while (i < 10){
    temp <- as.character(sapply(wise$studentData,function(r){rl <- fromJSON(r); return(ifelse(length(rl)>0&&!is.null(rl$studentChoices)&&length(rl$studentChoices)>=i&&!is.null(rl$studentChoices[[i]]
                                                                                                                                                                                $text),rl$studentChoices[[i]]$text,""))}))
    #is there anything relevant in temp?
    if (sum(temp!="") > 0){
      wise[,paste0("choice.",i)] <- temp
    } else {
      break
    }
    i <- i+1
  }

  wise$studentData <- NULL

  write.csv(wise, row.names=FALSE, na="");
}
