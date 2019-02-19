# Rproject_layout
Layout used for Rprojects 
In this repo there are two files:
  * **Github.R** <- This R script contais the following code, used to start the github repo of a project. 
  Always start the repo before commiting in R.
   ```{r}
   # How to upload things to GitHub:
   #  1) Save the script, select it in the Git tab (right).
   #  2) Click commit, enter a identifuing message in Commit message. (Maybe branches)
   #  3) Push it to Github. Tools > Shell
   #   |-- git remote add origin https://github.com/aberral/'nombre del repo'.git
   #     git config remote.origin.url git@github.com:aberral/'nombre del repo'.git
   #     git pull -u origin master
   #     git push -u origin master
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
# Sin comentarios fuera de los chunks
purl('index.RMD')
# Para guardar comentarios
purl('index.RMD', output = 'test.R', documentation = 2)
  ```
