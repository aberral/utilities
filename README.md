# Utilities
Useful things that I have found
  * **Github.R** <- This R script contais the following code, used to start the github repo of a project. 
  Always start the repo before commiting in R.
   ```{bash}
   # How to upload things to GitHub:
   #  1) Save the script, select it in the Git tab (right).
   #  2) Click commit, enter a identifuing message in Commit message. (Maybe branches)
   #  3) Push it to Github. Tools > Shell
   git remote add origin https://github.com/aberral/'nombre del repo'.git
   git config remote.origin.url git@github.com:aberral/'nombre del repo'.git
   git pull -u origin master
   git push -u origin master
   
   # Si alguna vez da errores: (borra todo en local)
   git reset --hard origin/master
   ```
  
  * **Layout.R** <- This R script create the folder structure of a new project, to maintain consistency across 
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

  * **RmdtoR.R** <- This R script converts between .rmd and .R format
  ```{R}
  library(knitr)
# Without comments outside chunks
purl('index.RMD')
# Saving all comments
purl('index.RMD', output = 'test.R', documentation = 2)
  ```

* **Working direcory** <- set the workind directory where the file is being executed
```{R}
wd <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(wd)
```
* **footer/header.html** <- footer and header for html output (rmd) credit to https://github.com/holtzy/Pimp-my-rmd

* **progress bar to for loop / apply** <- adding pb to apply loops.
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

* **Convert pdf to png unix** <- convertir todos los pdf en el directorio a png
```{bash}
#!/bin/bash
find . -type f -name '*.pdf' -print0 |
  while IFS= read -r -d '' file
    do convert -verbose -density 500 -quality 99 -resize 800 "${file}" "${file%.*}.png"
  done
```
* **R snippets** <- rellena automaticamente el esqueleto de diversas estructuras al pulsar tab en r.
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
* **Visualizar funcion** <- como visualizar alguna funcion de manera facil con colores.
```{R}
invisible(edit('funcion que queramos ver'))
invisible(edit(mean))
```

* **Asignaciones mas sencillas** <- usando el paquete magittr o dplyr.
```{R}
lirios <- iris[c(1:5,51:55,101:105),]
lirios %>%
  select(contains('Petal'))  %>%
  filter(Petal.Length > 4)   %>%
  arrange(Petal.Length) 
```
