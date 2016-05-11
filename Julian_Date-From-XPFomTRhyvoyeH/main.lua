-- Julian day-number calendar used for historical calculations.
-- Reference: https://simple.wikipedia.org/wiki/Julian_day
-- Julian day is the continuous count of days since the beginning of the Julian Period.
-- The Julian Day Number (JDN) is the integer assigned to a whole solar day in the Julian
-- day count starting from noon Greenwich Mean Time.
-- Julian day number 0 assigned to the day starting at noon on January 1, 4713 BC.
-- For example, the Julian day number for the day starting at 12:00 UT on January 1, 2000, was 2,451,545.

-- For more information:
-- http://help.interfaceware.com/v6/julian-date

local date = require 'date.parse'
local julian = require 'date.julian'

function main()
   local Date = '20150903'

   -- use pcall() to capture errors due to invalid input dates
   if pcall(date.parse,Date) then

      -- Convert the supplied date to the table format 
      -- required for date.julian functions
      local _, T = date.parse(Date)

      -- Calculate a day of year in current Julian year
      local J = julian.julianDayOfCurrentYear(T)   

      -- Julian Day Of a Year rounded up in 3 digits
      string.format("%.3d",math.ceil(J))      

      -- Julian Day Of a Year rounded down in 3 digits
      string.format("%.3d",math.floor(J))

      -- Calculate JDN (Julian Day Number) for 'Date' value
      J = julian.JDN(T)
   else
      iguana.logError('invalid date value')
   end  
end   