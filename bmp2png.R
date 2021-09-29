bmp2png<-function(bmpFile,pngFile='no',pngDataReturn=F){
	library(bmp) 
	library(png)
	pngData=read.bmp(bmpFile)/255##255
	if(pngFile!='no')writePNG(pngData,target=pngFile)
	if(pngDataReturn)return(pngData)
	##rm png image file
	#file.remove(pngFile)
}