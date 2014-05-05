{***************************************}
{ TeeChart Pro - TChartListBox class    }
{ Copyright (c) 1995-2003 David Berneda }
{     Component Registration Unit       }
{***************************************}
unit TeeLisB;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QStdCtrls, QGraphics, QForms, QControls, QButtons, QDialogs, Qt,
     {$ELSE}
     StdCtrls, Graphics, Forms, Controls, Buttons, Dialogs,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     SysUtils, Classes, Chart, TeeProcs, TeCanvas, TeEngine;

type TChartListBox=class;

     TDblClickSeriesEvent=procedure(Sender:TChartListBox; Index:Integer) of object;
     TNotifySeriesEvent=procedure(Sender:TChartListBox; Series:TCustomChartSeries) of object;
     TChangeOrderEvent=procedure(Sender:TChartListBox; Series1,Series2:TCustomChartSeries) of object;

     TListBoxSection=Packed record
       Width   : Integer;
       Visible : Boolean;
     end;

     TListBoxSections=Array[0..3] of TListBoxSection;

     TChartListBox=class(TCustomListBox,ITeeEventListener)
     private
       FAllowAdd         : Boolean;
       FAllowDelete      : Boolean;
       FAskDelete        : Boolean;
       FChart            : TCustomChart;
       FEnableChangeColor: Boolean;
       FEnableDragSeries : Boolean;
       FEnableChangeType : Boolean;
       {$IFNDEF CLX}
       FHitTest          : TPoint;
       {$ENDIF}

       FOnChangeColor    : TNotifySeriesEvent;
       FOnChangeOrder    : TChangeOrderEvent; // 5.03

       FOnEditSeries     : TDblClickSeriesEvent;
       FOnRemovedSeries  : TNotifySeriesEvent;
       FOtherItems       : TStrings;
       FOtherItemsChange : TNotifyEvent;
       FRefresh          : TNotifyEvent;
       ComingFromDoubleClick:Boolean;

       procedure DoRefresh;
       Function GetSelectedSeries:TChartSeries;
       Function GetShowActive:Boolean;
       Function GetShowIcon:Boolean;
       Function GetShowColor:Boolean;
       Function GetShowTitle:Boolean;
       function GetSeries(Index: Integer): TChartSeries;
       procedure LBSeriesClick(Sender: TObject);
       {$IFDEF CLX}
       procedure LBSeriesDrawItem(Sender: TObject; Index: Integer;
        Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
       {$ELSE}
       procedure LBSeriesDrawItem(Control: TWinControl; Index: Integer;
                                           Rect: TRect; State: TOwnerDrawState);
       {$ENDIF}
       procedure LBSeriesDragOver( Sender, Source: TObject; X,
                                   Y: Integer; State: TDragState; var Accept: Boolean);
       Procedure RefreshDesigner;
       Function SectionLeft(ASection:Integer):Integer;
       Procedure SelectSeries(AIndex:Integer);
       procedure SetChart(Value:TCustomChart);
       Procedure SetSelectedSeries(Value:TChartSeries);
       Procedure SetShowActive(Value:Boolean);
       Procedure SetShowIcon(Value:Boolean);
       Procedure SetShowColor(Value:Boolean);
       Procedure SetShowTitle(Value:Boolean);

       procedure TeeEvent(Event: TTeeEvent);  { interface }
     protected
       procedure DblClick; override;
       procedure KeyUp(var Key: Word; Shift: TShiftState); override;
       procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                           X, Y: Integer); override;
       procedure Notification(AComponent: TComponent;
                              Operation: TOperation); override;
       {$IFNDEF CLX}
       procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
       procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
       {$ELSE}
       procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
       {$ENDIF}
     public
       Sections : TListBoxSections;

       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;

       Function AddSeriesGallery:TChartSeries;
       Function AnySelected:Boolean;   { 5.01 }
       procedure ChangeTypeSeries(Sender: TObject);
       procedure ClearItems;
       {$IFNDEF D6}
       procedure ClearSelection;
       {$ENDIF}
       Procedure CloneSeries;
       Function DeleteSeries:Boolean;
       procedure DragDrop(Source: TObject; X, Y: Integer); override;
       procedure FillSeries(OldSeries:TChartSeries);
       Procedure MoveCurrentDown;
       Procedure MoveCurrentUp;
       property OtherItems:TStrings read FOtherItems write FOtherItems;
       Function PointInSection(Const P:TPoint; ASection:Integer):Boolean;
       Function RenameSeries:Boolean; { 5.02 }
       Procedure SelectAll; {$IFNDEF CLX}{$IFDEF D6} override; {$ENDIF}{$ENDIF}
       property Series[Index:Integer]:TChartSeries read GetSeries;
       Function SeriesAtMousePos(Var p:TPoint):Integer;
       property SelectedSeries:TChartSeries read GetSelectedSeries
                                            write SetSelectedSeries;
       procedure SwapSeries(tmp1,tmp2:Integer);
       procedure UpdateSeries;
     published
       property AllowAddSeries : Boolean read FAllowAdd
                                  write FAllowAdd default True;
       property AllowDeleteSeries : Boolean read FAllowDelete
                                  write FAllowDelete default True;
       property AskDelete:Boolean read FAskDelete write FAskDelete
                                  default True;
       property Chart:TCustomChart read FChart write SetChart;
       property EnableChangeColor:Boolean read FEnableChangeColor
                                          write FEnableChangeColor default True;
       property EnableDragSeries:Boolean read FEnableDragSeries
                                            write FEnableDragSeries default True;
       property EnableChangeType:Boolean read FEnableChangeType
                                         write FEnableChangeType default True;
       property OnChangeColor:TNotifySeriesEvent read FOnChangeColor
                                                write FOnChangeColor;
       property OnChangeOrder:TChangeOrderEvent read FOnChangeOrder
                                                write FOnChangeOrder;
       property OnDblClickSeries:TDblClickSeriesEvent read FOnEditSeries
                                                  write FOnEditSeries;
       property OnOtherItemsChange:TNotifyEvent read FOtherItemsChange
                                              write FOtherItemsChange;
       property OnRefresh:TNotifyEvent read FRefresh write FRefresh;
       property OnRemovedSeries:TNotifySeriesEvent read FOnRemovedSeries
                                                    write FOnRemovedSeries;
       property ShowActiveCheck:Boolean read GetShowActive
                                        write SetShowActive default True;
       property ShowSeriesColor:Boolean read GetShowColor
                                           write SetShowColor default True;
       property ShowSeriesIcon:Boolean read GetShowIcon
                                           write SetShowIcon default True;
       property ShowSeriesTitle:Boolean read GetShowTitle
                                           write SetShowTitle default True;

       property Align;
       property BorderStyle;
       property Color;
       {$IFNDEF CLX}
       property Ctl3D;
       {$ENDIF}
       property Enabled;
       property ExtendedSelect;
       property Font;
       {$IFNDEF CLX}
       property ImeMode;
       property ImeName;
       {$ENDIF}
       property ItemHeight; { 5.02 }
       property MultiSelect default True;  { 5.01 }
       property ParentColor;
       {$IFNDEF CLX}
       property ParentCtl3D;
       {$ENDIF}
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Visible;
       property OnClick;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       {$IFNDEF CLX}
       property OnStartDock;
       {$ENDIF}
       property OnStartDrag;
     end;

