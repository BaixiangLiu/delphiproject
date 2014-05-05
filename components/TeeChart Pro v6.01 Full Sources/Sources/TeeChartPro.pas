{*****************************************}
{  TeeChart Pro                           }
{  Copyright (c) 1996-2003 David Berneda  }
{                                         }
{  Component Registration Unit            }
{                                         }
{ Funcs:   TCountTeeFunction              }
{          TCurveFittingTeeFunction       }
{          TAverageTeeFunction            }
{          TMovingAverageTeeFunction      }
{          TExpMovAveFunction             }
{          TExpAverageTeeFunction         }
{          TMomentumTeeFunction           }
{          TRSITeeFunction                }
{          TStdDeviationTeeFunction       }
{          TMACDFunction                  }
{          TRootMeanSquareFunction        }
{          TCumulative                    }
{          TCompressFunction              }
{          TCrossPointsFunction           }
{          TSmoothPointsFunction          }
{          TCLVFunction                   }
{          TOBVFunction                   }
{          TPVOFunction                   }
{                                         }
{ Series:  TCandleSeries                  }
{          TVolumeSeries                  }
{          TSurfaceSeries                 }
{          TContourSeries                 }
{          TWaterFallSeries               }
{          TErrorBarSeries                }
{          TPolarSeries                   }
{          TBezierSeries                  }
{          TPoint3DSeries                 }
{          TDonutSeries                   }
{          TBoxPlotSeries                 }
{          THistogramSeries               }
{          TSmithSeries                   }
{          TPyramidSeries                 }
{          TMapSeries                     }
{          TPointFigureSeries             }
{          TGaugeSeries                   }
{          TTowerSeries                   }
{          TVector3DSeries                }
{                                         }
{ Tools:   TCursorTool                    }
{          TDragMarksTool                 }
{          TDrawLineTool                  }
{          THintsTool                     }
{          TRotateTool                    }
{          TAxisArrowTool                 }
{          TColorLineTool                 }
{          TColorBandTool                 }
{          TImageTool                     }
{          TPageNumTool                   }
{          TDragPointTool                 }
{          TExtraLegendTool               }
{          TSeriesAnimationTool           }
{          TGanttTool                     }
{          TGridBandTool                  }
{          TPieTool                       }
{                                         }
{ Other:   TDraw3D                        }
{          TTeeCommander                  }
{          TChartEditor                   }
{          TChartPreviewer                }
{          TChartScrollBar                }
{          TChartListBox                  }
{          TSeriesDataSet*                }
{          TChartGalleryPanel             }
{          TTeePreviewPanel               }
{          TChartGrid                     }
{          TChartGridNavigator            }
{          TChartPageNavigator            }
{          TChartWebSource                }
{          TSeriesTextSource              }
{          TTeeInspector                  }
{                                         }
{ Sample Series:                          }
{          TMyPointSeries                 }
{          TBar3DSeries                   }
{          TBigCandleSeries               }
{          TImagePointSeries              }
{          TDeltaPoint                    }
{          TImageBarSeries                }
{          TWindRoseSeries                }
{          TClockSeries                   }
{          TBarJoinSeries                 }
{          TCalendarSeries                }
{                                         }
{ TeeChart Actions (not for Delphi 3)     }
{          *Many*                         }
{                                         }
{ * TSeriesDataSet not available in       }
{   STANDARD versions of Delphi/CBuilder  }
{                                         }
{*****************************************}
unit TeeChartPro;
{$I TeeDefs.inc}

interface

procedure Register;

Procedure TeeSetLanguage(English:Boolean);

implementation

{$IFDEF CLX}
{$DEFINE TEENOSERIESDESIGN}
{$ENDIF}

{$IFDEF BCB}
{$DEFINE TEENOSERIESDESIGN}
{$ENDIF}

