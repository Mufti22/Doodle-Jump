unit OpenGLEx;

interface

uses Windows, OpenGL;

const

  GL_COLOR_ARRAY           = $8076;
  GL_VERTEX_ARRAY          = $8074;
  GL_NORMAL_ARRAY          = $8075;
  GL_TEXTURE_COORD_ARRAY   = $8078;

procedure glVertexPointer(size:GLint; atype:GLenum; stride:GLsizei; data:pointer); stdcall; external opengl32;
procedure glColorPointer(size:GLint; atype:GLenum; stride:GLsizei; data:pointer); stdcall; external OpenGL32;
procedure glNormalPointer(atype:GLenum; stride:GLsizei; data:pointer); stdcall; external OpenGL32;
procedure glTexCoordPointer(size: GLint; atype: GLEnum; stride: GLsizei; data: pointer); stdcall; external OpenGL32;
procedure glDrawArrays(mode:GLenum; first:GLint; count:GLsizei); stdcall; external OpenGL32;
procedure glDrawElements(mode: GLEnum; count: GLsizei; atype: GLEnum; indices: Pointer); stdcall; external OpenGL32;
procedure glEnableClientState(aarray:GLenum); stdcall; external OpenGL32;
procedure glDisableClientState(aarray:GLenum); stdcall; external OpenGL32;
procedure glArrayElement (i: GLint); stdcall; external OpenGL32;
procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external opengl32;
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

implementation

end.