var TeeAddGalleryProc:Function(AOwner:TComponent; Chart:TCustomChart; Series:TChartSeries):TChartSeries=nil;
    TeeChangeGalleryProc:Function(AOwner:TComponent; var Series: TChartSeries):TChartSeriesClass=nil;

implementation

{$R TeeBmps.res}

Uses TeePenDlg, TeeConst;

{ TChartListBox }
Constructor TChartListBox.Create(AOwner:TComponent);
begin
  inherited;
  ComingFromDoubleClick:=False;

//  DoubleBuffered:=True;

  FEnableChangeColor:=True;
  FEnableDragSeries:=True;
  FEnableChangeType:=True;

  Sections[0].Width:=26;  Sections[0].Visible:=True;
  Sections[1].Width:=16;  Sections[1].Visible:=True;
  Sections[2].Width:=26;  Sections[2].Visible:=True;
  Sections[3].Width:=216; Sections[3].Visible:=True;

  OnDrawItem:=LBSeriesDrawItem;
  OnDragOver:=LBSeriesDragOver;
  OnClick:=LBSeriesClick;

  {$IFDEF CLX}
  Style:=lbOwnerDrawVariable;
  {$ELSE}
  Style:=lbOwnerDrawFixed;
  {$ENDIF}
  ItemHeight:=24;
  Sorted:=False;
  MultiSelect:=True;
  FAskDelete:=True;
  FAllowDelete:=True;
  FAllowAdd:=True;
