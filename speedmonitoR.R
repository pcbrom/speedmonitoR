###############################################################################
# necessario instalar o speedtest:
# https://www.speedtest.net/pt/apps/cli
# Em debian e derivados use:
# sudo apt-get install speedtest-cli
# depois crie um inicializador para carregar 
# no arranque do sistema
# qualquer dúvida entre em contato: pcbrom@gmail.com
###############################################################################

setwd('/home/XXXXXX')
while (TRUE) {
  db <- read.csv2('resultados.csv', colClasses = c('character', 'character', 'character'))
  tp <- as.character(Sys.time())
  speed <- tryCatch(system('speedtest', intern = T))
  if (length(speed) == 9) {
    ping <- gsub('\\s+|ms', '', unlist(strsplit(speed[grep('(ms)$', speed)], ':')))[-1]
    dl <- unlist(strsplit(speed[grep('^Download', speed)], ' '))[2]
    ul <- unlist(strsplit(speed[grep('^Upload', speed)], ' '))[2]
  } else {
    dl = ul = NA
  }
  tmp <- cbind.data.frame(ping, dl, ul, tp)
  cat('ping:', tmp[[1]], 'dl:', tmp[[2]], 'ul:', tmp[[3]], 'tp:', tmp[[4]])
  db <- rbind.data.frame(db, tmp)
  write.csv2(db, 'resultados.csv', row.names = F)
  if (file.exists('speed_monitor.Rout')) file.remove('speed_monitor.Rout')
  Sys.sleep(900)
}
