#
# slk: shinyUI for Adoptable Animals, an experiment in accessing and viewing dynamic data
# from animal shelters in California.  Much work to be done, this is basically the outline
# for a bigger project
# 12/14/15
#
shinyUI(fluidPage(

     titlePanel("California Adoptable Animals"),

     sidebarLayout( position = "right",

          sidebarPanel(
               helpText("Pick one of the shelters on the list to see how many pets are available."),

               h2('Some of the shelters in CA'),

               radioButtons("oneShelter", label = h3("Radio buttons"),
                    choices = list("LA, South. CA766" = "CA766",
                           "Sante D'Or Foundation. CA774" = "CA774",
                           "Jackie's PURRfect Match. CA436" = "CA436",
                           "Pug Nation Rescue of LA. CA2386" = "CA2386",
                           "SEAACA. CA990" = "CA990",
                           "LA, North Central. CA736" = "CA763",
                           "LA CACC, Carson. CA673" = "CA673",
                           "LA CACC, Downy. CA607" = "CA607",
                           "Catmandoo Rescue. CA1192" = "CA1192",
                           "spcaLA South Bay PAC. CA1612" = "CA1612",
                           "Angel City Pit Bulls. CA1714" = "CA1714"),
                    selected = "LA, South. CA766"),

               helpText("The shelter data has been collected through a REST API from petfinder.com.
                        It has been pre-examined and cleaned to include interesting shelters for the
                        purposes of this class project.
                        Also for the purposes of this assignment this graph is using pre-downloaded
                        and cleaned data so that the number of petfinder key uses is not exceeded.")
          ),

          mainPanel(
               h3('Numbers by shelterId'),
               plotOutput('myBar'),
               h3('Shelter picked'),
               textOutput('text1'),
               plotOutput('oneBar'))
          )
     )
)
