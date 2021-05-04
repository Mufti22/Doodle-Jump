unit FreshText;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures, Math, Components, FreshPoc;

//////----------------****************************************************---------------------------////

type
  FFont = record
    x,y,sim,Leg,a: integer;
 end;

//////----------------****************************************************---------------------------////

var
  cis:integer;
  Sim:array[1..172] of string;
  FontI:array[1..169] of FFont;

//////----------------****************************************************---------------------------////

procedure Smart_Symvol(a:string);
procedure MassivTexta();
procedure Render_Symvol(Simvol:string; Size,X,Y,D,S:integer;  R,G,B:Byte);
procedure Symvol_Button(Simvol:string; Size,X,Y,D,S:integer;  R,G,B:Byte; Key:integer);
procedure R3D_To_2D(ClientWidth, ClientHeight:integer);
procedure R2D_To_3D();

//////----------------****************************************************---------------------------////

implementation
uses MainUnit, commands;

//////----------------****************************************************---------------------------////

procedure MassivTexta();
  var I,Y,B,J:integer;
begin
  Sim[1]:= 'A';Sim[2]:= 'B';
  Sim[3]:= 'C';Sim[4]:= 'D';
  Sim[5]:= 'E';Sim[6]:= 'F';
  Sim[7]:= 'G';Sim[8]:= 'H';
  Sim[9]:= 'I';Sim[10]:= 'J';
  Sim[11]:= 'K';Sim[12]:= 'L';
  Sim[13]:= 'M';Sim[14]:= 'N';
  Sim[15]:= 'O';Sim[16]:= 'P';
  Sim[17]:= 'Q';Sim[18]:= 'R';
  Sim[19]:= 'S';Sim[20]:= 'T';
  Sim[21]:= 'U';Sim[22]:= 'V';
  Sim[23]:= 'W';Sim[24]:= 'X';
  Sim[25]:= 'Y';Sim[26]:= 'Z';
  Sim[27]:= 'a';Sim[28]:= 'b';
  Sim[29]:= 'c';Sim[30]:= 'd';
  Sim[31]:= 'e';Sim[32]:= 'f';
  Sim[33]:= 'g';Sim[34]:= 'h';
  Sim[35]:= 'i';Sim[36]:= 'j';
  Sim[37]:= 'k';Sim[38]:= 'l';
  Sim[39]:= 'm';Sim[40]:= 'n';
  Sim[41]:= 'o';Sim[42]:= 'p';
  Sim[43]:= 'q';Sim[44]:= 'r';
  Sim[45]:= 's';Sim[46]:= 't';
  Sim[47]:= 'u';Sim[48]:= 'v';
  Sim[49]:= 'w';Sim[50]:= 'x';
  Sim[51]:= 'y';Sim[52]:= 'z';
  Sim[53]:= 'А';Sim[54]:= 'Б';
  Sim[55]:= 'В';Sim[56]:= 'Г';
  Sim[57]:= 'Д';Sim[58]:= 'Е';
  Sim[59]:= 'Ё';Sim[60]:= 'Ж';
  Sim[61]:= 'З';Sim[62]:= 'И';
  Sim[63]:= 'Й';Sim[64]:= 'К';
  Sim[65]:= 'Л';Sim[66]:= 'М';
  Sim[67]:= 'Н';Sim[68]:= 'О';
  Sim[69]:= 'П';Sim[70]:= 'Р';
  Sim[71]:= 'С';Sim[72]:= 'Т';
  Sim[73]:= 'У';Sim[74]:= 'Ф';
  Sim[75]:= 'Х';Sim[76]:= 'Ц';
  Sim[77]:= 'Ч';Sim[78]:= 'Ш';
  Sim[79]:= 'Щ';Sim[80]:= 'Ъ';
  Sim[81]:= 'Ы';Sim[82]:= 'Ь';
  Sim[83]:= 'Э';Sim[84]:= 'Ю';
  Sim[85]:= 'Я';Sim[86]:= '!';
  Sim[87]:= '"';Sim[88]:= '№';
  Sim[89]:= ';';Sim[90]:= '%';
  Sim[91]:= ':';Sim[92]:= '♣';
  Sim[93]:= '*';Sim[94]:= '(';
  Sim[95]:= ')';Sim[96]:= '-';
  Sim[97]:= '=';Sim[98]:= '_';
  Sim[99]:= '+';Sim[100]:= '/';
  Sim[101]:= '\';Sim[102]:= '.';
  Sim[103]:= ',';Sim[104]:= '~';
  Sim[105]:= 'а';Sim[106]:= 'б';
  Sim[107]:= 'в';Sim[108]:= 'г';
  Sim[109]:= 'д';Sim[110]:= 'е';
  Sim[111]:= 'ё';Sim[112]:= 'ж';
  Sim[113]:= 'з';Sim[114]:= 'и';
  Sim[115]:= 'й';Sim[116]:= 'к';
  Sim[117]:= 'л';Sim[118]:= 'м';
  Sim[119]:= 'н';Sim[120]:= 'о';
  Sim[121]:= 'п';Sim[122]:= 'р';
  Sim[123]:= 'с';Sim[124]:= 'т';
  Sim[125]:= 'у';Sim[126]:= 'ф';
  Sim[127]:= 'х';Sim[128]:= 'ц';
  Sim[129]:= 'ч';Sim[130]:= 'ш';
  Sim[131]:= 'щ';Sim[132]:= 'ъ';
  Sim[133]:= 'ы';Sim[134]:= 'ь';
  Sim[135]:= 'э';Sim[136]:= 'ю';
  Sim[137]:= 'я';Sim[138]:= ''+Chr(39)+'';
  Sim[139]:= '@';Sim[140]:= '#';
  Sim[141]:= '$';Sim[142]:= '^';
  Sim[143]:= '[';Sim[144]:= ']';
  Sim[145]:= '<';Sim[146]:= '>';
  Sim[147]:= '{';Sim[148]:= '}';
  Sim[149]:= '|';Sim[150]:= '1';
  Sim[151]:= '2';Sim[152]:= '3';
  Sim[153]:= '4';Sim[154]:= '5';
  Sim[155]:= '6';Sim[156]:= '7';
  Sim[157]:= '8';Sim[158]:= '9';
  Sim[159]:= '0';Sim[160]:= '©';
  Sim[161]:= '®';Sim[162]:= '™';
  Sim[163]:= '±';Sim[164]:= '&';
  Sim[165]:= '÷';Sim[166]:= ' ';
  Sim[167]:= '→';Sim[168]:= '≈';
  Sim[169]:= '`';

