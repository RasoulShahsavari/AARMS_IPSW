param n;
param m:=2;
param d:=4;
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
var x1{N,M};
param v{N,M};
set E, within N cross N;
param w1{D,M};
var e{E,M};
var c{E,D},binary;
param l{E};


maximize obj: sum{(i,j) in E}  (e[i,j,1]+e[i,j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k] >= x1[i,k]+sum{a in D} (c[i,j,a]*w1[a,k]*l[i,j])-x1[j,k];
s.t. c2{k in M, (i,j) in E}:e[i,j,k] >= -x1[i,k]-sum{a in D}(c[i,j,a]*w1[a,k]*l[i,j])+x1[j,k];

solve;
display x1,e;

data;

param n:=9;

param v:
                1         2 :=
      1         210     119
      2         203     431
      3         184     799
      4         654     804
      5         1148    799
      6         1124    406
      7         1119    118
      8         664     114
      9         648     451
      10        868     275;

param  w1:     1    2:=
      	1      1    0  
	2      0    1   
	3     -1    0  
	4      0   -1 ;

param: E : l :=
	1 2 175
	1 3 55
	2 2 70
	2 3 64
	3 1 100;

end;

