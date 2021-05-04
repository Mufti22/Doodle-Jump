
unit glForms;

interface

uses Classes, Windows, Messages, Forms, OpenGL;

type

  TGLForm = class(TForm)
  private
    FOpenGLInitialize: Boolean;

    FPosZ: glFloat;

    { Initialize OpenGL variables }
    FDC: HDC;
    FHRC: HGLRC;
    FNPixelFormat: Integer;
    FPixelFormatDescriptor: TPixelFormatDescriptor;

    { Full Screen variables }
    FFullScreen: Boolean;
    FSaveWindowState: TWindowState;
    FSaveBorderStyle: TBorderStyle;

    procedure InitializeOpenGL;
    procedure ReleaseOpenGL;

    procedure SetFullScreen(const AFFullScreen: Boolean);

    // см.: http://alexeyspace.ru/articles/1/
    procedure WMErasebkgnd(var Msg: TWMErasebkgnd); message WM_ERASEBKGND;
  protected
    procedure Paint; override;
    procedure DoCreate; override;
    procedure DoDestroy; override;
    procedure Resizing(State: TWindowState); override;
  public
    property PosZ: glFloat read FPosZ write FPosZ;
    property FullScreen: Boolean read FFullScreen write SetFullScreen;
  end;

implementation

{ TGLForm }

procedure TGLForm.InitializeOpenGL;
begin
  FillChar(FPixelFormatDescriptor, SizeOf(FPixelFormatDescriptor), 0);

  FPixelFormatDescriptor.dwFlags := PFD_DOUBLEBUFFER or
                                    PFD_SUPPORT_OPENGL or
                                    PFD_DRAW_TO_WINDOW or
                                    PFD_GENERIC_ACCELERATED;

  FNPixelFormat := ChoosePixelFormat(Canvas.Handle, @FPixelFormatDescriptor);
  SetPixelFormat(Canvas.Handle, FNPixelFormat, @FPixelFormatDescriptor);

  FDC := GetDC(Handle);

  FHRC := wglCreateContext(FDC);
  wglMakeCurrent(FDC, FHRC);

  FOpenGLInitialize := True;
end;

procedure TGLForm.Paint;
begin
  inherited;
end;

procedure TGLForm.ReleaseOpenGL;
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(FHRC);
  ReleaseDC(Handle, FDC);
end;

procedure TGLForm.Resizing(State: TWindowState);
begin
  inherited Resizing(State);
  if FOpenGLInitialize then
  begin
    glViewport(0, 0, ClientWidth, ClientHeight);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    gluPerspective(30.0, ClientWidth / ClientHeight, 1, 10);
    glTranslate(0, 0, -6);
    glMatrixMode(GL_MODELVIEW);
    InvalidateRect(Handle, nil, False);
  end;
end;

procedure TGLForm.SetFullScreen(const AFFullScreen: Boolean);
begin
  FFullScreen := AFFullScreen;
  if FFullScreen then
  begin
    FSaveBorderStyle := BorderStyle;
    FSaveWindowState := WindowState;
    BorderStyle := bsNone;
    WindowState := wsMaximized;
  end else
  begin
    BorderStyle := FSaveBorderStyle;
    WindowState := FSaveWindowState;
  end;
end;

procedure TGLForm.WMErasebkgnd(var Msg: TWMErasebkgnd);
begin
//
end;

procedure TGLForm.DoCreate;
begin
  inherited;
  FOpenGLInitialize := False;
  FSaveBorderStyle := bsNone;
  FSaveWindowState := wsNormal;
  InitializeOpenGL;
end;

procedure TGLForm.DoDestroy;
begin
  ReleaseOpenGL;
  inherited;
end;

end.