end;

Destructor TChartListBox.Destroy;
begin
  Chart:=nil;
  inherited;
end;

procedure TChartListBox.DragDrop(Source: TObject; X,Y: Integer);
var tmp1 : Integer;
    tmp2 : Integer;
begin
  if ItemIndex<>-1 then
  begin
    tmp1:=ItemIndex;
    tmp2:=ItemAtPos(TeePoint(X,Y),True);
    if (tmp2<>-1) and (tmp1<>tmp2) then SwapSeries(tmp1,tmp2);
  end;
end;

procedure TChartListBox.DoRefresh;
begin
  if Assigned(FRefresh) then FRefresh(Self);
end;

type TChartAccess=class(TCustomChart);

procedure TChartListBox.SetChart(Value:TCustomChart);
begin
  if FChart<>Value then
  begin
    if Assigned(Chart) then
    begin
      TChartAccess(Chart).RemoveListener(Self);
      {$IFDEF D5}
      Chart.RemoveFreeNotification(Self);
      {$ENDIF}
    end;

    FChart:=Value;

    if Assigned(Chart) then
    begin
      Chart.FreeNotification(Self);
      TChartAccess(Chart).Listeners.Add(Self);
      FillSeries(nil);
    end
    else ClearItems;
  end;
end;

procedure TChartListBox.ClearItems;
begin
  if not (csDestroying in ComponentState) then
  begin
    Items.Clear;
    if Assigned(FOtherItems) then FOtherItems.Clear;
  end;
end;

Procedure TChartListBox.SelectSeries(AIndex:Integer); { 5.01 }
begin
  if MultiSelect then Selected[AIndex]:=True
                 else ItemIndex:=AIndex;
end;

procedure TChartListBox.SwapSeries(tmp1,tmp2:Integer);
var tmp        : TCustomForm;
    Series1    : TCustomChartSeries;
    Series2    : TCustomChartSeries;
begin
  Items.Exchange(tmp1,tmp2);
  if Assigned(FOtherItems) then FOtherItems.Exchange(tmp1,tmp2);

  if Assigned(Chart) then
  begin
    Series1:=TCustomChartSeries(Items.Objects[tmp1]);
    Series2:=TCustomChartSeries(Items.Objects[tmp2]);
    Chart.ExchangeSeries(Series1,Series2);

    if Assigned(FOnChangeOrder) then
       FOnChangeOrder(Self,Series1,Series2); // 5.03
  end;

  tmp:=GetParentForm(Self);
  if Assigned(tmp) then tmp.ActiveControl:=Self;
  SelectSeries(tmp2);
  DoRefresh;
  RefreshDesigner;
end;

procedure TChartListBox.LBSeriesClick(Sender: TObject);
begin
  DoRefresh;
end;

Function TChartListBox.SectionLeft(ASection:Integer):Integer;
var t : Integer;
begin
  result:=0;
  for t:=0 to ASection-1 do
  if Sections[t].Visible then Inc(result,Sections[t].Width);
end;

type TSeriesAccess=class(TChartSeries);

{$IFDEF CLX}
procedure TChartListBox.LBSeriesDrawItem(Sender: TObject; Index: Integer;
     Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ELSE}
procedure TChartListBox.LBSeriesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
Const BrushColors : Array[Boolean] of TColor=(clWindow,clHighLight);
      FontColors  : Array[Boolean] of TColor=(clWindowText,clHighlightText);
