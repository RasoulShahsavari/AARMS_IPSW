param n;
param m:=2;
param d:=5;
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
var x1{N,M};
set E, within N cross N;
param w{D};
var e{E,M}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0;

maximize obj:  sum{(i,j) in E}(e[i,j,1]+e[i,j,2])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k]<=((x[i,1]-x[j,1])*((x[k,2]-x[l,2])/l[i,j])*l[i,j])-sum{a in D}(c[i,j,a]*w);
s.t. c2{k in M, (i,j) in E}:e[i,j,k]>=-((x[i,1]-x[j,1])*((x[k,2]-x[l,2])/l[i,j])*l[i,j])+sum{a in D}(c[i,j,a]*w);
s.t. c3{k in M, i in N}: x[i,k]-v[i,k]<= q[i,k];
s.t. c4{k in M, i in N}: -x[i,k]+v[i,k]<= q[i,k];