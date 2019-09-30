function [Direction,TYPE] = cancer(MAP2,Y1,X1,Z1)


[r,c,h]=size(MAP2);
INP(r,c,h)=1;
%% converts maze to usable data

for A=1:r
    for B=1:c
        for C=1:h
            if MAP2(A,B,C)~=1 && MAP2(A,B,C)~=3
                INP(A,B,C)=0;
            elseif MAP2(A,B,C)==3
                INP(A,B,C)=5;
                
                if A==h%makes sure not on the edge
                INP(A-1,B,C)=5;
                end
                
                if A==1%for the other edge
                INP(A+1,B,C)=5;
                end
                
                if B==c%makes sure not on the edge
                INP(A,B-1,C)=5;
                end
                
                if B==1%for the other edge
                INP(A,B+2,C)=5;
                end
                
                if C==h%makes sure not on the edge
                INP(A,B,C-1)=5;
                end
                
                if B==1%for the other edge
                INP(A,B,C+1)=5;
                end
                
                
                
                
                
                
                
                
                
            else
                
                INP(A,B,C)=1;
            end
        end
    end
end

%---------converter

%%







over=0;


while over==0
for A=2:r-1
    for B=2:c-1
        for C=2:h-1
          

           
            if INP(A,B,C+1)==5 || INP(A,B,C-1)==5 || INP(A,B+1,C)==5 || INP(A,B-1,C)==5 || INP(A+1,B,C)==5 || INP(A-1,B,C)==5
                if INP(A,B,C)~=1 && INP(A,B,C)~=5
                INP(A,B,C)=4;
                end
            end
        
            
        end
    end
end %surrounds every 5 in the matrix with 4's if there is an open path

%{
1 1 1       1 1 1
1 0 1  >    1 4 1
0 5 0       4 5 4
1 1 1       1 1 1
%}


for A=1:r
    for B=1:c
        for C=1:h          
            if INP(A,B,C)==4
                INP(A,B,C)=5;
            end
        end
    end
end %changes the 4's to 5's. The second step is necessary for preventing two 5's being made in one step

%{
1 1 1       1 1 1
1 4 1  >    1 5 1
4 5 4       5 5 5
1 1 1       1 1 1
%}


%% ------------DirectionOutput-------------------
if INP(Y1+1,X1,Z1)==5 %if the location touches a 5, the first time this occures is the direction t shoud go

    Direction='Go Down(s)';
    TYPE='ss';
    over=1;
    
end%if


if INP(Y1-1,X1,Z1)==5

    Direction='Go Up(w)';
    TYPE='ww';
    over=1;
    
end%if

if INP(Y1,X1+1,Z1)==5

    Direction='Go Right(d)';
    TYPE='dd';
    over=1;
    
end%if

if INP(Y1,X1-1,Z1)==5

    Direction='Go Left(a)';
    TYPE='aa';
    over=1;
    
end%if

if INP(Y1,X1,Z1+1)==5

    Direction='Climb Up(e)';
    TYPE='e';
    over=1;
    
end%if

if INP(Y1,X1,Z1-1)==5

    Direction='Climb Down(q)';
    TYPE='q';
    over=1;
    
end%if







end





end