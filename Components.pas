unit Components;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT,  Textures,  Math, Mesh, GLUT;

//////----------------****************************************************---------------------------////

const
  GL_CLAMP_TO_EDGE =$812F;
  GL_POLYGON_OFFSET_FILL  = $8037;

  VK_W = $57;   VK_1 = $31;
  VK_S = $53;   VK_2 = $32;
  VK_D = $44;   VK_3 = $33;
  VK_A = $41;   VK_4 = $34;
  VK_B = $42;   VK_F = $46;

  VK_G = $47;   VK_I = $49;
  VK_H = $48;   VK_L = $4C;
  VK_M = $4D;   VK_N = $4E;
  VK_O = $4F;   VK_P = $50;
  VK_T = $54;   VK_V = $56;
  VK_Y = $59;   VK_K = $4B;

  VK_X = $58;   VK_Q = $51;
  VK_E = $45;   VK_C = $43;
  VK_U = $55;   VK_Z = $5A;
  VK_J = $4A;   VK_R = $52;

  VK_YO     =  $C0;   VK_PLUS     = $BB;
  VK_MIN    =  $BD;   VK_RX       = $DB;
  VK_RZT    =  $DD;   VK_RG       = $BA;
  VK_RE     =  $DE;   VK_RB       = $BC;
  VK_RYU    =  $BE;   VK_RTOCHKA  = $BF;
  VK_PALKA  =  $DC;


//////----------------****************************************************---------------------------////

Type
  FLamp =record
    X,Y,Z:real;
    size:real;
  end;

//////----------------****************************************************---------------------------////

Type
  FGameStats = record
    Stay:integer;
    Game:boolean;
  end;

//////----------------****************************************************---------------------------////

Type
  FPlayer = record
    X,Y,Z:Real;
    angleX,AngleY: Single;
    Speed,vector,del:real;
    Check,Kill:boolean;
  end;

//////----------------****************************************************---------------------------////

Type
  FBlock =record
    X,Y:real;
    texture:uint;
    Check:boolean;
    public
    function Collision(PX:FPlayer;pcheck:boolean):boolean;
  end;

//////----------------****************************************************---------------------------////

var
   fogColor : array[0..3] of GLfloat = (0.14, 0.52, 0.89, 1); //цвет тумана
   glLightPos: array[0..2] of glFloat = (0.0, 0.0, 0.8);
   LightPosition: array[0..3] of glFloat;// = (1.0,1.0,1.0,1.0);
   light0_diffuse:array[0..3] of glFloat = (1.0, 1.0, 1.0, 1.0);
   glLightPos1: array[0..3] of glFloat = (0.8, 0.8, 3.0, 0.5);
   front_color:array[0..3] of GLFloat = (1.0, 1.0, 1.0, 1.0);
   Back_color:array[0..3] of GLFloat = (0,0,1,1);
   TempX1,TempY1,SingX,SingY,TempX2,TempY2: integer;
   Point: Tpoint;
   MouseMove1,MBL,MBR:boolean;
   FontEng,comt,Picture,GLmouse,Water,monster,rocket,rocket1,dira,fon: Uint;
   StayM,CW,CH:integer;
   Button:array[0..11] of Uint;
   SkyBox:array[0..5] of Uint;
   Doodle:array[0..4] of Uint;
   block:array[0..3] of Uint;

//////----------------****************************************************---------------------------////

procedure glGenTextures(n: GLsizei; textures: PGLuint); stdcall; external 'openGL32.dll';
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external 'openGL32.dll';
procedure glCopyTexImage2D(target: GLenum; level: GLint;
    internalFormat: GLenum; x, y: GLint; width, height: GLsizei;
    border: GLint); stdcall; external 'opengl32.dll';
procedure glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x,
    y: GLint; width, height: GLsizei); stdcall; external 'opengl32.dll';
procedure glPolygonOffset(factor, units: GLfloat); stdcall;  external 'opengl32.dll';

//////----------------****************************************************---------------------------////

