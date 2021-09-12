IRR=Irr.Data;
SICAKLIK=Sicaklik.Data;
V=V.Data;
I=I.Data;
Sutun(:,1)=IRR;
Sutun(:,2)=SICAKLIK;
Sutun(:,3)=I;
Sutun(:,4)=V;
save('data', 'Sutun');
xlswrite('data', Sutun);

%Ann
load('data.mat');
data=Sutun;
egitim_veri=data(1:end-251,1:end-1);
egtim_cikis=data(1:end-251,end:end);
test_veri=data(end-250:end,1:end-1);
test_cikis=data(end-250:end,end:end);

net=feedforwardnet([10,10,10],'traingdx');

net.trainParam.show=50;
net.trainParam.epochs=2500;
net.trainParam.goal=1*10^-10;
net.trainParam.mc=0.90;
net.trainParam.min_grad=0.1*10^-20;
net.trainParam.lr=0.4;
net.trainParam.lr_inc=1.05;
net.trainParam.lr_dec=0.95;
net.divideFcn='';
net = train(net, egitim_veri', egtim_cikis');
test_ann=sim(net,test_veri');
error=sum((test_cikis-test_ann').^2)/23;
plot(test_cikis,'b');hold on;plot(test_ann,'r');legend('testcikis', 'testann');
save ('net','net');
gensim(net);



