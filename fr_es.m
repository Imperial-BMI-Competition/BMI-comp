function l = fr_es(A, dt)

for j = 1:(length(A)-dt)
 l(j) = sum(A(j:j+dt))./(dt);
end 

end