B:=169;
  for Y := 1 to 13 do
    begin
      for I := -13 to -1 do
        begin
          FontI[B].x:=I*(-1);
          FontI[B].y:=Y;
          B:=B-1;
        end;
    end;
end;

//////----------------****************************************************---------------------------////

procedure Smart_Symvol(a:string);
  var X,I,Z:integer;
begin
  for I := 1 to 169 do
    begin
      if a[1] = Sim[I] then
        begin
          cis:=I;
        end;
    end;
end;

//////----------------****************************************************---------------------------////

procedure Render_Symvol(Simvol:string; Size,X,Y,D,S:integer; R,G,B:Byte);
  var BB,I:Integer;
      Text:FFont;
begin
  Text.Leg:=Length(Simvol);
  glPushMatrix;
  Disable_sun();
  glBindTexture(GL_TEXTURE_2D, FontEng);
  glColor(R,G,B);
    for I := 1 to Text.Leg do
      begin
        Smart_Symvol(Simvol[I]);
        BB:=cis;
          glBegin(GL_Quads);
            glTexCoord((FontI[BB].x-1)/13, (FontI[BB].y)/13);   glVertex((-1*Size)+x+((Size*1.5)*I), (-1*Size)+Y);
            glTexCoord((FontI[BB].x-1)/13, (FontI[BB].y-1)/13); glVertex((-1*Size)+X+((Size*1.5)*I), (1*Size)+Y);
            glTexCoord((FontI[BB].x)/13,   (FontI[BB].y-1)/13); glVertex((1*Size)+X+((Size*1.5)*I),  (1*Size)+Y);
            glTexCoord((FontI[BB].x)/13,   (FontI[BB].y)/13);   glVertex((1*Size)+X+((Size*1.5)*I),  (-1*Size)+Y);
          glEnd;
      end;
  glColor(255,255,255);
  GLpOPmATRIX;
