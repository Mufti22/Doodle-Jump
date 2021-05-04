unit Unit1;

interface

uses
  Windows, Messages, OpenGL, SysUtils, Variants, Classes, Controls, Forms,
  Contnrs, Graphics, Dialogs, DGLUT,  Textures, StdCtrls, ExtCtrls, glForms;

//////----------------****************************************************---------------------------////

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  end;

//////----------------****************************************************---------------------------////

var
  Form1: TForm1;

//////----------------****************************************************---------------------------////

implementation
uses MainUnit;
{$R *.dfm}

//////----------------****************************************************---------------------------////

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.color:=$3f3f3f;
end;

//////----------------****************************************************---------------------------////

end.
