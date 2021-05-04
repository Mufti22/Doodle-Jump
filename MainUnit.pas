unit MainUnit;

interface

uses
  Windows, Messages, OpenGL, SysUtils, Variants, Classes, Controls, Forms, Contnrs, Graphics, Dialogs,
  DGLUT, Textures, StdCtrls, ExtCtrls, glForms, Mesh, Unit1, Math, FreshPoc, Components,
  ShellAPI, FreshText, processed, Commands;

//////----------------****************************************************---------------------------////

type
  TMainForm = class(TGLForm)
    Graphics: TTimer;
    FPST: TTimer;
    Timer1: TTimer;
    Phizics: TTimer;
    controls: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure GraphicsTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PhizicsTimer(Sender: TObject);
    procedure FPSTTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure DrawScene;
  end;

//////----------------****************************************************---------------------------////

var
   HRC : HGLRC;
   DC:HDC;
   P,MenP:FPlayer;
   Pic:TBitmap;
   MainForm: TMainForm;
   Ttextobj : array[0..256] of Uint;
   M:integer;
   TObjects : array of TGLMultyMesh;
   Sun:FLamp;
   B:array[0..20] of FBlock;
   Sdvig:integer;
   DudPlayer:integer;
   MenB:FBlock;
   records:array[0..9] of string;
   recT:array[0..9] of integer;
   DX,DY:integer;

implementation
{$R *.dfm}

//////----------------****************************************************---------------------------////

procedure TMainForm.DrawScene;
  var fi:textfile;
begin
  ViewRender(ClientWidth, ClientHeight);
  ViewSponsor(ClientWidth, ClientHeight);
    if (GetAsyncKeyState(VK_ESCAPE)<>0) and (StayM<>1) then
      begin
        StayM:=2;
      end;

    if (GetAsyncKeyState(VK_LButton)=0) and (MBL=true)then
      begin
       MBL:=false;
      end;

      if StayM =100  then
      begin
        Close;
      end;
     glPushMatrix;
     glScissor(0,0,ClientWidth , ClientHeight);
     glEnable(GL_SCISSOR_TEST);
     Active_UnActive_system();
if StayM=0 then
begin
Random_block_Start();
     Phizica_Doodla();
     DiraWin();
     if p.Check=false then p.vector:=p.vector-0.007;

if p.Y+Sdvig<100 then  Sdvig:=Sdvig+round(p.del);
if p.Y+Sdvig>CH+10 then  StayM:=1;

if p.X<-25 then  p.X:=CW+25;
if p.X>CW+25 then  p.X:=-25;
  if p.del>-7 then   p.del:=p.del+p.vector;
     p.Y:=p.Y-p.del;
end
else
begin

  Phizica_Doodla2();
     if MenP.Check=false then MenP.vector:=MenP.vector-0.007;

  if MenP.del>-7 then   MenP.del:=MenP.del+MenP.vector;
     MenP.Y:=MenP.Y-MenP.del;

end;

  {   if (Commande=false) then
       begin
         Mouse_Move();
       end;   }
         Key_Move();

         GluLookAt(P.X+(sin((-p.AngleX)/180*PI))*4,P.Z+(Cos(-p.AngleX/180*PI))*4,P.Y+19,P.X+
             sin((-p.AngleX)/180*PI)*5,P.Z+Cos(-p.AngleX/180*PI)*5,P.Y+19+tan(p.AngleY/180*PI),0,0,1);
          Render_Scene(ClientWidth, ClientHeight);
       glPopMatrix;
 SwapBuffers(Canvas.Handle);
end;


//////----------------****************************************************---------------------------////



procedure TMainForm.FormCreate(Sender: TObject);
begin
  showCursor(false);
  Graphics.Enabled := True;
end;


//////----------------****************************************************---------------------------////

procedure TMainForm.FormDestroy(Sender: TObject);
  var I, Mass:integer;
begin
  mass:=1;
  for I := 0 to Mass-1 do
    Begin
      TObjects[I].Free;
    end;
  Save_records();
end;

//////----------------****************************************************---------------------------////

procedure TMainForm.FormPaint(Sender: TObject);
  var fi:textfile;  Mass,I,O:integer;
begin
  Form1.Show;
  pic:=Tbitmap.create;
  pic.Loadfromfile('resourse\Font\starting.bmp');
  form1.canvas.draw(0,0,pic);
    mass:=1;
    MassivTexta();
    Texture_Creates();
    SetLength(TObjects, Mass);
         TObjects[0] := TGLMultyMesh.Create;
         TObjects[0].LoadFromFile('DATA\Models\Box.gms');
         TObjects[0].Extent := true;
         TObjects[0].fSmooth := false; // Установить в фасеты
    Sun.x :=500;
    Sun.z :=-300;
    sun.y :=400;
  Commande:=false;
    sleep(1000);
  P.X:=200; P.Y:=100; p.vector:=0; p.angleX:=35;

  MenP.X:=30;
  MenP.Y:=100;
  MenP.vector:=0;

  MenB.X:=50;
  MenB.Y:=350;

  Load_records();

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
//Random_block_Start();
  StayM:=2;
  DX:=500;
  DY:=600;
  showCursor(true);
  Form1.Destroy;
  DrawScene;
end;

//////----------------****************************************************---------------------------////

procedure TMainForm.FormShow(Sender: TObject);
begin
  Resize;
end;

procedure TMainForm.FPSTTimer(Sender: TObject);
begin
  randomize;
  DX:=random(800);
  DY:=-Sdvig-random(1000);
end;

//////----------------****************************************************---------------------------////

procedure TMainForm.GraphicsTimer(Sender: TObject);
begin
  DrawScene;
end;

//////----------------****************************************************---------------------------////

procedure TMainForm.PhizicsTimer(Sender: TObject);
var I,Y,P,O:integer;
begin
  for I := 13 to 15 do
    begin

    if b[i].X<40 then  b[i].Check:=true;
    if b[i].X>CW-40 then  b[i].Check:=false;

      if B[I].Check=true then
        begin
          B[I].X:=B[I].X+2;
        end
        else
        begin
          B[I].X:=B[I].X-2;
        end;
    end;

end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
//MainForm.Position:=poDesktopCenter;

end;

//////----------------****************************************************---------------------------////


end.
