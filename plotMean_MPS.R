
################plot mean 3D face
scriptPath='/Users/taoxianming/Documents/face_3D/script/predict2018/featurePointsPlot_ok2/r3Dplot.R';
source(scriptPath)
meanPath='/Users/taoxianming/Documents/face_3D/MPS/2016/mean'
sex='male'
pngFile0=paste0(meanPath,'/',sex,'.mean.png')
pngFile=paste0(meanPath,'/',sex,'.mean.use.png')
pngData=readPNG(pngFile0)
pngData[,,]=pngData[,,]*1.5##to gray
writePNG(pngData,target=pngFile)
Sys.sleep(2)
##


meanPath='/Users/taoxianming/Downloads/liyi-ear-3D'
objFile=paste0(meanPath,'/',sex,'.mean.obj')
plot3D(pngFile=pngFile,objFile=objFile)
#par3d(windowRect = c(0,0,1680, 1050))##backgraound size
	#par3d(windowRect = c(0,0,1280, 800))
	#par3d(windowRect = c(0,0,1920, 1080))
##save 2D snapshot
side=c('left','center','right')
#zoomValue=c(5/15,6/15,5/15)
zoomValue=c(0.7,0.7,0.7)
#########zoom test######
#side=c('left','left','left','left','left','left','left','left','left')
#zoomValue=c(1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2)
#############
for (i in 1:length(side)){
    #jpgFile=paste0(meanPath,'/color/',sex,'.mean.',side[i],'.',zoomValue[i],'.jpg')
    jpgFile=paste0(meanPath,'/bright/',sex,'.mean.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()



scriptPath='/Users/taoxianming/Documents/face_3D/script/predict2018/featurePointsPlot_ok2/r3Dplot.R';
source(scriptPath)
meanPath='/Users/taoxianming/Downloads/liyi-ear-3D'
objFile=paste0(meanPath,'/AA.mean.obj')
plot3D(objFile=objFile)
#par3d(windowRect = c(0,0,1680, 1050))##backgraound size
	#par3d(windowRect = c(0,0,1280, 800))
	#par3d(windowRect = c(0,0,1920, 1080))
##save 2D snapshot
side=c('left','center','right')
#zoomValue=c(5/15,6/15,5/15)
zoomValue=c(0.7,0.7,0.7)
#########zoom test######
#side=c('left','left','left','left','left','left','left','left','left')
#zoomValue=c(1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2)
#############
for (i in 1:length(side)){
    #jpgFile=paste0(meanPath,'/color/',sex,'.mean.',side[i],'.',zoomValue[i],'.jpg')
    jpgFile=paste0(meanPath,'/AA.mean.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()

