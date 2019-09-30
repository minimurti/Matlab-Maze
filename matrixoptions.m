function choice = matrixoptions(INP,~)


if nargin==1
    a={INP.name,'View Highscores'};
    B='Select a Maze to play';
    
else%allows a change where the 'View Highscores' option is invisible
    
    a={INP.name};
    B='Choose which list to see.';
    
end




d = dialog('Position',[300 300 250 150],'Name','Maze Selection');
    prompt = uicontrol('Parent',d,'Style','text','Position',[20 80 210 40],'String',B);%sets winodw and screen and everything
       
    popup = uicontrol('Parent',d,...
           'Style','popup',...
           'Position',[75 70 100 25],...
           'String',a,...%options are shown based on the input into the function. In the Main file, the input is a structure containing the names of all the variables in the Maze.bat file. 
           'Callback',@popup_callback);
       
    btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Ok',...
           'Callback','delete(gcf)');
       
    choice = INP(1).name;%if there is no choice, the default is Level1, or the first maze shown. 
       
    uiwait(d);
          function popup_callback(popup,~)
          idx = popup.Value;
          popup_items = popup.String;

          choice = char(popup_items(idx,:));
          end

end