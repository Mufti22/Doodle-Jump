unit uTextures;

interface
uses
 OpenGL, Jpeg, Windows, Graphics;

type
 TBGR = record
   b,g,r : Byte;
 end;

 TRGBA = record
   r,g,b,a:Byte;
 end;

 TBGRarr  = array[0..0] of TBGR;
 TRGBAarr = array[0..0] of TRGBA;

const
 GL_BGR = $80E0;

function gluBuild2DMipmaps(Target: GLenum; Components, Width, Height: GLint; Format, atype: GLenum; Data: Pointer): GLint; stdcall; external glu32;
procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external 'opengl32.dll';
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external 'opengl32.dll';

function GenTexture(p:Pointer; w,h:Integer;b:Byte;mode:GLuint):GLuint;
function LoadJPG(const FileName : string):GLuint;
function LoadBMP24(const BMP24 : string):GLuint;

function LoadBMP25(const BMP24 : TBitmap):GLuint;

function LoadSprite(const BMP24 : string):GLuint;


implementation

function LoadSprite;
var
 bf   : TBitmapFileHeader;
 bi   : TBitmapInfoHeader;
 f    : file of Byte;
 size : Cardinal;
 p,a  : Pointer;
 x    : Integer;
begin
 Result := 0;
 AssignFile(f, BMP24);
 Reset(f);

 BlockRead(f, bf, sizeof(bf));

 if bf.bfType = $4D42 then
 begin
   BlockRead(f, bi, sizeof(bi));

   if bi.biBitCount = 24 then
   begin
     size := bi.biWidth*bi.biHeight*3;
     GetMem(p, size);
     BlockRead(f, p^, size);
     GetMem(a, bi.biWidth*bi.biHeight*4);

     for x := 0 to bi.biWidth*bi.biHeight-1 do
     begin
       TRGBAarr(a^)[x].r := TBGRArr(p^)[x].r;
       TRGBAarr(a^)[x].g := TBGRArr(p^)[x].g;
       TRGBAarr(a^)[x].b := TBGRArr(p^)[x].b;

       if (TBGRArr(p^)[x].r = 255)and(TBGRArr(p^)[x].g=0)and(TBGRArr(p^)[x].b = 255)then
       begin
         TRGBAarr(a^)[x].a := 0;
         TRGBAarr(a^)[x].r := 0;
         TRGBAarr(a^)[x].g := 0;
         TRGBAarr(a^)[x].b := 0;
       end else
           TRGBAarr(a^)[x].a := 255;

     end;

     Result := GenTexture(a, bi.biWidth, bi.biHeight, 32, GL_RGBA);

     FreeMem(a);
     FreeMem(p);
   end;
 end;

 CloseFile(f);
end;

function LoadBMP24;
var
 bf   : TBitmapFileHeader;
 bi   : TBitmapInfoHeader;
 f    : file of Byte;
 size : Cardinal;
 p    : Pointer;
begin
 Result := 0;
 AssignFile(f, BMP24);
 Reset(f);

 BlockRead(f, bf, sizeof(bf));

 if bf.bfType = $4D42 then
 begin
   BlockRead(f, bi, sizeof(bi));

   if bi.biBitCount = 24 then
   begin
     size := bi.biWidth*bi.biHeight*(bi.biBitCount div 8);
     GetMem(p, size);

     BlockRead(f, p^, size);

     Result := GenTexture(p, bi.biWidth, bi.biHeight, bi.biBitCount, GL_BGR);
   end;
 end;

 CloseFile(f);
end;















function LoadBMP25;
var
 bf   : TBitmapFileHeader;
 bi   : TBitmapInfoHeader;
 f    : file of Byte;
 size : Cardinal;
 p    : Pointer;
begin
 Result := 0;

// bf:=bmp24;


 if bf.bfType = $4D42 then
 begin
   BlockRead(f, bi, sizeof(bi));

   if bi.biBitCount = 24 then
   begin
     size := bi.biWidth*bi.biHeight*(bi.biBitCount div 8);
     GetMem(p, size);

     BlockRead(f, p^, size);

     Result := GenTexture(p, bi.biWidth, bi.biHeight, bi.biBitCount, GL_BGR);
   end;
 end;


end;





{------------------------------------------------------------------}
{  Load JPEG textures  by Jan Horn                                 }
{------------------------------------------------------------------}

function LoadJPG(const FileName : string):GLuint;
type
 TRGB = record
   r,g,b:Byte;
 end;

 TRGBarr = array[0..0] of TRGB;
var
 jpg : TJPEGImage;
 bmp : TBitmap;
 x   : Integer;
 i,j : Integer;
 p   : Pointer;
begin
 jpg := TJPEGImage.Create;
 jpg.LoadFromFile(FileName);

 bmp := TBitmap.Create;
 bmp.Assign(jpg);

 GetMem(p, jpg.Width*jpg.Height*3);

 x := 0;
 for i := 0 to jpg.Width-1 do
 begin
   for j := 0 to jpg.Height-1 do
   begin
     TRGBarr(p^)[x].r := TRGBAarr(bmp.Canvas.Pixels[i,j])[x].r;
     TRGBarr(p^)[x].g := TRGBAarr(bmp.Canvas.Pixels[i,j])[x].g;
     TRGBarr(p^)[x].b := TRGBAarr(bmp.Canvas.Pixels[i,j])[x].b;
     inc(x);
   end;
 end;

 Result := GenTexture(p, jpg.Width, jpg.Height, 24, GL_RGB);

 bmp.Free;
 jpg.Free;
 FreeMem(p);

end;

function GenTexture(p:Pointer; w,h:Integer;b:Byte;mode:GLuint):GLuint;
begin
 glGenTextures(1, Result);
 glBindTexture(GL_TEXTURE_2D, Result);

 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST);
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST_MIPMAP_NEAREST);

 gluBuild2DMipmaps(GL_TEXTURE_2D, b div 8, w, h, mode, GL_UNSIGNED_BYTE, p);
end;

end.
