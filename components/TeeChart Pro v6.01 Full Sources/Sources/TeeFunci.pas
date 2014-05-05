{********************************************}
{    TeeChart Functions                      }
{   Copyright (c) 1996-2003 by David Berneda }
{    All Rights Reserved                     }
{********************************************}
unit TeeFunci;
{$I TeeDefs.inc}

interface

Uses Classes, TeEngine;

type
     TAddTeeFunction=class(TTeeFunction)
     public
       Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
       Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
     end;

     TManySeriesTeeFunction=class(TTeeFunction)
     protected
       Function CalculateValue(Const AResult,AValue:Double):Double; virtual; abstract;
     public
       Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
     end;

     TSubtractTeeFunction=class(TManySeriesTeeFunction)
     protected
       Function CalculateValue(Const AResult,AValue:Double):Double; override;
     end;

     TMultiplyTeeFunction=class(TManySeriesTeeFunction)
     protected
       Function CalculateValue(Const AResult,AValue:Double):Double; override;
     end;

     TDivideTeeFunction=class(TManySeriesTeeFunction)
     protected
       Function CalculateValue(Const AResult,AValue:Double):Double; override;
     end;

     THighTeeFunction=class(TTeeFunction)
     public
       Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
       Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
     end;

     TLowTeeFunction=class(TTeeFunction)
     public
       Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
       Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
     end;

     TAverageTeeFunction=class(TTeeFunction)
     private
       FIncludeNulls : Boolean;
       procedure SetIncludeNulls(const Value: Boolean);
     protected
       class Function GetEditorClass:String; override;
     public
       Constructor Create(AOwner:TComponent); override;

       Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
       Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
     published
       property IncludeNulls:Boolean read FIncludeNulls write SetIncludeNulls default True;
     end;

     TCustomTeeFunction=class;

     TCalculateEvent=
      procedure(Sender:TCustomTeeFunction; const x:Double; var y:Double) of object;

     TCustomTeeFunction=class(TTeeFunction)
     private
       FCalculate : TCalculateEvent;
       FNumPoints : Integer;
       FStartX    : Double;
       FX         : Double;
     protected
       class Function GetEditorClass:String; override;
     public
       Constructor Create(AOwner:TComponent); override;
       procedure AddPoints(Source:TChartSeries); override;
       property X:Double read FX write FX;
     published
       property NumPoints:Integer read FNumPoints write FNumPoints;
       property StartX:Double read FStartX write FStartX;
       property OnCalculate:TCalculateEvent read FCalculate write FCalculate;
     end;

implementation

Uses SysUtils, TeeProcs, TeeConst, Chart;

{ Add }
Function TAddTeeFunction.Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var t : Integer;
begin
  With ValueList(SourceSeries) do
  if FirstIndex=TeeAllValues then result:=Total
  else
  begin
    result:=0;
    for t:=FirstIndex to LastIndex do result:=result+Value[t];
  end;
end;

Function TAddTeeFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var t       : Integer;
    tmpList : TChartValueList;
begin
  result:=0;
  for t:=0 to SourceSeriesList.Count-1 do
  begin
    tmpList:=ValueList(TChartSeries(SourceSeriesList[t]));
    if tmpList.Count>ValueIndex then result:=result+tmpList.Value[ValueIndex];
  end;
end;

{ ManySeriesFunction }
Function TManySeriesTeeFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var tmpList  : TChartValueList;
    tmpFirst : Boolean;
    t        : Integer;
begin
  tmpFirst:=True;
  result:=0;
  for t:=0 to SourceSeriesList.Count-1 do
  begin
    tmpList:=ValueList(TChartSeries(SourceSeriesList[t]));
    if tmpList.Count>ValueIndex then
    begin
      if tmpFirst then
      begin
        result:=tmpList.Value[ValueIndex];
        tmpFirst:=False;
      end
      else result:=CalculateValue(result,tmpList.Value[ValueIndex]);
    end
  end
end;

{ Subtract }
Function TSubtractTeeFunction.CalculateValue(Const AResult,AValue:Double):Double;
begin
  result:=AResult-AValue;
end;

{ Multiply }
Function TMultiplyTeeFunction.CalculateValue(Const AResult,AValue:Double):Double;
begin
  result:=AResult*AValue;
end;

{ Divide }
Function TDivideTeeFunction.CalculateValue(Const AResult,AValue:Double):Double;
begin
  if AValue=0 then result:=AResult
              else result:=AResult/AValue;
end;

{ High }
Function THighTeeFunction.Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var t   : Integer;
    tmp : Double;
begin
  With ValueList(SourceSeries) do
  if FirstIndex=TeeAllValues then result:=MaxValue
  else
  begin
    result:=0;
    for t:=FirstIndex to LastIndex do
    begin
      tmp:=Value[t];
      if t=FirstIndex then result:=tmp else
      if tmp>result then result:=tmp;
    end;
  end;
end;

Function THighTeeFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var t       : Integer;
    tmp     : Double;
    tmpList : TChartValueList;
