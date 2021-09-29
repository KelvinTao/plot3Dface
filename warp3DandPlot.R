#3d transition and plot
scriptPath='E:/script23D/R_3Dplot/R_3Dplot/bin'
#load scripts: 3D warp and 3D plot
source(paste0(scriptPath,'/','tpsGauWarp3D.R'))
source(paste0(scriptPath,'/','r3Dplot.R'))
#######mean 3D images
meanPath='D:/RS/MAP_mean_VNandPNG'
#sex='female'
sex='male'
#pngFile=paste0(meanPath,'/',sex,'/',sex,'.mean.png')
objMeanFile=paste0(meanPath,'/',sex,'/',sex,'.mean.obj')
vMean=readObj(objMeanFile)$'v'

####mapping images of each 3D images

#matPath='E:/RS/mat'
#vtx_g_mat=paste0(matPath,'/',sex,'RD_vtx_g_IID_mat.RData')
#load(vtx_g_mat)#mat
###################
imid='100902084111'
#######
pngPath='D:/RS/MAP_png';pngFile=paste0(pngPath,'/',imid,'.png')
######get vtx_g
vtx_g_path='D:/RS/RS_vtx_g';vtx_g_file=paste0(vtx_g_path,'/',imid,'_g.vtx')
vs=apply(read.table(vtx_g_file,sep='\t',stringsAsFactors=F),2,as.numeric)
######get vn vt f
mapPath='D:/RS/MAP'
objFile=paste0(mapPath,'/',imid,'.obj')
objData=readObj(objFile)


#######tps reconstruction by llandmarks
#lm NO.:   1 2 3 4 5 6 7 8 91011121314151617
#accurate: k i j l p o m n q s r t v w z x y
lmIndexAll=c(23786,23814,23860,23890,24265,17346,16834,16879,15121,12596,10823,9073,10292,10349,3206,14999,15245)
vMeanLms=vMean[lmIndexAll,];vsLms=vs[lmIndexAll,]
#warpMethod='tps';r=1;
#vsConstruct=tpsGauWarp3D(vMean,vMeanLms,vsLms,method='tps')
warpMethod='gau';r=10
vsConstruct=tpsGauWarp3D(vMean,vMeanLms,vsLms,method='gau',r=r)
##reconstruction 3d face
objData$'v'=vsConstruct
plot3D(pngFile,objData)

##save 2D snapshot
remakePath='D:/RS/reMake3D'
side=c('left','center','right')
#zoomValue=c(5/15,6/15,5/15)
zoomValue=c(0.7,0.7,0.7)
#########zoom test######
#side=c('left','left','left','left','left','left','left','left','left')
#zoomValue=c(1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2)
#############
for (i in 1:length(side)){
    jpgFile=paste0(remakePath,'/',imid,'.',warpMethod,'-r-',r,'.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()



####real 3D images
objData$'v'=vs
plot3D(pngFile,objData)
for (i in 1:length(side)){
    jpgFile=paste0(remakePath,'/',imid,'.',side[i],'.',zoomValue[i],'.jpg')
    save2Dfrom3D(jpgFile,side[i],zoomValue[i])
}
close3D()


if(F){
idPath='D:/RS/id'
load(paste0(idPath,'/',sex,'RD_id.RData'))##idPair
imgID=as.character(idPair$imgID)
imgID[imgID=='1.31024e+11']='131024000000'
pngFilesPath=paste0(pngPath,'/',imgID,'.png')
##########landmarks index in 32251 points
#lm NO.:   1 2 3 4 5 6 7 8 91011121314151617
#accurate: k i j l p o m n q s r t v w z x y
#Index NO in 32251
#lmIndexAll=[23786 23814 23860 23890 24265 17346 16834 16879 15121 12596 10823 9073 10292 10349 3206 14999 15245];
#initail 13 points for xiong: k i p o j l n q m s v t w
#xiongNO=[1 2 5 6 3 4 8 9 7 10 13 12 14];
#outIndex=[11 15 16 17];
}
