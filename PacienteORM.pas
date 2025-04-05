unit PacienteORM;

interface

uses
  SysUtils;

type
  TPaciente = class
  private
    FId: Integer;
    FNombre: string;
    FApellido: string;
    FFechaNacimiento: TDate;
    FSexo: string;
  public
    property Id: Integer read FId write FId;
    property Nombre: string read FNombre write FNombre;
    property Apellido: string read FApellido write FApellido;
    property FechaNacimiento: TDate read FFechaNacimiento write FFechaNacimiento;
    property Sexo: string read FSexo write FSexo;

    constructor Create; overload;
    constructor CreateConDatos(Id: Integer; Nombre, Apellido, Sexo: string; FechaNacimiento: TDate); overload;

    function CalcularEdad: Integer;
  end;

implementation

constructor TPaciente.Create;
begin
  inherited Create;
end;

constructor TPaciente.CreateConDatos(Id: Integer; Nombre, Apellido, Sexo: string; FechaNacimiento: TDate);
begin
  Self.FId := Id;
  Self.FNombre := Nombre;
  Self.FApellido := Apellido;
  Self.FSexo := Sexo;
  Self.FFechaNacimiento := FechaNacimiento;
end;

function TPaciente.CalcularEdad: Integer;
begin
  Result := YearsBetween(FFechaNacimiento, Date);
end;

end.
