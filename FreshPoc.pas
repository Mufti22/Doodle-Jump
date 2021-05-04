unit FreshPoc;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures, Math, Components;

//////----------------****************************************************---------------------------////

 procedure Enable_sun();
 procedure Disable_sun();
 procedure Enable_Atest();
 procedure Disable_Atest();
 procedure Fog();
 procedure ViewRender(ClientWidth, ClientHeight:integer);
 procedure Mouse_Move();
 procedure Key_Move();
 procedure Phizica_Doodla();
 function Phizica_blocka(x,y:real):boolean;
 procedure Phizica_Doodla2();
 procedure DiraWin();

//////----------------****************************************************---------------------------////

implementation

uses MainUnit,Commands;

//////----------------****************************************************---------------------------////

function Phizica_blocka(x,y:real):boolean;
begin



end;

//////----------------****************************************************---------------------------////
procedure DiraWin();
begin
  if DiraStop(P)=true then
  begin
    p.vector:=0;
    p.del:=0;
    sleep(1000);
    StayM:=1;
  end
  else
  begin

  end;

end;



procedure Phizica_Doodla();
var I:integer;
begin

for I := 0 to 15 do
  begin
if B[I].Collision(P,p.Check)= true then
begin
  if (p.del<0) and (B[I].texture<>block[2]) then
  begin
   p.vector:=0.2;
   p.del:=4;
   p.Check:=true;
  end;
end
else
begin
  p.Check:=false;
end;
  end;

for I := 0 to 15 do
  begin
if B[I].Collision(P,p.Check)= true then
begin
  if (p.del<0) and (B[I].texture=block[2]) then
  begin
       randomize;
       b[I].Y:=b[I].Y-random(CH)-random(CH);
       b[I].X:=40+random(CW-100);
  end;
end
else
begin
  p.Check:=false;
end;
  end;


end;


procedure Phizica_Doodla2();
var I:integer;
begin

if MenB.Collision(MenP,MenP.Check)= true then
begin
  if (MenP.del<0) then
  begin
   MenP.vector:=0.2;
   MenP.del:=4;
   MenP.Check:=true;
  end;
end
else
begin
  MenP.Check:=false;
end;




end;


//////----------------****************************************************---------------------------////

procedure Key_Move();
begin
  p.Speed:=3.6;
  if (GetAsyncKeyState(VK_W)<>0) then
    begin
      //P.Y:=P.Y-p.Speed;

    end;

  if (GetAsyncKeyState(VK_S)<>0) then
    begin
     // P.Y:=P.Y+p.Speed;
    end;

  if (GetAsyncKeyState(VK_D)<>0) or (GetAsyncKeyState(VK_right)<>0)  then
    begin
      P.X:=P.X+p.Speed;
      p.angleX:=-35;
    end;



  if (GetAsyncKeyState(VK_A)<>0) or (GetAsyncKeyState(VK_left)<>0)  then
    begin
      P.X:=P.X-p.Speed;
      p.angleX:=35;
    end;

  if (GetAsyncKeyState(VK_Return)<>0) and (StayM=1) then
    begin
      CalcRecords();
      reset_game();

      StayM:=0;
    end;

  if (GetAsyncKeyState(VK_Escape)<>0) and (StayM=1) then
    begin
      CalcRecords();
      reset_game();

      StayM:=2;
    end;

end;

//////----------------****************************************************---------------------------////

procedure Mouse_Move();
begin
  begin
    try                                                               //
      if MouseMove1=false then                                        //
        begin                                                         //
          GetCursorPos(Point);                                        //
          TempX1:=point.X;                                            //
          TempY1:=point.Y;                                            //
          MouseMove1:=true;                                           //
        end;                                                          //
    finally                                                           //
      SetCursorPos(screen.Width div 2,screen.Height div 2);           //
      //SetCursorPos((W div 2) +WLe,(H div 2) +WTo);                  //
      GetCursorPos(Point) ;                                           //
        if MouseMove1=true then                                       //
          begin                                                       //
            TempX2:=point.X;                                          //
            TempY2:=point.Y;                                          //
            SingX:=TempX1-TempX2;                                     //
            SingY:=TempY1-TempY2;                                     //
            P.AngleY  :=p.AngleY  +(-SingY/8);                        //
            p.angleX:=p.angleX+(-SingX/4);                            //
            TempX1:=0;                                                //
            TempY1:=0;                                                //
            TempX2:=0;                                                //
            TempY2:=0;                                                //
            SingX:=0;                                                 //
            SingY:=0;                                                 //
            MouseMove1:=false;                                        //
          end;                                                        //
      end;
  end;
end;

//////----------------****************************************************---------------------------////

procedure ViewRender(ClientWidth, ClientHeight:integer);
begin
  begin
    glViewport(0, 0, ClientWidth,ClientHeight);
    glMatrixMode ( GL_PROJECTION ); //переходим в матрицу проекции
    glLoadIdentity;  //—брасываем текущую матрицу
    gluPerspective(60,ClientWidth/ClientHeight,0.001,10000); //ќбласть видимости
    glMatrixMode ( GL_MODELVIEW ); //переходим в модельную матрицу
    glLoadIdentity;//—брасываем текущую матрицу
    glOrtho(-1.2, 1.2, -1.2, 1.2, 1, 1);
  end;
end;

//////----------------****************************************************---------------------------////

procedure Enable_sun();
begin
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
end;

//////----------------****************************************************---------------------------////

procedure Disable_sun();
begin
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
end;

//////----------------****************************************************---------------------------////

procedure Enable_Atest();
begin
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_NORMALIZE);
  glEnable(GL_COLOR_MATERIAL);
  glShadeModel(GL_SMOOTH);
end;

//////----------------****************************************************---------------------------////

procedure Disable_Atest();
begin
  glDisable(GL_NORMALIZE);
  glDisable(GL_COLOR_MATERIAL);
  glDisable(GL_DEPTH_TEST);
end;

//////----------------****************************************************---------------------------////

procedure Fog();
begin
  glFogi(GL_FOG_MODE, GL_LINEAR ); // задаем закон смешени€ тумана
  glHint(GL_FOG_HINT, GL_NICEST);
  glFogf(GL_FOG_START , 700); // начало тумана
  glFogf(GL_FOG_END , 1500); // конец тумана
  glFogfv(GL_FOG_COLOR, @fogColor); // цвет дымки6
  glFogf(GL_FOG_DENSITY, 0.5); // плотность тумана
end;

//////----------------****************************************************---------------------------////


end.
