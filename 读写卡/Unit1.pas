unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,declaredll,strutils, ComCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel2: TBevel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  port,baud:integer;



implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
//轻松写卡
{
技术支持：
网站：
}
var
    i:byte;
    j:char;
    mylen:byte;
    status:byte;//存放返回值
    myareano:byte;//区号
    authmode:byte;//密码类型，用A密码或B密码
    myctrlword:byte;//控制字
	  mypicckey:array[0..5] of byte;//密码
    mypiccserial:array[0..3] of byte;//卡序列号
    mypiccdata:array[0..47] of byte;//卡数据缓冲
    thistime:TDate;
    Year,Month,Day:Word;

    strls:string;

begin

   //控制字指定,控制字的含义请查看本公司网站提供的动态库说明
   myctrlword := BLOCK0_EN + BLOCK1_EN;

    //指定区号
    myareano := 9;//指定为第9区
    //批定密码模式
    authmode := 1;//大于0表示用A密码认证，推荐用A密码认证

    //指定密码
    mypicckey[0] := $ff;
    mypicckey[1] := $ff;
    mypicckey[2] := $ff;
    mypicckey[3] := $ff;
    mypicckey[4] := $ff;
    mypicckey[5] := $ff;

    //第一块：AB,姓名7位，后面没有就补零
    //性别（0表示女，1表示男），时间（2008-10-22）共四个字节, 9个字节,1个字节


    //提取第一块
    //AB
    if (Length(Edit1.Text) <> 2) then
    begin
      ShowMessage('第一块字符串只能为2个英文或1个汉字');
      Edit1.SelectAll();
      Edit1.SetFocus();
      exit;
    end;
    mypiccdata[0] := byte(Edit1.Text[1]);
    mypiccdata[1] := byte(Edit1.Text[2]);

    //名字
    mylen := Length(Edit2.Text);
    if (mylen > 14) then
    begin
      ShowMessage('第二块字符串不通超过14个英文或7个汉字');
      Edit2.SelectAll();
      Edit2.SetFocus();
      exit;
    end;
    for i := 1 to mylen do
    begin
      mypiccdata[i+1] := byte(Edit2.Text[i]);
    end;
    for i := (mylen+1) to 11 do
    begin
      mypiccdata[i+1] := 0;
    end;
    //提取第二块

    //性别
    if ComboBox1.Text = '男' then
    begin
      mypiccdata[0+16] := 1;
    end
    else
    begin
      mypiccdata[0+16] := 0;
    end;
    //日期
    //thistime.
     thistime:= DateTimePicker1.Date;
     DecodeDate(thistime,Year,Month,Day);
     mypiccdata[1+16]:= StrToInt('$' + IntToStr(Year-2000));
     mypiccdata[2+16]:= StrToInt('$' + IntToStr(Month));
     mypiccdata[3+16]:= StrToInt('$' + IntToStr(Day));;

    //身份证

    mylen := Length(Edit3.Text);
    if (NOT((mylen = 15) or (mylen = 18))) then
    begin
      ShowMessage('身份证字符串只能是15位或18位字');
      Edit3.SelectAll();
      Edit3.SetFocus();
      exit;
    end;

    if(mylen = 15) then
    begin
      for i := 1 to 15 do
      begin
        j := Edit3.Text[i];
        if not((j>='0') and (j<='9') or (j>='a') and (j<='f')or (j>='A') and (j<='F')) then
        begin
          ShowMessage('身份证字符串格式错误');
          Edit3.SelectAll();
          Edit3.SetFocus();
          exit;
        end;

      end;
      mypiccdata[4+16] := 0;
      for i := 0 to 6 do
      begin
        mypiccdata[5+16+i] := StrToInt('$' + copy(Edit3.Text,1+i*2,2));
      end;
      mypiccdata[5+16+7]  :=  StrToInt('$' + copy(Edit3.Text,1+7*2,1) + '0');

    end
    else
    begin
      for i := 1 to 17 do
      begin
        j := Edit3.Text[i];
        if not((j>='0') and (j<='9') or (j>='a') and (j<='f')or (j>='A') and (j<='F')) then
        begin
          ShowMessage('身份证字符串格式错误');
          Edit3.SelectAll();
          Edit3.SetFocus();
          exit;
        end;

      end;

      mypiccdata[4+16] := 1;
      for i := 0 to 7 do
      begin
        mypiccdata[5+16+i] := StrToInt('$' + copy(Edit3.Text,1+i*2,2));
      end;
      mypiccdata[5+16+8]  :=  StrToInt('$' + copy(Edit3.Text,1+8*2,1) + '0');
      mypiccdata[5+16+9]  :=  byte(Edit3.Text[2+8*2]);


    end;



    //日期


    status := piccwriteex(myctrlword,@mypiccserial,myareano,authmode,@mypicckey,@mypiccdata);
        //在下面设定断点，然后查看mypiccserial、mypiccdata，
        //调用完 piccreadex函数可读出卡序列号到 mypiccserial，读出卡数据到mypiccdata，
        //开发人员根据自己的需要处理mypiccserial、mypiccdata 中的数据了。



        //处理返回函数

        case status of
          0:
            begin
            pcdbeep(50);
            ShowMessage('写卡成功');
            end;

          8: ShowMessage('请将卡放在感应区');


        else
          begin
          ShowMessage('读写器没连线或驱动程序没安装');
          end;
        end;

        //返回解释
        {
        #define ERR_REQUEST 8//寻卡错误
        #define ERR_READSERIAL 9//读序列吗错误
        #define ERR_SELECTCARD 10//选卡错误
        #define ERR_LOADKEY 11//装载密码错误
        #define ERR_AUTHKEY 12//密码认证错误
        #define ERR_READ 13//读卡错误
        #define ERR_WRITE 14//写卡错误

        #define ERR_NONEDLL 21//没有动态库
        #define ERR_DRIVERORDLL 22//动态库或驱动程序异常
        #define ERR_DRIVERNULL 23//驱动程序错误或尚未安装
        #define ERR_TIMEOUT 24//操作超时，一般是动态库没有反映
        #define ERR_TXSIZE 25//发送字数不够
        #define ERR_TXCRC 26//发送的CRC错
        #define ERR_RXSIZE 27//接收的字数不够
        #define ERR_RXCRC 28//接收的CRC错
        }
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.Edit4Change(Sender: TObject);
var
  i:integer;
  j:char;
  isok:boolean;
  len:integer;
  strchar:array[0..200] of byte;//卡数据缓冲
  edc:byte;//校验和缓存
  edc0:byte;//校验和缓存

  str0:string;//存放卡号
  str1:string;//第一块
  str2:string;//第二块
  str3:string;//第三块
  str4:string;//第四块
  cardhao:Longword;//卡号
  pointer:integer;


