setwd("C:/Users/Javier/Dropbox/Sajuria/MPs website 2019")
dir.create()

current.date <- substr(date(),5, 10)
current.date <- gsub(" ", "_", current.date)
dir.create(current.date)
setwd(current.date)

if(Sys.info()["sysname"]=="Linux") {
  download.file("https://candidates.democracyclub.org.uk/media/candidates-2019-12-12.csv", 
                destfile = "candidates-parl.2017-06-08.csv",
                method="curl")
  candidates <- read.csv("candidates.csv",
                         stringsAsFactors = FALSE)	
} else {
  source("../scrape_functions.R")	
  candidates <- read.csv("https://candidates.democracyclub.org.uk/media/candidates-2019-12-12.csv",
                         stringsAsFactors = FALSE)
  
}

for(i in 1:nrow(candidates)) {
  candidate.row <- candidates[i, ]
  print(candidate.row$name)
  try(scrapeCandidateWebsite(candidate.row = candidate.row)	)
}
