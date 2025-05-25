{

  Copyright (C) <avx-testfile-generator> <Torsten Grundke>

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  MA 02110-1301, USA.
}

{$mode objfpc}

program AVXTestGenerator;
uses
  sysutils,
  AVXOpCodes in 'AVXOpCodes.pas',
  AsmTestGenerator in 'AsmTestGenerator.pas',
  Options in 'Options.pas';

begin
  with TAVXTestGenerator.Create do
  try
    with TOptions.Create do
    try
      LoadParams;

      if Help then
      begin
        writeln('avx-testfile-generator 0.2');
        writeln('author: torsten grundke');
        writeln('');
        writeln('make avx assembler-testfiles');
        writeln('');
        writeln('-h  help');
        writeln('-f  [fpc,fpcmref,fpccd8,nasm,fasm,gas,fpcinc] outputformat');
        writeln('-l  list opcode-memrefsize-states');
        writeln('-m  create only these testfile(s) (e.g. -mvgather,vpgather)');
        writeln('-o  destination path');
        writeln('-p  [x8664] codegenerator for x86_64 platform');
        writeln('-z  avx512');

        writeln('');
      end
      else
      begin
        //TAsmTestGenerator.CalcTestInstFile;
        //exit;

        case OutputFormat of
          'f': MakeTestFiles(tfFPC, x64, AVX512, false, Path, Filemask);
          'F': MakeTestFiles(tfFasm, x64, AVX512, false, Path, Filemask);
          'n': MakeTestFiles(tfNasm, x64, AVX512, false, Path, Filemask);
          'g': MakeTestFiles(tfGas, x64, AVX512, false, Path, Filemask);
          'I': MakeTestFiles(tfFPCInc, x64, AVX512, false, Path, Filemask);
          'm': MakeTestFiles(tfFPCMRef, x64, AVX512, false, Path, Filemask);
          'd': MakeTestFiles(tfFPCCDisp8, x64, true, false, Path, Filemask);
          'l': ListMemRefState;
        end;
      end;
    finally
      Free;
    end;
  finally
    Free;
  end;
end.
