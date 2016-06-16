unit LUX.Color;

interface //#################################################################### Å°

uses System.UITypes,
     LUX;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Åyå^Åz

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉåÉRÅ[ÉhÅz

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TByteRGBA

     TByteRGBA = packed record
     private
     public
     {$IFDEF BIGENDIAN}
       A :Byte;
       R :Byte;
       G :Byte;
       B :Byte;
     {$ELSE}
       B :Byte;
       G :Byte;
       R :Byte;
       A :Byte;
     {$ENDIF}
       /////
       constructor Create( const R_,G_,B_:Byte; const A_:Byte = $FF );
       ///// ÉvÉçÉpÉeÉB
       ///// ââéZéq
       ///// å^ïœä∑
       class operator Implicit( const C_:TByteRGBA ) :TAlphaColor;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TByteRGB

     TByteRGB = packed record
     private
     public
     {$IFDEF BIGENDIAN}
       R :Byte;
       G :Byte;
       B :Byte;
     {$ELSE}
       B :Byte;
       G :Byte;
       R :Byte;
     {$ENDIF}
       /////
       constructor Create( const R_,G_,B_:Byte );
       ///// ÉvÉçÉpÉeÉB
       ///// ââéZéq
       class operator IntDivide( const A_:TByteRGB; const B_:Integer ): TByteRGB;
       ///// å^ïœä∑
       class operator Implicit( const L_:Byte ) :TByteRGB;
       class operator Implicit( const C_:TByteRGB ) :TByteRGBA;
       class operator Implicit( const C_:TByteRGB ) :TAlphaColor;
     end;

     /////////////////////////////////////////////////////////////////////////// TRGB

     TRGB = TByteRGB;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGB

     TSingleRGB = packed record
     private
       ///// ÉAÉNÉZÉX
       function GetSiz2 :Single;
       function GetSize :Single;
     public
       R :Single;
       G :Single;
       B :Single;
       /////
       constructor Create( const R_,G_,B_:Single );
       ///// ÉvÉçÉpÉeÉB
       property Siz2 :Single read GetSiz2;
       property Size :Single read GetSize;
       ///// ââéZéq
       class operator Negative( const V_:TSingleRGB ) :TSingleRGB;
       class operator Positive( const V_:TSingleRGB ) :TSingleRGB;
       class operator Add( const A_,B_:TSingleRGB ) :TSingleRGB;
       class operator Subtract( const A_,B_:TSingleRGB ) :TSingleRGB;
       class operator Multiply( const A_,B_:TSingleRGB ) :TSingleRGB;
       class operator Multiply( const A_:Single; const B_:TSingleRGB ): TSingleRGB;
       class operator Multiply( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
       class operator Divide( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
       ///// å^ïœä∑
       class operator Implicit( const C_:Single ) :TSingleRGB;
       class operator Implicit( const C_:TAlphaColor ) :TSingleRGB;
       class operator Implicit( const C_:TSingleRGB ) :TAlphaColor;
       class operator Implicit( const C_:TByteRGB ) :TSingleRGB;
       class operator Implicit( const C_:TSingleRGB ) :TByteRGB;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGBA

     TSingleRGBA = packed record
     private
       ///// ÉAÉNÉZÉX
       function GetSiz2 :Single;
       function GetSize :Single;
     public
       R :Single;
       G :Single;
       B :Single;
       A :Single;
       /////
       constructor Create( const R_,G_,B_:Single; const A_:Single = 1 );
       ///// ÉvÉçÉpÉeÉB
       property Siz2 :Single read GetSiz2;
       property Size :Single read GetSize;
       ///// ââéZéq
       class operator Negative( const V_:TSingleRGBA ) :TSingleRGBA;
       class operator Positive( const V_:TSingleRGBA ) :TSingleRGBA;
       class operator Add( const A_,B_:TSingleRGBA ) :TSingleRGBA;
       class operator Subtract( const A_,B_:TSingleRGBA ) :TSingleRGBA;
       class operator Multiply( const A_,B_:TSingleRGBA ) :TSingleRGBA;
       class operator Multiply( const A_:Single; const B_:TSingleRGBA ): TSingleRGBA;
       class operator Multiply( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
       class operator Divide( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
       ///// å^ïœä∑
       class operator Implicit( const C_:Single ) :TSingleRGBA;
       class operator Implicit( const C_:TAlphaColor ) :TSingleRGBA;
       class operator Implicit( const C_:TSingleRGBA ) :TAlphaColor;
       class operator Implicit( const C_:TByteRGBA ) :TSingleRGBA;
       class operator Implicit( const C_:TSingleRGBA ) :TByteRGBA;
       class operator Implicit( const C_:TSingleRGB ) :TSingleRGBA;
       class operator Implicit( const C_:TSingleRGBA ) :TSingleRGB;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉNÉâÉXÅz

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyíËêîÅz

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyïœêîÅz

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉãÅ[É`ÉìÅz

function Ave( const C1_,C2_:TSingleRGB ) :TSingleRGB; overload;
function Ave( const C1_,C2_:TSingleRGBA ) :TSingleRGBA; overload;

function Distanc2( const C1_,C2_:TSingleRGB ) :Single; overload;
function Distanc2( const C1_,C2_:TSingleRGBA ) :Single; overload;

function Distance( const C1_,C2_:TSingleRGB ) :Single; overload;
function Distance( const C1_,C2_:TSingleRGBA ) :Single; overload;

function GammaCorrect( const C_:TSingleRGB; const G_:Single ) :TSingleRGB; overload;
function GammaCorrect( const C_:TSingleRGBA; const G_:Single ) :TSingleRGBA; overload;

implementation //############################################################### Å°

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉåÉRÅ[ÉhÅz

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TByteRGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TByteRGBA.Create( const R_,G_,B_:Byte; const A_:Byte = $FF );
begin
     R := R_;
     G := G_;
     B := B_;
     A := A_;
end;

///////////////////////////////////////////////////////////////////////// ââéZéq

///////////////////////////////////////////////////////////////////////// å^ïœä∑

class operator TByteRGBA.Implicit( const C_:TByteRGBA ) :TAlphaColor;
begin
     Result := PAlphaColor( @C_ )^;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TByteRGB

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TByteRGB.Create( const R_,G_,B_:Byte );
begin
     R := R_;
     G := G_;
     B := B_;
end;

///////////////////////////////////////////////////////////////////////// ââéZéq

class operator TByteRGB.IntDivide( const A_:TByteRGB; const B_:Integer ): TByteRGB;
begin
     with Result do
     begin
          R := A_.R div B_;
          G := A_.G div B_;
          B := A_.B div B_;
     end;
end;

///////////////////////////////////////////////////////////////////////// å^ïœä∑

class operator TByteRGB.Implicit( const L_:Byte ) :TByteRGB;
begin
     with Result do
     begin
          R := L_;
          G := L_;
          B := L_;
     end;
end;

class operator TByteRGB.Implicit( const C_:TByteRGB ) :TByteRGBA;
begin
     with Result do
     begin
          A := $FF;
          R := C_.R;
          G := C_.G;
          B := C_.B;
     end;
end;

class operator TByteRGB.Implicit( const C_:TByteRGB ) :TAlphaColor;
begin
     Result := TByteRGBA( C_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGB

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// ÉAÉNÉZÉX

function TSingleRGB.GetSiz2 :Single;
begin
     Result := Pow2( R ) + Pow2( G ) + Pow2( B );
end;

function TSingleRGB.GetSize :Single;
begin
     Result := Roo2( GetSiz2 );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingleRGB.Create( const R_,G_,B_:Single );
begin
     R := R_;
     G := G_;
     B := B_;
end;

///////////////////////////////////////////////////////////////////////// ââéZéq

class operator TSingleRGB.Negative( const V_:TSingleRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := -V_.R;
          G := -V_.G;
          B := -V_.B;
     end;
end;

class operator TSingleRGB.Positive( const V_:TSingleRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := +V_.R;
          G := +V_.G;
          B := +V_.B;
     end;
end;

class operator TSingleRGB.Add( const A_,B_:TSingleRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := A_.R + B_.R;
          G := A_.G + B_.G;
          B := A_.B + B_.B;
     end;
end;

class operator TSingleRGB.Subtract( const A_,B_:TSingleRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := A_.R - B_.R;
          G := A_.G - B_.G;
          B := A_.B - B_.B;
     end;
end;

class operator TSingleRGB.Multiply( const A_,B_:TSingleRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := A_.R * B_.R;
          G := A_.G * B_.G;
          B := A_.B * B_.B;
     end;
end;

class operator TSingleRGB.Multiply( const A_:Single; const B_:TSingleRGB ): TSingleRGB;
begin
     with Result do
     begin
          R := A_ * B_.R;
          G := A_ * B_.G;
          B := A_ * B_.B;
     end;
end;

class operator TSingleRGB.Multiply( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
begin
     with Result do
     begin
          R := A_.R * B_;
          G := A_.G * B_;
          B := A_.B * B_;
     end;
end;

class operator TSingleRGB.Divide( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
begin
     with Result do
     begin
          R := A_.R / B_;
          G := A_.G / B_;
          B := A_.B / B_;
     end;
end;

///////////////////////////////////////////////////////////////////////// å^ïœä∑

class operator TSingleRGB.Implicit( const C_:Single ) :TSingleRGB;
begin
     with Result do
     begin
          R := C_;
          G := C_;
          B := C_;
     end;
end;

class operator TSingleRGB.Implicit( const C_:TAlphaColor ) :TSingleRGB;
begin
     Result := TByteRGB( C_ );
end;

class operator TSingleRGB.Implicit( const C_:TSingleRGB ) :TAlphaColor;
begin
     Result := TByteRGB( C_ );
end;

class operator TSingleRGB.Implicit( const C_:TByteRGB ) :TSingleRGB;
begin
     with Result do
     begin
          R := C_.R / 255;
          G := C_.G / 255;
          B := C_.B / 255;
     end;
end;

class operator TSingleRGB.Implicit( const C_:TSingleRGB ) :TByteRGB;
begin
     with Result do
     begin
          R := ClipRange( Round( 255 * C_.R ), 0, 255 );
          G := ClipRange( Round( 255 * C_.G ), 0, 255 );
          B := ClipRange( Round( 255 * C_.B ), 0, 255 );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// ÉAÉNÉZÉX

function TSingleRGBA.GetSiz2 :Single;
begin
     Result := Pow2( R ) + Pow2( G ) + Pow2( B ) + Pow2( A );
end;

function TSingleRGBA.GetSize :Single;
begin
     Result := Roo2( GetSiz2 );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingleRGBA.Create( const R_,G_,B_:Single; const A_:Single = 1 );
begin
     R := R_;
     G := G_;
     B := B_;
     A := A_;
end;

///////////////////////////////////////////////////////////////////////// ââéZéq

class operator TSingleRGBA.Negative( const V_:TSingleRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := -V_.R;
          G := -V_.G;
          B := -V_.B;
          A := -V_.A;
     end;
end;

class operator TSingleRGBA.Positive( const V_:TSingleRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := +V_.R;
          G := +V_.G;
          B := +V_.B;
          A := +V_.A;
     end;
end;

class operator TSingleRGBA.Add( const A_,B_:TSingleRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := A_.R + B_.R;
          G := A_.G + B_.G;
          B := A_.B + B_.B;
          A := A_.A + B_.A;
     end;
end;

class operator TSingleRGBA.Subtract( const A_,B_:TSingleRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := A_.R - B_.R;
          G := A_.G - B_.G;
          B := A_.B - B_.B;
          A := A_.A - B_.A;
     end;
end;

class operator TSingleRGBA.Multiply( const A_,B_:TSingleRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := A_.R * B_.R;
          G := A_.G * B_.G;
          B := A_.B * B_.B;
          A := A_.A * B_.A;
     end;
end;

class operator TSingleRGBA.Multiply( const A_:Single; const B_:TSingleRGBA ): TSingleRGBA;
begin
     with Result do
     begin
          R := A_ * B_.R;
          G := A_ * B_.G;
          B := A_ * B_.B;
          A := A_ * B_.A;
     end;
end;

class operator TSingleRGBA.Multiply( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
begin
     with Result do
     begin
          R := A_.R * B_;
          G := A_.G * B_;
          B := A_.B * B_;
          A := A_.A * B_;
     end;
end;

class operator TSingleRGBA.Divide( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
begin
     with Result do
     begin
          R := A_.R / B_;
          G := A_.G / B_;
          B := A_.B / B_;
          A := A_.A / B_;
     end;
end;

///////////////////////////////////////////////////////////////////////// å^ïœä∑

class operator TSingleRGBA.Implicit( const C_:Single ) :TSingleRGBA;
begin
     with Result do
     begin
          R := C_;
          G := C_;
          B := C_;
          A := 1;
     end;
end;

class operator TSingleRGBA.Implicit( const C_:TAlphaColor ) :TSingleRGBA;
begin
     Result := TByteRGBA( C_ );
end;

class operator TSingleRGBA.Implicit( const C_:TSingleRGBA ) :TAlphaColor;
begin
     Result := TByteRGBA( C_ );
end;

class operator TSingleRGBA.Implicit( const C_:TByteRGBA ) :TSingleRGBA;
begin
     with Result do
     begin
          R := C_.R / 255;
          G := C_.G / 255;
          B := C_.B / 255;
          A := C_.A / 255;
     end;
end;

class operator TSingleRGBA.Implicit( const C_:TSingleRGBA ) :TByteRGBA;
begin
     with Result do
     begin
          R := ClipRange( Round( 255 * C_.R ), 0, 255 );
          G := ClipRange( Round( 255 * C_.G ), 0, 255 );
          B := ClipRange( Round( 255 * C_.B ), 0, 255 );
          A := ClipRange( Round( 255 * C_.A ), 0, 255 );
     end;
end;

class operator TSingleRGBA.Implicit( const C_:TSingleRGB ) :TSingleRGBA;
begin
     with Result do
     begin
          R := C_.R;
          G := C_.G;
          B := C_.B;
          A := 1;
     end;
end;

class operator TSingleRGBA.Implicit( const C_:TSingleRGBA ) :TSingleRGB;
begin
     with Result do
     begin
          R := C_.R;
          G := C_.G;
          B := C_.B;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉNÉâÉXÅz

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ÅyÉãÅ[É`ÉìÅz

function Ave( const C1_,C2_:TSingleRGB ) :TSingleRGB;
begin
     Result := ( C1_ + C2_ ) / 2;
end;

function Ave( const C1_,C2_:TSingleRGBA ) :TSingleRGBA;
begin
     Result := ( C1_ + C2_ ) / 2;
end;

//------------------------------------------------------------------------------

function Distanc2( const C1_,C2_:TSingleRGB ) :Single;
begin
     Result := Pow2( C2_.R - C1_.R )
             + Pow2( C2_.G - C1_.G )
             + Pow2( C2_.B - C1_.B );
end;

function Distanc2( const C1_,C2_:TSingleRGBA ) :Single;
begin
     Result := Pow2( C2_.R - C1_.R )
             + Pow2( C2_.G - C1_.G )
             + Pow2( C2_.B - C1_.B );
end;

function Distance( const C1_,C2_:TSingleRGB ) :Single;
begin
     Result := Roo2( Distanc2( C1_, C2_ ) );
end;

function Distance( const C1_,C2_:TSingleRGBA ) :Single;
begin
     Result := Roo2( Distanc2( C1_, C2_ ) );
end;

//------------------------------------------------------------------------------

function GammaCorrect( const C_:TSingleRGB; const G_:Single ) :TSingleRGB;
var
   RecG :Single;
begin
     RecG := 1 / G_;

     with Result do
     begin
          R := Power( C_.R, RecG );
          G := Power( C_.G, RecG );
          B := Power( C_.B, RecG );
     end;
end;

function GammaCorrect( const C_:TSingleRGBA; const G_:Single ) :TSingleRGBA;
var
   RecG :Single;
begin
     RecG := 1 / G_;

     with Result do
     begin
          R := Power( C_.R, RecG );
          G := Power( C_.G, RecG );
          B := Power( C_.B, RecG );
          A :=        C_.A        ;
     end;
end;

//############################################################################## Å†

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ èâä˙âª

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ç≈èIâª

end. //######################################################################### Å°
