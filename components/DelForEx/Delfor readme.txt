Program:
        Delfor, Delphi Formatter Standalone version

Version:
        2

Category:
        Programmers tool

Description:
        Delfor is the standalone version of DelforExp, a customizable 
        source code formatter. 
        It can improve the indentation, spacing, capitalization and
        the use of blank lines of Delphi 4.0 source code.
        In the default settings, the style of the Borland source code
        is followed closely.
        The standalone version has a high capacity Delphi 
        look-and-feel editor (mwEdit). It is easy to select many files
        and whole projects for updating many files at once.

Credits:
	The editor of the program (mwEdit) is created by Martin Waldenburg 
        and others and distributed as a freeware component, 
        see:http://www.eccentrica.org/gabr/mw/mwedit.htm.

Status:
        The program is released as FREEWARE to improve the productivity
        of Delphi. You may distribute the files freely as long as you don't
        make money by it. The use of the program is at own risk.

Files:
        DelFor.exe             The program
        DelFor.hlp             On-line help (of DelforExp)
        Delfor Readme.txt      this file

Install:
        No installation needed. 
        To add the program to the Tools menu of the Delphi IDE:
        - press "Configure Tools"
        - press "Add"
        - Enter a Title
        - Enter the full path of the program (or use browse button)
        - Enter in the parameter field: $EDNAME $SAVE
        - OK and Close

DeInstall:
        Delete all files.

Contact:
        Egbert van Nes
        http://www.slm.wau.nl/wkao/DelForExp.html
        egbert.vannes@aqec.wkao.wau.nl
	Wageningen Agricultural University
	The Netherlands

FAQ
	Q: Could you please add xxx option in your formatter?
    	A: There are many wishes like yours. Currently, I only add 
           those that (a) I like a LOT and (b) are not too difficult
           to implement. My time is limited, the formatter is quite
           complex and I don't make money with this tool. My priority 
           is to keep the formatter stable and to fix bugs. 

	Q: Please give me the source code!
        A: Ha, ha!

	Q: Could I please buy the code?
        A: Yes, do me a offer I can't refuse ;-).

	Q: Do you have a home page?
        A: http://www.slm.wau.nl/wkao/DelForExp.html

	Q: Where can I find your free formatter?
        A: At the official homepage (http://www.slm.wau.nl/wkao/DelForExp.html) or
           Torry Pages (http://www.torry.ru), the fastest way to find 
           it there is to go to the authors page and find my name
           or The Delphi Super Page (http://sunsite.icm.edu.pl/delphi/)

Known problems:
        (1)
        Compiler {$IFDEF} + {$ELSE} directives may be nested to 3 levels and break
        into blocks of code. After the third nested level the right indentation
        is not guaranteed.

        (2)
        After some options (align, adding line breaks) the indentation might
        be not correct. Rerunning DelFor can fix the problems.

        (3)
        It is tried to indent function directives after function declarations.
        In some cases this does not happen.

