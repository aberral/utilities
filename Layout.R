# Basic R-project layout
ifelse(file.exists('R/'), '', dir.create('R/'))
ifelse(file.exists('data/'), '', dir.create('data/'))
ifelse(file.exists('data/raw'), '', dir.create('data/raw'))
ifelse(file.exists('data/processed'), '', dir.create('data/processed'))
ifelse(file.exists('doc/'), '', dir.create('doc/'))
ifelse(file.exists('figs/'), '', dir.create('figs/'))
ifelse(file.exists('output/'), '', dir.create('output/'))
