{******************************************}
{ TeeChart OHLC Compression Function       }
{ Copyright (c) 2000-2003 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeCompressOHLC;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QForms, QControls, QStdCtrls, QComCtrls,
     {$ELSE}
     Forms, Controls, StdCtrls, ComCtrls,
     {$ENDIF}
     TeEngine, OHLChart, TeeBaseFuncEdit, TeCanvas;

{
  This unit contains a "TeeFunction" ( TCompressOHLCFunction class )

  The purpose of this function is to "compress" an OHLC series
  (for example a financial Candle series).

  ( OHLC stands for "Open High Low Close" in financial terms )

  To "compress" means to find out the OHLC of a date-time period from
  the original data.

  This function also works with non-OHLC source series.

}

type
  TCompressFuncEditor = class(TBaseFunctionEditor)
    CBPeriod: TComboFlat;
    RadioButton1: TRadioButton;
    ENum: TEdit;
    RadioButton2: TRadioButton;
    UpDown1: TUpDown;
    procedure CBPeriodChange(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ENumChange(Sender: TObject);
    procedure ENumClick(Sender: TObject);
    procedure CBPeriodClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    procedure SetFunction; override;
  public
    { Public declarations }
  end;

  TCompressionPeriod=(ocDay,ocWeek,ocMonth,ocBiMonth,ocQuarter,ocYear);

  TCompressGetDate=procedure(Sender:TTeeFunction; Source:TChartSeries;
                             ValueIndex:Integer; Var Date:TDateTime) of object;

  TCompressFunction=class(TTeeFunction)
  private
    FCompress: TCompressionPeriod;
    FOnGetDate: TCompressGetDate;
    procedure SetCompress(const Value: TCompressionPeriod);
  protected
    class function GetEditorClass: String; override;
    class procedure PrepareForGallery(Chart:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source: TChartSeries); override;

    Procedure CompressSeries(Source:TChartSeries;
                             DestOHLC:TOHLCSeries;
                             Volume:TChartSeries=nil;
                             DestVolume:TChartSeries=nil);
  published
    property Compress:TCompressionPeriod read FCompress write SetCompress default ocWeek;
    property OnGetDate:TCompressGetDate read FOnGetDate write FOnGetDate;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses Chart, SysUtils, TeeProCo, CandleCh;

{ TCompressFunction }

constructor TCompressFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
  HideSourceList:=True;
  FCompress:=ocWeek;
end;

class function TCompressFunction.GetEditorClass: String;
begin
  result:='TCompressFuncEditor';
end;

procedure TCompressFunction.AddPoints(Source: TChartSeries);
begin
  if ParentSeries is TOHLCSeries then
     CompressSeries(Source,TOHLCSeries(ParentSeries),nil,nil);
end;

Procedure TCompressFunction.CompressSeries(Source:TChartSeries;
                                           DestOHLC:TOHLCSeries;
                                           Volume:TChartSeries=nil;
                                           DestVolume:TChartSeries=nil);
var t        : Integer;
    tmpDay   : Integer;
    OldDay   : Integer;
    tmp      : Integer;
    Year     : Word;
    Month    : Word;
    Day      : Word;
    DoIt     : Boolean;
    tmpDate  : TDateTime;
    tmpValue : TChartValue;
    tmpList  : TChartValueList;
    tmpPeriod : Integer;
begin
  DestOHLC.Clear;
  if Assigned(DestVolume) then DestVolume.Clear;

  OldDay:=0;

  tmpList:=ValueList(Source);
  tmpPeriod:=Round(Period);

  for t:=0 to Source.Count-1 do
  begin
    tmpDate:=Source.NotMandatoryValueList.Value[t];

    if tmpPeriod=0 then
    begin

      if Assigned(FOnGetDate) then FOnGetDate(Self,Source,t,tmpDate);
      DecodeDate(tmpDate,Year,Month,Day);

      Case Compress of
         ocDay: tmpDay:=Trunc(tmpDate);
        ocWeek: begin
                  tmpDay:=DayOfWeek(tmpDate)-1;
                  if tmpDay=0 then tmpDay:=7;
                end;
       ocMonth: tmpDay:=Month;
     ocBiMonth: tmpDay:=(Month-1) div 2;
     ocQuarter: tmpDay:=(Month-1) div 3;
      else      tmpDay:=Year;
      end;

      if Compress=ocWeek then DoIt:=tmpDay<OldDay else DoIt:=tmpDay<>OldDay;

      OldDay:=tmpDay;
    end
    else DoIt:=(t mod tmpPeriod)=0;

    if (t=0) or DoIt then
    begin

      if Source is TOHLCSeries then
      With TOHLCSeries(Source) do
        tmp:=DestOHLC.AddOHLC(
                  tmpDate,
                  OpenValues.Value[t],
                  HighValues.Value[t],
                  LowValues.Value[t],
                  CloseValues.Value[t])
      else
      With Source do
      begin
        tmpValue:=tmpList.Value[t];
        tmp:=DestOHLC.AddOHLC(
                  tmpDate,
                  tmpValue,
                  tmpValue,
                  tmpValue,
                  tmpValue);
      end;

      DestOHLC.Labels[tmp]:=Source.Labels[t];

      if Assigned(DestVolume) then
         DestVolume.AddXY(Source.NotMandatoryValueList.Value[t],
                          Volume.YValues.Value[t]);
    end
    else
    begin
      tmp:=DestOHLC.Count-1;

      if Source is TOHLCSeries then
      with TOHLCSeries(Source) do
      begin
        DestOHLC.CloseValues.Value[tmp]:=CloseValues.Value[t];
        DestOHLC.DateValues.Value[tmp] :=DateValues.Value[t];
        if HighValues[t]>DestOHLC.HighValues.Value[tmp] then
           DestOHLC.HighValues.Value[tmp]:=HighValues.Value[t];
        if LowValues[t]<DestOHLC.LowValues.Value[tmp] then
           DestOHLC.LowValues.Value[tmp]:=LowValues.Value[t];
      end
      else
      with Source do
      begin
        tmpValue:=tmpList.Value[t];
        DestOHLC.CloseValues.Value[tmp]:=tmpValue;
        DestOHLC.DateValues.Value[tmp] :=NotMandatoryValueList.Value[t];
        if tmpValue>DestOHLC.HighValues.Value[tmp] then
           DestOHLC.HighValues.Value[tmp]:=tmpValue;
        if tmpValue<DestOHLC.LowValues.Value[tmp] then
           DestOHLC.LowValues.Value[tmp]:=tmpValue;
      end;

      DestOHLC.Labels[tmp]:=Source.Labels[t];

      if Assigned(DestVolume) then
      begin
        With DestVolume.YValues do
           Value[tmp]:=Value[tmp]+Volume.YValues.Value[t];
        DestVolume.XValues.Value[tmp]:=Volume.XValues.Value[t];
      end;
    end;
  end;

  if Assigned(DestVolume) then  // 5.01
  begin
    DestVolume.XValues.Modified:=True; // 5.01
    DestVolume.YValues.Modified:=True;
  end;
end;

procedure TCompressFunction.SetCompress(const Value: TCompressionPeriod);
begin
  if FCompress<>Value then
  begin
    FCompress:=Value;
    ReCalculate;
  end;
end;

type TSeriesAccess=class(TChartSeries);

class Procedure TCompressFunction.PrepareForGallery(Chart:TCustomAxisPanel);
var tmpSeries : TChartSeries;
begin
  Chart.FreeAllSeries;
  tmpSeries:=CreateNewSeries(Chart.Owner,Chart,TCandleSeries,TCompressFunction);
  TSeriesAccess(tmpSeries).PrepareForGallery(True);
end;

procedure TCompressFuncEditor.CBPeriodChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCompressFuncEditor.SetFunction;
begin
  inherited;
  with TCompressFunction(IFunction) do
  begin
    CBPeriod.ItemIndex:=Ord(Compress);
    UpDown1.Position:=Round(Period);
    RadioButton1.Checked:=UpDown1.Position=0;
    RadioButton2.Checked:=not RadioButton1.Checked;
  end;
end;

procedure TCompressFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TCompressFunction(IFunction) do
  begin
    Compress:=TCompressionPeriod(CBPeriod.ItemIndex);
    Period:=UpDown1.Position;
  end;
end;

procedure TCompressFuncEditor.RadioButton1Click(Sender: TObject);
begin
  UpDown1.Position:=0;
  CBPeriod.SetFocus;
  EnableApply;
end;

procedure TCompressFuncEditor.RadioButton2Click(Sender: TObject);
begin
  ENum.SetFocus;
  EnableApply;
end;

procedure TCompressFuncEditor.ENumChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCompressFuncEditor.ENumClick(Sender: TObject);
begin
  RadioButton2.Checked:=True;
  EnableApply;
end;

procedure TCompressFuncEditor.CBPeriodClick(Sender: TObject);
begin
  RadioButton1.Checked:=True;
  EnableApply;
end;

initialization
  RegisterClass(TCompressFuncEditor);
  RegisterTeeFunction( TCompressFunction, @TeeMsg_FunctionCompress, @TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([TCompressFunction]);
end.
