unit LIB.Raytrace.Material;

interface //#################################################################### ■

uses LUX, LUX.D3, LUX.Matrix.L4, LUX.Color,
     LUX.Raytrace, LUX.Raytrace.Material,
     LIB.Raytrace;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMyMaterial

     TMyMaterial = class( TRayMaterial )
     private
     protected
       _DiffRatio :TSingleRGB;
     public
       constructor Create;
       ///// プロパティ
       property DiffRatio :TSingleRGB read _DiffRatio write _DiffRatio;
       ///// メソッド
       function Scatter( const WorldRay_:TRayRay; const WorldHit_:TRayHit ) :TSingleRGB; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMyMaterial

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMyMaterial.Create;
begin
     inherited;

     _DiffRatio := TSingleRGB.Create( 1, 1, 1 );
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TMyMaterial.Scatter( const WorldRay_:TRayRay; const WorldHit_:TRayHit ) :TSingleRGB;
var
   L :TRayLight;
   A :TRayRay;
//･･････････････････････････････････････････････････････････････････････････････
     procedure Diff;
     var
        D :Single;
     begin
          D := DotProduct( WorldHit_.Nor, A.Ray.Vec );  if D < 0 then D := 0;

          Result := Result + D * L.Color * _DiffRatio;
     end;
//･･････････････････････････････････････････････････････････････････････････････
var
   I :Integer;
   H, S :TRayHit;
begin
     Result := TSingleRGB.Create( 0, 0, 0 );

     for I := 0 to World.LightsN-1 do
     begin
          L := World.Lights[ I ];

          H := L.RayJoin( WorldHit_.Pos );

          with A do
          begin
               Ord     := WorldRay_.Ord + 1;
               Ray.Pos := WorldHit_.Pos;
               Ray.Vec := WorldHit_.Pos.UnitorTo( H.Pos );
          end;

          S := World.RayCasts( A );

          if Assigned( S.Obj ) then
          begin
               if S.Len >= H.Len then Diff;
          end
          else Diff;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■