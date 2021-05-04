unit processed;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, GUI, ShellAPI,
  Dialogs, OpenGL, DGLUT, Textures, Math,FreshPoc, Components, FreshText, Commands, uTextures;


//////----------------****************************************************---------------------------////

Procedure Render_Scene(ClientWidth, ClientHeight:integer);

//////----------------****************************************************---------------------------////

implementation
uses MainUnit;

//////----------------****************************************************---------------------------////

Procedure Render_Scene(ClientWidth, ClientHeight:integer);
  var I,Y,X,Zoom,J,O:integer;
begin
  LightPosition[0]:=Sun.X;
  LightPosition[1]:=Sun.Z;
  LightPosition[2]:=Sun.Y;
  LightPosition[3]:=1;
    glPushMatrix;
      Enable_Atest();
      glClearColor(0.0, 0.0, 0.0, 1);
      glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
      Enable_sun();
      glLightfv(GL_LIGHT0,GL_DIFFUSE ,@light0_diffuse);
      glLightfv(GL_LIGHT0,GL_POSITION,@LightPosition);
      glBindTexture(GL_TEXTURE_2D,Ttextobj[0]);
        glTranslatef(0,10,-10);
          glPushMatrix;
            glScalef(10,10,10);
            TObjects[0].Draw;
          glPopMatrix;
        glTranslatef(-0,-10,10);
      Disable_Sun();

    glpushmatrix();
    R3D_To_2D(ClientWidth, ClientHeight);
    if (Commande=true) then
      begin
        MouseGL(30, GLmouse);
      end;
 if StayM =0  then
 begin
     Render_Symvol('счет = '+ inttostr(round(Sdvig)),10,10,20,1,1,1,1,1);
If Sdvig<recT[0] then     Render_Symvol('рекорд = '+ records[0],10,10,40,1,1,1,1,1);
If Sdvig>=recT[0] then     Render_Symvol('рекорд = '+ intToStr(Sdvig),10,10,40,1,1,1,1,1);

//// верхние слои
     SpriteDraw(p.x, p.y-35+Sdvig, p.angleX, 35, Doodle[DudPlayer]);
     SpriteDraw(DX, DY+Sdvig, 60, 60, Dira);
for I := 0 to 15 do
  begin
     SpriteDraw(B[I].X, B[I].Y+Sdvig, 40, 10, B[I].texture);
  end;
for I := 0 to 9 do
  begin
     Render_Symvol(records[I] + '-' ,10,CW-100,-recT[I]+Sdvig,1,1,1,1,1);
  end;

 end;

 if StayM =1  then
 begin
     Render_Symvol('ваш счет',25,30,round(CH/2)-30,1,1,20,1,1);
     Render_Symvol(inttostr(round(Sdvig)),25,30,round(CH/2)+30,1,1,20,1,1);
     Render_Symvol('чтобы начать сначала нажмите enter',15,10,CH-30,1,1,200,1,1);

 end;

 if StayM =2  then
 begin
     Render_Symvol('Главное меню',25,Round(CW/2)-200,30,1,1,20,100,50);
//nder_Symvol('играть',25,Round(CW/2)-100,Round(CH/4),1,1,20,100,50);
     Symvol_Button('играть',25,Round(CW/2)-100,Round(CH/4),1,1,100,0,0, 0);
     Symvol_Button('рекорды',25,Round(CW/2)-100,Round(CH/2)-60,1,1,100,0,0, 4);
     Symvol_Button('опции',25,Round(CW/2)-100,Round(CH/2)+10,1,1,100,0,0, 3);

     Symvol_Button('выход',25,Round(CW/2)-100,Round(CH/1.5),1,1,100,0,0, 10);
     SpriteDraw(MenP.x+50, MenP.y-35+100, 35, 35, Doodle[DudPlayer]);
     SpriteDraw(MenB.X+50, MenB.Y+100, 40, 10, Block[0]);


 end;

 if StayM =3  then
 begin
     Render_Symvol('Выбор персонажа',25,100,30,1,1,20,100,50);
//nder_Symvol('играть',25,Round(CW/2)-100,Round(CH/4),1,1,20,100,50);
     SpriteButton(100,100, 25,25,Doodle[0], 20);
     SpriteButton(200,100, 25,25,Doodle[1], 21);
     SpriteButton(300,100, 25,25,Doodle[2], 22);
     SpriteButton(100,200, 25,25,Doodle[3], 23);
     SpriteButton(200,200, 25,25,Doodle[4], 24);

     SpriteButton(500,300, 45,45,Doodle[DudPlayer], 10);
     Render_Symvol('Ваш Dudl',10,480,360,1,1,20,100,50);



     Symvol_Button('назад',25,Round(CW/2)-100,Round(CH)-40,1,1,100,0,0, 2);
 end;

 if StayM =4  then
 begin
     Render_Symvol('Рекорды',25,Round(CW/2)-100,30,1,1,20,100,50);
//nder_Symvol('играть',25,Round(CW/2)-100,Round(CH/4),1,1,20,100,50);
     //Render_Symvol(FormatDateTime('dd.mm.yy"   "hh:nn:ss', Now),15,100,Round(CH/4),1,1,20,100,50);

for I := 0 to 9 do
  begin
     Render_Symvol(intTostr(I+1)+ ')  ' + records[I],10,100,Round(CH/5)+(I*25),1,1,20,100,50);
  end;

     Symvol_Button('назад',25,Round(CW/2)-100,Round(CH)-40,1,1,100,0,0, 2);
 end;



 if StayM =20  then
 begin
   DudPlayer:=0;  StayM:=3;
 end;
 if StayM =21  then
 begin
   DudPlayer:=1;  StayM:=3;
 end;
 if StayM =22  then
 begin
   DudPlayer:=2;  StayM:=3;
 end;
 if StayM =23  then
 begin
   DudPlayer:=3;  StayM:=3;
 end;
 if StayM =24  then
 begin
   DudPlayer:=4;  StayM:=3;
 end;



     SpriteDraw(ClientWidth/2, ClientHeight/2,ClientWidth/2, ClientWidth/1.5,fon);

/// нижние слои
    // код символа ♣ alt+5, символ ♣ = ?
    //Render_Symvol('текст выводится так!',30,10,90,1,1,255,255,255);
    //Symvol_Button('текстовая кнопка так!',15,20,ClientHeight-60,1,1,Pixel[0][0],Pixel[0][1],Pixel[0][2], 5);
    R2D_To_3D();

    glpopmatrix();
    Enable_sun();
    Enable_Atest();
    Enable_sun();
    Disable_sun();
    Disable_Atest();
  glPopMatrix;
end;

//////----------------****************************************************---------------------------////

end.