begin
  result:=0;
  for t:=0 to SourceSeriesList.Count-1 do
  begin
    tmpList:=ValueList(TChartSeries(SourceSeriesList[t]));
    if tmpList.Count>ValueIndex then
    begin
      tmp:=tmpList.Value[ValueIndex];
      if (t=0) or (tmp>result) then result:=tmp;
    end;
  end;
end;

{ Low }
Function TLowTeeFunction.Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var t   : Integer;
    tmp : Double;
begin
  With ValueList(SourceSeries) do
  if FirstIndex=TeeAllValues then result:=MinValue
  else
  begin
    result:=0;
    for t:=FirstIndex to LastIndex do
    begin
      tmp:=Value[t];
      if t=FirstIndex then result:=tmp else
      if tmp<result then result:=tmp;
    end;
  end;
end;

Function TLowTeeFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var t       : Integer;
    tmp     : Double;
    tmpList : TChartValueList;
begin
  result:=0;
  for t:=0 to SourceSeriesList.Count-1 do
  begin
    tmpList:=ValueList(TChartSeries(SourceSeriesList[t]));
    if tmpList.Count>ValueIndex then
    begin
      tmp:=tmpList.Value[ValueIndex];
      if (t=0) or (tmp<result) then result:=tmp;
    end;
  end;
end;

{ Average }
constructor TAverageTeeFunction.Create(AOwner: TComponent);
begin
  inherited;
  FIncludeNulls:=True;
end;

Function TAverageTeeFunction.Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var t        : Integer;
    tmpCount : Integer;
begin
  if (FirstIndex=TeeAllValues) and IncludeNulls then
  With SourceSeries do
  begin
    if Count>0 then result:=ValueList(SourceSeries).Total/Count
               else result:=0;
  end
  else
  begin
    if FirstIndex=TeeAllValues then
    begin
      FirstIndex:=0;
      LastIndex:=SourceSeries.Count-1;
    end;
    result:=0;
    tmpCount:=0;
    With ValueList(SourceSeries) do
    for t:=FirstIndex to LastIndex do
    if IncludeNulls or (not SourceSeries.IsNull(t)) then
    begin
      result:=result+Value[t];
      Inc(tmpCount);
    end;
    if tmpCount=0 then result:=0
                  else result:=result/tmpCount;
  end;
end;

Function TAverageTeeFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var t       : Integer;
    Counter : Integer;
    tmpList : TChartValueList;
begin
  result:=0;
  if SourceSeriesList.Count>0 then
  begin
    Counter:=0;
    for t:=0 to SourceSeriesList.Count-1 do
    begin
      tmpList:=ValueList(TChartSeries(SourceSeriesList[t]));
      if (tmpList.Count>ValueIndex) and
         (IncludeNulls or (not TChartSeries(SourceSeriesList[t]).IsNull(t))) then
      begin
        Inc(Counter);
        result:=result+tmpList.Value[ValueIndex];
      end;
    end;
    if Counter>0 then result:=result/Counter;
  end;
end;

procedure TAverageTeeFunction.SetIncludeNulls(const Value: Boolean);
begin
  if FIncludeNulls<>Value then
  begin
    FIncludeNulls:=Value;
    ReCalculate;
  end;
end;

class function TAverageTeeFunction.GetEditorClass: String;
begin
  result:='TAverageFuncEditor';
end;

{ TCustomTeeFunction }
Constructor TCustomTeeFunction.Create(AOwner: TComponent);
begin
  inherited;
  NoSourceRequired:=True;
  Period:=1;
  FNumPoints:=100;
end;

procedure TCustomTeeFunction.AddPoints(Source: TChartSeries);
var x : Double;
    y : Double;
    t : Integer;
begin
  if Assigned(FCalculate) then
  begin
    ParentSeries.Clear;
    x:=FStartX;
    for t:=1 to FNumPoints do
    begin
      FX:=x;
      FCalculate(Self,x,y);
      if ParentSeries.YMandatory then ParentSeries.AddXY(FX,y)
                                 else ParentSeries.AddXY(y,FX);
      x:=x+Period;
    end;
  end;
end;

class function TCustomTeeFunction.GetEditorClass: String;
begin
  result:='TCustomFunctionEditor';
end;

initialization
  RegisterTeeBasicFunction( TAddTeeFunction,      @TeeMsg_FunctionAdd );
  RegisterTeeBasicFunction( TSubtractTeeFunction, @TeeMsg_FunctionSubtract );
  RegisterTeeBasicFunction( TMultiplyTeeFunction, @TeeMsg_FunctionMultiply );
  RegisterTeeBasicFunction( TDivideTeeFunction,   @TeeMsg_FunctionDivide );
  RegisterTeeBasicFunction( THighTeeFunction,     @TeeMsg_FunctionHigh );
  RegisterTeeBasicFunction( TLowTeeFunction,      @TeeMsg_FunctionLow );
  RegisterTeeBasicFunction( TAverageTeeFunction,  @TeeMsg_FunctionAverage );
  RegisterTeeBasicFunction( TCustomTeeFunction,   @TeeMsg_FunctionCustom);
end.
