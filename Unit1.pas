unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, StrUtils, Data.DB, Datasnap.DBClient, Vcl.DBGrids, Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    lblEntrada: TLabel;
    edt_Entrada: TEdit;
    btn_Gerar: TButton;
    btn_Avancar: TButton;
    lbl_Fim: TLabel;
    dbg_Derivacao: TDBGrid;
    src_Derivacao: TDataSource;
    cds_Derivacao: TClientDataSet;
    btn_Limpar: TButton;
    sg_Tabela: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    rdg_Exemplos: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    btn_TokenAleatorio: TButton;
    btn_GeraTokenValido: TButton;
    procedure FormShow(Sender: TObject);
    procedure btn_AvancarClick(Sender: TObject);
    procedure btn_GerarClick(Sender: TObject);
    procedure btn_LimparClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_EntradaChange(Sender: TObject);
    procedure rdg_ExemplosClick(Sender: TObject);
    procedure edt_EntradaKeyPress(Sender: TObject; var Key: Char);
    procedure btn_TokenAleatorioClick(Sender: TObject);
    procedure btn_GeraTokenValidoClick(Sender: TObject);
  private
    { Private declarations }
    procedure geraLinha;
  public
    { Public declarations }
    FPilha: TStringList;
    FEntrada: TStringList;
    FRegra: TStringList;
    FLinha: Integer;
    FFirst: Boolean;
    FLer: Boolean;
    FFim: Boolean;
    FGerar: Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  sg_Tabela.Selection := TGridRect(Rect(-1, -1, -1, -1));
  FPilha := TStringList.create();
  FEntrada := TStringList.create();
  FRegra := TStringList.create();
  FLinha := 0;
  FFirst := True;
  FLer := False;
  FFim := False;
  FGerar := False;

  lbl_Fim.Caption := EmptyStr;

  cds_Derivacao.FieldDefs.Add('Iteracao', ftInteger);
  cds_Derivacao.FieldDefs.Add('Pilha', ftString, 50);
  cds_Derivacao.FieldDefs.Add('Entrada', ftString, 50);
  cds_Derivacao.FieldDefs.Add('Regra', ftString, 50);
  cds_Derivacao.CreateDataSet;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  sg_Tabela.Cells[0, 0] := 'TABELA';
  sg_Tabela.Cells[0, 1] := 'S';
  sg_Tabela.Cells[0, 2] := 'A';
  sg_Tabela.Cells[0, 3] := 'B';
  sg_Tabela.Cells[0, 4] := 'C';
  sg_Tabela.Cells[1, 0] := 'a';
  sg_Tabela.Cells[2, 0] := 'b';
  sg_Tabela.Cells[3, 0] := 'c';
  sg_Tabela.Cells[4, 0] := 'd';
  sg_Tabela.Cells[5, 0] := '$';
  sg_Tabela.Cells[1, 1] := 'aCb';
  sg_Tabela.Cells[1, 2] := 'aSa';
  sg_Tabela.Cells[1, 3] := 'ε';
  sg_Tabela.Cells[1, 4] := 'aSb';
  sg_Tabela.Cells[2, 2] := 'bBd';
  sg_Tabela.Cells[3, 3] := 'cAd';
  sg_Tabela.Cells[3, 4] := 'cBa';
  sg_Tabela.Cells[4, 3] := 'ε';

  cds_Derivacao.EmptyDataSet;
end;

