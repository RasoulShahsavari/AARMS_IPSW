param n;
param m:=2;
param d:=8;
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
var x1{N,M};
set E, within N cross N;
param w1{D,M};
var e{E,M}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0;

minimize obj: sum{(i,j) in E}(e[i,j,1]+e[i,j,2])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k] >= x1[i,k]+sum{a in D} (c[i,j,a]*w1[a,k]*l[i,j])-x1[j,k];
s.t. c2{k in M, (i,j) in E}:e[i,j,k] >= -x1[i,k]-sum{a in D}(c[i,j,a]*w1[a,k]*l[i,j])+x1[j,k];
s.t. c3{k in M, (i,j) in E}: x1[i,k]-v[i,k]<= q[j,k];
s.t. c4{k in M, i in N}: -x1[i,k]+v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
