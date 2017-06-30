unit OSXTests;

interface

uses
  DUnitX.TestFramework;

{
to test:

TAdvFile
stuff in file support


}

type
  [TextFixture]
  TOSXTests = class (TObject)
  public
    [TestCase] procedure TestAdvObject;
    [TestCase] procedure TestCriticalSectionSimple;
    [TestCase] procedure TestCriticalSectionThreaded;
    [TestCase] procedure TestTemp;
    [TestCase] procedure TestDateTimeEx;
    [TestCase] procedure TestAdvFile;
  end;


implementation

uses
  SysUtils, Classes,
  {$IFDEF MACOS} OSXUtils, {$ELSE} Windows, {$ENDIF}
  SystemSupport, DateSupport, FileSupport,
  AdvObjects, AdvFiles;

var
  globalInt : cardinal;
  cs : TRTLCriticalSection;

Const
  TEST_FILE_CONTENT : AnsiString = 'this is some test content'+#13#10;

procedure TOSXTests.TestAdvFile;
var
  filename : String;
  f : TAdvFile;
  s : AnsiString;
begin
  filename := Path([SystemTemp, 'delphi.file.test.txt']);
  if FileExists(filename) then
    FileDelete(filename);
  Assert.IsFalse(FileExists(filename));
  f := TAdvFile.Create;
  try
    f.Name := filename;
    f.OpenCreate;
    f.Write(TEST_FILE_CONTENT[1], length(TEST_FILE_CONTENT));
    f.Close;
  finally
    f.Free;
  end;
  Assert.IsTrue(FileExists(filename));
  Assert.IsTrue(FileSize(filename) = 27);
  f := TAdvFile.Create;
  try
    f.Name := filename;
    f.OpenRead;
    SetLength(s, f.Size);
    f.Read(s[1], f.Size);
    Assert.IsTrue(s = TEST_FILE_CONTENT);
    f.Close;
  finally
    f.Free;
  end;
  FileSetReadOnly(filename, true);
  FileDelete(filename);
  Assert.IsTrue(FileExists(filename));
  FileSetReadOnly(filename, false);
  FileDelete(filename);
  Assert.IsFalse(FileExists(filename));
end;

procedure TOSXTests.TestAdvObject;
var
  obj : TAdvObject;
begin
  obj := TAdvObject.Create;
  try
    Assert.IsTrue(obj.AdvObjectReferenceCount = 0);
    obj.Link;
    Assert.IsTrue(obj.AdvObjectReferenceCount = 1);
    obj.Free;
    Assert.IsTrue(obj.AdvObjectReferenceCount = 0);
  finally
    obj.Free;
  end;
end;

procedure TOSXTests.TestCriticalSectionSimple;
begin
  InitializeCriticalSection(cs);
  try
    EnterCriticalSection(cs);
    try
      Assert.IsTrue(true);
    finally
      LeaveCriticalSection(cs);
    end;
  finally
    DeleteCriticalSection(cs);
  end;
end;

type
  TTestThread = class(TThread)
  protected
    procedure Execute; override;
  end;

procedure TOSXTests.TestCriticalSectionThreaded;
begin
  globalInt := GetCurrentThreadId;
  InitializeCriticalSection(cs);
  try
    EnterCriticalSection(cs);
    try
      TTestThread.create();
      Sleep(10);
      Assert.IsTrue(globalInt = GetCurrentThreadId);
    finally
      LeaveCriticalSection(cs);
    end;
    sleep(10);
    EnterCriticalSection(cs);
    try
      Assert.IsTrue(globalInt <> GetCurrentThreadId);
    finally
      LeaveCriticalSection(cs);
    end;
  finally
    DeleteCriticalSection(cs);
  end;
end;

procedure TOSXTests.TestTemp;
begin
  Assert.IsNotEmpty(SystemTemp);
end;

procedure TOSXTests.TestDateTimeEx;
var
  d1, d2 : TDateTimeEx;
  dt1, dt2 : Double;
