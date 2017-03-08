function xhat = predictKalman(filter,angle,z)
xhat(:,1) = zeros(2,1);
P{1}= zeros(2,2);


for k=2:size(z,2)
    
   
    xbar(:,k) = filter{angle}.A*xhat(:,k-1);
    Pbar{k} = filter{angle}.A*(P{k-1})*transpose(filter{angle}.A) + filter{angle}.W; 
    K{k}= Pbar{k}*transpose(filter{angle}.H)*inv(filter{angle}.H*Pbar{k}*transpose(filter{angle}.H)+filter{angle}.Q); 
  
    xhat(:,k) = xbar(:,k) + K{k}*(z(:,k)-filter{angle}.H*xbar(:,k));
    
    P{k}= (eye(size(K{k},1))- K{k}*filter{angle}.H)*Pbar{k};

    
end 
end

