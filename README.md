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
- [11. Create RDS of installed R packages with repo](#11-create-rds-of-installed-r-packages-with-repo)
- [12. Install R packages from RDS](#12-install-r-packages-from-rds)
- [13. Load exact objects from Rdata](#13-load-exact-objects-from-rdata)
- [14. Create new R Objetcts](#14-create-new-r-object)
- [15. Rstudio-Telegram Notifying Bot](#15-telegram-bot)

<!-- /TOC -->



## 1. Github
This R script contais the following code, used to start the github repo of a project. 
 Always start the repo before commiting in R.
  ```{bash}
  ------> https://hefistion.github.io/Empezando-con-Git-I/
  
  https://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github
  
  

Deleting the .git folder may cause problems in your git repository. **If you want to delete 
all your commit history but keep the code in its current state, it is very safe to do it 
as in the following:**

    - Checkout

    git checkout --orphan latest_branch

    - Add all the files

    git add -A

    - Commit the changes

    git commit -am "commit message"

    - Delete the branch

    git branch -D master

    - Rename the current branch to master

    git branch -m master

    - Finally, force update your repository

    git push -u -f origin master

PS: this will not keep your old commit history around


  # Si alguna vez pide usario y contraseña de un repo, modificar el archivo config dentro del repo en 
  # local y poner la url en formato: 
  - url = git@github.com:aberral/log.git
  
  ##0) Como iniciar el repo si la has liado
  
    git checkout master
    git fetch origin
    git reset --hard origin/master
    git checkout -b newbranch

  ##1 How to upload things to GitHub:
  #  1) Save the script, select it in the Git tab (right).
  #  2) Click commit, enter a identifuing message in Commit message. (Maybe branches)
  #  3) Push it to Github. Tools > Shell
  git init
  git remote -v
  git remote rm origin
  git remote add origin https://github.com/aberral/'nombre del repo'.git
  git config remote.origin.url git@github.com:aberral/'nombre del repo'.git
  git config --global user.email aberralgonzalez@usal.es
  git config --global user.name aberral
  # -u is used so Rstudio buttons wont go gray
  git pull origin main --set-upstream
  git push origin main --set-upstream

  # Si falla el -u flag usar:
  # add-apt-repository ppa:git-core/ppa 
  # apt update; apt install git
  
  **INICIAR REPO CON README** 
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
#############################################
for (i in seq(1,10)) {
  cat('\r', paste0('Progress:', i*10, '%'))
  flush.console() 
}
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

## 11. Create RDS of installed R packages with repo
Used to create a backup of installed R packages
```{R}
# Creation of rds objects with packages
######################################################################################
pacman::p_load(tidyverse, here)

# data frame of all installed packages
local_pkgs <- installed.packages() %>%
  as_tibble() %>%
  print()

# get source details (cran, github...) from package_info()
local_details <- 
  sessioninfo::package_info(pkgs = local_pkgs$Package) %>%
  as_tibble() %>%
  select(package, local_version = ondiskversion, source) %>%
  print()

# available.packages() returns pkg info for ALL pkgs on CRAN.
cran_pkgs <- available.packages() %>% 
  as_tibble(.name_repair = tolower) %>%
  print()
# Packages we have already installed
slimmer_frame <- 
  left_join(
    x = select(local_details, package, local_version, source),
    y = select(cran_pkgs, package, cran_version = version)
  ) %>%
  print()

# Packages for installation
compare_frame <- slimmer_frame %>%
  group_by(package) %>% 
  mutate(
    source_locale = case_when(
      compareVersion(local_version, cran_version) == 1 &
        str_detect(source, "Github") ~ "Github",
      compareVersion(local_version, cran_version) == 1 &
        is.na(cran_version) &
        str_detect(source, "CRAN") ~ "Unavailable on CRAN",
      compareVersion(local_version, cran_version) == 1 &
        (is.na(cran_version) == FALSE) &
        str_detect(source, "CRAN") ~ "Downgraded on CRAN",
      compareVersion(local_version, cran_version) %in% c(-1, 0) ~ "CRAN"
    ),
    github_repo = case_when(
      source_locale == "Github" ~ 
        str_split(string = source, pattern = "@", simplify = TRUE)[,1] %>%
        str_replace("Github \\(", ""),
      TRUE ~ as.character(NA)
    ),
  ) %>%
  ungroup() %>%
  print()

# output data location
dir.create(here("data"))

# output file
out_file <- as.character(str_glue("pkg-data_{Sys.Date()}.rds"))
write_rds(compare_frame, here("data", out_file))
```
## 12. Install R packages from RDS
To use after R upgrade or OS install
```{R}
# If it's a new OS, install this system dependencies
 - libxml2
 - libxml2-dev
 - libssl
 - libssl-dev
 - libcurl
 - libcurl4-openssl-dev
 
 sudo apt-get install libxml2 libxml2-dev libssl libssl-dev libcurl libcurl4-openssl-dev

# install some packages
install.packages("pacman")
pacman::p_load("httr", "remotes", "here", 'stringr')

# read package data
pkgs <- readRDS(here::here("data", "pkg-data_2020-10-22.rds"))

# install from cran 
cran_pkgs <- pkgs[str_detect(pkgs$source, "CRAN"), ][["package"]]
install.packages(cran_pkgs)

# install from github repos
github_pkgs <- pkgs[str_detect(pkgs$source, "Github"), ][["github_repo"]]
remotes::install_github(github_pkgs)

# install from biconductor
bioc_pkgs <- pkgs[str_detect(pkgs$source, "Bioconductor"), ][["package"]]
remotes::install_bioc(bioc_pkgs)
```
## 13. Load exact objects from Rdata
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
## 14. Create new R object
@https://github.com/OscarGVelasco/DeepNeuralNetworks4R
Ventajas:

    Variables predefinidas, incluso el tipo de datos que son. Más control sobre los datos con los que 
    van a trabajar nuestras funciones.
    Posibilidad de definir funciones para que automaticamente se ejecuten para cosas muy comunes.

Inconvenientes...

    Una vez definida la clase, y creado el objeto, no se puede ampliar (no se pueden añadir más datos 
    de los que define la clase, es decir, no podemos añadirle una matriz extra a las que ya están
    declaradas.

##############################################################
```{R}
# Creating the DeepNNModel object: this object will store all information, structure and data of the 
# Neural Network
  DeepNNModel <- setClass(Class = "DeepNNModel", slots = list(dnn = "list", 
                                                              error = "numeric", 
                                                              bestDnn = "list",
                                                              bestError = "numeric", 
                                                              bestDnn2 = "list",
                                                              bestError2 = "numeric", 
                                                              dnn.structure = "vector",
                                                              training = "list"))
# We re-define the function show()
setMethod("show",
            "DeepNNModel",
            function(object) {
              cat("Object of class: ",class(object), "\n")
              cat("\t - stores a deep neural network model and its metrics.")
            }
  )
# We create an object of class DeppNNModel and we asign it some values
DeepNNModel <- DeepNNModel(dnn = Wn, dnn.structure = c(D,H,K))

## Ahora al poner el objeto en la consola de R y darle a enter para mostrar su contenido (es lo mismo 
## que hacer show(objeto o variable) ejecutará nuestra función, y no la de por defecto:
> DeepNNModel
Object of class:  DeepNNModel
          - stores a deep neural network model and its metrics.
```
## 15. Telegram Bot
Sauce: https://blog.datascienceheroes.com/get-notify-when-an-r-script-finishes-on-telegram/

Step 1: Create a bot

Find @BotFather on telegram. Send the message: \start. Then \newbot. And follow the instructions.
The first name asked is the one that will appear on telegram. The secon one is the one in the url.
Save the bot token and never share publicly.

Step 2: Set-up the bot

After your bot is created. You have to send the message \start. And the bot is finally configurated!

Step 3: Use it with R

Put the bot token in the .Renviron:
```{R}
user_renviron <- path.expand(file.path("~", ".Renviron"))
file.edit(user_renviron) 
# This should look something like this:
## R_TELEGRAM_BOT_AberralRBot=XXXXXXXXXX:YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
```
Now restart R. Rstudio `Session' > 'Restar R'

```{R}
pacman::p_load("telegram.bot")

# Initiate the bot session using the token from the enviroment variable.
bot = Bot(token = bot_token('AberralRBot')) # Same name as in the R Environ.

# The first time, you will need the chat id (which is the chat where you will get the notifications)
https://docs.influxdata.com/kapacitor/v1.5/event_handlers/telegram/
Go to:
https://api.telegram.org/bot<API-access-token>/getUpdates?offset=0
where <API-access-token> is your token. And retriever your personal chat id.

Time to use in the R workflow! We will send a test message and a plot:

# Sending text
message_to_bot=sprintf('Process finished - Accuracy: %s', 0.99)
bot$sendMessage(chat_id = 174860321, text = message_to_bot)

# Sending image (we need to save it first)
library(ggplot2)
my_plot=ggplot(mtcars, aes(x=mpg))  + geom_histogram(bins = 5)
ggplot2::ggsave("my_plot.png", my_plot)
bot$sendPhoto(chat_id = 174860321, photo = 'my_plot.png')
