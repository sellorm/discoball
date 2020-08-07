
# discoball

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of discoball is to provide a simple wrapper around the Discourse API for some of the more common actions you might want to perform.

## Installation

You can install the development version of discoball from GitHub with:

``` r
install.packages("remotes")
remotes::install_github("sellorm/discoball")
```

## Usage 

Set the environment variable DISCOURSE_SERVER before you use any of the functions.

You can do this in R like this:

```
Sys.setenv("DISCOURSE_SERVER" = "https://discourse.example.com")
