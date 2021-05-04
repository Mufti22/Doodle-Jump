unit Commands;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures, Math, FreshPoc, Components, FreshText;

//////----------------****************************************************---------------------------////

var Commande, KeyClick:boolean;

//////----------------****************************************************---------------------------////

procedure Active_UnActive_system();
procedure ShowCom(px,py,sx,sy:integer);
procedure Load_commands();
procedure Load_records();
procedure Save_records();
procedure CalcRecords();


//////----------------****************************************************---------------------------////

implementation
uses MainUnit;

//////----------------****************************************************---------------------------////

procedure Load_commands();
begin

end;

//////----------------****************************************************---------------------------////


procedure CalcRecords();
  var I,N,Y:integer;
begin
  I:=-1;
  N:=10;
    repeat
      I:=I+1;
      begin
        if (round(Sdvig)>RecT[I]) then
          begin
            N:=N-1;
      //  records[I]:='1)'+ FormatDateTime('dd.mm.yy"   "hh:nn:ss', Now) + ' d ' + inttostr(Sdvig);
          end;
      end;
    until I>=9;
  Y:=10;
    repeat
      Y:=Y-1;
      begin
        recT[Y]:=recT[Y-1];
      end;
    until Y<=N;
  recT[N]:=Sdvig;
    for I := 0 to 9 do
      begin
        records[I]:=IntToStr(recT[I]);
      end;
end;

//////----------------****************************************************---------------------------////

procedure Load_records();
var fi:textfile;
I,N:integer;
Recmy:string;
begin
assignfile(fi,'DATA\Saves\Settings.FFS'); reset(fi);
readln(fi,DudPlayer);
readln(fi);
for I := 0 to 9 do
  begin
     readln(fi,recT[I]);
     Records[I]:=intTostr(RecT[I]);
  end;
closefile(fi);

end;

//////----------------****************************************************---------------------------////

procedure Save_records();
var fi:textfile;
I:integer;
begin
assignfile(fi,'DATA\Saves\Settings.FFS'); rewrite(fi);
Writeln(fi,DudPlayer);
Writeln(fi);
for I := 0 to 9 do
  begin
     Writeln(fi,records[I]);
  end;
closefile(fi);
end;


//////----------------****************************************************---------------------------////


procedure Active_UnActive_system();
begin
if (GetAsyncKeyState(VK_YO)<>0) then
  begin
    Commande:=true;
  end;
if (GetAsyncKeyState(VK_R)<>0) then
  begin
    SetCursorPos(screen.Width div 2,screen.Height div 2);
    Commande:=false;
  end;
end;

//////----------------****************************************************---------------------------////

procedure  ShowCom(px,py,sx,sy:integer);
begin
glPushMatrix;
  Disable_sun();
  glColor(255,255,255);
  glBindTexture(GL_TEXTURE_2D, comt);
    glBegin(GL_Quads);
      glTexCoord2d(0.0, 0.0);  glVertex2d(px-sx,py-sy);
      glTexCoord2d(1.0, 0.0);  glVertex2d(px-sx,py+sy);
      glTexCoord2d(1.0, 1.0);  glVertex2d(px+sx,py+sy);
      glTexCoord2d(0.0, 1.0);  glVertex2d(px+sx,py-sy);
    glEnd;
  glColor(255,255,255);
  Enable_sun();
GLpOPmATRIX;
end;

//////----------------****************************************************---------------------------////

end.
