#
# petData.  Compare the number of cats/dogs/others in local shelters currently available for adoption
# future: add subgroup of ages of animals.
#
# items before shinyServer only run once.
# The api for petfinder.com has a limit on the number of requests based on your key.
#
library(UsingR)
library(XML)
library(ggplot2)
library(reshape2)
library(dplyr)

# xml.url <- "http://api.petfinder.com/pet.find?key=72609e7b0d2fac5982ee204316157c6d&id=CA803&count=1000&output=full&location=CA"
# xmlfile <- xmlTreeParse(xml.url)
# xmltop = xmlRoot(xmlfile)
# take the pets section
# pets <- xmltop[[3]]
# petcatalog <- xmlSApply(pets, function(x) xmlSApply(x, xmlValue))
# Put the data into a data-frame
# pets_df <- data.frame(t(petcatalog),row.names=NULL)
# unique(pets_df$shelterId)

# selected only the columns I care about.
# had to really futz by hand
# df$size <- as.character(df$size)
# df$size <- as.factor(df$size)
# to get columns types corrected.  must be a better way.
# using dplyr select
# mydata <- select(df, id:size)
# then lots of as.factors
# > class(mydata)
# [1] "data.frame"
# > class(mydata$sex)
# [1] "list"
# mydata$sex <- as.character(mydata$sex)
# mydata$sex <- as.factor(mydata$sex)
# mydata$size <- as.character(mydata$size)
# mydata$size <- as.factor(mydata$size)
# mydata$age <- as.character(mydata$age)
# mydata$age <- as.factor(mydata$age)
# mydata$breeds <- as.character(mydata$breeds)
# mydata$animal <- as.character(mydata$animal)
# mydata$animal <- as.factor(mydata$animal)
# mydata$name <- as.character(mydata$name)
# mydata$shelterPetId <- as.character(mydata$shelterPetId)
# class(mydata$id)
#[1] "numeric"
# class(mydata$shelterId)
#[1] "list"
# mydata$shelterId <- as.character(mydata$shelterId)
# mydata$shelterId <- as.factor(mydata$shelterId)

# use test data set until app is running so I don't burn up my key

# save data some ways:
# dump(mydata, "petsTestData.Rdmpd")
# pets_df <- source("petsTestData.Rdmpd")
# write.csv2(mydata, "pData.csv")

newdata <- read.csv2("pData.csv")
pets_df <- newdata
### todo save and read in new data file....
### todo reactiveUI - had it putting the shelterIds in the UI but the radio button wasn't
### sending back the data to the server.
### todo would like to have names of shelters
### todo would like to have checkBox of shelters instead of just one
### todo must have documentation

### todo if you run summary(mydata$shelterId) you will see many that have only 1 entry.
### we could take those out to make a smaller, more interesting chart
### maybe if there are less than 5 entries
# summary(mydata$shelterId)
#CA107 CA1192 CA1271 CA1280 CA1303 CA1365 CA1489 CA1522 CA1556 CA1612
#20     23     18      1      2      3      8     12      2     54
#CA1626  CA166 CA1714 CA1794 CA1850 CA1910  CA193 CA2031 CA2162 CA2210
#1      1     56      1     14      5     18      4      9      1
#CA2224 CA2260 CA2281 CA2329 CA2356 CA2382 CA2386 CA2395  CA250  CA434
#20     12      1     11     15      2     33      2      1      8
#CA436  CA607  CA673  CA716  CA741  CA763  CA766  CA774  CA901  CA914
#28     88     34      1      3    135    200     56     15      1
#CA990  MS113  NV160  WA526
#78      1      1      1
bigS <- c("CA1192", "CA1612", "CA1714", "CA607",
          "CA673", "CA763", "CA774",
          "CA436", "CA2386", "CA990", "CA766")
mydata <- filter(pets_df, shelterId %in% bigS)

shinyServer(
     function(input, output) {

          output$myBar <- renderPlot({
               # qplot(factor(animal), data=pets_df, geom="bar", fill=shelterId, position="dodge")
               ggplot(mydata, aes(animal, fill=shelterId)) +
                    geom_bar(stat="bin", position="dodge") +
                    scale_fill_brewer(palette = "BrBG")
          })

          output$text1 <- renderText({
               paste("You have chosen shelter",
                     input$oneShelter, ".")
          })

          output$oneBar <- renderPlot({
               shelterCode <- input$oneShelter
               availpets <- filter(pets_df, shelterId == shelterCode)
               ggplot(availpets, aes(animal, fill=sex)) +
                    geom_bar(stat="bin", position="dodge")+
                    scale_fill_brewer(palette = "Pastel1")
          })

          output$directions <- renderPlot({
               paste("Notes about this program go here")
          })
     })