procedure Texture_Creates();
procedure SpriteDraw(PX,PY,SX,SY:real;Pict:Uint);
procedure SpriteButton(PX,PY,SX,SY:real;Pict:Uint; Key:integer);
procedure MouseGL(Size:integer; Texture:Uint);
procedure ShowMenu(Stay:integer);
procedure ViewSponsor(ClientWidth, ClientHeight:integer);
procedure Render_Sprite(PX,PY,PZ,MSize:real; TT:Uint);
procedure Plane_Draw(PX,PZ,PY,MSize:real; TT:Uint; R,G,B:Byte);
procedure Random_block_Start();
procedure reset_game();
Function DiraStop(PX:FPlayer):boolean;

//////----------------****************************************************---------------------------////

implementation
uses FreshPoc,MainUnit;

procedure reset_game();
var I:integer;
begin
  for I := 1 to 10 do
  begin
  B[I].X:=200;
  B[I].Y:=10000;
  B[I].texture:=Block[0];
  end;
for I := 11 to 12 do
  begin
  B[I].X:=200;
  B[I].Y:=10000;
  B[I].texture:=Block[2];
  end;

for I := 13 to 15 do
  begin
  B[I].X:=200;
  B[I].Y:=10000;
  B[I].texture:=Block[1];
  b[i].Check:=true;
  end;
  B[0].X:=200;
  B[0].Y:=500;
  B[0].texture:=Block[0];
    P.X:=200; P.Y:=100; p.vector:=0; p.angleX:=35;
    Sdvig:=0;
end;


Function DiraStop(PX:FPlayer):boolean;
begin
  if (PX.X<DX+30) and (PX.X>DX-30) and (PX.Y<DY+30) and (PX.Y>DY-30) then
  begin
    result:=true;
  end
  else
  begin
    result:=false;
  end;


end;

//////----------------****************************************************---------------------------////

function FBlock.Collision;
begin
if (pX.X>X-40) and (px.x<X+40) and (px.y>y-10) and (px.y<y+10) then
  begin
        result:=true;
  end
  else
  begin
        result:=false;
  end;

end;

//////----------------****************************************************---------------------------////

procedure ViewSponsor(ClientWidth, ClientHeight:integer);
begin
  CW:= ClientWidth;
  CH:= ClientHeight;
end;

//////----------------****************************************************---------------------------////

procedure Random_block_Start();
var I:integer;
begin

 for I := 0 to 15 do
   begin
     if b[I].Y+Sdvig>CH then
     begin
       randomize;
       b[I].Y:=b[I].Y-random(CH)-random(CH);
       b[I].X:=40+random(CW-100);
     end
     else
     begin

     end;
   end;
end;


procedure SpriteDraw(PX,PY,SX,SY:real;Pict:Uint);
begin
  glPushMatrix;
  Disable_sun();
     //  glColor(255,255,255);
  glBindTexture(GL_TEXTURE_2D, Pict);
    glBegin(GL_Quads);
      glTexCoord2d(0.0, 1.0);  glVertex2d(px-sx,py-sy);
      glTexCoord2d(0.0, 0.0);  glVertex2d(px-sx,py+sy);
      glTexCoord2d(1.0, 0.0);  glVertex2d(px+sx,py+sy);
      glTexCoord2d(1.0, 1.0);  glVertex2d(px+sx,py-sy);
    glEnd;
       // glColor(255,255,255);
  Enable_sun();
  GLpOPmATRIX;
end;

//////----------------****************************************************---------------------------////

procedure Render_Sprite(PX,PY,PZ,MSize:real; TT:Uint);
begin
  glTranslatef(PX,PZ,PY);
    glPushMatrix;
      glRotatef(P.angleX+90,0,0,1);
      glRotatef(-P.angleY,0,1,0);
      glRotatef(90,0,1,0);
      Disable_sun();
        glScalef(1,1,1);
        SpriteDraw(0,0,MSize,MSize,TT);
      Enable_sun();
      glRotatef(-90,0,1,0);
      glRotatef(P.angleY,0,1,0);
      glRotatef(-P.angleX-90,0,0,1);
    glPopMatrix;
  glTranslatef(-PX,-PZ,-PY);
end;

//////----------------****************************************************---------------------------////

procedure Plane_Draw(PX,PZ,PY,MSize:real; TT:Uint; R,G,B:Byte);
begin
  glTranslatef(PX,PZ,PY);
    glPushMatrix;
    Disable_sun();
      glScalef(1,1,1);
      glColor4f(R,G,B,100);
        SpriteDraw(0,0,MSize,MSize,TT);
      glColor4f(255,255,255,255);
    Enable_sun();
    glPopMatrix;
  glTranslatef(-PX,-PZ,-PY);
