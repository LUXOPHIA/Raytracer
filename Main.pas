unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit,
  LUX, LUX.Matrix.L4, LUX.Color,
  LUX.Raytrace, LUX.Raytrace.Geometry, LUX.Raytrace.Material, LUX.Raytrace.Render,
  LIB.Raytrace, LIB.Raytrace.Geometry, LIB.Raytrace.Material;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    GroupBoxI: TGroupBox;
    LabelIW: TLabel;
    EditIW: TEdit;
    LabelIH: TLabel;
    EditIH: TEdit;
    GroupBoxR: TGroupBox;
    ButtonP: TButton;
    ButtonS: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonPClick(Sender: TObject);
    procedure ButtonSClick(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Render :TRayRender;
    _World  :TRayWorld;
    _Sky    :TRaySky;
    _Camera :TRayCamera;
    _Light  :TRayLight;
    _Ground :TRayGround;
    ///// メソッド
    procedure MakeScene;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.MakeScene;
var
   N :Integer;
begin
     ////////// 世界

     _World := TRayWorld.Create;

     _Render.World := _World;

     ////////// カメラ

     _Camera := TRayCamera.Create( _World );
     with _Camera do
     begin
          LocalMatrix := TSingleM4.RotateX( DegToRad( -30 ) )
                       * TSingleM4.Translate( 0, 0, 15 );
     end;

     _Render.Camera := _Camera;

     ////////// ライト

     _Light := TRayLight.Create( _World );
     with _Light do
     begin
          LocalMatrix := TSingleM4.Translate( 0, 100, 0 );

          Color       := TSingleRGBA.Create( 1, 1, 1 );
     end;

     ////////// 地面
     {
     _Ground := TRayGround.Create( _World );
     with _Ground do
     begin
          LocalMatrix := TSingleM4.Translate( 0, -6, 0 );

          Material := TMaterialDiff.Create;

          with TMaterialDiff( Material ) do
          begin
               DiffRatio := TSingleRGB.Create( 1, 1, 1 );
          end;
     end;
     }
     ////////// 空

     _Sky := TRaySky.Create( _World );
     with _Sky do
     begin
          Material := TMaterialTexColor.Create;

          with TMaterialTexColor( Material ) do
          begin
               Texture.LoadFromFile( '..\..\_DATA\Sky.png' );
          end;
     end;

     ////////// 球

     with TMyGeometry.Create( _World ) do
     begin
          Radius := 3;

          Material := TMaterialGlass.Create;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Render := TRayRender.Create;

     with _Render do
     begin
          MaxSampleN := 1;
          ConvN      := 1;
          ConvE      := 1/8;
     end;

     MakeScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _World.Free;

     _Render.Free;
end;

//------------------------------------------------------------------------------

procedure TForm1.ButtonPClick(Sender: TObject);
begin
     ButtonP.Enabled := False;
     ButtonS.Enabled := True ;

     with _Render do
     begin
          Pixels.BricX := EditIW.Text.ToInteger;
          Pixels.BricY := EditIH.Text.ToInteger;

          Run;

          CopyToBitmap( Image1.Bitmap );
     end;

     Image1.Bitmap.SaveToFile( 'Image.png' );

     ButtonP.Enabled := True ;
     ButtonS.Enabled := False;
end;

procedure TForm1.ButtonSClick(Sender: TObject);
begin
     ButtonS.Enabled := False;

     _Render.Stop;
end;

end. //######################################################################### ■
