unit test;
{$modeswitch UnicodeStrings}
{$H+}

interface

uses TestFramework, datetimeclass;

type  
  cDatetimeTest = class(TTestCase)
    published
      procedure Test_Create;
      procedure Test_Update;
      procedure Test_UpdateAndAdd;
      procedure Test_Conversion;
  end;


procedure RegisterTests;

implementation

uses sysutils, typinfo, dateutils;
  
procedure RegisterTests;
begin
  TestFramework.RegisterTest('DateTimeClass Test Suite', cDatetimeTest.Suite);
end;

procedure cDatetimeTest.Test_Create;
  var 
     dt1, dt2, dt3: cDateTime;
     
  begin
    dt1 := cDateTime.create(EncodeDate(2017, 02, 22));
    dt2 := cDateTime.create(2017, 02, 22);
    dt3 := cDateTime.create(2017, 02, 22, 0, 0, 0, 100);
    
    CheckEquals(EncodeDateTime(2017, 02, 22, 0, 0, 0, 0), dt1.toDateTime, 'Failed - DateTime create 1');
    CheckEquals(EncodeDateTime(2017, 02, 22, 0, 0, 0, 0), dt2.toDateTime, 'Failed - DateTime create 2');
    CheckEquals(EncodeDateTime(2017, 02, 22, 0, 0, 0, 100), dt3.toDateTime, 'Failed - DateTime create 3');
  end;
  
procedure cDatetimeTest.Test_Update;
  var 
     dt1, dt2, dt3: cDateTime;
     
  begin
    dt1 := cDateTime.create(EncodeDate(2017, 02, 22));
    dt2 := cDateTime.create(2017, 02, 22);
    dt3 := cDateTime.create(2017, 02, 22, 0, 0, 0, 100);
    
    dt1.updateYear(2018).updateSecond(54);
    dt2.updateYear(2019).updateMonth(3).updateDay(10);
    dt3.updateHour(13).updateMinute(37);
    
    CheckEquals(EncodeDateTime(2018, 02, 22, 0, 0, 54, 0), dt1.toDateTime, 'Failed - DateTime update 1');
    CheckEquals(EncodeDateTime(2019, 03, 10, 0, 0, 0, 0), dt2.toDateTime, 'Failed - DateTime update 2');
    CheckEquals(EncodeDateTime(2017, 02, 22, 13, 37, 0, 100), dt3.toDateTime, 'Failed - DateTime update 3');
  end;
  
procedure cDatetimeTest.Test_UpdateAndAdd;
  var 
     dt1, dt2, dt3: cDateTime;
     
  begin
    dt1 := cDateTime.create(EncodeDate(2017, 02, 22));
    dt2 := cDateTime.create(2017, 02, 22);
    dt3 := cDateTime.create(2017, 02, 22, 0, 0, 0, 100);
    
    dt1.updateYear(2018).updateSecond(54).addDays(5).addSeconds(-3);
    dt2.updateYear(2019).updateMonth(3).updateDay(10).addHours(8);
    dt3.updateHour(13).updateMinute(37).addYears(2).addMilliseconds();
    
    CheckEquals(EncodeDateTime(2018, 02, 27, 0, 0, 51, 0), dt1.toDateTime, 'Failed - DateTime update and add 1');
    CheckEquals(EncodeDateTime(2019, 03, 10, 8, 0, 0, 0), dt2.toDateTime, 'Failed - DateTime update and add 2');
    CheckEquals('2019-02-22 13:37:00.101', dt3.toString, 'Failed - DateTime update and add 3');
  end;
  
procedure cDatetimeTest.Test_Conversion;
  var 
     dt1, dt2, dt3: cDateTime;
     
  begin
    dt1 := cDateTime.create(EncodeDate(2017, 02, 22));
    dt2 := cDateTime.create(2017, 02, 22);
    dt3 := cDateTime.create(2017, 02, 22, 0, 0, 0, 100);
        
    CheckEquals('2017-02-22', dt1.toString, 'Failed - DateTime conversion 1');
    CheckEquals(DateTimeToUnix(EncodeDate(2017, 02, 22)), dt2.toNumeric, 'Failed - DateTime conversion 2');
    CheckEquals(EncodeDateTime(2017, 02, 22, 0, 0, 0, 0), dt3.StringToDateTime('2017-02-22 00:00:00.000'), 'Failed - DateTime conversion 3');
  end;

end.