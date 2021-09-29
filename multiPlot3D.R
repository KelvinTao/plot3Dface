#3d transition and plot
#scriptPath='E:/script23D/R_3Dplot/R_3Dplot/bin'
scriptPath='/Users/taoxianming/Documents/face_3D/script23D/R_3Dplot/bin'
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
vsConstruct=tpsGauWarp3D(vMean,vMeanLms,vsLms,method=warpMethod,r=r)
##reconstruction 3d face
objData$'v'=vsConstruct
shape=mesh3D(pngFile,objData)
####real 3D images
objData$'v'=vs
shapeReal=mesh3D(pngFile,objData)
########### plot two 3D on one plane
shapes <- list(Real=shapeReal,Reconstruction=shape)
####
#rgl.close()#open3d()
imNum=2;
mat <- matrix(1:4, 2, imNum)
par3d(windowRect = c(0,0,1920, 1080))
layout3d(mat, height = c(30, 1))#sharedMouse = TRUE

##########plot
degree=0;side='center';zoomValue=0.7;
for (i in 1:imNum) {
next3d();rgl.viewpoint(zoom=zoomValue);
par3d(userMatrix = rotationMatrix(degree*pi/180, 0, 1, 0))
shade3d(shapes[[i]],lit=F)
next3d();text3d(0,0,0,names(shapes)[i],font=1,cex=2)
}
#####save 2D images
remakePath='D:/RS/reMake3D'
jpgFile=paste0(remakePath,'/',imid,'.',warpMethod,'-r-',r,'.',side,'.',zoomValue,'.jpg')
rgl.snapshot(jpgFile)
close3D()

