unit LIB.Raytrace.Geometry;

interface //#################################################################### ■

uses LUX, LUX.D1, LUX.D3, LUX.Matrix.L4,
     LUX.Raytrace, LUX.Raytrace.Geometry,
     LIB.Raytrace;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMyGeometry

     TMyGeometry = class( TRayGeometry )
     private
     protected
       _Radius :Single;
       ///// アクセス
       function GetLocalAABB :TSingleArea3D; override;
       ///// メソッド
       procedure _RayCast( var LocalRay_:TRayRay; var LocalHit_:TRayHit; const Len_:TSingleArea ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Radius :Single read _Radius write _Radius;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils, System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMyGeometry

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TMyGeometry.GetLocalAABB :TSingleArea3D;
begin
     Result := TSingleArea3D.Create( -_Radius, -_Radius, -_Radius,
                                     +_Radius, +_Radius, +_Radius );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TMyGeometry._RayCast( var LocalRay_:TRayRay; var LocalHit_:TRayHit; const Len_:TSingleArea );
var
   A, B, C, D, D2, T0, T1 :Single;
begin
     with LocalRay_.Ray do
     begin
          A := Vec.Siz2;
          B := DotProduct( Pos, Vec );
          C := Pos.Siz2 - Pow2( _Radius );
     end;

     D := Pow2( B ) - A * C;

     if D > 0 then
     begin
          D2 := Roo2( D );

          T1 := ( -B + D2 ) / A;

          if T1 > 0 then
          begin
               T0 := ( -B - D2 ) / A;

               with LocalRay_ do
               begin
                    if T0 > 0 then Len := T0
                              else Len := T1;
               end;

               with LocalHit_ do
               begin
                    Obj := Self;

                    Nor := LocalHit_.Pos.Unitor;
               end;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMyGeometry.Create;
begin
     inherited;

     Radius := 1;
end;

destructor TMyGeometry.Destroy;
begin

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■