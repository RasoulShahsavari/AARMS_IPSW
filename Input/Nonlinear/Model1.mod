param n;
param t;
param m:=2;
param d:=9;
param o=4;
set O, default{1..o};
set T, default{1..t};
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
set E, within N cross N cross N;
set E1, within N cross N cross N;
var c{E,D},binary;
param w{D};
var ed{E,O};
var x{N,M};
param v{N,M};
var e{E}, >=0;
var e1{E1}, >=0;
param l1{E};
param l2{E};
param l3{E1};
param l4{E1};

var q{N,M}, >=0 ;

minimize obj:  sum{j in N}(q[j,1]+q[j,2])+10*sum{(i,j,k) in E}(e[i,j,k]+e[i,j,k])+0.001*sum{(i,j,k) in E1}(e1[i,j,k]+e1[i,j,k]);

s.t. c1{ (i,j,k) in E }:e[i,j,k] >=((x[j,1]-x[i,1])*(x[j,1]-x[k,1])+(x[j,2]-x[i,2])*(x[j,2]-x[k,2]))/l1[i,j,k]*l2[i,j,k];
s.t. c2{ (i,j,k) in E }:e[i,j,k] >=-((x[j,1]-x[i,1])*(x[j,1]-x[k,1])+(x[j,2]-x[i,2])*(x[j,2]-x[k,2]))/l1[i,j,k]*l2[i,j,k];
s.t. c5{ (i,j,k) in E1 }:e1[i,j,k] >=((x[j,1]-x[i,1])*(x[j,1]-x[k,1])+(x[j,2]-x[i,2])*(x[j,2]-x[k,2]))/l3[i,j,k]*l4[i,j,k]-0.70710678118;
s.t. c6{ (i,j,k) in E1 }:e1[i,j,k] >=-((x[j,1]-x[i,1])*(x[j,1]-x[k,1])+(x[j,2]-x[i,2])*(x[j,2]-x[k,2]))/l3[i,j,k]*l4[i,j,k]+0.70710678118;
s.t. c3{k in M, i in N}: q[i,k] >=x[i,k]-v[i,k];
s.t. c4{k in M, i in N}: q[i,k] >=-x[i,k]+v[i,k];
s.t. c8{k in M, i in N}: q[i,k]<=30;
s.t.  c9{(i,j,k) in E, (p,a,b) in E1}: e[i,j,k]<= 0.2*e1[p,a,b];