begin
  //30 310CE24A 4142 4 D5C5C8FD 1 081021 1 44010519880808586580A
  if Length(Edit4.Text)>28 then//字符串最小长度
  begin
    //校验是否为有效的字符，无效时不进行转换
    isok := true;
    for i := 1 to Length(Edit4.Text) do
    begin
      j := Edit4.Text[i];
      if not((j>='0') and (j<='9') or (j>='a') and (j<='f')or (j>='A') and (j<='F')) then
      begin
        isok := false;

      end;
    end;

    if not isok then
    begin

      exit;
    end;

    //效验长度是否正确
    len := StrToInt('$' + copy(Edit4.Text,1,2));
    if len <> (Length(Edit4.Text)-4) then
    begin
        //ShowMessage('1');
        exit;
    end;
    //和校验
    edc0 := StrToInt('$' + copy(Edit4.Text,Length(Edit4.Text)-1,2));
    edc  := 0;
    for i := 3 to Length(Edit4.Text)-2 do
    begin
      edc := edc xor byte(Edit4.Text[i]);
    end;

    if edc <> edc0 then
    begin
       //ShowMessage('1');
       exit;

    end;
    //4294967295 | A | | VIP客户#2008-10-19 |
    //转换成指定的字符
    //1---卡号
    cardhao := StrToInt('$' + copy(Edit4.Text,3,8));
    str1 := '0000000000' + IntToStr(cardhao);
    str0 := copy(str1,length(str1)-9,10);

    //2---计算第一块
    SetLength(str1,2);
    for i := 1 to 2 do
    begin
      str1[i] := char(StrToInt('$' + copy(Edit4.Text,9+2*i,2)));
    end;
    //ShowMessage(str1);

    //3---计算第二块
    pointer := 15;
    len :=  StrToInt('$' + copy(Edit4.Text,pointer,1));
    SetLength(str2,len);

    for i := 1 to len do
    begin
      str2[i] := char(StrToInt('$' + copy(Edit4.Text,pointer-1+2*i,2)));
    end;
    str2 := str2 + '#';
    pointer := pointer+1+2*len;
    if copy(Edit4.Text,pointer,1) = '0' then
    begin
      str2 := str2 + '女#';
    end
    else
    begin
      str2 := str2 + '男#';
    end;

    str2:= str2 + '20'+ copy(Edit4.Text,pointer+1,2) + '-' +  copy(Edit4.Text,pointer+3,2) + '-' + copy(Edit4.Text,pointer+5,2);

    //4---第三块身份证
    pointer := pointer +7;

    if (copy(Edit4.Text,pointer,1) = '0') then
    begin //15位身份证
      str3 := copy(Edit4.Text,pointer+1,15);
    end
    else
    begin//18位身份证
      str3 := copy(Edit4.Text,pointer+1,17);
      SetLength(str3,18);
      str3[18] := char(StrToInt('$' + copy(Edit4.Text,pointer+1+17,2)));
    end;

   //showmessage(str3);
    //1234567890 | A | 张三#男#1980-11-25 | VIP客户#2008-10-19 |
    Edit4.Text :=str0 + '|'+ str1 + '|'+ str2 + '|'+str3 + '|';

  end;




end;

end.
