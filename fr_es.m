function l = fr_es(A, dt)

for j = dt:(length(A))
 l(j) = sum(A((j-dt):j))./(dt);
end 

end

