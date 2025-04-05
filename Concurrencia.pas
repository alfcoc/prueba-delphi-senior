unit Concurrencia;

interface

uses
  SysUtils, Classes, Threading, JSON, HttpClient;

type
  IApiClient = interface
    function Get(const url: string): string;
  end;

  THttpClient = class(TInterfacedObject, IApiClient)
  public
    function Get(const url: string): string;
  end;

procedure ObtenerLanzamientosEnParalelo;

implementation

function THttpClient.Get(const url: string): string;
begin
  // llamada HTTP simulada
  if url.Contains('latest') then
    Result := '{"name":"Misión Última"}'
  else if url.Contains('next') then
    Result := '{"name":"Misión Próxima"}'
  else
    Result := '{"name":"Misión Histórica"}';
end;

procedure ObtenerLanzamientosEnParalelo;
var
  Cliente: IApiClient;
  Tarea1, Tarea2, Tarea3: ITask;
  Resultado1, Resultado2, Resultado3: string;
begin
  Cliente := THttpClient.Create;

  Tarea1 := TTask.Run(
    procedure
    begin
      Resultado1 := Cliente.Get('https://api.spacexdata.com/v5/launches/latest');
    end);

  Tarea2 := TTask.Run(
    procedure
    begin
      Resultado2 := Cliente.Get('https://api.spacexdata.com/v5/launches/next');
    end);

  Tarea3 := TTask.Run(
    procedure
    begin
      Resultado3 := Cliente.Get('https://api.spacexdata.com/v5/launches/past');
    end);

  TTask.WaitForAll([Tarea1, Tarea2, Tarea3]);

  ShowMessage('Última: ' + Resultado1);
  ShowMessage('Próxima: ' + Resultado2);
  ShowMessage('Histórica: ' + Resultado3);
end;

end.
