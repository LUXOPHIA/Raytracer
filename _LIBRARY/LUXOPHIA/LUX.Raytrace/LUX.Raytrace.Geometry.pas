unit LUX.Raytrace.Geometry;

interface //#################################################################### ■

uses LUX, LUX.D3, LUX.Graph.Tree, LUX.Raytrace, LUX.Raytrace.Hit;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TRaySphere = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRayGround

     TRayGround = class( TRayGeometry )
     private
     protected
       ///// メソッド
       function RayCast( const Ray_:TRay ) :TRayHit; override;
     public
       ///// メソッド
       function HitBoundBox( const Ray_:TRay ) :Boolean; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRaySphere

     TRaySphere = class( TRayGeometry )
     private
     protected
       _Radius :Single;
       ///// アクセス
       procedure SetRadius( const Radius_:Single );
       ///// メソッド
       function RayCast( const Ray_:TRay ) :TRayHit; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Radius :Single read _Radius write SetRadius;
       ///// メソッド
       function HitBoundBox( const Ray_:TRay ) :Boolean; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRayGround

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TRayGround.RayCast( const Ray_:TRay ) :TRayHit;
var
   V, P, T :Single;
begin
     Result := inherited;

     P := ( Ray_.Pos.Y );
     V := ( Ray_.Vec.Y );

     if ( P > 0 ) and ( V < 0 ) then
     begin
          T := P / -V;

          if T > 0.001 then
          begin
               Result := TRayHitNorTex2D.Create;

               with TRayHitNorTex2D( Result ) do
               begin
                    _Obj := Self;
                    _Len := T;
                    _Pos := T * Ray_.Vec + Ray_.Pos;
                    _Nor := TSingle3D.Create( 0, 1, 0 );
               end;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TRayGround.HitBoundBox( const Ray_:TRay ) :Boolean;
begin
     Result := True;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRaySphere

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

procedure TRaySphere.SetRadius( const Radius_:Single );
begin
     _Radius := Radius_;

     _BoundingBox := TSingleArea3D.Create( -Radius_, -Radius_, -Radius_,
                                           +Radius_, +Radius_, +Radius_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TRaySphere.RayCast( const Ray_:TRay ) :TRayHit;
var
   B, C, D, T :Single;
begin
     Result := inherited;

     B := DotProduct( Ray_.Pos, Ray_.Vec );
     C := Ray_.Pos.Siz2 - Pow2( _Radius );

     D := Pow2( B ) - C;

     if D > 0 then
     begin
          T := -B - Roo2( D );

          if T > 0.001 then
          begin
               Result := TRayHitNorTex2D.Create;

               with TRayHitNorTex2D( Result ) do
               begin
                    _Obj := Self;
                    _Len := T;
                    _Pos := T * Ray_.Vec + Ray_.Pos;
                    _Nor := _Pos.Unitor;
               end;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TRaySphere.Create;
begin
     inherited;

     _Radius := 1;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TRaySphere.HitBoundBox( const Ray_:TRay ) :Boolean;
begin
     Result := True;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■