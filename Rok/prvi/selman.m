x=[1 8 13 21];
y=[0 1 1 0];

pseq=con2seq(x);
tseq=con2seq(y);


net=newelm(minmax(x), [30 10 1], {'tansig','tansig','purelin'}, 'traingdx');

net.trainParam.epochs=3000;
net.trainParam.show=100;
net.trainParam.goal=1e-9;

tic
[net,tr]=train(net,pseq,tseq);
toc

a=sim(net,pseq);
b=cat(2,a{:});

plot(x,y,'bo-',x,b,'r--')