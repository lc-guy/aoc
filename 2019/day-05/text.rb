code = "9,16,1001,1,1,1,0101,0,1,11,1106,1,0,1105,1,0,"

text = '
                             ___________
                      _,,oood88888888888booo.._
                 ,ood8888888888888888888888888888boo._
              ,d888888888888888888888888888888888888888oo
           _d888888888888888888888888888888888888888888888o._
         ,d88888888888888888888888888888888888888888888888888b.
       ,d888888888888888888888888888888888888888888888888888888p
     ,o888888888888888888888888888888888888888888888888888888888L
    ,888888888888888888888888888888888888888888888888888888888888b
   ,88888888888888888888888888888888888888888888888888888888888888.
  ,8888888888888888888888888888888888888888888888888888888888888888
  d8888888888888888888888888888888888888888888888888888888888888888b
 ,888888888888888888888888888888888888888888888888888888888888888888b
 d8888888888888888888888888888888888888888888888888888888888888888888.
 8888888888888888888888P""`\'78888888888888888888888888888888888888888b
,888888888888888888888"     d888888888888P"888888888888888888888888888
d88888888888888888888P      Y88888888888P  "88888888d88888888888888888b
d888888888888888PY88P         Y88Y\' `YP"    Y"    "YP"88888888888888PY8
888888888888888P  Y8           `"`        _.ooo888oo. 8P88888888888\'  "
888888888888"" _.oo88888oo.             `" ,--- __      `8888888888
88888888888P  "     __ ---.                 oP"88887o.   :Y88888P\'8.
Y8888888888b     .od888"o.`                    Y88P  Y   :. \'"Y\'_88b
 ""88888888K    Y. Y88P                      -._____;    888Y _`"Y88.
   "88888l  l    `.___..-\'                               88\',d88:d88\'
    Y8P"Y8.  l                                           : 88888:888p
     "   Y8b.                                            :d88888:8888.
          `8888b                                        ,8888888:88888b
           Y8888b                                      d88888888:888888"
           dbd888b.                ` \'                d888888888:888P\'
          d888888888o_             .--             _p88888888888;P\'
         `YP"Y888888888b.                          Y8888P"Y88888
               \'\'\'"YP"""YP=p._                     |       d8888
                           [  \'-.._      _.-       `.      d8888
                          ,\'       \'\'-\'\'\'            l     Y8888
                         j                            l    d8888
                        \'------------------------------`   `"""\'
                                 HAHAHAHA
                       YOU THINK YOURE THOUGH UH ?
                         I HAVE ONE WORD FOR YOU
                   THE FORCED INDENTATION OF THE CODE
                                 GET IT ?
                             I DONT THINK SO
                YOU DONT KNOW ABOUT MY OTHER CAR I GUESS ?
                                ITS A CDR
                        AND IS PRONOUNCED ``CUDDER
                OK YOU FUQIN ANGERED AN EXPERT PROGRAMMER
                               THIS IS /prog/
        YOU ARE ALLOWED TO POST HERE ONLY IF YOU HAVE ACHIEVED SATORI
PROGRAMMING IS ALL ABOUT ``ABSTRACT BULLSHITE THAT YOU WILL NEVER COMPREHEND
                              I HAVE READ SICP
                        IF ITS NOT DONE YOU HAVE TO
                   TOO BAD RUBY ON RAILS IS SLOW AS FUCK
             BBCODE AND ((SCHEME)) ARE THE ULTIMATE LANGUAGES
                                   ALSO
                             WELCOME TO /prog/
                     EVERY THREAD WILL BE REPLIED TO
                               NO EXCEPTION

                       MERRY CHRISTMAS, FA/g/g/OTS
'

arr = text.chars.map { |c| c.ord }
arr = code.split(',') + arr
arr << 99
arr[7] = -(arr.length-1)
arr[12] = arr.length-1
File.open('mystery.txt', 'w') { |file| file.write(arr.join(',')) }