Uses Classes,
     {$IFDEF CLX}
     DesignIntf, DesignEditors,
     QControls, QGraphics, QDialogs, QActnList, QForms,
     {$ELSE}
      {$IFDEF D6}
      DesignIntf, DesignEditors,
      {$ELSE}
      DsgnIntf,
      {$ENDIF}
     Controls, Graphics, Dialogs, ActnList, Forms,
     {$ENDIF}

     {$IFNDEF TEENOSERIESDESIGN}
     TeeSeriesDesign,
     {$ENDIF}

     TeeTranslate,
     { Languages }
     TeeSpanish,
     TeeGerman,
     TeeCatalan,
     TeeFrench,
     TeeDanish,
     TeeDutch,
     TeeChinese,
     TeeChineseSimp,
     TeeBrazil,
     TeeSwedish,
     TeePortuguese,
     TeeRussian,
     TeeSlovene,
     TeeNorwegian,
     TeeJapanese,
     TeePolish,
     TeeTurkish,
     TeeHungarian,
     TeeItalian,
     TeeArabic,
     TeeHebrew,
     TeeUkrainian,
     TeeKorean,
     TeeIndonesian,
     TeeGalician,
     TeeFinnish,

     CandleCh, CurvFitt, ErrorBar, TeeErrBarEd, TeeSurfa, TeeNavigator,
     TeeSurfEdit, TeePolar, TeePolarEditor, TeeCandlEdi, StatChar,
     TeEngine, Chart, TeeProcs, TeeChartReg, TeeEditPro, TeeConst, TeeProCo,
     TeeBezie, TeePoin3, TeCanvas, TeeScroB, TeeEdit, TeeComma, TeeVolEd,
     TeeLisB, TeeEdiGene, TeeInspector, TeeCount, TeeCumu, TeeDonut,
     TeeTools, TeeTriSurface, TeeDragPoint, TeeGalleryPanel, TeePrevi,
     TeePreviewPanel, TeePreviewPanelEditor, MyPoint, Bar3D, BigCandl,
     ImaPoint, ImageBar, TeeImaEd, TeeRose, TeeChartGrid, TeeBoxPlot,
     TeeDraw3D, TeeURL, TeeSeriesTextEd, TeeMapSeries, TeeChartActions,
     TeeSmith, TeeCalendar, TeeCompressOHLC, TeeExtraLegendTool,
     TeeCLVFunction, TeeOBVFunction, TeeSeriesAnimEdit,
     TeePointFigure, TeeGanttTool, 
     {$IFNDEF LINUX}
     TeeXML, 
     {$ENDIF}
     TeeGridBandToolEdit, TeeGaugeEditor, TeeTowerEdit, TeePieTool;

type TChartEditorCompEditor=class(TComponentEditor)
     public
       procedure ExecuteVerb( Index : Integer ); override;
       function GetVerbCount : Integer; override;
       function GetVerb( Index : Integer ) : string; override;
     end;

     TPreviewPanelCompEditor=class(TComponentEditor)
     public
       procedure ExecuteVerb( Index : Integer ); override;
       function GetVerbCount : Integer; override;
       function GetVerb( Index : Integer ) : string; override;
     end;

{ TChartEditorCompEditor }
procedure TChartEditorCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then TCustomChartEditor(Component).Execute
             else inherited;
end;

function TChartEditorCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TChartEditorCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Test
             else result:=inherited GetVerb(Index);
end;

{ TPreviewPanelCompEditor }
procedure TPreviewPanelCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then
  With TFormPreviewPanelEditor.CreatePanel(nil,TTeePreviewPanel(Component)) do
  try
    ShowModal;
  finally
    Free;
  end
  else inherited;
end;

function TPreviewPanelCompEditor.GetVerbCount : Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TPreviewPanelCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

type
  TTeeCustomToolAxisProperty = class(TPropertyEditor)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TTeeCustomToolAxisProperty }
function TTeeCustomToolAxisProperty.GetAttributes: TPropertyAttributes;
begin
  result:=[paValueList,paMultiSelect,paRevertable]
end;

function TTeeCustomToolAxisProperty.GetValue: string;
begin
  With TTeeCustomToolAxis(GetComponent(0)) do
       result:=TCustomChart(ParentChart).AxisTitleOrName(Axis);
end;

procedure TTeeCustomToolAxisProperty.GetValues(Proc: TGetStrProc);
begin
  inherited;
  Proc(TeeMsg_LeftAxis);
  Proc(TeeMsg_RightAxis);
  Proc(TeeMsg_TopAxis);
  Proc(TeeMsg_BottomAxis);
end;

procedure TTeeCustomToolAxisProperty.SetValue(const Value: string);
var tmp : TCustomAxisPanel;
begin
  tmp:=TTeeCustomToolAxis(GetComponent(0)).ParentChart;
  if Value=TeeMsg_LeftAxis then SetOrdValue(Integer(tmp.LeftAxis))
  else
  if Value=TeeMsg_RightAxis then SetOrdValue(Integer(tmp.RightAxis))
  else
  if Value=TeeMsg_TopAxis then SetOrdValue(Integer(tmp.TopAxis))
  else
  if Value=TeeMsg_BottomAxis then SetOrdValue(Integer(tmp.BottomAxis))
end;

type
  TChartWebCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer); override;
    function GetVerb(Index:Integer):string; override;
    function GetVerbCount:Integer; override;
  end;

