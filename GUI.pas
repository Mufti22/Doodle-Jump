unit GUI;

interface
uses
winapi.Windows, winapi.Messages, SysUtils,Variants, Classes,Controls, Mesh,
OpenGL, DGLUT, Textures, Math,Components, StdCtrls, ShellAPI, Dialogs, ExtCtrls;

Type
 FMod = record
 px,py,pz: real;
 sx,sy,sz: real;
 rx,ry,rz: real;
 end;

Type
 FAnimMan = class
 Keys:integer;
 Frame:Integer;
 FLHand:array[0..59] of FMod;
 FRHand:array[0..59] of FMod;
 FTorse:array[0..59] of FMod;
 FHead: array[0..59] of FMod;
 FRFoot:array[0..59] of FMod;
 FLFoot:array[0..59] of FMod;
   public
 procedure LoadAnim(Put:String);
 procedure PlayAnim();
 end;

procedure DrawModel(x,z,y,sx,sy,sz,rx,rz,ry:Real; Model:TGLMultyMesh; Texture:GLUINT);
procedure DrawModelMesh(x,z,y,sx,sy,sz,rx,rz,ry,smx,smz,smy:Real; Model:TGLMultyMesh; Texture:GLUINT);



procedure Terrain_Create();
procedure Terrain_Draw();
procedure Terrain_Mod();
procedure Anim_H_Load();
procedure Anim_H_Draw();
procedure Line_Draw();
procedure Water_Plane_Draw();
procedure Cloth_Draw();
procedure Car_Create();
procedure Car_Draw();


implementation
uses MainUnit;



procedure DrawModel(x,z,y,sx,sy,sz,rx,rz,ry:Real; Model:TGLMultyMesh; Texture:GLUINT);
begin
glBindTexture(GL_TEXTURE_2D,Texture);
glTranslatef(x,z,y);

glRotatef(rx,0,0,1);
glRotatef(ry,0,1,0);
glRotatef(rz,1,0,0);

 glPushMatrix;
 glScalef(sx,sy,sz);
  Model.Draw;
 glPopMatrix;

glRotatef(-rz,1,0,0);
glRotatef(-ry,0,1,0);
glRotatef(-rx,0,0,1);

glTranslatef(-x,-z,-y);
end;

procedure DrawModelMesh(x,z,y,sx,sy,sz,rx,rz,ry,smx,smz,smy:Real; Model:TGLMultyMesh; Texture:GLUINT);
begin
 //Render_Sprite(x,y,z,3,Ttextobj[55]); //COJIHUE

glTranslatef(-smx,-smz,-smy);

glTranslatef(x+smx,z+smz,y+smy);
 glPushMatrix;

glRotatef(rx,0,0,1);
glRotatef(ry,0,1,0);
glRotatef(rz,1,0,0);
glBindTexture(GL_TEXTURE_2D,Texture);

glTranslatef(-smx,-smz,-smy);

 glScalef(sx,sy,sz);
  Model.Draw;

glTranslatef(smx,smz,smy);

glRotatef(-rz,1,0,0);
glRotatef(-ry,0,1,0);
glRotatef(-rx,0,0,1);
 glPopMatrix;
glTranslatef(-x-smx,-z-smz,-y-smy);

glTranslatef(smx,smz,smy);

end;






procedure FAnimMan.LoadAnim(Put: string);
Var
 Tex:TextFile;
 I:integer;
begin

 if FileExists(Put) then
 begin
   AssignFile(Tex,Put); reset(Tex);
   Readln(Tex,Keys);
   If Keys =60 then
   begin
   for I := 0 to Keys-1 do
   begin
   Readln(Tex,FHead[I].px,FHead[I].px,FHead[I].px,
              FHead[I].sx,FHead[I].sx,FHead[I].sx,
              FHead[I].rx,FHead[I].rx,FHead[I].rx);
   Readln(Tex,FTorse[I].px,FTorse[I].px,FTorse[I].px,
              FTorse[I].sx,FTorse[I].sx,FTorse[I].sx,
              FTorse[I].rx,FTorse[I].rx,FTorse[I].rx);
   Readln(Tex,FRHand[I].px,FRHand[I].px,FRHand[I].px,
              FRHand[I].sx,FRHand[I].sx,FRHand[I].sx,
              FRHand[I].rx,FRHand[I].rx,FRHand[I].rx);
   Readln(Tex,FLHand[I].px,FLHand[I].px,FLHand[I].px,
              FLHand[I].sx,FLHand[I].sx,FLHand[I].sx,
              FLHand[I].rx,FLHand[I].rx,FLHand[I].rx);
   Readln(Tex,FRFoot[I].px,FRFoot[I].px,FRFoot[I].px,
              FRFoot[I].sx,FRFoot[I].sx,FRFoot[I].sx,
              FRFoot[I].rx,FRFoot[I].rx,FRFoot[I].rx);
   Readln(Tex,FLFoot[I].px,FLFoot[I].px,FLFoot[I].px,
              FLFoot[I].sx,FLFoot[I].sx,FLFoot[I].sx,
              FLFoot[I].rx,FLFoot[I].rx,FLFoot[I].rx);
   end;
   end;
   CloseFile(Tex);
 end
 else
 begin
   ShowMessage('No File Animation in adress '+Put);
 end;
end;

procedure FAnimMan.PlayAnim;
begin

end;



procedure Terrain_Create();
begin

end;
procedure Terrain_Draw();
begin

end;
procedure Terrain_Mod();
begin

end;
procedure Anim_H_Load();
begin

end;
procedure Anim_H_Draw();
begin

end;
procedure Line_Draw();
begin

end;
procedure Water_Plane_Draw();
begin

end;
procedure Cloth_Draw();
begin

end;
procedure Car_Create();
begin

end;
procedure Car_Draw();
begin

end;


end.