end;

//////----------------****************************************************---------------------------////

procedure Symvol_Button(Simvol:string; Size,X,Y,D,S:integer; R,G,B:Byte; Key:integer);
  var BB,I:Integer;
      Text:FFont;
      MX,MY:integer;
begin
  GetCursorPos(Point);
  MX:=-MainForm.Left +Point.X;
  MY:=-MainForm.Top-15  +point.Y;
  Text.Leg:=Length(Simvol);
    glPushMatrix;
      Disable_sun();
      glBindTexture(GL_TEXTURE_2D, FontEng);
      glColor(R,G,B);
        if (MX<(-1*Size)+x+((Size*1.5)*(Text.Leg+1))) and (MX>(-1*Size)+x+((Size*1.5)*1)) then
          if (MY<(1*Size)+Y) and (MY>(-1*Size)+Y) then
            begin
              glColor(255,255,0);
            end;
      for I := 1 to Text.Leg do
        begin
          Smart_Symvol(Simvol[I]);
          BB:=cis;
          glBegin(GL_Quads);
            glTexCoord((FontI[BB].x-1)/13, (FontI[BB].y)/13);   glVertex((-1*Size)+x+((Size*1.5)*I), (-1*Size)+Y);
            glTexCoord((FontI[BB].x-1)/13, (FontI[BB].y-1)/13); glVertex((-1*Size)+X+((Size*1.5)*I), (1*Size)+Y);
            glTexCoord((FontI[BB].x)/13,   (FontI[BB].y-1)/13); glVertex((1*Size)+X+((Size*1.5)*I),  (1*Size)+Y);
            glTexCoord((FontI[BB].x)/13,   (FontI[BB].y)/13);   glVertex((1*Size)+X+((Size*1.5)*I),  (-1*Size)+Y);
          glEnd;
        end;
      glColor(255,255,255);
    GLpOPmATRIX;
      if (MX<(-1*Size)+x+((Size*1.5)*(Text.Leg+1))) and (MX>(-1*Size)+x+((Size*1.5)*1)) then
        if (MY<(1*Size)+Y) and (MY>(-1*Size)+Y) then
          if (GetAsyncKeyState(VK_LBUTTON)<>0) and (MBL=false) then
            begin
              if Key=10 then
                begin
                  StayM:=100;
                end;
              if Key<>10 then
                begin
                    StayM:=Key;
                end;
       MBL:=true;
    end;
end;

//////----------------****************************************************---------------------------////

procedure R3D_To_2D(ClientWidth, ClientHeight:integer);
begin
  glPushMatrix;
  glLoadIdentity;
  glMatrixMode(GL_PROJECTION);
  glPushMatrix;
  glLoadIdentity;
  gluOrtho2D(0,ClientWidth, ClientHeight,0);
  glMatrixMode(GL_MODELVIEW);
end;

//////----------------****************************************************---------------------------////

procedure R2D_To_3D();
begin
  glMatrixMode(GL_PROJECTION);
  glPopMatrix;
  glMatrixMode(GL_MODELVIEW);
  glPopMatrix;
end;

//////----------------****************************************************---------------------------////

end.