var tmp       : Integer;
    tmpSeries : TChartSeries;
    tmpR      : TRect;
    CBRect    : TRect;
    tmpCanvas : TCanvas;
    tmpBitmap : TBitmap;
begin
  tmpCanvas:=Canvas;
  With tmpCanvas do
  begin
    if odSelected in State then Brush.Color:=clHighLight
                           else Brush.Color:=Self.Color;
    {$IFDEF CLX}
    Brush.Style:=bsSolid;
    {$ENDIF}
    FillRect(Rect);

    Brush.Color:=Self.Color;
    Brush.Style:=bsSolid;
    tmpR:=Rect;
    tmpR.Right:=SectionLeft(3)-2;

    {$IFDEF CLX}
    Inc(tmpR.Bottom);
    {$ENDIF}

    FillRect(tmpR);

    tmpSeries:=Series[Index];

    if Assigned(tmpSeries) then
    begin

      if ShowSeriesIcon then
      begin
        tmpBitmap:=TBitmap.Create;
        try
          TeeGetBitmapEditor(tmpSeries,tmpBitmap);
          {$IFNDEF CLX}
          tmpBitmap.Transparent:=True;
          {$ENDIF}
          Draw(SectionLeft(0),Rect.Top,tmpBitmap);
        finally
          tmpBitmap.Free;
        end;
      end;

      if ShowSeriesColor and
         (TSeriesAccess(tmpSeries).IUseSeriesColor) then
      begin
        tmp:=SectionLeft(2)-2;
        tmpR:=Classes.Rect(tmp,Rect.Top,tmp+Sections[2].Width,Rect.Bottom);
        InflateRect(tmpR,-4,-4);
        PaintSeriesLegend(tmpSeries,tmpCanvas,tmpR);
      end;

      if ShowActiveCheck then
      begin
        tmp:=SectionLeft(1);
        CBRect:=Classes.Rect(tmp+2,Rect.Top+6,tmp+12,Rect.Top+18);
        TeeDrawCheckBox(CBRect.Left,CBRect.Top,tmpCanvas,tmpSeries.Active,Self.Color);
      end;

      Brush.Style:=bsClear;
      if ShowSeriesTitle then
      begin
        if odSelected in State then Font.Color:={$IFNDEF CLX}ColorToRGB{$ENDIF}(clHighlightText)
                               else Font.Color:=ColorToRGB(Self.Font.Color);

        {$IFDEF CLX}
        Start;
        QPainter_setBackgroundMode(Handle,BGMode_TransparentMode);
        Stop;
        {$ELSE}
        SetBkMode(Handle,Transparent);
        {$ENDIF}

        TextOut(SectionLeft(3)+1,Rect.Top+((ItemHeight-TextHeight('W')) div 2),Items[Index]);

        {$IFDEF CLX}
        Start;
        QPainter_setBackgroundMode(Handle,BGMode_OpaqueMode);
        Stop;
        {$ELSE}
        SetBkMode(Handle,Opaque);
        {$ENDIF}
      end
      else TextOut(0,0,'');
      
    end;
  end;
end;

Function TChartListBox.GetSelectedSeries:TChartSeries;
begin
  result:=Series[ItemIndex];
end;

Procedure TChartListBox.SetSelectedSeries(Value:TChartSeries);
begin
  ItemIndex:=Items.IndexOfObject(Value);
  if ItemIndex<>-1 then Selected[ItemIndex]:=True;
  {$IFDEF CLX}
  DoRefresh;
  {$ENDIF}
end;

procedure TChartListBox.LBSeriesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=FEnableDragSeries and (Sender=Source);
end;

Function TChartListBox.SeriesAtMousePos(Var p:TPoint):Integer;
begin
  p:=ScreenToClient(Mouse.CursorPos);
  result:=ItemAtPos(p,True);
end;

Function TChartListBox.PointInSection(Const P:TPoint; ASection:Integer):Boolean;
Var tmpPos : Integer;
begin
  if Sections[ASection].Visible then
  begin
    tmpPos:=SectionLeft(ASection);
    result:=(p.x>tmpPos) and (p.x<tmpPos+Sections[ASection].Width);
  end
  else result:=False;
end;

