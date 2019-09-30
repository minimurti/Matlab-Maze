%% Maze Data Analisis

clear all  %#ok<CLALL>solve
format compact
SHMA=1;
AUTO=0;
Steps=0;
SHHE=1;
SHOWWAY=1;
WAY=''; %defininng varaibles for later use



try
load Mazes.mat
catch
error('No "Mazes.mat" file found in the directory');
end %load the maze file

LIST=matfile('Mazes.mat'); %gets the properties of all the stuff in the maze
LISTER=whos(LIST); %gets specifically the names of the variables FE: "Level1"
CHOICES=matrixoptions(LISTER); %runs the function that gives the GUI of the list. The outpur is a script

%eval(['WORLD = ',CHOICES,';']);%basically defines the world WORLD variable, as the variable who's name was selected

if strcmp(CHOICES,'View Highscores')    
%% highscore analysis and display initial (copied from below

CHOICES=matrixoptions(LISTER,1); %the 1, prevents seeing the "View Highscores" prompt.

FileNAME=sprintf('%sscores.mat',CHOICES);
        try 
        load(FileNAME);
        catch 
        scores(1)=struct('Rank','#1','Steps','1','Time',0.01,'Name','JordanMurti');

        end

    P=1;    


scoresd=scores;

for i=1:length(scoresd)
    
    scoresd(i).Time=sec2min(scoresd(i).Time);
    
end



    disp(struct2table(scoresd));
    
xmin=min([scores.Steps])-1;
xmax=max([scores.Steps])+1;
ymax=max([scores.Time])+1;
plot([scores.Steps],[scores.Time],'o');
axis([xmin,xmax,0,ymax])
ylabel('Time (s)')
xlabel('Number of Steps')
title('Plot of Steps vs. Time')



figure;histogram([scores.Steps]);
title('Histogram of Steps')


return



else
%% MAP INPUT source and input determination    
eval(['WORLD = ',CHOICES,';']);
[r, c, h]=size(WORLD);
for u=1:r
    for v=1:c
        for w=1:h
            if WORLD(u,v,w)==7
                Y=u;
                X=v;
                Z=w;
            end
        end
    end
end %searches maze for 7 and determines coordinates of the starting point.


FINISHED=0;

  
tic

end


%{
%Old choice options
CHOICE=input(sprintf('Choose difficulty number\n1.Easy\n2.Medium\n3.Hard\n\n'));
if CHOICE==1;
    WORLD=EASY;
elseif CHOICE==2;
    WORLD=MEDIUM;
elseif CHOICE==3;
    WORLD=HARD;
    
    
    
else
    error('please type an apporpriate number and hit enter')
end
%}





%% GAME
while FINISHED==0

        WORLD(Y,X,Z)=5;
    
    



%% ------------------------Potential Movement ANALISIS------------------

if WORLD(Y-1,X,Z)~=1
    UPOS=1;
else
      UPOS=0;
end



if WORLD(Y+1,X,Z)~=1

    DPOS=1;
else
      DPOS=0;
    
end

if WORLD(Y,X+1,Z)~=1
        RPOS=1;
else
      RPOS=0;
end

if WORLD(Y,X-1,Z)~=1

        LPOS=1;
else
      LPOS=0;
end



if WORLD(Y,X,Z+1)~=1

        CPOS=1;
        disp('"e" to climb up')
else
      CPOS=0;
end

if WORLD(Y,X,Z-1)~=1

        FPOS=1;
        disp('"q" to climb down')
else
      FPOS=0;
end







%% -------------------------MAP DISPLAY----------------------------
MAP=WORLD;

[r c F]=size(WORLD);


if SHMA==1

for u=1:r
    for v=1:c
    

        
        if MAP(u,v,Z+1)~=1
            MAP(u,v,Z)=2;
        end
        
        
        
        if MAP(u,v,Z-1)~=1
            MAP(u,v,Z)=2;
        end
       
        MAP(Y,X,Z)=4;
        
        if MAP(u,v,Z)==1
            %fprintf('[Ø]')
            fprintf('%s%s%s',char(9109),char(9109),char(9109))
        elseif MAP(u,v,Z)==0 || MAP(u,v,Z)==7
            fprintf('   ')
        elseif MAP(u,v,Z)==2
            fprintf(' <a href="">#</a> ')
        elseif MAP(u,v,Z)==3
            fprintf(2,' X ')
        elseif MAP(u,v,Z)==9
            fprintf(2,' ? ')
        elseif MAP(u,v,Z)==4
            fprintf('[\b %s ]\b',char(9786))
        elseif MAP(u,v,Z)==5
            fprintf(' %s ',char(8226))
        end

        
    end
    fprintf('\n')
end
fprintf('\n')

else
    SHMA=1;
end




%% --------------------------ControllEngine-----------------------------

if AUTO==0

    if SHHE
    fprintf('\nType "help" and hit enter for instructions.\nMake sure you have a large enough command window \n\n');
    SHHE=0;
    end
    
    if SHOWWAY
    disp(WAY)
    
    WAY='';
    end

Direct=input(' ','s');
else    
    
    try
    [WAY,Direct]=cancer(WORLD,Y,X,Z);
   
    catch
        AUTO=0;
        SHOWWAY=0;
        
    end
        
end





switch Direct
    case 'w'
        
            if UPOS
            Y=Y-1;
            Steps=Steps+1;
            else
            fprintf(2,'You ran face first into a wall\n'); 
            end
    case 'ww'
            if UPOS
            Y=Y-1;
            Steps=Steps+1;
            end
            while WORLD(Y,X,Z)~=3 && (WORLD(Y-1,X,Z)==0 || WORLD(Y-1,X,Z)==5) && WORLD(Y,X+1,Z)==1 && WORLD(Y,X-1,Z)==1 && WORLD(Y,X,Z-1)==1 && WORLD(Y,X,Z+1)==1
            WORLD(Y,X,Z)=5;
            Y=Y-1;
            Steps=Steps+1;
            end
            
            
    case 'www'
        
            while WORLD(Y,X,Z)~=3 && WORLD(Y-1,X,Z)==0 || WORLD(Y-1,X,Z)==5
            WORLD(Y,X,Z)=5;
            Y=Y-1;
            Steps=Steps+1;
            end

    case 's'
            if DPOS
            Y=Y+1;
            Steps=Steps+1;
            else
            fprintf(2,'You ran back into a wall\n')
       
            end
   
    case 'ss'
            if DPOS
            Y=Y+1;
            Steps=Steps+1;
            end
            while WORLD(Y,X,Z)~=3 && (WORLD(Y+1,X,Z)==0 || WORLD(Y+1,X,Z)==5) && WORLD(Y,X+1,Z)==1 && WORLD(Y,X-1,Z)==1 && WORLD(Y,X,Z-1)==1 && WORLD(Y,X,Z+1)==1
            WORLD(Y,X,Z)=5;
            Y=Y+1;
            Steps=Steps+1;
            end
            
            
    case 'sss'
        
            while WORLD(Y,X,Z)~=3 && WORLD(Y+1,X,Z)==0 || WORLD(Y+1,X,Z)==5
            WORLD(Y,X,Z)=5;
            Y=Y+1;
            Steps=Steps+1;
            end
    
    case 'a'
            if LPOS
            X=X-1;
            Steps=Steps+1;
            else
            fprintf(2,'You ran leftward into a wall\n');
            end
    case 'aa'
            if LPOS
            X=X-1;
            Steps=Steps+1;
            end
            while WORLD(Y,X,Z)~=3 && (WORLD(Y,X-1,Z)==0|| WORLD(Y,X-1,Z)==5) && WORLD(Y+1,X,Z)==1 && WORLD(Y-1,X,Z)==1 && WORLD(Y,X,Z-1)==1 && WORLD(Y,X,Z+1)==1
            WORLD(Y,X,Z)=5;
            X=X-1;
            Steps=Steps+1;
            end
            
            
    case 'aaa'
        
            while WORLD(Y,X,Z)~=3 && WORLD(Y,X-1,Z)==0 || WORLD(Y,X-1,Z)==5
            WORLD(Y,X,Z)=5;
            X=X-1;
            Steps=Steps+1;
            end
            
    case 'd'
            if RPOS
            X=X+1;
            Steps=Steps+1;
            else
            fprintf(2,'You ran rightward into a wall\n');     
            end

    case 'dd'
            if RPOS
            X=X+1;
            Steps=Steps+1;
            end
            while WORLD(Y,X,Z)~=3 && (WORLD(Y,X+1,Z)==0  || WORLD(Y,X+1,Z)==5)&& WORLD(Y+1,X,Z)==1 && WORLD(Y-1,X,Z)==1 && WORLD(Y,X,Z-1)==1 && WORLD(Y,X,Z+1)==1
            WORLD(Y,X,Z)=5;
            X=X+1;
            Steps=Steps+1;
            end
            
            
    case 'ddd'
        
            while WORLD(Y,X,Z)~=3 && WORLD(Y,X+1,Z)==0 || WORLD(Y,X+1,Z)==5
            WORLD(Y,X,Z)=5;
            X=X+1;
            Steps=Steps+1;
            end
                        
    
    case 'e'
        
            if CPOS
            Z=Z+2;
            else
            fprintf(2,'You jumped and hit your head on a wall\n')
            end
            
            
    case 'q'
            if FPOS==1
            Z=Z-2;
            else
            fprintf(2,'You triped on nothing\n')
            end
            
    
    case 'help'
            disp('Type a key, string, a command and then hit "enter"')
            Movement=struct('Forward','w,ww,www','Backwards','s,ss,sss','Left','a,aa,aaa','Right','d,dd,ddd') %#ok<NOPTS>
            Legend=struct('Wall',char(9109),'Cavity','#','Exit','X','Alex',char(9786)) %#ok<NOPTS>
            Comands=struct('Help','help','Navigate','assist','Solve','solve','Quit','quit') %#ok<NOPTS>
            
            SHMA=0;
    
    case 'solve'
        AUTO=1;
    case 'quit'
        
        disp('Goodbye');
        return
        
    
    case 'assist'
        
        try
        WAY=cancer(WORLD,Y,X,Z);
        catch
        fprintf(2,'The end is one step away!\n');
        
        end
        
    otherwise
        SHHE=1;
        

        
            

end 

%% end

if WORLD(Y,X,Z)==3
    %Breadcrumbs=sum(WORLD(:)==5);
    disp('Congratulations! You escaped the maze')
    fprintf('You only took %d Steps and %.0f seconds!',Steps,toc)
    FINISHED=1;
    
end
%% story element

if WORLD(Y,X,Z)==9
disp('A scary man offers you riches In return for a favor')


DEC=1;
while DEC==1
    
    offer=input('Do you trust him?(y/n):','s');
    
switch offer
    case 'n'
    disp('He ran away.You Survived the incident')
    DEC=0;
    WORLD(Y,X,Z)=0;
    case 'y'
    DEC=0;
    fprintf(2,'You Were given a poison and died. Game over. What part of "scary man" made him trustworthy?\n');
    return
    FINISHED=1;
    otherwise 
        fprintf('one lowercase key! try again!')
        
end


end

end




end
%Breadcrumbs=sum(WORLD(:)==5);
Time=toc;



%% highscore analysis
Nam=input('\nEnter a name to save your score and\nsee how well you ranked!\nOtherwise, just hit enter:','s');
if isempty(Nam)
else

try
Name=Nam(1:20);
catch
Name=Nam;
end
FileNAME=sprintf('%sscores.mat',CHOICES);
        try 
        load(FileNAME);
        N=length(scores)+1;
        scores(N)=struct('Rank',N,'Steps',Steps,'Time',Time,'Name',Name);
        scores=cusort(scores);
        save(FileNAME,'scores');
        catch 
        scores(1)=struct('Rank','#1','Steps',Steps,'Time',Time,'Name',Name);
        save(FileNAME,'scores');
        end

    P=1;    

while scores(P).Steps~=Steps ||~ strcmp(scores(P).Name,Name);
    P=P+1;
    
end
scoresd=scores;

for i=1:length(scoresd)
    
    scoresd(i).Time=sec2min(scoresd(i).Time);
    
end
if length(scoresd)<10    
    disp(struct2table(scoresd((1:length(scoresd)))));
else
    disp(struct2table(scoresd(1:10)));
end

fprintf('\nYou Ranked #%d out of %d players!\n',P,length(scoresd));



end


%end %i hope this doesnt bite me
% yah

%% MATRIX GUID
%{
Number meaning guid
0:Path
1:Wall
2:Cavity
3:Exit
4: Alex/You
5: Breadcrumb


%}




