function find_passage(r)
    n=0; side=Ost
    while isborder(r,Nord)==true # прохода сверху нет
        n+=1
        move!(r,side,n)
        side=inverse(side)
    end
end

move!(r,side,num_steps)=for _ in 1:num_steps move!(r,side) end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))