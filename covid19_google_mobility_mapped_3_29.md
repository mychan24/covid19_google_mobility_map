State Mobility Map
================

Map setup

``` r
usa <- map_data("usa")
states <- map_data("state")

theme_map <- function(...) {
  theme_minimal() +
  theme(
    axis.line = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    ...
  )
}
```

Load data

``` r
odf <- read.csv("./data/state_mobility_google_map_3_29.csv")

df <- odf %>% filter(!is.element(odf$states, c("Alaska", "Hawaii"))) # take out alaska & hawaii just for mapping # also we don't have DC

df$states <- tolower(df$states)
df$states <- gsub("_", " ", df$states)

# check all states are present
sum(is.element(df$states, unique(states$region)))/48
```

    ## [1] 1

Merge data

``` r
ns <- data.frame(states, retail=NA, grocery=NA, parks=NA, transit=NA, workplace=NA, residence=NA)

for(i in 1:nrow(ns)){
  if(ns$region[i]=="district of columbia"){
      ns[i,7:ncol(ns)] <- NA
  }else{
      ns[i,7:ncol(ns)] <- as.character(unlist(df[df$states==ns$region[i],2:ncol(df)]))
  }
}

for(j in 7:ncol(ns)){
  ns[,j] <- as.numeric(sub("%", "",ns[,j]))
}

ns[,7:ncol(ns)] <- ns[,7:ncol(ns)] *.01
```

mutate to long form

``` r
ldf <- ns %>% 
  gather(data = ., key = "Type", value = "Percent_Change", retail:residence, factor_key = T)

ldf$Type<- recode(ldf$Type,
         retail="Retail & recreation", 
         grocery="Grocery & pharmacy",
         parks="Parks", 
         transit="Transit stations", 
         workplace="Workplaces", 
         residence="Residential")
```

## Reduced density in these categories:

``` r
ldf %>% 
  filter(!is.element(Type, c("Parks", "Residential"))) %>%
  ggplot() + 
    geom_polygon(aes(x = long, y = lat, group = group, fill=Percent_Change), color = "white") + 
    coord_fixed(1.3) +
    scale_fill_gradient(low = "navyblue", high = "white", lim=c(-.80,0),
                         labels = scales::percent) +
    facet_wrap(~Type) + 
    ggtitle("Mobility changes from March 29 compared to Median of Jan 3-Feb 6") +
    theme_map()
```

![](covid19_google_mobility_mapped_3_29_files/figure-gfm/reduce_map-1.png)<!-- -->

## Increased in density in these categories:

``` r
ldf %>% 
  filter(is.element(Type, c("Residential"))) %>%
  ggplot() + 
    geom_polygon(aes(x = long, y = lat, group = group, fill=Percent_Change), color = "white") + 
    coord_fixed(1.3) +
    scale_fill_gradient(low = "white",high = "firebrick", lim=c(0,.25),
                         labels = scales::percent) +
    facet_wrap(~Type) + 
    ggtitle("Mobility changes from March 29 compared to Median of Jan 3-Feb 6") +
    theme_map() 
```

![](covid19_google_mobility_mapped_3_29_files/figure-gfm/increasemap-1.png)<!-- -->

## Mixed increase/decrease in density in these categories:

``` r
ldf %>% 
  filter(is.element(Type, c("Parks"))) %>%
  ggplot() + 
    geom_polygon(aes(x = long, y = lat, group = group, fill=Percent_Change), color = "white") + 
    coord_fixed(1.3) +
    scale_fill_gradient2(low = "navyblue", mid="white",high = "firebrick", lim=c(-.80,.80),
                         labels = scales::percent) +
    facet_wrap(~Type) + 
    ggtitle("Mobility changes from March 29 compared to Median of Jan 3-Feb 6") +
    theme_map()
```

![](covid19_google_mobility_mapped_3_29_files/figure-gfm/mixmap-1.png)<!-- -->