procedure TForm1.btn_AvancarClick(Sender: TObject);
  function GetRegra(ALinha, AColuna: string): string;
  begin
    if (ALinha = EmptyStr) and (AColuna = EmptyStr) then
    begin
      btn_Avancar.Enabled := False;
      btn_Gerar.Enabled := False;
      FEntrada.Add('$');
      FRegra.Add('Aceito em ' + IntToStr(FLinha + 1) + ' Iterações');
      lbl_Fim.Font.Color := clLime;
      lbl_Fim.Caption := 'ACEITO';
      FFim := True;

      FGerar := False;
      Exit;
    end
    else if (ALinha <> EmptyStr) and (AColuna = EmptyStr) then
    begin
      btn_Avancar.Enabled := False;
      btn_Gerar.Enabled := False;
      FEntrada.Add('$');
      FRegra.Add('Erro em ' + IntToStr(FLinha + 1) + ' Iterações');
      lbl_Fim.Font.Color := clRed;
      lbl_Fim.Caption := 'ERRO';
      FFim := True;

      FGerar := False;
      Exit;
    end
    else if (ALinha = EmptyStr) and (AColuna <> EmptyStr) then
    begin
      btn_Avancar.Enabled := False;
      btn_Gerar.Enabled := False;
      FEntrada.Add('$');
      FRegra.Add('Erro em ' + IntToStr(FLinha + 1) + ' Iterações');
      lbl_Fim.Font.Color := clRed;
      lbl_Fim.Caption := 'ERRO';
      FFim := True;

      FGerar := False;
      Exit;
    end;

    var i: Integer;
    for i := 0 to sg_Tabela.ColCount - 1 do
      if sg_Tabela.Cells[I, 0] = AColuna then
      begin
        sg_Tabela.FixedCols := I;
        break;
      end;

    var J: Integer;
    for J := 0 to sg_Tabela.RowCount - 1 do
      if sg_Tabela.Cells[0, J] = ALinha then
      begin
        sg_Tabela.FixedRows := J;
        break;
      end;

    Result := sg_Tabela.Cells[I, J];

    if Result = EmptyStr then
      sg_Tabela.Selection := TGridRect(Rect(-1, -1, -1, -1));
  end;

  function GetTopoPilha: String;
  begin
    Result := AnsiReverseString(FPilha.Strings[FPilha.Count - 1]).Substring(0, 1);
  end;

  function GetTopoEntrada: String;
  begin
    Result := FEntrada.Strings[FEntrada.Count - 1].Substring(0, 1);
  end;

  procedure ProcessaDerivacao;
  var                        
    LEps: string;
  begin
    if (FRegra.Strings[FRegra.Count - 1].Substring(0, 2) <> 'Lê') then
    begin
      if FRegra.Strings[FRegra.Count - 1] = 'ε' then
        LEps := EmptyStr
      else if FRegra.Strings[FRegra.Count - 1] = '' then
      begin
        btn_Avancar.Enabled := False;
        btn_Gerar.Enabled := False;
        FEntrada.Add('$');
        FRegra.Add('Erro em ' + IntToStr(FLinha + 1) + ' Iterações');
        lbl_Fim.Font.Color := clRed;
        lbl_Fim.Caption := 'ERRO';
        FFim := True;

        FGerar := False;
        Exit;
      end
      else
        LEps := AnsiReverseString(FRegra.Strings[FRegra.Count - 1]);

      FPilha.Strings[FPilha.Count - 1] :=
        Copy(FPilha.Strings[FPilha.Count - 1], 1,
          Length(FPilha.Strings[FPilha.Count - 1]) - 1) + LEps;
    end
    else
    begin
      FEntrada.Strings[FEntrada.Count - 1] :=
        Copy(FEntrada.Strings[FEntrada.Count - 1], 2,
          Length(FEntrada.Strings[FEntrada.Count - 1]));

      FRegra.Add(GetRegra(GetTopoPilha, GetTopoEntrada));
      if FFim then
        FRegra.Delete(FRegra.Count - 1);
    end;

    if (not FFim) and (GetTopoPilha = GetTopoEntrada) then
    begin
      FRegra.Add('Lê ' + GetTopoPilha);
      FLer := True;
    end;
  end;

begin
  if FFirst then
  begin
    FPilha.Add('S');
    FEntrada.Add(edt_Entrada.Text);
    FFirst := False;
    FRegra.Add(GetRegra(GetTopoPilha, GetTopoEntrada));
  end
  else
  begin
    ProcessaDerivacao;
  end;

  geraLinha;
end;

