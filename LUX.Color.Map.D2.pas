unit LUX.Color.Map.D2;

interface //#################################################################### Å°

uses System.UITypes,
     FMX.Graphics,
     LUX, LUX.D2, LUX.Color, LUX.Map.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Åyå^Åz

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉåÉRÅ[ÉhÅz

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉNÉâÉXÅz

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TTexture2D

     TTexture2D = class( TBricArray2D<TSingleRGBA> )
     private
     protected
     public
       constructor Create( const FileName_:String ); overload;
       ///// ÉÅÉ\ÉbÉh
       procedure LoadFromBitmap( const Bitmap_:TBitmap );
       procedure LoadFromFile( const FileName_:String );
       function Interp( const X_,Y_:Single ) :TSingleRGBA; overload;
       function Interp( const P_:TSingle2D ) :TSingleRGBA; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyíËêîÅz

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyïœêîÅz

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉãÅ[É`ÉìÅz

implementation //############################################################### Å°

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉåÉRÅ[ÉhÅz

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉNÉâÉXÅz

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TTexture2D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TTexture2D.Create( const FileName_:String );
begin
     Create;

     LoadFromFile( FileName_ );
end;

/////////////////////////////////////////////////////////////////////// ÉÅÉ\ÉbÉh

procedure TTexture2D.LoadFromBitmap( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
   P :PAlphaColor;
begin
     BricX := Bitmap_.Width ;
     BricY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to BricY-1 do
     begin
          P := B.GetScanline( Y );

          for X := 0 to BricX-1 do
          begin
               Bric[ X, Y ] := P^;  Inc( P );
          end;
     end;

     Bitmap_.Unmap( B );
end;

procedure TTexture2D.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     LoadFromBitmap( B );

     B.Free;
end;

function TTexture2D.Interp( const X_,Y_:Single ) :TSingleRGBA;
var
   X1, Y1, Xi, Yi :Integer;
   X, Y, Xd, Yd :Single;
   C00, C01,
   C10, C11,
   C0, C1 :TSingleRGBA;
begin
     X1 := BricX-1;
     Y1 := BricY-1;

     if X_ <= 0 then X := 0
                else
     if X_ >= 1 then X := X1
                else X := X1 * X_;

     if Y_ <= 0 then Y := 0
                else
     if Y_ >= 1 then Y := Y1
                else Y := Y1 * Y_;

     Xi := Floor( X );  if Xi > X1 then Xi := X1;  Xd := X - Xi;
     Yi := Floor( Y );  if Yi > Y1 then Yi := Y1;  Yd := Y - Yi;

     C00 := Bric[ Xi+0, Yi+0 ];  C01 := Bric[ Xi+1, Yi+0 ];
     C10 := Bric[ Xi+0, Yi+1 ];  C11 := Bric[ Xi+1, Yi+1 ];

     C0 := ( C01 - C00 ) * Xd + C00;
     C1 := ( C11 - C10 ) * Xd + C10;

     Result := ( C1 - C0 ) * Yd + C0;
end;

function TTexture2D.Interp( const P_:TSingle2D ) :TSingleRGBA;
begin
     with P_ do Result := Interp( X, Y );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉãÅ[É`ÉìÅz

//############################################################################## Å†

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ èâä˙âª

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ç≈èIâª

end. //######################################################################### Å°
