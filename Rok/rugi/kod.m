N = 4;

P = y(:, 1); 
T = y(:, 2);


min_ulaz  = min(P);
max_ulaz  = max(P);
min_izlaz = min(T);
max_izlaz = max(T);


P = 2 * (P - min_ulaz)  ./ (max_ulaz - min_ulaz)  - 1;   % funkcija 1 i 2
T = 2 * (T - min_izlaz) ./ (max_izlaz - min_izlaz) - 1;   % funkcija 3


vel = length(T);                    
ulaz = zeros(2*N, vel - N);        
izlaz = zeros(1, vel - N);        

for k = N : vel - 1
    t = flipud(T(k-N+1:k+1));       
    p = flipud(P(k-N+1:k-1));    
    ulaz(:, k) = [t; p];            
    izlaz(k) = P(k);               
end


net=newff([zeros(2*N,1)-1 zeros(2*N,1)+1], [15 5 1], {'tansig','tansig','purelin'}, 'trainlm');




net.trainParam.epochs = 2000;    % broj epoha
net.trainParam.goal   = 2e-9;    % ciljana greška
net.trainParam.time   = Inf;     % bez vremenskog ogranièenja
net.trainParam.show=10;


net = train(net, ulaz, izlaz);

izlaz_sim = sim(net, ulaz);

izlaz_sim = (izlaz_sim + 1) * (max_ulaz - min_ulaz) / 2 + min_ulaz;   % fcn blok nakon Subsystem-a


figure;
subplot(2,1,1);
plot(y(:,1));
title('Originalni ulaz u sistem');
xlabel('Vrijeme');
ylabel('Amplituda');

subplot(2,1,2);
plot(izlaz_sim, 'r');
title('Procijenjeni ulaz (izlaz mreže)');
xlabel('Vrijeme');
ylabel('Amplituda');


gensim(net, 0.1);
