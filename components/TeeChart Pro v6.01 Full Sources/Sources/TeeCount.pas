{**********************************************}
{   TCountTeeFunction Component                }
{   Copyright (c) 1996-2003 by David Berneda   }
{**********************************************}
unit TeeCount;
{$I TeeDefs.inc}

interface

Uses Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, Series;

Type
  TCountTeeFunction=class(TTeeFunction)
  public
    Function Calculate(Series:TChartSeries; First,Last:Integer):Double; override;
    Function CalculateMany(SeriesList:TList; ValueIndex:Integer):Double;  override;
  end;

implementation

Uses SysUtils, TeeProCo;

Function TCountTeeFunction.Calculate(Series:TChartSeries; First,Last:Integer):Double;
begin
  if First=TeeAllValues then result:=ValueList(Series).Count
                        else result:=Last-First+1;
end;

Function TCountTeeFunction.CalculateMany(SeriesList:TList; ValueIndex:Integer):Double;
var t : Integer;
begin
  result:=0;
  for t:=0 to SeriesList.Count-1 do
    if ValueList(TChartSeries(SeriesList[t])).Count>ValueIndex then result:=result+1;
end;

initialization
  RegisterTeeBasicFunction(TCountTeeFunction, @TeeMsg_FunctionCount);
finalization
  UnRegisterTeeFunctions([TCountTeeFunction]);
end.