end;

//////----------------****************************************************---------------------------////

procedure SpriteButton(PX,PY,SX,SY:real;Pict:Uint; Key:integer);
var X,Y:integer;
begin
  GetCursorPos(Point);
  X:=-MainForm.Left +Point.X;
  Y:=-MainForm.Top-15  +point.Y;
  SpriteDraw(PX,PY,SX,SY,Pict);
    if (X<px+sx) and (X>px-sx) then
      if (Y<py+sy) and (Y>py-sy) then
        if (GetAsyncKeyState(VK_LBUTTON)<>0) and (MBL=false) then
          begin
          if Key=10 then
            begin
              // RayCast();
            end;
          if Key<>10 then
            begin
               StayM:=Key;
            end;
            MBL:=true;
      end;
end;

//////----------------****************************************************---------------------------////

procedure MouseGL(Size:integer; Texture:Uint);
var X,Y:integer;
begin
  GetCursorPos(Point);
  X:=point.X;
  Y:=point.Y;
    glPushMatrix;
    Disable_sun();
    glColor(255,255,255);
    glBindTexture(GL_TEXTURE_2D, Texture);
      glBegin(GL_Quads);
        glTexCoord2d(0.0, 1.0);  glVertex2d(x,y);
        glTexCoord2d(0.0, 0.0);  glVertex2d(x,y+Size*1.5);
        glTexCoord2d(1.0, 0.0);  glVertex2d(x+Size*1.5,y+Size*1.5);
        glTexCoord2d(1.0, 1.0);  glVertex2d(x+Size*1.5,y);
      glEnd;
    glColor(255,255,255);
  Enable_sun();
  GLpOPmATRIX;
end;

//////----------------****************************************************---------------------------////

procedure Texture_Creates();
begin
  glEnable(GL_TEXTURE_2D);   //Включаем режим наложения текстур
  glEnable(GL_ALPHA_TEST);     //Разрешаем альфа тест (прозрачность текстур)
  glAlphaFunc(GL_GREATER,0.025);
  glEnable (GL_BLEND);         //Включаем режим смешивания цветов
  glDepthMask(GL_True);
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA) ; //Тип смешивания
  glTexEnvi( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE );
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA) ; //Тип смешивания
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); //Параметры наложения текстуры
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR); //Параметры наложения текстуры
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);


    LoadTexture('resourse\Font\MyFont.tga',FontEng,false);
    LoadTexture('resourse\Font\comt.tga',comt,false);
    //LoadTexture('resourse\data\textures\mouse.tga',GLmouse,false);
    //LoadTexture('resourse\data\textures\o.tga',Button[11],false);
    LoadTexture('resourse\data\textures\menu.tga',Ttextobj[0],false);

    LoadTexture('resourse\data\textures\background.tga',fon,false);
    LoadTexture('resourse\data\textures\Dud1.tga',Doodle[0],false);
    LoadTexture('resourse\data\textures\Dud2.tga',Doodle[1],false);
    LoadTexture('resourse\data\textures\Dud3.tga',Doodle[2],false);
    LoadTexture('resourse\data\textures\Dud4.tga',Doodle[3],false);
    LoadTexture('resourse\data\textures\Dud5.tga',Doodle[4],false);
    LoadTexture('resourse\data\textures\Block.tga',block[0],false);
    LoadTexture('resourse\data\textures\Block2.tga',block[1],false);
    LoadTexture('resourse\data\textures\Block3.tga',block[2],false);
    LoadTexture('resourse\data\textures\monster.tga',monster,false);
    LoadTexture('resourse\data\textures\D.tga',dira,false);
    LoadTexture('resourse\data\textures\rocket.tga',rocket,false);
    LoadTexture('resourse\data\textures\rocket1.tga',rocket1,false);
end;

//////----------------****************************************************---------------------------////

procedure ShowMenu(Stay:integer);
begin
  if Stay=1 then
    begin
      SpriteDraw(CW/2, CH/2,CW/2, CH/2,Button[6]);
    end;
end;

//////----------------****************************************************---------------------------////


end.
