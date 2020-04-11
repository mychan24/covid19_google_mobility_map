
## render 3/29/2020's data into index.html
# rmarkdown::render("./covid19_google_mobility_mapped_3_29.Rmd",
#                   output_dir="./covid_mobility_map/docs/",  
#                   output_file = "index.html")

## Render 4/5/2020's data into index.html
rmarkdown::render("./covid19_google_mobility_mapped_4_05.Rmd",
                  output_dir="./docs/",  
                  output_file = "index.html")