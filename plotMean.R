
################plot mean 3D face
scriptPath='E:/script23D/R_3Dplot/R_3Dplot/bin'
#load scripts: 3D warp and 3D plot
source(paste0(scriptPath,'/','r3Dplot.R'))
meanPath='D:/RS/MAP_mean_VNandPNG'
sex='female'
#sex='male'
pngFile=paste0(meanPath,'/',sex,'/',sex,'.mean.png')
objFile=paste0(meanPath,'/',sex,'/',sex,'.mean.obj')
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
    jpgFile=paste0(meanPath,'/',sex,'/',sex,'.mean.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()