procedure TChartListBox.FillSeries(OldSeries:TChartSeries);
var tmp : Integer;
Begin
  ClearItems;
  if Assigned(Chart) then FillSeriesItems(Items,Chart);
  if Assigned(FOtherItems) then FOtherItems.Assign(Items);

  tmp:=Items.IndexOfObject(OldSeries);
  if (tmp=-1) and (Items.Count>0) then tmp:=0;

  if (tmp<>-1) and (Items.Count>tmp) then SelectSeries(tmp);

  if Assigned(FOtherItemsChange) then FOtherItemsChange(Self);
  DoRefresh;
end;

Function TChartListBox.AnySelected:Boolean;   { 5.01 }
begin
  if MultiSelect then result:=SelCount>0
                 else result:=ItemIndex<>-1;
end;

procedure TChartListBox.ChangeTypeSeries(Sender: TObject);
var tmpSeries : TChartSeries;
    NewClass  : TChartSeriesClass;
    t         : Integer;
    tmp       : Integer;
    FirstTime : Boolean;
    tmpList   : TChartSeriesList;
begin
  if AnySelected and Assigned(Chart) and Assigned(TeeChangeGalleryProc) then
  begin
    tmpList:=TChartSeriesList.Create;
    try
      { get selected list of series }
      if MultiSelect then { 5.01 }
      begin
         for t:=0 to Items.Count-1 do
             if Selected[t] then tmpList.Add(Series[t])
      end
      else tmpList.Add(Series[ItemIndex]);

      FirstTime:=True;
      NewClass:=nil;

      { change all selected... }
      for t:=0 to tmpList.Count-1 do
      begin
        tmpSeries:=tmpList[t];
        if FirstTime then
        begin
          NewClass:=TeeChangeGalleryProc(Owner,tmpSeries);
          FirstTime:=False;
        end
        else ChangeSeriesType(tmpSeries,NewClass);
        tmpList[t]:=tmpSeries;
      end;

      { reset the selected list... }
      for t:=0 to tmpList.Count-1 do
      begin
        tmp:=Items.IndexOfObject(tmpList[t]);
        if tmp<>-1 then SelectSeries(tmp);
      end;
    finally
      tmpList.Free;
    end;
    { refill and repaint list }
    DoRefresh;
    { tell the series designer we have changed... }
    RefreshDesigner;
  end;
end;

procedure TChartListBox.DblClick;

  Function IsSelected(tmp:Integer):Boolean;  { 5.01 }
  begin
    if MultiSelect then result:=Selected[tmp]
                   else result:=ItemIndex=tmp;
  end;

var p        : TPoint;
    tmp      : Integer;
    tmpColor : TColor;
begin
  ComingFromDoubleClick:=True;

  { find series at mouse position "p" }
  tmp:=SeriesAtMousePos(p);
  if (tmp<>-1) and IsSelected(tmp) then
  begin
    if PointInSection(p,0) and FEnableChangeType then ChangeTypeSeries(Self)
    else
    if PointInSection(p,2) and FEnableChangeColor then
    begin
      if TSeriesAccess(Series[tmp]).IUseSeriesColor then
      With Series[tmp] do
      begin
        tmpColor:=SeriesColor;
        if EditColorDialog(Self,tmpColor) then
        begin
          SeriesColor:=tmpColor;
          ColorEachPoint:=False;
          if Assigned(FOnChangeColor) then
             FOnChangeColor(Self,Series[tmp]);
        end;
      end;
    end
    else
    if PointInSection(p,3) then
       if Assigned(FOnEditSeries) then FOnEditSeries(Self,tmp);
  end;
end;

procedure TChartListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
var tmp : Integer;
    p   : TPoint;
begin
  if ItemIndex<>-1 then
  begin
    tmp:=SeriesAtMousePos(p);
    if (tmp<>-1) and (PointInSection(p,1)) then
    begin
      with Series[tmp] do Active:=not Active;
      if not Assigned(Series[tmp].ParentChart) then Self.Repaint;
    end
    else
    if FEnableDragSeries and
       PointInSection(p,3) and (not ComingFromDoubleClick) and
       (not (ssShift in Shift)) and
       (not (ssCtrl in Shift)) and
       ( ( ssLeft in Shift) ) then
            BeginDrag(False);
    ComingFromDoubleClick:=False;
    if Assigned(FOtherItemsChange) then FOtherItemsChange(Self);
  end;
