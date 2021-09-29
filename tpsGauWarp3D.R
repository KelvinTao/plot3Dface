### radius basis functions
###gussian function
rbf<-function(d,r){
	## d: square sum of distance  , r: radius
	return(exp(-d/(r^2)))
}

###thin plate function
ThinPlate<-function(d){
    d0=d;## d: square sum of distance 
    d0[d==0]=10^(-100)
    # Avoid log(0)=inf
    return(d * log(d0))# general product
}

tpsGauWarp3D<-function(p3d,ps,pd,method,r=1){
    #  Radial basis function/Thin-plate spline 3D point set warping.
    #  input:  p3d: 3d point set used for transition
    #          ps: 3d source landmark [n*3];
    #          pd: 3d destination landmark [n*3];
    # method:
    # ‘gau’,r  - for Gaussian function   ko = exp(-|pi-pj|/r.^2);
    #’tps’   - for Thin-plate function ko = (|pi-pj|^2) * log(|pi-pj|^2)
    #output:
    #p3do: output point set
    #Bookstein, F. L.
    #”Principal Warps: Thin Plate Splines and the Decomposition of Deformations.”
    #IEEE Trans. Pattern Anal. Mach. Intell. 11, 567-585, 1989. 

    ##### Training 'w' with 'L'
    num_center = nrow(pd);
    nump = nrow(ps);
    K = matrix(0,nump,num_center);
    #####
    nump3d = nrow(p3d);
    K3d=matrix(0,nump3d,num_center);
    #######
    for (i in 1:num_center){
        #Forward warping, different from image warping
        dx = matrix(1,nump,1)%*%pd[i,]-ps; 
        #use |dist|^2 as input
        K[,i]=apply(dx^2,1,sum);
        #####
        dx3d = matrix(1,nump3d,1)%*%pd[i,]-p3d;
        K3d[,i]=apply(dx3d^2,1,sum);
    }
    if(method =='gau'){K=rbf(K,r);K3d=rbf(K3d,r);}
    if(method=='tps'){K=ThinPlate(K);K3d=ThinPlate(K3d);}
    # Y = L * w;
    # L: RBF matrix about source
    # Y: Points matrix about destination
    # w: transition matrix
    # P = [1,ps] where ps are n landmark points (nx3)
    # L = [ K  P;
    #       P' 0 ](n+4)x(n+4)
    # Y = [ pd;
    #        0]; (n+4)x3
    ######## get w
    P=cbind(1,ps);
    L=rbind(cbind(K,P),cbind(t(P),matrix(0,4,4)))
    Y = rbind(pd,matrix(0,4,3));
    w=solve(L,Y);
    ######get matrix after transition
    L3d = cbind(K3d,1,p3d);
    return(L3d %*% w)
}