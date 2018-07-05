param n;
param d:=8;
param m:=2;
set D, default{1..d};
set N, default{0..n-1};
set M, default{1..m};
var x1{N,M};
set E, within N cross N;
param w1{D,M};
var e{E,M}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0;

param file, symbolic;

minimize obj: sum{(i,j) in E}(e[i,j,1]+e[i,j,2])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k] >= x1[i,k]+sum{a in D} (c[i,j,a]*w1[a,k]*l[i,j])-x1[j,k];
s.t. c2{k in M, (i,j) in E}:e[i,j,k] >= -x1[i,k]-sum{a in D}(c[i,j,a]*w1[a,k]*l[i,j])+x1[j,k];
s.t. c3{k in M, (i,j) in E}: x1[i,k]-v[i,k]<= q[j,k]; 
s.t. c4{k in M, i in N}: -x1[i,k] +v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
solve;

printf "{\n" > file;

printf '"vertices":[\n' >> file;
printf{i in 0..n-2}  '{"x":%g, "y":%g },\n', x1[i,1], x1[i,2] >> file;
printf{i in {n-1}}  '{"x":%g, "y":%g }\n', x1[i,1], x1[i,2]>> file;
printf "],\n" >>file;

printf '"edges":[\n' >>file; 
printf{(i,j) in E}  '{"v1":%d, "v2":%d, "distance": 0, "speed": 0 },\n', i,j >> file;
printf '{"v1":%d, "v2":%d, "distance": 0, "speed": 0 }\n', 0,0 >> file;
printf "]\n">>file;
printf "}\n" >>file;

end;

