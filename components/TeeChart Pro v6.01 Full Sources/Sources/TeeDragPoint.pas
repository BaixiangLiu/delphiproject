{******************************************}
{ TDragPointTool and Editor Dialog         }
{ Copyright (c) 2000-2003 by David Berneda }
{******************************************}
unit TeeDragPoint;
{$I TeeDefs.inc}

interface

uses {$IFDEF LINUX}
     Libc,
     {$ELSE}
     {$IFNDEF CLX}
     Windows, Messages,
     {$ENDIF}
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeeToolSeriesEdit, TeEngine, TeeTools;


{ DragPoint: A TeeChart Tool example.

  This tool component can be used to allow the end-user to
  drag points of any Chart Series by using the mouse.

  This unit also includes a Form that is used as the editor dialog
  for the tool. This form automatically shows at the Tools tab of the
  TeeChart editor.

  Installation / use:

  1) Add this unit to a project or to a design-time package.

  2) Then, edit a Chart1 and go to "Tools" tab and Add a DragPoint tool.

  3) Set the tool Series property to a existing series (eg: Series1 ).

  4) Fill the series with points as usually.

  5) At run-time, use the left mouse button to click and drag a
     Series point.

}

type
  { The Tool editor dialog }
  TDragPointToolEdit = class(TSeriesToolEditor)
    RGStyle: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDragPointTool=class;

  TDragPointToolEvent=procedure(Sender:TDragPointTool; Index:Integer) of object;

  TDragPointStyle=(dsX,dsY,dsBoth);

  { Drag Point Tool }
  TDragPointTool=class(TTeeCustomToolSeries)
  private
    FDragStyle: TDragPointStyle;
    FOnDrag   : TDragPointToolEvent;

    IDragging : Integer;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
  published
    property Active;
    property DragStyle:TDragPointStyle read FDragStyle write FDragStyle
                                       default dsBoth;
    property Series;
    { events }
    property OnDragPoint:TDragPointToolEvent read FOnDrag write FOnDrag;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses Chart, TeeProCo;

{ TDragPointTool }
Constructor TDragPointTool.Create(AOwner: TComponent);
begin
  inherited;
  IDragging:=-1;
  FDragStyle:=dsBoth;
end;

{ When the user clicks or moves the mouse... }
procedure TDragPointTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(Series) then
  Case AEvent of
      cmeUp: IDragging:=-1;  { stop dragging on mouse up  }

    cmeMove: if IDragging<>-1 then { if dragging... }
             With Series do
             begin
               BeginUpdate;

               { Change the Series point X and / or Y values... }
               if (Self.DragStyle=dsX) or (Self.DragStyle=dsBoth) then
                  XValue[IDragging]:=GetHorizAxis.CalcPosPoint(x);
               if (Self.DragStyle=dsY) or (Self.DragStyle=dsBoth) then
                  YValue[IDragging]:=GetVertAxis.CalcPosPoint(y);

               EndUpdate;

               { Notify the point values change... }
               if Assigned(FOnDrag) then FOnDrag(Self,IDragging);
             end;

    cmeDown: begin { when the mouse button is pressed... }
               IDragging:=Series.Clicked(x,y);
               { if clicked a Series point... }
               if IDragging<>-1 then ParentChart.CancelMouse:=True;
             end;
  end;
end;

class function TDragPointTool.Description: String;
begin
  result:=TeeMsg_DragPoint;
end;

class function TDragPointTool.GetEditorClass: String;
begin
  result:='TDragPointToolEdit';  { the editor dialog class name }
end;

procedure TDragPointToolEdit.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(Tool) then 
  Case TDragPointTool(Tool).DragStyle of
    dsX : RGStyle.ItemIndex:=0;
    dsY : RGStyle.ItemIndex:=1;
  else
    RGStyle.ItemIndex:=2;
  end;
end;

procedure TDragPointToolEdit.RGStyleClick(Sender: TObject);
begin
  With TDragPointTool(Tool) do
  Case RGStyle.ItemIndex of
    0: DragStyle:=dsX;
    1: DragStyle:=dsY;
  else
     DragStyle:=dsBoth;
  end;
end;

{ register both the tool and the tool editor dialog form }
initialization
  RegisterClass(TDragPointToolEdit);
  RegisterTeeTools([TDragPointTool]);
finalization
  { un-register the tool }
  UnRegisterTeeTools([TDragPointTool]);
end.
