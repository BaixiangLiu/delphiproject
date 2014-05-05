unit PRenameCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

type
  TCardValue = 1..13;
  TCardSuit = (Spades, Diamonds, Clubs, Hearts);
  TShortSuit = (S, D, C, H);
  TDecks = (Standard1, Standard2, Fishes1, Fishes2,
    Beach, Leaves1, Leaves2, Robot,
    Roses, Shell, Castle, Hand);
  TCard = class(TGraphicControl)
  private
    CardBitmap: TBitmap;
    FDeckType: TDecks;
    FPicParth: string;
    FShowDeck: Boolean;
    FSuit: TCardSuit;
    FValue: TCardValue;
    procedure SetDeckType(DeckType: TDecks);
    procedure SetShowDeck(ShowDeck: Boolean);
    procedure SetSuit(Suit: TCardSuit);
    procedure SetValue(Value: TCardValue);
    procedure WMSize(var Message: TWMSize); message WM_PAINT;
  protected
    procedure Paint; override;
    property Height default 96;
    property Width default 71;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FastChangeCard(Ivalue: Integer; Isuit: TCardSuit);
    procedure SetCard(CValue: Integer; CSuit: TShortSuit);
  published
    property DeckType: TDecks read FDeckType write SetDeckType;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property ShowDeck: Boolean read FShowDeck write SetShowDeck;
    property Suit: TCardSuit read FSuit write SetSuit;
    property Value: TCardValue read FValue write SetValue;
  end;

implementation

{
************************************ TCard *************************************
}

constructor TCard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CardBitmap := TBitmap.Create;
  Height := 96;
  Width := 71;
  FValue := 1;
  FSuit := Hearts;
  FDeckType := Roses;
  FShowDeck := False;
  FPicParth := ExtractFilePath(Application.ExeName) + 'CardPic\';
end;

destructor TCard.Destroy;
begin
  CardBitmap.Free;
  inherited Destroy;
end;

procedure TCard.FastChangeCard(Ivalue: Integer; Isuit: TCardSuit);
begin
  if (iValue > 0) and (iValue < 14) then
    FValue := Ivalue;
  FSuit := Isuit;
  Paint;
end;

procedure TCard.Paint;
var
  ResName: string;
begin
  if not ShowDeck then begin // show selected card
    case FSuit of
      Hearts: ResName := 'H';
      Spades: ResName := 'S';
      Clubs: ResName := 'C';
      Diamonds: ResName := 'D';
    end;
    ResName := ResName + IntToStr(FValue);
  end
  else // show selected deck
    case DeckType of
      Standard1: ResName := 'STD1';
      Standard2: ResName := 'STD2';
      Fishes1: ResName := 'FISHES1';
      Fishes2: ResName := 'FISHES2';
      Beach: ResName := 'BEACH';
      Leaves1: ResName := 'LEAVES1';
      Leaves2: ResName := 'LEAVES2';
      Robot: ResName := 'ROBOT';
      Roses: ResName := 'ROSES';
      Shell: ResName := 'SHELL';
      Castle: ResName := 'CASTLE';
      Hand: ResName := 'HAND';
    end;
  // load bitmap from resources
  CardBitmap.LoadFromFile(FPicParth + ResName + '.bmp');
  Canvas.Draw(0, 0, CardBitmap);
  {Canvas.Brush.Color := (Owner as TForm).Color;
  Canvas.FloodFill(0,0,clBlack,fsBorder);
  Canvas.FloodFill(70,0,clBlack,fsBorder);
  Canvas.FloodFill(0,95,clBlack,fsBorder);
  Canvas.FloodFill(70,95,clBlack,fsBorder);}
end;

procedure TCard.SetCard(CValue: Integer; CSuit: TShortSuit);
begin
  if (CValue > 0) and (CValue < 14) then Value := CValue;
  if CSuit in [C, H, S, D] then
    case CSuit of
      C: Suit := Clubs;
      H: Suit := Hearts;
      S: Suit := Spades;
      D: Suit := Diamonds;
    end;
end;

procedure TCard.SetDeckType(DeckType: TDecks);
begin
  FDeckType := DeckType;
  Paint;
end;

procedure TCard.SetShowDeck(ShowDeck: Boolean);
begin
  FShowDeck := ShowDeck;
  Paint;
end;

procedure TCard.SetSuit(Suit: TCardSuit);
begin
  FSuit := Suit;
  Paint;
end;

procedure TCard.SetValue(Value: TCardValue);
begin
  if Value < 1 then Value := 1;
  if Value > 13 then Value := 13;
  FValue := Value;
  Paint;
end;

procedure TCard.WMSize(var Message: TWMSize);
begin
  inherited;
  Width := 71;
  Height := 96;
end;


end.
