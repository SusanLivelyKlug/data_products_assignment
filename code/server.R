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

newdata <- read.csv2("../data/pData.csv")
pets_df <- newdata
bigS <- c("CA1192", "CA1612", "CA1714", "CA607",
          "CA673", "CA763", "CA774",
          "CA436", "CA2386", "CA990", "CA766")
mydata <- filter(pets_df, shelterId %in% bigS)

shinyServer(
     function(input, output) {

          output$myBar <- renderPlot({
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
