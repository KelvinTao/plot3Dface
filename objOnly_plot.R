source('/Users/taoxianming/Documents/face_3D/script23D/R_3Dplot/bin/r3Dplot.R')
sex='female'
path='/Users/taoxianming/Documents/face_3D/RS/3D/MAP_mean_VNandPNG/'
obj=paste0(path,'/',sex,'/',sex,'.mean.obj')
resPath=paste0(path,'/objOnly')
#png=paste0(path,'/male.mean.png')
plot3D(objFile=obj)
side=c('left','center','right')
#zoomValue=c(5/15,6/15,5/15)
zoomValue=c(0.7,0.7,0.7)
#############
for (i in 1:length(side)){
    jpgFile=paste0(resPath,'/',sex,'.mean.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()



