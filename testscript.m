load magmulseq
y_mul = catsamples(y1,y2,y3,'pad');
u_mul = catsamples(u1,u2,u3,'pad');
d1 = [1:2];
d2 = [1:2];

narx_net = narxnet(d1,d2,10);
narx_net.divideFcn = '';
narx_net.trainParam.min_grad = 1e-10;

[p,Pi,Ai,t] = preparets(narx_net,u_mul,{},y_mul);

narx_net = train(narx_net,p,t,Pi);