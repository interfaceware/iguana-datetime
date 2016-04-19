-- This module calculates age from date of birth - it returns years, months and partial years.
-- This example shows the use of the age module
-- http://help.interfaceware.com/v6/age-example-channel

local date = {}
date.age = require 'date.age'

function main(Data)
   local Msg = hl7.parse{vmd ='demo.vmd', data=Data}

	-- getAge() requires date as a string parameter
   AgeYr, AgeMth, AgeDec = date.age('19980210')
   trace(AgeYr, AgeMth, AgeDec)
 
   AgeYr, AgeMth, AgeDec = date.age('1998-02-10')   
   trace(AgeYr, AgeMth, AgeDec)

   -- use :nodeValue() as getAge() requires date as a string
   local AgeYr, AgeMth, AgeDec = date.age(Msg.PID[7][1])
   trace(AgeYr, AgeMth, AgeDec)
   
   -- age.lua uses dateparse to support non-conformant date formats
   local AgeYr, AgeMth, AgeDec = date.age('01/10/1948')
   trace(AgeYr, AgeMth, AgeDec)
   
   -- if today is the birthday and time are not specified, age is
   -- how old the person turns today.
   local today = os.date('*t')
   local dob1 = (today.year - 10) .. '-' .. today.month .. '-' .. today.day
   local dob2 = (today.year - 1) .. '-' .. today.month .. '-' .. today.day

   AgeYr1 = date.age(dob1) -- turning 10 years old today
   AgeYr2 = date.age(dob2) -- turning 1 year old today
   trace(AgeYr1,AgeYr2)
end