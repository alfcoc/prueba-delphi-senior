unit GrillaFormulario;

interface

uses
  Vcl.Grids, PacienteORM, Generics.Collections, DateUtils, Classes, SysUtils;

type
  TGrillaPacientes = class
  private
    FGrid: TStringGrid;
    FPacientes: TObjectList<TPaciente>;
  public
    constructor Create(Grid: TStringGrid);
    procedure CargarDatosAsync;
    procedure FiltrarPorNombre(const nombre: string);
    procedure OrdenarPorEdad;
    procedure RefrescarGrilla;
  end;

implementation

constructor TGrillaPacientes.Create(Grid: TStringGrid);
begin
  FGrid := Grid;
  FPacientes := TObjectList<TPaciente>.Create;
end;

procedure TGrillaPacientes.CargarDatosAsync;
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      Sleep(1000);
      TThread.Synchronize(nil,
        procedure
        begin
          FPacientes.Add(TPaciente.CreateConDatos(1, 'Ana', 'López', 'F', EncodeDate(1985, 5, 20)));
          FPacientes.Add(TPaciente.CreateConDatos(2, 'Luis', 'Pérez', 'M', EncodeDate(1990, 8, 12)));
          RefrescarGrilla;
        end);
    end).Start;
end;

procedure TGrillaPacientes.RefrescarGrilla;
var
  i: Integer;
begin
  FGrid.RowCount := FPacientes.Count + 1;
  FGrid.Cells[0, 0] := 'Nombre';
  FGrid.Cells[1, 0] := 'Edad';

  for i := 0 to FPacientes.Count - 1 do
  begin
    FGrid.Cells[0, i + 1] := FPacientes[i].Nombre;
    FGrid.Cells[1, i + 1] := IntToStr(FPacientes[i].CalcularEdad);
  end;
end;

procedure TGrillaPacientes.FiltrarPorNombre(const nombre: string);
var
  Filtrados: TObjectList<TPaciente>;
  Paciente: TPaciente;
begin
  Filtrados := TObjectList<TPaciente>.Create(False);
  for Paciente in FPacientes do
    if Pos(LowerCase(nombre), LowerCase(Paciente.Nombre)) > 0 then
      Filtrados.Add(Paciente);

  FPacientes := Filtrados;
  RefrescarGrilla;
end;

procedure TGrillaPacientes.OrdenarPorEdad;
begin
  FPacientes.Sort(
    TComparer<TPaciente>.Construct(
      function(const A, B: TPaciente): Integer
      begin
        Result := B.CalcularEdad - A.CalcularEdad;
      end));
  RefrescarGrilla;
end;

end.
