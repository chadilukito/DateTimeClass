{
    MIT License

    Copyright (c) 2017 Christian Hadi

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
}

unit datetimeclass;
{$modeswitch UnicodeStrings}
{$H+}
interface

uses sysutils;

type
  cDateTime = class
    private    
      _formatDatetime: TFormatSettings;
      _internalDatetime: TDateTime;
    
    public
      property DateTimeFormat: TFormatSettings read _formatDatetime write _formatDatetime;
    
      constructor create(const aDatetime: TDateTime); overload;
      constructor create(const aYear, aMonth, aDay: Word); overload;
      constructor create(const aYear, aMonth, aDay, aHour, aMinute, aSecond, aMillisecond: Word); overload;
      
      function updateDatetime(const aDatetime: TDateTime): cDateTime;
      function updateYear(const aYear: Word): cDateTime;
      function updateMonth(const aMonth: Word): cDateTime;
      function updateDay(const aDay: Word): cDateTime;
      function updateHour(const aHour: Word): cDateTime;
      function updateMinute(const aMinute: Word): cDateTime;
      function updateSecond(const aSecond: Word): cDateTime;
      function updateMillisecond(const aMillisecond: Word): cDateTime;
      
      function addYears(const aNumberOfYears: Integer = 1): cDateTime;
      function addMonths(const aNumberOfMonths: Integer = 1): cDateTime;
      function addWeeks(const aNumberOfWeeks: Integer = 1): cDateTime;
      function addDays(const aNumberOfDays: Integer = 1): cDateTime;
      function addHours(const aNumberOfHours: Int64 = 1): cDateTime;
      function addMinutes(const aNumberOfMinutes: Int64 = 1): cDateTime;
      function addSeconds(const aNumberOfSeconds: Int64 = 1): cDateTime;
      function addMilliseconds(const aNumberOfMilliseconds: Int64 = 1): cDateTime;
      
      function toDateTime(): TDateTime;
      function toString(const aFormatStr: String = ''): String; reintroduce;
      function toNumeric(): Int64;

      class function GetCustomFormatSettings: TFormatSettings; static;
      class function StringToDateTime(str: String): TDateTime; static;
      class function DateTimeToString(dt: TDateTime): String; static;
  end;

implementation

uses dateutils;

constructor cDateTime.create(const aDatetime: TDateTime);
  begin
    _internalDatetime := aDatetime;
    DateTimeFormat := GetCustomFormatSettings;
  end;

constructor cDateTime.create(const aYear, aMonth, aDay: Word);
  begin
    create(EncodeDate(aYear, aMonth, aDay));
  end;

constructor cDateTime.create(const aYear, aMonth, aDay, aHour, aMinute, aSecond, aMillisecond: Word);
  begin
    create(EncodeDateTime(aYear, aMonth, aDay, aHour, aMinute, aSecond, aMillisecond));
  end;
  
function cDateTime.updateDatetime(const aDatetime: TDateTime): cDateTime;
  begin
    _internalDatetime := aDatetime;
    result := self;
  end;
  
function cDateTime.updateYear(const aYear: Word): cDateTime;
  begin
    _internalDatetime := RecodeYear(_internalDatetime, aYear);
    result := self;
  end;
  
function cDateTime.updateMonth(const aMonth: Word): cDateTime;
  begin
    _internalDatetime := RecodeMonth(_internalDatetime, aMonth);
    result := self;
  end;
  
function cDateTime.updateDay(const aDay: Word): cDateTime;
  begin
    _internalDatetime := RecodeDay(_internalDatetime, aDay);
    result := self;
  end;
  
function cDateTime.updateHour(const aHour: Word): cDateTime;
  begin
    _internalDatetime := RecodeHour(_internalDatetime, aHour);
    result := self;
  end;
  
function cDateTime.updateMinute(const aMinute: Word): cDateTime;
  begin
    _internalDatetime := RecodeMinute(_internalDatetime, aMinute);
    result := self;
  end;
  
function cDateTime.updateSecond(const aSecond: Word): cDateTime;
  begin
    _internalDatetime := RecodeSecond(_internalDatetime, aSecond);
    result := self;
  end;
  
function cDateTime.updateMillisecond(const aMillisecond: Word): cDateTime;
  begin
    _internalDatetime := RecodeMillisecond(_internalDatetime, aMillisecond);
    result := self;
  end;

function cDateTime.addYears(const aNumberOfYears: Integer = 1): cDateTime;
  begin
    _internalDatetime := IncYear(_internalDatetime, aNumberOfYears);
    result := self;
  end;
  
function cDateTime.addMonths(const aNumberOfMonths: Integer = 1): cDateTime;
  begin
    _internalDatetime := IncMonth(_internalDatetime, aNumberOfMonths);
    result := self;
  end;
  
function cDateTime.addWeeks(const aNumberOfWeeks: Integer = 1): cDateTime;  
  begin
    _internalDatetime := IncWeek(_internalDatetime, aNumberOfWeeks);
    result := self;
  end;
  
function cDateTime.addDays(const aNumberOfDays: Integer = 1): cDateTime;
  begin
    _internalDatetime := IncDay(_internalDatetime, aNumberOfDays);
    result := self;
  end;
  
function cDateTime.addHours(const aNumberOfHours: Int64 = 1): cDateTime;
  begin
    _internalDatetime := IncHour(_internalDatetime, aNumberOfHours);
    result := self;
  end;
  
function cDateTime.addMinutes(const aNumberOfMinutes: Int64 = 1): cDateTime;
  begin
    _internalDatetime := IncMinute(_internalDatetime, aNumberOfMinutes);
    result := self;
  end;
  
function cDateTime.addSeconds(const aNumberOfSeconds: Int64 = 1): cDateTime;
  begin
    _internalDatetime := IncSecond(_internalDatetime, aNumberOfSeconds);
    result := self;
  end;
  
function cDateTime.addMilliseconds(const aNumberOfMilliseconds: Int64 = 1): cDateTime;
  begin
    _internalDatetime := IncMilliSecond(_internalDatetime, aNumberOfMilliseconds);
    result := self;
  end;

function cDateTime.toDateTime(): TDateTime;
  begin
    result := _internalDatetime;
  end;

function cDateTime.toString(const aFormatStr: String = ''): String;
  begin
    if aFormatStr = '' then
      result := DateTimeToStr(_internalDatetime, _formatDatetime)
    else
      result := FormatDateTime(aFormatStr, _internalDatetime);
  end;
  
function cDateTime.toNumeric(): Int64;
  begin
    result := DateTimeToUnix(_internalDatetime);
  end;  
  
class function cDateTime.StringToDateTime(str: String): TDateTime;
  begin
    result := StrToDateTime(str, GetCustomFormatSettings());
  end;

class function cDateTime.DateTimeToString(dt: TDateTime): String;
  begin
    result := DateTimeToStr(dt, GetCustomFormatSettings())
  end;
  
class function cDateTime.GetCustomFormatSettings : TFormatSettings;
  var tmp : TFormatSettings;
  begin
    tmp := DefaultFormatSettings;
    tmp.DateSeparator:='-';
    tmp.TimeSeparator:=':';
    tmp.ShortDateFormat:= 'yyyy-mm-dd';
    //tmp.LongDateFormat := 'yyyy-mm-dd';
    tmp.LongTimeFormat := 'hh:nn:ss.zzz';
    
    result := tmp;
  end;

end.