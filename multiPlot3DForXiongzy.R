#3d transition and plot
scriptPath='E:/script23D/R_3Dplot/R_3Dplot/bin'
#load scripts: 3D warp and 3D plot
source(paste0(scriptPath,'/','tpsGauWarp3D.R'))
source(paste0(scriptPath,'/','r3Dplot.R'))
#######mean 3D images ###  nouse:pngFile=paste0(meanPath,'/',sex,'/',sex,'.mean.png')
meanPath='D:/RS/MAP_mean_VNandPNG'
#sex='female'
sex='male'
objMeanFile=paste0(meanPath,'/',sex,'/',sex,'.mean.obj')
vMean=readObj(objMeanFile)$'v'
####warp images of each 3D images
######get predicted landmarks file
predlmPath='E:/RS/xiongzy/fit_cood'
###warp
warpMethod='gau';r=10#warpMethod='tps';r=1;
coff=10;imgSavePath=paste0(predlmPath,'/',coff,'/',sex);dir.create(imgSavePath);
predlmFile=paste0(predlmPath,'/39score_',sex,'_coff_',coff,'.csv')
data=read.csv(predlmFile,stringsAsFactors=F)
####################warp by prediction and plot############
for (imidI in 1:dim(data)[1]){
	###get imid and predicted landmarks coordimates
	imid=data[imidI,1];
	vsLms=as.numeric(data[imidI,5:dim(data)[2]]);vLen=length(vsLms);
    vsLms=cbind(vsLms[seq(1,vLen,3)],vsLms[seq(2,vLen,3)],vsLms[seq(3,vLen,3)])#reshape to 13x3
	#############get vn vt f
	pngPath='D:/RS/MAP_png';pngFile=paste0(pngPath,'/',imid,'.png')
	mapPath='D:/RS/MAP';objFile=paste0(mapPath,'/',imid,'.obj')
	objData=readObj(objFile)###map obj with no gpa vertext
	#######tps reconstruction by llandmarks
	#lms NO.:      1 2 3 4 5 6 7 8 91011121314151617
	#char on face: k i j l p o m n q s r t v w z x y
	lmIndexAll=c(23786,23814,23860,23890,24265,17346,16834,16879,15121,12596,10823,9073,10292,10349,3206,14999,15245)
	#13 points for xiong: k i p o j l n q m s v t w
	xiongNO=c(1,2,5,6,3,4,8,9,7,10,13,12,14);outNO=c(11,15,16,17);
    xiongUseNO=c(xiongNO,outNO);xiongIndex=lmIndexAll[xiongUseNO];
    ###use 17 landmarks: mean ; 13 predicted and 4 mean 
    vMeanLms=vMean[xiongIndex,];
    outIndex=lmIndexAll[outNO];
    vsLms=rbind(vsLms,vMean[outIndex,])
	vsConstruct=tpsGauWarp3D(vMean,vMeanLms,vsLms,method=warpMethod,r=r)
	##reconstruction 3d face
	objData$'v'=vsConstruct
	shape=mesh3D(pngFile,objData)
	####real 3D images
	######get vtx_g, vertext after gpa
	vtx_g_path='D:/RS/RS_vtx_g';vtx_g_file=paste0(vtx_g_path,'/',imid,'_g.vtx')
	vs=apply(read.table(vtx_g_file,sep='\t',stringsAsFactors=F),2,as.numeric)
	objData$'v'=vs
	shapeReal=mesh3D(pngFile,objData)
	########### plot two 3D on one plane
	shapes <- list(Real=shapeReal,Reconstruction=shape)
	imgNum=2;
	mat <- matrix(1:4, 2, imgNum)
	par3d(windowRect = c(0,0,1920, 1080))
	layout3d(mat, height = c(30, 1))#sharedMouse = TRUE
	##########plot front images
	degree=0;side='center';zoomValue=0.7;
	for (i in 1:imgNum){
		next3d();rgl.viewpoint(zoom=zoomValue);
		par3d(userMatrix = rotationMatrix(degree*pi/180, 0, 1, 0))
		shade3d(shapes[[i]],lit=F)
		next3d();text3d(0,0,0,names(shapes)[i],font=1,cex=2)
	}
	#####save 2D images
	jpgFile=paste0(imgSavePath,'/',imid,'.',warpMethod,'-r-',r,'.',side,'.',zoomValue,'.jpg')
	rgl.snapshot(jpgFile)
	close3D()
	print(imidI)
}

