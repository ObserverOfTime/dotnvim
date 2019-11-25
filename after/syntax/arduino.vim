syn keyword arduinoConstant
            \ BIN
            \ CHANGE
            \ DEC
            \ DEFAULT
            \ EXTERNAL
            \ FALLING
            \ HALF_PI
            \ HEX
            \ HIGH
            \ INPUT
            \ INPUT_PULLUP
            \ INTERNAL
            \ INTERNAL1V1
            \ INTERNAL2V56
            \ LOW
            \ LSBFIRST
            \ MSBFIRST
            \ OCT
            \ OUTPUT
            \ PI
            \ RISING
            \ TWO_PI

syn keyword arduinoFunc
            \ abs
            \ accept
            \ acos
            \ analogRead
            \ analogReference
            \ analogWrite
            \ asin
            \ atan
            \ atan2
            \ attachInterrupt
            \ available
            \ availableForWrite
            \ begin
            \ bit
            \ bitClear
            \ bitRead
            \ bitSet
            \ bitWrite
            \ ceil
            \ charAt
            \ click
            \ compareTo
            \ concat
            \ constrain
            \ cos
            \ degrees
            \ delay
            \ delayMicroseconds
            \ detachInterrupt
            \ digitalRead
            \ digitalWrite
            \ end
            \ endsWith
            \ equals
            \ equalsIgnoreCase
            \ exp
            \ find
            \ findUntil
            \ floor
            \ flush
            \ getBytes
            \ highByte
            \ indexOf
            \ indexOf
            \ interrupts
            \ isPressed
            \ lastIndexOf
            \ length
            \ log
            \ loop
            \ lowByte
            \ map
            \ max
            \ micros
            \ millis
            \ min
            \ move
            \ noInterrupts
            \ noTone
            \ parseFloat
            \ parseInt
            \ peek
            \ pinMode
            \ pow
            \ press
            \ print
            \ println
            \ pulseIn
            \ radians
            \ random
            \ randomSeed
            \ read
            \ readBytes
            \ readBytesUntil
            \ readString
            \ readStringUntil
            \ release
            \ releaseAll
            \ replace
            \ round
            \ setCharAt
            \ setTimeout
            \ setup
            \ shiftIn
            \ shiftOut
            \ sin
            \ sq
            \ sqrt
            \ startsWith
            \ substring
            \ tan
            \ toCharArray
            \ toInt
            \ toLowerCase
            \ toUpperCase
            \ tone
            \ trim
            \ word
            \ yield

syn keyword arduinoModule Keyboard Mouse
syn match arduinoModule /Serial\([123]\|USB\)\=/

syn keyword arduinoType boolean byte String word

hi def link arduinoConstant Constant
hi def link arduinoFunc Function
hi def link arduinoModule Identifier
hi def link arduinoType Type