end;

Procedure TChartListBox.MoveCurrentUp;
begin
  if ItemIndex>0 then SwapSeries(ItemIndex,ItemIndex-1);
end;

Procedure TChartListBox.MoveCurrentDown;
begin
  if (ItemIndex<>-1) and (ItemIndex<Items.Count-1) then
     SwapSeries(ItemIndex,ItemIndex+1);
end;

{ Delete the current selected Series, if any. Returns True if deleted }
Function TChartListBox.DeleteSeries:Boolean;

  Procedure DoDelete;
  Var t : Integer;
  begin
    if MultiSelect then { 5.01 }
    begin
      t:=0;
      While t<Items.Count do
      if Selected[t] then Series[t].Free
                     else Inc(t);
    end
    else
    if ItemIndex<>-1 then Series[ItemIndex].Free;

    if Items.Count>0 then SelectSeries(0);

    DoRefresh;
    RefreshDesigner;
  end;

var tmpSt : String;
begin
  result:=False;
  if AnySelected then { 5.01 }
    if FAskDelete then
    begin
      if (not MultiSelect) or (SelCount=1) then  { 5.01 }
         tmpSt:=SeriesTitleOrName(SelectedSeries)
      else
         tmpSt:=TeeMsg_SelectedSeries;

      if TeeYesNoDelete(tmpSt,Self) then
      begin
        DoDelete;
        result:=True;
      end;
    end
    else
    begin
      DoDelete;
      result:=True;
    end;
end;

Procedure TChartListBox.CloneSeries;
begin { duplicate current selected series }
  if ItemIndex<>-1 then
  begin
    CloneChartSeries(SelectedSeries);
    RefreshDesigner;
  end;
end;

procedure TChartListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Case Key of
    {$IFDEF CLX}
    Key_Insert
    {$ELSE}
    VK_INSERT
    {$ENDIF}:  if FAllowAdd then AddSeriesGallery;

    {$IFDEF CLX}
    Key_Delete
    {$ELSE}
    VK_DELETE
    {$ENDIF}:  if FAllowDelete then DeleteSeries;
  end;
end;

Function TChartListBox.RenameSeries:Boolean; { 5.02 }
var tmp       : Integer;
    tmpSeries : TChartSeries;
    tmpSt     : String;
    Old       : String;
begin
  result:=False;
  tmp:=ItemIndex;
  if tmp<>-1 then
  begin
    tmpSeries:=SelectedSeries;
    tmpSt:=SeriesTitleOrName(tmpSeries);
    Old:=tmpSt;
    if InputQuery(TeeMsg_ChangeSeriesTitle,
                  TeeMsg_NewSeriesTitle,tmpSt) then
    begin
      if tmpSt<>'' then
         if tmpSt=tmpSeries.Name then tmpSeries.Title:=''
                                 else tmpSeries.Title:=tmpSt;
      { return True if the title has been changed }
      result:=Old<>SeriesTitleOrName(tmpSeries);
    end;
    SelectSeries(tmp);
  end;
end;

Procedure TChartListBox.RefreshDesigner;
begin
  if Assigned(Chart) and Assigned(Chart.Designer) then Chart.Designer.Refresh;
end;

Function TChartListBox.AddSeriesGallery:TChartSeries;
var t : Integer;
begin
  if Assigned(TeeAddGalleryProc) then
  begin
    result:=TeeAddGalleryProc(Owner,Chart,SelectedSeries);
    if Assigned(result) then
    begin
      if MultiSelect then // 5.01
         for t:=0 to Items.Count-1 do Selected[t]:=False;

      SelectSeries(Items.IndexOfObject(result));

      DoRefresh;
      RefreshDesigner;
    end;
  end
  else result:=nil;
end;

procedure TChartListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(Chart) and (AComponent=Chart) then
     Chart:=nil;
end;

