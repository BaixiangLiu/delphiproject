unit uIO;


interface


uses
    SysUtils, Forms, FileCtrl, ComObj, DBGrids, DB, Controls,Dialogs,Variants;

procedure writeLog(content: string);
procedure makeDir(dirString: string);
procedure DBGridSaveXLS(aDBGrid: TDBGrid; sFileName: string);

implementation


procedure writeLog(content: string);
var
    logFilename: string;
    F: Textfile;
begin
    makeDir(ExtractFilePath(Application.EXEName) + '..\logs\');
    logFilename := ExtractFilePath(Application.EXEName) + '..\logs\'
        + FormatDateTime('yyyymmdd', Now()) + '.log';
    if fileExists(logFilename) then begin
        AssignFile(F, logFilename);
        Append(F);
    end
    else begin
        AssignFile(F, logFilename);
        ReWrite(F);
    end;
    Writeln(F, content);
    Flush(F);
    Closefile(F);

end;

procedure makeDir(dirString: string);
begin
    if not DirectoryExists(dirString) then begin
        if not CreateDir(dirString) then
            raise Exception.Create('Cannot create ' + dirString);
    end;
end;


procedure DBGridSaveXLS(aDBGrid: TDBGrid; sFileName: string);
    function LineFeedsToXLS(s: string): string;
    var
        Res: string;
        i: Integer;
    begin
        Res := '';
        for i := 1 to Length(s) do
            if s[i] <> #13 then
                Res := Res + s[i];
        Result := res;
    end;
var
    FExcel: Variant;
    FWorkbook: Variant;
    FWorksheet: Variant;
    FArray: Variant;
    s, z: Integer;
    RangeStr, sTitle: string;
    aBookMark: TBookMark;
    StrtCol, StrtRow, RowCount, ColCount: Integer;
begin
    Screen.Cursor := crHourGlass;
    try
        FExcel := CreateOleObject('excel.application');
    except
        Screen.cursor := crDefault;
        MessageDlg('Could not start Microsoft Excel!', mtError, [mbCancel], 0);
        Exit;
    end;
    aBookMark := aDBGrid.DataSource.DataSet.GetBookMark;
    aDBGrid.DataSource.DataSet.DisableControls;
    try
        StrtCol := 0;
        StrtRow := 0;
        FWorkBook := FExcel.WorkBooks.Add;
        //FWorkSheet := FWorkBook.WorkSheets.Add;
        FWorkSheet := FExcel.WorkBooks[1].WorkSheets[1];
        RowCount := aDBGrid.DataSource.DataSet.RecordCount + 1; //加上標題行
        ColCount := aDBGrid.Columns.Count;
        FArray := VarArrayCreate([0, RowCount - 1 - StrtRow, 0, ColCount - 1 - StrtCol], VarVariant);
        //Title
        for z := StrtCol to ColCount - 1 do begin
            sTitle := aDBGrid.Columns[z].Title.Caption;
            if sTitle = '' then
                sTitle := aDBGrid.Columns[z].FieldName;
            FArray[0, z - StrtCol] := LineFeedsToXLS(sTitle);
        end;
        //data
        {for s := StrtRow to RowCount - 1 do
          for z := StrtCol to ColCount - 1 do
            FArray[s - StrtRow, z - StrtCol] := LineFeedsToXLS();}
        s := 1; //s := StrtRow;
        aDBGrid.DataSource.DataSet.First;
        while not aDBGrid.DataSource.DataSet.Eof do begin
            for z := StrtCol to ColCount - 1 do
                FArray[s - StrtRow, z - StrtCol] := LineFeedsToXLS(aDBGrid.Columns[z].Field.DisplayText);
            Inc(s);
            aDBGrid.DataSource.DataSet.Next;
        end;
        RangeStr := 'A1:';
        if (ColCount - StrtCol) > 26 then begin
            if (ColCount - StrtCol) mod 26 = 0 then begin
                RangeStr := RangeStr + Chr(Ord('A') - 2 + ((ColCount - StrtCol) div 26));
                RangeStr := RangeStr + 'Z';
            end
            else begin
                RangeStr := RangeStr + Chr(Ord('A') - 1 + ((ColCount - StrtCol) div 26));
                RangeStr := RangeStr + Chr(Ord('A') - 1 + ((ColCount - StrtCol) mod 26));
            end;
        end
        else
            RangeStr := RangeStr + Chr(Ord('A') - 1 + (ColCount - StrtCol));
        RangeStr := RangeStr + IntToStr(RowCount - StrtRow);
        FWorkSheet.Range[RangeStr].Value := FArray;
        if sFileName <> '' then begin
            FWorkbook.SaveAs(sFileName);
            FExcel.Quit;
            FExcel := unAssigned;
        end
        else
            FExcel.Visible := True;
    finally
        aDBGrid.DataSource.DataSet.GotoBookMark(aBookMark);
        aDBGrid.DataSource.DataSet.EnableControls;
        aDBGrid.DataSource.DataSet.FreeBookMark(aBookMark);
        Screen.Cursor := crDefault;
    end;
end;


end.