begin
  // null
  Assert.IsTrue(d1.null);
  Assert.IsFalse(d1.notNull);
  d1 := TDateTimeEx.makeToday;
  Assert.IsTrue(d1.notNull);
  Assert.IsFalse(d1.null);
  d1 := TDateTimeEx.makeNull;
  Assert.IsTrue(d1.null);
  Assert.IsFalse(d1.notNull);

  // format support
  Assert.IsTrue(TDateTimeEx.fromXML('2013-04-05T12:34:56').toHL7 = '20130405123456');
  Assert.IsTrue(TDateTimeEx.fromXML('2013-04-05T12:34:56Z').toHL7 = '20130405123456Z');
  Assert.IsTrue(TDateTimeEx.fromXML('2013-04-05T12:34:56+10:00').toHL7 = '20130405123456+1000');
  Assert.IsTrue(TDateTimeEx.fromXML('2013-04-05T12:34:56-10:00').toHL7 = '20130405123456-1000');
  Assert.IsTrue(TDateTimeEx.fromXML('2013-04-05').toHL7 = '20130405');
  Assert.IsTrue(TDateTimeEx.fromHL7('20130405123456-1000').toXML = '2013-04-05T12:34:56-10:00');

  // Date Time conversion
  Assert.IsTrue(TDateTimeEx.make(EncodeDate(2013, 4, 5) + EncodeTime(12, 34,56, 0), dttzUnknown).toHL7 = '20130405123456');
  Assert.IsTrue(TDateTimeEx.fromHL7('20130405123456').DateTime = EncodeDate(2013, 4, 5) + EncodeTime(12, 34,56, 0));

  // Timezone Wrangling
  d1 := TDateTimeEx.make(EncodeDate(2011, 2, 2)+ EncodeTime(14, 0, 0, 0), dttzLocal); // during daylight savings (+11)
  d2 := TDateTimeEx.make(EncodeDate(2011, 2, 2)+ EncodeTime(3, 0, 0, 0), dttzUTC); // UTC Time
  Assert.IsTrue(sameInstant(d1.DateTime - TimezoneBias(d1.DateTime), d2.DateTime));
  Assert.IsTrue(sameInstant(d1.UTC.DateTime, d2.DateTime));
  Assert.IsTrue(not d1.equal(d2));
  Assert.IsTrue(d1.sameTime(d2));
  d1 := TDateTimeEx.make(EncodeDate(2011, 7, 2)+ EncodeTime(14, 0, 0, 0), dttzLocal); // not during daylight savings (+10)
  d2 := TDateTimeEx.make(EncodeDate(2011, 7, 2)+ EncodeTime(4, 0, 0, 0), dttzUTC); // UTC Time
  dt1 := d1.DateTime - TimezoneBias(d1.DateTime);
  dt2 := d2.DateTime;
  Assert.IsTrue(sameInstant(dt1, dt2));
  Assert.IsTrue(sameInstant(d1.UTC.DateTime, d2.DateTime));
  Assert.IsTrue(not d1.equal(d2));
  Assert.IsTrue(d1.sameTime(d2));

  Assert.IsTrue(TDateTimeEx.fromHL7('20130405120000-1000').sameTime(TDateTimeEx.fromHL7('20130405100000-0800')));

  // Min/Max
  Assert.IsTrue(TDateTimeEx.fromHL7('20130405123456').Min.toHL7 = '20130405123456.000');
  Assert.IsTrue(TDateTimeEx.fromHL7('20130405123456').Max.toHL7 = '20130405123457.000');
  Assert.IsTrue(TDateTimeEx.fromHL7('201304051234').Min.toHL7 = '20130405123400.000');
  Assert.IsTrue(TDateTimeEx.fromHL7('201304051234').Max.toHL7 = '20130405123500.000');

  //
//  d1 := UniversalDateTime;
//  d2 := LocalDateTime;
//  d3 := TimeZoneBias;
//  Assert.IsTrue(d1 <> d2);
//  Assert.IsTrue(d1 = d2 - d3);
end;

{ TTestThread }

procedure TTestThread.execute;
begin
  EnterCriticalSection(cs);
  try
    globalInt := GetCurrentThreadId;
  finally
    LeaveCriticalSection(cs);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TOSXTests);
end.
