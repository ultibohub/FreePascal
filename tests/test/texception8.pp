{ %fail }
uses
  sysutils;

begin
  // this should fail with a runtime error
  try
    raise ETestException.Create;
  except
    ReleaseExceptionObject;
  end;
end.
