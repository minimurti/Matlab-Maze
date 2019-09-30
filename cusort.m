function OUT = cusort(INPU)

n=length(INPU);

INP=INPU;
for h=1:n

    for j=1:n-1 

        if INP(j+1).Steps<INP(j).Steps

            a=INP(j);
            INP(j)=INP(j+1);
            INP(j+1)=a;
            
            
        end%sorts people according to the amout of steps taken
        
        if INP(j+1).Steps==INP(j).Steps
           if INP(j+1).Time<INP(j).Time
            a=INP(j);
            INP(j)=INP(j+1);
            INP(j+1)=a;
           end
            
        end%then sorts according to time. 
        
        
        
        
        

    end
    

end


for j=1:n
   INP(j).Rank=sprintf('#%d',j);
    
end



OUT=INP;

end