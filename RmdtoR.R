library(knitr)
# Sin comentarios fuera de los chunks
purl('index.RMD')
# Para guardar comentarios
purl('index.RMD', output = 'test.R', documentation = 2)