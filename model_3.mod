param n;
param m:=2;
param d:=5;
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
var x{N,M};
set E, within N cross N;
param w{D};
var e{E}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0 ;

minimize obj:  sum{(i,j) in E}(e[i,j])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{ (i,p) in E , (i,j) in E}:e[i,j]>=(x[i,1]-x[j,1])*(x[i,2]-x[p,2])/l[i,j]*l[i,p]-sum{a in D}(c[i,j,a]*w[a]);
s.t. c2{ (i,p) in E,(i,j) in E}:e[i,j]>=-(x[i,1]-x[j,1])*(x[i,2]-x[p,2])/l[i,j]*l[i,p]+sum{a in D}(c[i,j,a]*w[a]);
s.t. c3{k in M, i in N}: x[i,k]-v[i,k]<= q[i,k];
s.t. c4{k in M, i in N}: -x[i,k]+v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
s.t. c6{k in M, i in N}: q[i,k]<=25;