{$IFNDEF CLX}
procedure TChartListBox.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  FHitTest:=SmallPointToPoint(Msg.Pos);
end;

procedure TChartListBox.WMSetCursor(var Msg: TWMSetCursor);
var I: Integer;
begin
  if csDesigning in ComponentState then Exit;

  if (Items.Count>0) and (SeriesAtMousePos(FHitTest)<>-1) and
     (Msg.HitTest=HTCLIENT) then

     for I:=0 to 2 do  { don't count last section }
     begin
       if PointInSection(FHitTest,I) then
       begin
         if ((I=0) and FEnableChangeType) or
            ((I=2) and FEnableChangeColor) then
         begin
           SetCursor(Screen.Cursors[crHandPoint]);
           Exit;
         end
         else break;
       end;
     end;
  inherited;
end;

{$ELSE}

procedure TChartListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var I : Integer;
    P : TPoint;
begin
  if csDesigning in ComponentState then Exit;

  P:=TeePoint(X,Y);
  if (Items.Count>0) and (SeriesAtMousePos(P)<>-1) then

     for I:=0 to 2 do  { don't count last section }
     begin
       if PointInSection(P,I) then
       begin
         if ((I=0) and FEnableChangeType) or
            ((I=2) and FEnableChangeColor) then
         begin
           Cursor:=crHandPoint;
           Exit;
         end
         else break;
       end;
     end;
  Cursor:=crDefault;
end;
{$ENDIF}

procedure TChartListBox.UpdateSeries;
begin
  FillSeries(SelectedSeries);
end;

Function TChartListBox.GetShowActive:Boolean;
begin
  result:=Sections[1].Visible;
end;

procedure TChartListBox.SetShowActive(Value:Boolean);
begin
  Sections[1].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowIcon:Boolean;
begin
  result:=Sections[0].Visible;
end;

procedure TChartListBox.SetShowIcon(Value:Boolean);
begin
  Sections[0].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowColor:Boolean;
begin
  result:=Sections[2].Visible;
end;

procedure TChartListBox.SetShowColor(Value:Boolean);
begin
  Sections[2].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowTitle:Boolean;
begin
  result:=Sections[3].Visible;
end;

procedure TChartListBox.SetShowTitle(Value:Boolean);
begin
  Sections[3].Visible:=Value; Repaint;
end;

procedure TChartListBox.SelectAll;
{$IFNDEF D6}
var t : Integer;
{$ENDIF}
begin
  if MultiSelect then { 5.01 }
  begin
    {$IFDEF D6}
    inherited;
    {$ELSE}
    for t:=0 to Items.Count-1 do Selected[t]:=True;
    {$ENDIF}
    RefreshDesigner;
  end;
end;

Function TChartListBox.GetSeries(Index:Integer):TChartSeries;
begin
  if (Index<>-1) and (Index<Items.Count) then
     result:=TChartSeries(Items.Objects[Index])
  else
     result:=nil;
end;

procedure TChartListBox.TeeEvent(Event:TTeeEvent);
var tmp : Integer;
begin
  if not (csDestroying in ComponentState) then
  if Event is TTeeSeriesEvent then
  With TTeeSeriesEvent(Event) do
  Case Event of
    seChangeColor,
    seChangeActive: Invalidate;
    seChangeTitle: begin
                tmp:=Items.IndexOfObject(Series);
                if tmp<>-1 then Items[tmp]:=SeriesTitleOrName(Series);
              end;
    seRemove: begin
                tmp:=Items.IndexOfObject(Series);
                if tmp<>-1 then
                begin
                  Items.Delete(tmp);
                  if Assigned(FOtherItems) then FOtherItems.Delete(tmp);
                  if Assigned(FOnRemovedSeries) then
                     FOnRemovedSeries(Self,Series); { 5.02 }
                end;
              end;
      seAdd,
      seSwap: UpdateSeries;
  end;
end;

{$IFNDEF D6}
Procedure TChartListBox.ClearSelection;
var t: Integer;
begin
  if MultiSelect then
     for t:=0 to Items.Count-1 do Selected[t]:=False
  else
     ItemIndex:=-1;
end;
{$ENDIF}

end.

