-- Julian day-number calendar used for historical calculations.
-- Reference: https://simple.wikipedia.org/wiki/Julian_day
-- Julian day is the continuous count of days since the beginning of the Julian Period.
-- The Julian Day Number (JDN) is the integer assigned to a whole solar day in the Julian
-- day count starting from noon Greenwich Mean Time.
-- Julian day number 0 assigned to the day starting at noon on January 1, 4713 BC.
-- For example, the Julian day number for the day starting at 12:00 UT on January 1, 2000, was 2,451,545.

-- For more information:
-- http://help.interfaceware.com/v6/julian-date

local julianDay = {}

local function JulianDayDiff(a,b)
   return jd.JDN(b) - jd.JDN(a)
end

local function previousYearEnd(t)
   local dt = {}
   dt.year = t.year - 1
   dt.month = 12
   dt.day = 31    
   return dt
end

-- public --
function julianDay.JDN(d)
   local A = d.year/100
   local B = A/4
   local C = 2-A+B
   local E = 365.25*(d.year+4716)
   local F = 30.6001*(d.month+1)
   return C+d.day+E+F-1524.5 
end

function julianDay.julianDayOfCurrentYear(t)   
   local function JulianDayDiff(a,b)
      return julianDay.JDN(b) - julianDay.JDN(a)
   end
   
   return JulianDayDiff(previousYearEnd(t),t)
end

local HELP_DEF=[[{
"Desc": "Calculates Julian Day for current Julian Year (days from start of current year), for a specified date.
",
"Returns": [
{
"Desc": "Julian Day number in current year, with fraction of last day, i.e., 245.7 <u>double</u>."
}
],
"SummaryLine": "Calculates ongoing Julian Day Number for current Year.",
"SeeAlso": [
{
"Title": "Wiki: Julian Date",
"Link": "http://help.interfaceware.com/v6/julian-date"
},
{
"Title": "Module for calculating Julian Date.",
"Link": "https://github.com/interfaceware/iguana-datetime/blob/master/shared/date/julian.lua"
}
],
"Title": "julian.julianDayOfCurrentYear",
"Usage": "julian.julianDayOfCurrentYear(Date)",
"Parameters": [
{
"Data": {
"Desc": "DateTime table returned by dateparse.parse(Date) <u>table</u>. "
}
}
],
"Examples": [
"<pre>local J = julian.JulianDayOfCurrentYear(t) </pre>"
],
"ParameterTable": false
}]]

help.set{input_function=julianDay.julianDayOfCurrentYear, help_data=json.parse{data=HELP_DEF}}

local HELP_DEF=[[{
"Desc": "Calculates Julian Day Number (days from noon on January 1, 4713 BC), for a specified date.
",
"Returns": [
{
"Desc": "Julian Day Number (JDN), with fraction of last day, i.e., 2,451,545.7 <u>double</u>."
}
],
"SummaryLine": "Calculates Julian Day Number (JDN).",
"SeeAlso": [
{
"Title": "Wiki: Julian Date",
"Link": "http://help.interfaceware.com/v6/julian-date"
},
{
"Title": "Module for calculating Julian Date.",
"Link": "https://github.com/interfaceware/iguana-datetime/blob/master/shared/date/julian.lua"
}
],
"Title": "julian.JDN",
"Usage": "julian.JDN(Date)",
"Parameters": [
{
"Data": {
"Desc": "DateTime table returned by dateparse.parse(Date) <u>table</u>. "
}
}
],
"Examples": [
"<pre>local J = julian.JDN(T) </pre>"
],
"ParameterTable": false
}]]

help.set{input_function=julianDay.JDN, help_data=json.parse{data=HELP_DEF}}

return julianDay