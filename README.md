# Utilities
Useful things that I have found
<!-- TOC depthFrom:2 -->

- [1. Github](#1-github)
- [2. Layout](#2-layout)
- [3. RmdtoR](#3-rmdtor)
- [4. Working directory](#4-working-directory)
- [5. footer header in html](#5-footer-header-in-html)
- [6. progress bar](#6-progress-bar)
- [7. Convert pdf to png unix](#7-convert-pdf-to-png-unix)
- [8. R snippets](#8-r-snippets)
- [9. Check function](#9-check-function)
- [10. Simple assignations](#10-simple-assignations)
- [11. List all R packages installed](#11-list-all-r-packages-installed)
- [12. Load exact objects from Rdata](#12-load-exact-objects-from-rdata)

<!-- /TOC -->



## 1. Github
This R script contais the following code, used to start the github repo of a project. 
 Always start the repo before commiting in R.
  ```{bash}
  # How to upload things to GitHub:
  #  1) Save the script, select it in the Git tab (right).
  #  2) Click commit, enter a identifuing message in Commit message. (Maybe branches)
  #  3) Push it to Github. Tools > Shell
  git remote add origin https://github.com/aberral/'nombre del repo'.git
  git config remote.origin.url git@github.com:aberral/'nombre del repo'.git
  git config --global user.email aberralgonzalez@usal.es
  git config --global user.name aberral
  # -u is used so Rstudio buttons wont go gray
  git pull -u origin master
  git push -u origin master

  # Si alguna vez da errores: (borra todo en local)
  git reset --hard origin/master
  ```
  
 ## 2. Layout
 This R script create the folder structure of a new project, to maintain consistency across 
 all projects done.
 ```{r}
 # Basic R-project layout
 ifelse(file.exists('R/'), '', dir.create('R/'))
 ifelse(file.exists('data/'), '', dir.create('data/'))
 ifelse(file.exists('data/raw'), '', dir.create('data/raw'))
 ifelse(file.exists('data/processed'), '', dir.create('data/processed'))
 ifelse(file.exists('doc/'), '', dir.create('doc/'))
 ifelse(file.exists('figs/'), '', dir.create('figs/'))
 ifelse(file.exists('output/'), '', dir.create('output/'))
 ```

 ## 3. RmdtoR
 This R script converts between .rmd and .R format
 ```{R}
 # R to RMD
 rmarkdown::render("analysis.R")

 library(knitr)
 # Without comments outside chunks
 purl('index.RMD')
 # Saving all comments
 purl('index.RMD', output = 'test.R', documentation = 2)
  ```

## 4. Working directory
Set the workind directory where the file is being executed
```{R}
wd <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(wd)
```
## 5. footer header in html
Footer and header for html output (rmd) credit to https://github.com/holtzy/Pimp-my-rmd

## 6. progress bar
Adding progress bar  to for loop / apply loops.
```{R}
library(svMisc)
for (i in seq(1:5)){
  progress(i, progress.bar = T)
  ................
  if (i == 5) cat("Done!\n")
}
###########################################
library(pbapply)      
mtrx <- pbsapply(separar, function(x) 
    sapply(separar, function(y) is.subset(x, y)))
```

## 7. Convert pdf to png unix
Convert all pdf files in the folder to png
```{bash}
#!/bin/bash
find . -type f -name '*.pdf' -print0 |
  while IFS= read -r -d '' file
    do convert -verbose -density 500 -quality 99 -resize 800 "${file}" "${file%.*}.png"
  done
```
## 8. R snippets
Automatically fill the structure of some functions while using tab in r.
  ```{R}
  fun <- snippet for functions
  ts <- add comented timestamp to code
  if/el/ei <- if/else/elif statement
  mat <- matriz
  lib <- library
  for <- bucle for
  while <- bucle while
  {x}apply <- estructura para la correspondiente funcion: sapply, lapply, vapply, apply, etc.
  ```
## 9. Check function
How to check on function with colors.
```{R}
invisible(edit('funcion que queramos ver'))
invisible(edit(mean))
```

## 10. Simple assignations
Using magittr o dplyr.
```{R}
lirios <- iris[c(1:5,51:55,101:105),]
lirios %>%
  select(contains('Petal'))  %>%
  filter(Petal.Length > 4)   %>%
  arrange(Petal.Length) 
```

## 11. List all R packages installed
The first column can be used to install the packages after a new R installation.
```{R}
# Generamos todos los paquetes en un dataframe
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
# Eliminamos los rownames porque ya estan como variable en una columna
rownames(ip) <- NULL
# Nos quedamos con los paquetes que no son base, ni recomendados, y
# eliminamos la columna
ip <- ip[is.na(ip$Priority), 1:2 , drop = FALSE]
# Guardamos los paquetes en un fichero
write.csv(ip, 'paquetes.csv', row.names = F)
```
## 12. Load exact objects from Rdata
How to load specific objects from rdata whithout loading the whole rdata.
```{R}
e1 <- new.env()
load("/home/aberral/Data/cms_jorge_julienne/data/env_final.RData", envir = e1)
ls(e1)

AAAmExpr_RMA_Combat <- get('AAAmExpr_RMA_Combat', e1)
mExpr <- AAAmExpr_RMA_Combat
eids <- get('eids', e1)
mClin1273 <- get('mClin1273', e1)
rm(e1)
```
