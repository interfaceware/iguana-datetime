-- In accounting we often talk about the "Financial Year" of a company.
-- This is the when the company finishes it's year for tax purposes.
-- For instance the financial year of a company might begin at the
-- start of April and end at the end of March.

-- It's useful for reporting to be able to translate dates into the financial
-- year. This module is a simple example of doing this.

-- For more information:
-- http://help.interfaceware.com/v6/financial-monthyearlocal 

local MonthLookup={"Jan","Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct","Nov", "Dec"} 

local function Convert(T)
   local StartMonth = T.start_month or 1
   local Time = T.time
   local TT= os.ts.date("*t", Time)
   
   local Year = TT.year
   if TT.month < StartMonth then
      Year = Year - 1
   end
   local Quarter = TT.month - StartMonth 
   if Quarter < 0 then Quarter = Quarter + 12 end
         
   trace(Quarter)
   local Month = (Quarter % 3) + 1
   trace(Month)
   Quarter=math.floor(Quarter / 3)+1
   trace(Quarter)
   
   Quarter = "Q"..Quarter
   return Year, Quarter, MonthLookup[TT.month], Month
end

local ConvertHelp=[[{
   "Returns": [{"Desc": "Financial year (Integer)"}, { "Desc" : "Financial Quarter (string)"}, {"Desc" : "Month (string)"}, {"Desc" : "Order of month in quarter (integer)"}],
   "Title": "calendar_financial.convert",
   "Parameters": [
      { "time": {"Desc": "Time in seconds since 1970 in UTC time."}},
      { "start_month": {"Desc": "The month as an integer that is the start of the financial year. i.e. 1 is for January"}}],
   "ParameterTable": true,
   "Usage": "local Year, Quarter, Month = calendar_financial.convert{time=os.ts.time()- 24*60*60*200}",
   "Examples": [
      "-- If our financial year is February - then we use start_month=2
-- See the results for the first two months of the year.
calendar_financial.convert{time=os.ts.time{year=2016,month=1,day=1}, start_month=2}
calendar_financial.convert{time=os.ts.time{year=2016,month=2,day=1}, start_month=2}",
      "-- Subtract 200 days (as seconds) from the current time and return info for the quarter
-- NOTE: the start_month defaults to 1 (January)
local Year, Quarter, Month = calendar_financial.convert{time=os.ts.time()- 24*60*60*200}"],
   "SeeAlso": [
      {
         "Title": "Wiki: Financial Month/Year",
         "Link": "http://help.interfaceware.com/v6/financial-monthyear"
      },
      {
         "Title": "Module for translating dates into the financial year.",
         "Link": "https://github.com/interfaceware/iguana-datetime/blob/master/shared/date/financial.lua"
      }
   ],
   "Desc": "This function converts a UTC time into the financial year, quarter and month."
}]]

help.set{input_function=Convert, help_data=json.parse{data=ConvertHelp}}

return Convert