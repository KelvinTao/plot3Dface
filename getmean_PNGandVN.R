#####calculate mean  png
pngPath='D:/RS/MAP_png'
######female mean
library(png)
sex='male'
idPath='D:/RS/id'
load(paste0(idPath,'/',sex,'RD_id.RData'))##idPair
imgID=as.character(idPair$imgID)
imgID[imgID=='1.31024e+11']='131024000000'
pngFilesPath=paste0(pngPath,'/',imgID,'.png')
#sum(file.exists(pngFilesPath))
num=length(pngFilesPath)
for(i in 1:num){
	print(i)
	png=readPNG(pngFilesPath[i])
	if(i==1){pngAll=png}else{pngAll=png+pngAll}
	#break
}
###save
pngMean=pngAll/num
meanPath='D:/RS/MAP_mean_VNandPNG'
meanPNGFile=paste0(meanPath,'/',sex,'.mean.png')
writePNG(pngMean, target=meanPNGFile)


###get mean vn (normal vector) from obj
library(data.table)
mapPath='D:/RS/MAP'
######female mean
sex='female'
#sex='male'
idPath='D:/RS/id'
load(paste0(idPath,'/',sex,'RD_id.RData'))##idPair
imgID=as.character(idPair$imgID)
imgID[imgID=='1.31024e+11']='131024000000'
objFilesPath=paste0(mapPath,'/',imgID,'.obj')
#sum(file.exists(objFilesPath))
num=length(objFilesPath)
for(i in 1:num){
	print(i)
	#obj=read.table(objFilesPath[i],stringsAsFactors=F,fill=T)
	obj=fread(objFilesPath[i],head=F,data.table=F,fill=T)
    vn=apply(obj[which(obj[,1]=='vn'),-1],2,as.numeric)
	if(i==1){vnAll=vn}else{vnAll=vn+vnAll}
}
###save
vnMean=vnAll/num
meanPath='D:/RS/MAP_mean_VNandPNG'
meanVNFile=paste0(meanPath,'/',sex,'.mean.vn.txt')
write.table(vnMean,meanVNFile,sep=' ',quote=F,row.names=F,col.names=F)


####get mean Vtx_g from vtx_g(GPA)  data
#sex='female'
sex='male'
vtxgPath='D:/3DpreAge/mat_vtx_g'
load(paste0(vtxgPath,'/',sex,'RD.RData'))#female or male
#mat=female;
mat=male
idPath='D:/RS/id'
load(paste0(idPath,'/',sex,'RD_id.RData'))##idPair
imgID=as.character(idPair$imgID)
imgID[imgID=='1.31024e+11']='131024000000'
idPair$imgID=imgID
mat=data.frame(rownames(mat),mat[,-1])
matUse=merge(idPair,mat,by.x=2,by.y=1)[,c(-1,-2)]
col=dim(matUse)[2]
matMean=apply(matUse,2,mean)
vtx_g=cbind(matMean[seq(1,col,3)],matMean[seq(2,col,3)],matMean[seq(3,col,3)])
meanPath='D:/RS/MAP_mean_VNandPNG'
meanVFile=paste0(meanPath,'/',sex,'.mean.vtx_g.txt')
write.table(vtx_g,meanVFile,sep=' ',quote=F,row.names=F,col.names=F)


##make mean obj
sex='female'
path=paste0('D:/RS/MAP_mean_VNandPNG','/',sex)
vn=read.table(paste0(path,'/',sex,'.mean.vn.txt'),head=F)
vnUse=cbind('vn',vn)
write.table(vnUse,paste0(path,'/',sex,'.mean.vnuse.txt'),quote=F,row.names=F,col.names=F)


v=read.table(paste0(path,'/',sex,'.mean.vtx_g.txt'),head=F)
vUse=cbind('v',v)
write.table(vUse,paste0(path,'/',sex,'.mean.vuse.txt'),quote=F,row.names=F,col.names=F)

#vtf=read.table(paste0(path,'/VTandF.txt'),head=F,fill=T)