procedure TForm1.geraLinha;
begin
  FLinha := FLinha + 1;

  cds_Derivacao.Append;
  cds_Derivacao.FieldByName('Iteracao').AsInteger := FLinha;
  if FPilha.Strings[FPilha.Count - 1] = '$' then
    cds_Derivacao.FieldByName('Pilha').AsString := FPilha.Strings[FPilha.Count - 1]
  else
    cds_Derivacao.FieldByName('Pilha').AsString := '$' + FPilha.Strings[FPilha.Count - 1];

  if FEntrada.Strings[FEntrada.Count - 1] = '$' then
    cds_Derivacao.FieldByName('Entrada').AsString := FEntrada.Strings[FEntrada.Count - 1]
  else
    cds_Derivacao.FieldByName('Entrada').AsString := FEntrada.Strings[FEntrada.Count - 1] + '$';

  cds_Derivacao.FieldByName('Regra').AsString := FRegra.Strings[FRegra.Count - 1];
  cds_Derivacao.Post;

  if FLer then
  begin
    FPilha.Strings[FPilha.Count - 1] :=
      Copy(FPilha.Strings[FPilha.Count - 1], 1,
        Length(FPilha.Strings[FPilha.Count - 1]) - 1);

    FLer := False;
  end;
end;

procedure TForm1.btn_GerarClick(Sender: TObject);
begin
  while True do
  begin
    btn_avancar.Click;

    if FFim then
      Break;
  end;
end;

procedure TForm1.btn_GeraTokenValidoClick(Sender: TObject);
var
  LToken: string;

  procedure GeraToken(ASimbolo: Char);
  var
    LRegra: string;
    LEscolha: Integer;
  begin
    case ASimbolo of
      'S': LRegra := 'aCb';
      'A':
        begin
          LEscolha := Random(2) + 1;
          case LEscolha of
            1: LRegra := 'bBd';
            2: LRegra := 'aSa';
          end;
        end;
      'B':
        begin
          LEscolha := Random(2) + 1;
          case LEscolha of
            1: LRegra := 'cAd';
            2: LRegra := 'ε';
          end;
        end;
      'C':
        begin
          LEscolha := Random(2) + 1;
          case LEscolha of
            1: LRegra := 'aSb';
            2: LRegra := 'cBa';
          end;
        end;
    else
      LToken := LToken + ASimbolo;
      Exit;
    end;

    for ASimbolo in LRegra do
      if ASimbolo <> 'ε' then
        GeraToken(ASimbolo);
  end;

begin
  LToken := '';
  Randomize;
  GeraToken('S');
  edt_Entrada.Text := LToken;
end;

procedure TForm1.btn_LimparClick(Sender: TObject);
var
  i, j: integer;
begin
  FGerar := False;
  lbl_Fim.Caption := EmptyStr;
  btn_Avancar.Enabled := True;
  btn_Gerar.Enabled := True;

  cds_Derivacao.EmptyDataSet;
  FLinha := 0;
  FFirst := True;
  FLer := False;
  FFim := False;

  FPilha.Clear;
  FEntrada.Clear;
  FRegra.Clear;

  edt_Entrada.Clear;
  edt_Entrada.SetFocus;
end;

procedure TForm1.btn_TokenAleatorioClick(Sender: TObject);
const
  LLetters: array[0..3] of Char = ('a', 'b', 'c', 'd');
begin
  var LRes: String := '';

  Randomize;
  var LTokenLength: Integer := 5 + Random(16);
  for var I := 0 to LTokenLength do
    LRes := LRes + LLetters[Random(Length(LLetters))];

  edt_Entrada.Text := LRes;
end;

procedure TForm1.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.edt_EntradaChange(Sender: TObject);
begin
  btn_Avancar.Enabled := Length(edt_Entrada.Text) > 0;
  btn_Gerar.Enabled := Length(edt_Entrada.Text) > 0;
end;

procedure TForm1.edt_EntradaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'d', Chr(8)]) then
    Key := #0;
end;

procedure TForm1.rdg_ExemplosClick(Sender: TObject);
begin
  edt_Entrada.Text := rdg_Exemplos.Items[rdg_Exemplos.ItemIndex];;
end;

end.
