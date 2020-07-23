###############################################################################
# versão para windows 10 64-bits
###############################################################################

setwd('/home/XXXXXX')
if (file.exists('speedtest.exe.Rout')) file.remove('speedtest.exe.Rout')
while (TRUE) {
  db <- read.csv2('resultados.csv', colClasses = c('character', 'character', 'character'))
  tp <- as.character(Sys.time())
  speed <- tryCatch(system('speedtest.exe', intern = T))
  if (length(speed) == 10) {
    ping <- trimws(unlist(strsplit(unlist(strsplit(speed[6], "ms"))[1], ":"))[2])
    dl <- trimws(unlist(strsplit(unlist(strsplit(speed[7], split = 'Mbps'))[1], ":"))[2])
    ul <- trimws(unlist(strsplit(unlist(strsplit(speed[8], split = 'Mbps'))[1], ":"))[2])
  } else {
    dl = ul = ping = NA
  }
  tmp <- cbind.data.frame(ping, dl, ul, tp)
  cat('ping:', tmp[[1]], 'dl:', tmp[[2]], 'ul:', tmp[[3]], 'tp:', tmp[[4]])
  db <- rbind.data.frame(db, tmp)
  write.csv2(db, 'resultados.csv', row.names = F)
  Sys.sleep(900)
}
