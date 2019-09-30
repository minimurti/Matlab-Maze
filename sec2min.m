function out = sec2min(INP)



    
  MM=floor(INP/60);
  SS=rem(INP,60);
  if SS>10
  out=sprintf('%d:%.2f',MM,SS);
  else
    out=sprintf('%d:0%.2f',MM,SS);
  end




end