{ TChartWebCompEditor }
procedure TChartWebCompEditor.ExecuteVerb(Index:Integer);
begin
  if Index=0 then
  begin
    Screen.Cursor:=crHourGlass;
    try
      TChartWebSource(Component).Execute;
    finally
      Screen.Cursor:=crDefault;
    end;
  end
  else inherited;
end;

function TChartWebCompEditor.GetVerbCount:Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TChartWebCompEditor.GetVerb(Index:Integer):string;
begin
  if Index=0 then result:=TeeMsg_Load
             else result:=inherited GetVerb(Index);
end;

type
  TSeriesTextCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer); override;
    function GetVerb(Index:Integer):string; override;
    function GetVerbCount:Integer; override;
  end;

{ TSeriesTextCompEditor }
procedure TSeriesTextCompEditor.ExecuteVerb(Index:Integer);
begin
  if Index=0 then
  begin
    TeeEditSeriesTextSource(TSeriesTextSource(Component));
    Designer.Modified;
  end
  else inherited;
end;

function TSeriesTextCompEditor.GetVerbCount:Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TSeriesTextCompEditor.GetVerb(Index:Integer):string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

Procedure TeeSetLanguage(English:Boolean);
begin
  Case TeeLanguageRegistry of
    1: TeeSetBrazil;
    2: TeeSetCatalan;
    3: TeeSetChineseSimp;
    4: TeeSetChinese;
    5: TeeSetDanish;
    6: TeeSetDutch;
    7: TeeSetFrench;
    8: TeeSetGerman;
    9: TeeSetItalian;
   10: TeeSetPortuguese;
   11: TeeSetRussian;
   12: TeeSetSpanish;
   13: TeeSetSwedish;
   14: TeeSetNorwegian;
   15: TeeSetJapanese;
   16: TeeSetPolish;
   17: TeeSetSlovene;
   18: TeeSetTurkish;
   19: TeeSetHungarian;
   20: TeeSetGalician;
   21: TeeSetArabic;
   22: TeeSetHebrew;
   23: TeeSetUkrainian;
   24: TeeSetKorean;
   25: TeeSetIndonesian;
   26: TeeSetFinnish;
  else
    if English then TeeSetEnglish;
  end;
end;

Procedure TeeAskLanguageHook;
begin
  if TeeAskLanguage then TeeSetLanguage(True);
end;

procedure Register;
begin
  { Pro Components }
  RegisterComponents(TeeMsg_TeeChartPalette, [ TChartEditor,
                                               TChartPreviewer,
                                               TDraw3D,
                                               TChartScrollBar,
                                               TTeeCommander,
                                               TChartListBox,
                                               TChartEditorPanel,
                                               TChartGalleryPanel,
                                               TTeePreviewPanel,
                                               TChartGrid,
                                               TChartGridNavigator,
                                               TChartPageNavigator,
                                               TChartWebSource,
                                               TTeeInspector,
                                               {$IFNDEF LINUX}
                                               TTeeXMLSource, 
                                               {$ENDIF}
                                               TSeriesTextSource
                                             ]);

  { Pro Editors }
  RegisterComponentEditor(  TChartEditor,TChartEditorCompEditor);
  RegisterComponentEditor(  TChartPreviewer,TChartEditorCompEditor);
  RegisterComponentEditor(  TTeePreviewPanel,TPreviewPanelCompEditor);
  RegisterComponentEditor(  TChartWebSource,TChartWebCompEditor);
  RegisterComponentEditor(  TSeriesTextSource,TSeriesTextCompEditor);
  RegisterPropertyEditor(TypeInfo(TChartAxis), TTeeCustomToolAxis, '',TTeeCustomToolAxisProperty);

  { Chart Actions }
  RegisterActions(TeeMsg_CategoryChartActions,
                  [ TChartAction3D,TChartActionEdit,
                    TChartActionCopy,TChartActionPrint,
                    TChartActionAxes,TChartActionGrid,
                    TChartActionLegend,
                    TChartActionSave ],nil);

  { Series Actions }
  RegisterActions(TeeMsg_CategorySeriesActions,
                  [ TSeriesActionActive,TSeriesActionEdit,
                    TSeriesActionMarks ], nil);

  TeeSetLanguage(False);
end;

initialization
  {$IFNDEF TEENOSERIESDESIGN}
  TeeChartEditorHook:=TeeShowSeriesEditor;
  {$ENDIF}

  TeeChartLanguageHook:=TeeAskLanguageHook;
finalization
  TeeChartEditorHook:=nil; { For TeeChartReg "Series..." menu item }
  TeeChartLanguageHook:=nil; { For TeeChartReg "Language..." menu item }
  if TeeLanguage<>TeeEnglishLanguage then { reset language }
     TeeSetEnglish;
end.
