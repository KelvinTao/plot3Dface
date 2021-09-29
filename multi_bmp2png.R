###get bmp2png function
scriptPath='E:/script23D/R_3Dplot/R_3Dplot/bin'
scriptPath='/Users/taoxianming/Documents/face_3D/script23D/R_3Dplot/bin'
source(paste0(scriptPath,'/bmp2png.R'))

##get bmp 
mapPath='/Users/taoxianming/Documents/research/other/liyi/errorCheck'
#mapPath='D:/RS/MAP'
files=list.files(mapPath)
isbmp<-function(file){return(gregexpr('.bmp',file)>0)}
bmpFiles=files[sapply(files,isbmp)]
bmpFilesPath=paste0(mapPath,'/',bmpFiles)
#bmp2png and save
#pngPath='D:/RS/MAP_png'
pngPath='/Users/taoxianming/Documents/research/other/liyi/errorCheck'
pngFilesPath=paste0(pngPath,'/',gsub('.bmp','.png',bmpFiles))
####save png
for(i in 1:length(bmpFilesPath))bmp2png(bmpFilesPath[i],pngFilesPath[i])
