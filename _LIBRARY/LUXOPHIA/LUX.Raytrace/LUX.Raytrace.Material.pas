unit LUX.Raytrace.Material;

interface //#################################################################### ■

uses LUX, LUX.D3, LUX.Matrix.L4, LUX.Color,
     LUX.Raytrace, LUX.Raytrace.Hit;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMaterialRGB

     TMaterialRGB = class( TRayMaterial )
     private
     protected
     public
       ///// メソッド
       function Scatter( const Ray_:TRay; const Hit_:TRayHit ) :TSingleRGBA; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMaterialDiff

     TMaterialDiff = class( TRayMaterial )
     private
     protected
       _DiffRatio :TSingleRGBA;
     public
       constructor Create;
       ///// プロパティ
       property DiffRatio :TSingleRGBA read _DiffRatio write _DiffRatio;
       ///// メソッド
       function Scatter( const Ray_:TRay; const Hit_:TRayHit ) :TSingleRGBA; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMaterialRGB

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TMaterialRGB.Scatter( const Ray_:TRay; const Hit_:TRayHit ) :TSingleRGBA;
begin
     with TRayHitNor( Hit_ ).Nor do
     begin
          Result.R := ( 1 + X ) / 2;
          Result.G := ( 1 + Y ) / 2;
          Result.B := ( 1 + Z ) / 2;
          Result.A := 1;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMaterialDiff

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMaterialDiff.Create;
begin
     inherited;

     _DiffRatio := TSingleRGBA.Create( 1, 1, 1, 1 );
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TMaterialDiff.Scatter( const Ray_:TRay; const Hit_:TRayHit ) :TSingleRGBA;
var
   Hit :TRayHitNor;
   I :Integer;
   L :TRayLight;
   H :TRayHit;
   V :TSingle3D;
   D :Single;
begin
     Hit := TRayHitNor( Hit_ );

     Result := 0;

     for I := 0 to World.LightsN-1 do
     begin
          L := World.Lights[ I ];
          H := L.RayJoins( Hit_ );

          if Assigned( H ) then
          begin
               V := Hit_.Pos.UnitorTo( H.Pos );
               D := DotProduct( Hit.Nor, V );
               if D < 0 then D := 0;

               Result := Result + D * L.Color * _DiffRatio;

               H.Free;
          end;
     end;

     Result.A := 1;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■