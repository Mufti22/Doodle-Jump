unit TextureGL;

interface

Uses
  Windows, Messages, Classes, Graphics, Forms, ExtCtrls, Menus,
  Controls, Dialogs, SysUtils, OpenGL, Math;

Type
  TTextureGL = class
    Width,
    Height : Integer;
    pBits : pByteArray;
    Destructor Destroy; override;
    procedure LoadFromFile( const AFileName : String);
    procedure Enable;
    procedure Disable;
  end;

implementation

Destructor TTextureGL.Destroy;
begin
  if Assigned(pBits) then FreeMem(pBits);
  Inherited Destroy;
end;

procedure TTextureGl.LoadFromFile( const AFileName : String);
var B : TBitmap;
    i,j : Integer;
begin
  B := TBitmap.Create;
  B.LoadFromFile(AFileName);
  Width := B.Width;
  Height := B.Height;

  GetMem(pBits,Width*Height*3);

  for j := 0 to Height - 1 do begin
    for i := 0 to Width - 1 do begin
      pBits[(j*Width + i)*3] := GetRValue(B.Canvas.Pixels[i,j]);
      pBits[(j*Width + i)*3+1] := GetGValue(B.Canvas.Pixels[i,j]);
      pBits[(j*Width + i)*3+2] := GetBValue(B.Canvas.Pixels[i,j]);
    end;
  end;

  B.Free;
end;

procedure TTextureGL.Enable;
begin
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

  glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,Width,Height,0,GL_RGB,GL_UNSIGNED_BYTE,pBits);

  glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_DECAL);
  glEnable(GL_TEXTURE_2D);
end;

procedure TTextureGL.Disable;
begin
  glDisable(GL_TEXTURE_2D);
end;

end.
