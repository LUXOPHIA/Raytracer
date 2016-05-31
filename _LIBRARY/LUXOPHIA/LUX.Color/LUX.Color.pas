unit LUX.Color;

interface //#################################################################### ��

uses System.UITypes,
     FMX.Graphics,
     LUX;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y�^�z

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y���R�[�h�z

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
       ///// �v���p�e�B
       ///// ���Z�q
       ///// �^�ϊ�
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
       ///// �v���p�e�B
       ///// ���Z�q
       class operator IntDivide( const A_:TByteRGB; const B_:Integer ): TByteRGB;
       ///// �^�ϊ�
       class operator Implicit( const L_:Byte ) :TByteRGB;
       class operator Implicit( const C_:TByteRGB ) :TByteRGBA;
       class operator Implicit( const C_:TByteRGB ) :TAlphaColor;
     end;

     /////////////////////////////////////////////////////////////////////////// TRGB

     TRGB = TByteRGB;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGB

     TSingleRGB = packed record
     private
     public
       R :Single;
       G :Single;
       B :Single;
       /////
       constructor Create( const R_,G_,B_:Single );
       ///// �v���p�e�B
       ///// ���Z�q
       class operator Negative( const V_:TSingleRGB ) :TSingleRGB;
       class operator Positive( const V_:TSingleRGB ) :TSingleRGB;
       class operator Add( const A_,B_:TSingleRGB ) :TSingleRGB;
       class operator Subtract( const A_,B_:TSingleRGB ) :TSingleRGB;
       class operator Multiply( const A_:Single; const B_:TSingleRGB ): TSingleRGB;
       class operator Multiply( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
       class operator Divide( const A_:TSingleRGB; const B_:Single ): TSingleRGB;
       ///// �^�ϊ�
       class operator Implicit( const C_:TByteRGB ) :TSingleRGB;
       class operator Implicit( const C_:TSingleRGB ) :TByteRGB;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleRGBA

     TSingleRGBA = packed record
     private
     public
       R :Single;
       G :Single;
       B :Single;
       A :Single;
       /////
       constructor Create( const R_,G_,B_:Single; const A_:Single = 1 );
       ///// �v���p�e�B
       ///// ���Z�q
       class operator Negative( const V_:TSingleRGBA ) :TSingleRGBA;
       class operator Positive( const V_:TSingleRGBA ) :TSingleRGBA;
       class operator Add( const A_,B_:TSingleRGBA ) :TSingleRGBA;
       class operator Subtract( const A_,B_:TSingleRGBA ) :TSingleRGBA;
       class operator Multiply( const A_,B_:TSingleRGBA ): TSingleRGBA;
       class operator Multiply( const A_:Single; const B_:TSingleRGBA ): TSingleRGBA;
       class operator Multiply( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
       class operator Divide( const A_:TSingleRGBA; const B_:Single ): TSingleRGBA;
       ///// �^�ϊ�
       class operator Implicit( const C_:TAlphaColor ) :TSingleRGBA;
       class operator Implicit( const C_:TSingleRGBA ) :TAlphaColor;
       class operator Implicit( const C_:TByteRGBA ) :TSingleRGBA;
       class operator Implicit( const C_:TSingleRGBA ) :TByteRGBA;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y�N���X�z

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGradation1D

     TGradation1D = class
     private
     protected
       _Colors  :TArray<TSingleRGBA>;
       _ColorsN :Integer;
       ///// �A�N�Z�X
       function GetColors( const I_:Integer ) :TSingleRGBA;
       procedure SetColors( const I_:Integer; const Colors_:TSingleRGBA );
       procedure SetColorsN( const ColorsN_:Integer );
     public
       constructor Create; overload;
       constructor Create( const FileName_:String ); overload;
       destructor Destroy; override;
       ///// �v���p�e�B
       property Colors[ const I_:Integer ] :TSingleRGBA read GetColors write SetColors;
       property ColorsN                    :Integer     read _ColorsN  write SetColorsN;
       ///// ���\�b�h
       procedure LoadFromBitmap( const Bitmap_:TBitmap );
       procedure LoadFromFile( const FileName_:String );
       function Interp( const X_:Single ) :TSingleRGBA;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y�萔�z

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y�ϐ��z

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y���[�`���z

implementation //############################################################### ��

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y���R�[�h�z

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

///////////////////////////////////////////////////////////////////////// ���Z�q

///////////////////////////////////////////////////////////////////////// �^�ϊ�

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

///////////////////////////////////////////////////////////////////////// ���Z�q

class operator TByteRGB.IntDivide( const A_:TByteRGB; const B_:Integer ): TByteRGB;
begin
     with Result do
     begin
          R := A_.R div B_;
          G := A_.G div B_;
          B := A_.B div B_;
     end;
end;

///////////////////////////////////////////////////////////////////////// �^�ϊ�

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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingleRGB.Create( const R_,G_,B_:Single );
begin
     R := R_;
     G := G_;
     B := B_;
end;

///////////////////////////////////////////////////////////////////////// ���Z�q

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

///////////////////////////////////////////////////////////////////////// �^�ϊ�

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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingleRGBA.Create( const R_,G_,B_:Single; const A_:Single = 1 );
begin
     R := R_;
     G := G_;
     B := B_;
     A := A_;
end;

///////////////////////////////////////////////////////////////////////// ���Z�q

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

class operator TSingleRGBA.Multiply( const A_,B_:TSingleRGBA ): TSingleRGBA;
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

///////////////////////////////////////////////////////////////////////// �^�ϊ�

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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y�N���X�z

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGradation1D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// �A�N�Z�X

function TGradation1D.GetColors( const I_:Integer ) :TSingleRGBA;
begin
     Result := _Colors[ I_ ];
end;

procedure TGradation1D.SetColors( const I_:Integer; const Colors_:TSingleRGBA );
begin
     _Colors[ I_ ] := Colors_;
end;

procedure TGradation1D.SetColorsN( const ColorsN_:Integer );
begin
     _ColorsN := ColorsN_;

     SetLength( _Colors, _ColorsN );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGradation1D.Create;
begin
     inherited;

end;

constructor TGradation1D.Create( const FileName_:String );
begin
     Create;

     LoadFromFile( FileName_ );
end;

destructor TGradation1D.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// ���\�b�h

procedure TGradation1D.LoadFromBitmap( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   I :Integer;
   P :PAlphaColor;
begin
     Bitmap_.Map( TMapAccess.Read, B );

     ColorsN := Bitmap_.Width;

     P := B.GetScanline( 0 );
     for I := 0 to _ColorsN-1 do
     begin
          _Colors[ I ] := P^;  Inc( P );
     end;

     Bitmap_.Unmap( B );
end;

procedure TGradation1D.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     LoadFromBitmap( B );

     B.Free;
end;

function TGradation1D.Interp( const X_:Single ) :TSingleRGBA;
var
   Xi :Integer;
   X, Xd :Single;
   C0, C1 :TSingleRGBA;
begin
     if X_ <= 0 then Result := _Colors[ 0          ]
     else
     if X_ >= 1 then Result := _Colors[ _ColorsN-1 ]
     else
     begin
          X := ( _ColorsN-1 ) * X_;

          Xi := Floor( X );  Xd := X - Xi;

          C0 := _Colors[ Xi   ];
          C1 := _Colors[ Xi+1 ];

          Result := ( C1 - C0 ) * Xd + C0;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$�y���[�`���z

//############################################################################## ��

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ������

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ �ŏI��

end. //######################################################################### ��
