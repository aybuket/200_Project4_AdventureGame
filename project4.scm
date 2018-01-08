;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;::;;::
;;;   The Object-Oriented Adventure Game
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;::;:;;
;;;    	  	   	 
;;; aakgul13@ku.edu.tr    	  	   	 
;;;    	  	   	 
;;; Before you start:    	  	   	 
;;; * Please read the project handout available on the course
;;;   web site first to get a basic idea about the project and the
;;;   logic behind it, then to find out the details about what
;;;   your tasks are for the rest of the project.
;;;    	  	   	 
;;; * The following code should be studied and loaded for this
;;;   project.  Please do not modify these files, put all your work in
;;;   this file.    	  	   	 
;;;    	  	   	 
;;; - objsys.scm: support for an elementary object system
;;; - objtypes.scm: a few nice object classes
;;; - setup.scm: a bizarre world constructed using these classes
;;;    	  	   	 
;;; * Plan your work with pencil and paper before starting to code.
;;;    	  	   	 
;;; While you are working:    	  	   	 
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code (in this file)
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;    	  	   	 
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;    	  	   	 
;;;    	  	   	 
;;; When you are done:    	  	   	 
;;; * Perform a final save and submit your work following the instructions.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200help@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors:
;;;    	  	   	 
;;; *** IF (load "project4.scm") GIVES ERRORS YOUR PROJECT WILL NOT BE GRADED *
;;;    	  	   	 
;;;    	  	   	 
;; Do NOT modify or delete the lines below.
(#%require (only racket/base random))
(load "objsys.scm")    	  	   	 
(load "objtypes.scm")    	  	   	 
(load "setup.scm")    	  	   	 
(define nil '())    	  	   	 
(define your-answer-here #f)    	  	   	 
;;;;;;;;;    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;::;:;:
;;; PART II. Programming Assignment
;;;    	  	   	 
;;; The answers to the computer exercises in Section 5 go in the
;;; appropriate sections below.
;;;    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;::;::;
;;;;;;;;;;;;; Computer Exercise 0: Setting up ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    	  	   	 
;;;;;;;;;;;;; CODES: ;;;;;;;;;;;;;
;;    	  	   	 

;   (ask screen 'deity-mode #f)
;   (setup 'aybuke)
;   (ask (ask me 'location) 'name)
;   (ask me 'say (list 'my 'name 'is (ask me 'name)))
;   (ask me 'say '(hello world!))
;   (ask me 'go 'east)
;   (ask me 'take (thing-named 'engineering-book))
;   (ask me 'toss 'engineering-book)
;   (ask me 'die)
   	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;::;:::
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;   > (ask screen 'deity-mode #f)
;   > (setup 'aybuke)
;   Value; ready
;   > (ask (ask me 'location) 'name)
;   Value; gym
;   > (ask me 'say (list 'my 'name 'is (ask me 'name)))
;   Value; At gym aybuke says -- my name is aybuke said-and-heard
;   > (ask me 'say '(hello world!))
;   Value; At gym aybuke says -- hello world! said-and-heard
;   > (ask me 'go 'east)
;   Value; aybuke moves from gym to library 
;          --- the-clock Tick 0 --- 
;          You are in library 
;          You are not holding anything. 
;          You see stuff in the room: engineering-book 
;          There are no other people around you. 
;          The exits are in directions: west east #t
;   > (ask me 'take (thing-named 'engineering-book))
;   Value; At library aybuke says -- I take engineering-book from library 
;   > (ask me 'toss 'engineering-book)
;   Value; At library aybuke says -- I drop engineering-book at library 
;   > (ask me 'die)
;   Value; At library aybuke says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;          An earth-shattering, soul-piercing scream is heard... 
;          aybuke moves from library to heaven game-over-for-you-dude  	  	   	 
    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;:::;;;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;::;;:::;;:
;;;;;; Computer Exercise 1: Understanding installation;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;;;;
;;    	  	   	 
;;;;;;;;;;;;; ANSWER: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; Implementation of ask:
; get-method from object and apply the same object
; Implementation of delegation:
; get-method from general form (also the smallest one) and apply the specific form (also the bigger one).
; What i mean with general or smallest?
; I use general form to show that it is a first superclass, and specific form to show that it is
; a class that inherit from some superclass and specified with its own methods.
; In other words, number of general form is the smallest because it is more common behaviour.
; But when you specialize somethings, we may want to inherit from other classes or may want to have a special behaviours
; which only it has, then it is bigger than the general form.
; ask vs delegate
; Assume there is 3 classes. First ones radius is r (first general form), second ones radius is 2r (inner form), and
; The last one with radius 3r (specified one). Assume that they have same center. When we use the specified one,
; if we (for example change-location) use (ask 'r 'change-location), it affects only the r one. So r one's location changed, hence
; it acts like different object. Bu if we take out the method hem apply it to specified one, location changes with all of them and
; the center will contunie be same. Therefore, using delegate is more proper to inherited object. 
    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;;;:
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;;:;
;;;;;;;;;;;; Computer Exercise 2: Who just died? ;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;;::
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;   (define who-just-die?
;        (car (map (lambda (x) (ask x 'name)) (ask heaven 'things))))    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;:;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; Because of the oop, (ask heaven 'things) returns a list that contains procedure. Then we should take name's from the procedure
; to see who died. Since we do not know how many people died (or going to die), there will be more than one procedure in the list.
; We should use map to take name's from the list. Last person who died will be the first element of the list. Then we can learn
; the last person who died with taking car of the list.
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;:;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;    > who-just-die?
;      Value; cici    	  	   	 
    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;::;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;::;:::
;;;;;;;; Computer exercise 3: Having a quick look ;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;:::;;;
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
    ; JUST THE "GO" PART OF THE MAKE-PERSON CODE

;	((GO)    	  	   	 
;	 (lambda (self direction)  ; Shadows person's GO
;	   (let ((success? (delegate person-part self 'GO direction)))
;	     (if success?    	  	   	 
;                 (begin (ask clock 'TICK)
;                        (ask self 'LOOK-AROUND)));;I changed this line to look around.
;	     success?)))  	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;::;:::;:::;;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; I didn't change anything. The above code is the same code in the objtypes.scm.
; The question asks to change the code to add look-around everytime it change the location
; i.e. "go" somewhere. But the code had already changed when I download from the F drive.
; The note near the (ask self 'look-around) is already there. However, I do not know the
; previous version (i guessed there was only (ask clock 'TICK) line); but the version
; that the question asks is above code.   	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;;;;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;     > (setup 'aybüke)
;       ready
;     > (ask screen 'deity-mode #f)
;     > (ask me 'look-around)

;       You are in great-court 
;       You are not holding anything. 
;       You see stuff in the room: flag-pole 
;       There are no other people around you. 
;       The exits are in directions: up east west south north ok
;     > (ask me 'go 'up)

;       aybüke moves from great-court to graduation-stage 
;       --- the-clock Tick 0 --- 
;       You are in graduation-stage 
;       You are not holding anything. 
;       There is no stuff in the room. 
;       There are no other people around you. 
;       The exits are in directions: down #t  	  	   	 
    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;;;:
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;;:;
;;;;;; Computer exercise 4: But I'm too young to die!! ;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;;::
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
(define (make-person name birthplace) ; symbol, location -> person
  (let ((mobile-thing-part (make-mobile-thing name birthplace))
	(container-part    (make-container))
	(health            3)    	  	   	 
	(strength          1)
   (lives             3))    	  	   	 
    (lambda (message)    	  	   	 
      (case message    	  	   	 
	((PERSON?) (lambda (self) #T))
	((STRENGTH) (lambda (self) strength))
	((HEALTH) (lambda (self) health))
        ((SAY)    	  	   	 
         (lambda (self list-of-stuff)
           (ask screen 'TELL-ROOM (ask self 'location)
                (append (list "At" (ask (ask self 'LOCATION) 'NAME)
                                 (ask self 'NAME) "says --")
                           list-of-stuff))
                  'SAID-AND-HEARD))
	((HAVE-FIT)    	  	   	 
	 (lambda (self)    	  	   	 
	   (ask self 'SAY '("Yaaaah! I am upset!"))
	   'I-feel-better-now))
    	  	   	 
	((PEOPLE-AROUND)	; other people in room...
	 (lambda (self)    	  	   	 
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
	     (delq self people))))
    	  	   	 
	((STUFF-AROUND)		; stuff (non people) in room...
	 (lambda (self)    	  	   	 
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (stuff (myfilter (lambda (x) (not (is-a x 'PERSON?))) in-room)))
	     stuff)))    	  	   	 
    	  	   	 
	((PEEK-AROUND)		; other people's stuff...
	 (lambda (self)    	  	   	 
	   (let ((people (ask self 'PEOPLE-AROUND)))
	     (accumulate append '() (map (lambda (p) (ask p 'THINGS)) people)))))
    	  	   	 
	((TAKE)    	  	   	 
	 (lambda (self thing)    	  	   	 
	   (cond ((ask self 'HAVE-THING? thing)  ; already have it
		  (ask self 'SAY (list "I am already carrying"
				       (ask thing 'NAME)))
		  #f)    	  	   	 
		 ((or (is-a thing 'PERSON?)
		      (not (is-a thing 'MOBILE-THING?)))
		  (ask self 'SAY (list "I try but cannot take"
				       (ask thing 'NAME)))
		  #F)    	  	   	 
		 (else    	  	   	 
		  (let ((owner (ask thing 'LOCATION)))
		    (ask self 'SAY (list "I take" (ask thing 'NAME)
					 "from" (ask owner 'NAME)))
		    (if (is-a owner 'PERSON?)
			(ask owner 'LOSE thing self)
			(ask thing 'CHANGE-LOCATION self))
		    thing)))))    	  	   	 
    	  	   	 
	((LOSE)    	  	   	 
	 (lambda (self thing lose-to)
	   (ask self 'SAY (list "I lose" (ask thing 'NAME)))
	   (ask self 'HAVE-FIT)
	   (ask thing 'CHANGE-LOCATION lose-to)))
    	  	   	 
	((DROP)    	  	   	 
	 (lambda (self thing)    	  	   	 
	   (ask self 'SAY (list "I drop" (ask thing 'NAME)
				"at" (ask (ask self 'LOCATION) 'NAME)))
	   (ask thing 'CHANGE-LOCATION (ask self 'LOCATION))))
    	  	   	 
        ((GO-EXIT)    	  	   	 
         (lambda (self exit)    	  	   	 
           (ask exit 'USE self)))
    	  	   	 
	((GO)    	  	   	 
	 (lambda (self direction) ; person, symbol -> boolean
	   (let ((exit (ask (ask self 'LOCATION) 'EXIT-TOWARDS direction)))
	     (if (is-a exit 'EXIT?)
                 (ask self 'GO-EXIT exit)
		 (begin (ask screen 'TELL-ROOM (ask self 'LOCATION)
			     (list "No exit in" direction "direction"))
			#F)))))
	((SUFFER)    	  	   	 
	 (lambda (self hits)    	  	   	 
	   (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
	   (set! health (- health hits))
	   (if (<= health 0) (ask self 'DIE))
	   health))    	  	   	 
    	  	   	 
	((DEATH-SCREAM)    	  	   	 
	 (lambda (self)    	  	   	 
	   (ask screen 'TELL-WORLD
		'("An earth-shattering, soul-piercing scream is heard..."))))
    	  	   	 
	((ENTER-ROOM)    	  	   	 
	 (lambda (self)    	  	   	 
	   (let ((others (ask self 'PEOPLE-AROUND)))
	     (if (not (null? others))
		 (ask self 'SAY (cons "Hi" (names-of others)))))
	   (ask (ask self 'location) 'make-noise self)
	   #T))    	  	   	 
    	  	   	 
	;; Here is the original DIE method
	;; ((DIE)    	  	   	 
	;;  (lambda (self)    	  	   	 
	;;    (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
	;;    (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
	;; 	     (ask self 'THINGS))
	;;    (ask self 'DEATH-SCREAM)
	;;    (ask death-exit 'USE self)
	;;    'GAME-OVER-FOR-YOU-DUDE))
    	  	   	 
	;; Your version goes here:
    	  	   	 
          ((DIE)
           (lambda (self)
             (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
             (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
                       (ask self 'THINGS))
             (ask self 'DEATH-SCREAM)
             (if (> lives 1)
                 (begin (set! lives (- lives 1)) (begin (set! health 3)
             (set! mobile-thing-part (make-mobile-thing name birthplace))))
                 (begin (ask death-exit 'USE self)
	   'GAME-OVER-FOR-YOU-DUDE )))
             
	   )    	  	   	 
    	  	   	 
	(else (find-method message mobile-thing-part container-part))))))
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;:;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; I added the make-person "lives". It begins with 3 lives, then when it becomes 1,
; this is the last life it has. When it die, if it has a 1 life, then it will be die,
; and go to the heaven as before.
; When it takes a "die" message, first it says the same sentences and losing everything that
; it had as before. Then if it has lives more than 1, then its lives will be dacrease and
; it will be reshowed the place that it will appear first. When it has 1 life and takes
; a "die" message, then its lives becomes 0, and it will die.
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;:;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;    > (setup 'aybuke)
;      ready
;    > (ask screen 'deity-mode #f)
;    > (ask me 'look-around)

;      You are in deans-office 
;      You are not holding anything. 
;      You see stuff in the room: transcript 
;      There are no other people around you. 
;      The exits are in directions: down ok
;    > (ask me 'take (thing-named 'transcript))

;      At deans-office aybuke says -- I take transcript from deans-office 
;    > (ask me 'go 'down)

;      aybuke moves from deans-office to eng-z21 
;      --- the-clock Tick 0 --- 
;      You are in eng-z21 
;      You are holding: transcript 
;      You see stuff in the room: problem-set 
;      There are no other people around you. 
;      The exits are in directions: up down south out #t
;    > (ask me 'go 'out)

;      aybuke moves from eng-z21 to eng-building 
;      At eng-building aybuke says -- Hi alyssa-p-hacker 
;      alyssa-p-hacker moves from eng-building to soccer-field 
;      --- the-clock Tick 1 --- 
;      You are in eng-building 
;      You are holding: transcript 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south in west north #t
;    > (ask me 'go 'south)

;      aybuke moves from eng-building to sci-building 
;      At sci-building aybuke says -- Hi prof-yuret 
;      prof-yuret moves from sci-building to sos-building 
;      --- the-clock Tick 2 --- 
;      You are in sci-building 
;      You are holding: transcript 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t
;    > (ask me 'go 'south)

;      aybuke moves from sci-building to sos-building 
;      At sos-building aybuke says -- Hi ben-bitdiddle prof-yuret 
;      An earth-shattering, soul-piercing scream is heard... 
;      prof-yuret moves from sos-building to cas-building 
;      ben-bitdiddle moves from sos-building to cas-building 
;      --- the-clock Tick 3 --- 
;      You are in sos-building 
;      You are holding: transcript 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: east south north #t
;    > (ask me 'go 'south)

;      aybuke moves from sos-building to cas-building 
;      At cas-building aybuke says -- Hi prof-yuret 
;      prof-yuret moves from cas-building to sos-building 
;      --- the-clock Tick 4 --- 
;      You are in cas-building 
;      You are holding: transcript 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t
;    > (ask me 'go 'south)

;      aybuke moves from cas-building to great-court 
;      An earth-shattering, soul-piercing scream is heard... 
;      At great-court suzy says -- Hi aybuke 
;      At great-court suzy says -- Prepare to suffer, aybuke ! 
;      At great-court aybuke says -- Ouch! 3 hits is more than I want! 
;      At great-court aybuke says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;      At great-court aybuke says -- I lose transcript 
;      At great-court aybuke says -- Yaaaah! I am upset! 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 5 ---                                                   ; FIRST REINCARNATION
;      You are in deans-office 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: down #t
;    > (ask me 'go 'down)

;      aybuke moves from deans-office to eng-z21 
;      --- the-clock Tick 6 --- 
;      You are in eng-z21 
;      You are not holding anything. 
;      You see stuff in the room: problem-set 
;      There are no other people around you. 
;      The exits are in directions: up down south out #t
;    > (ask me 'get 'problem-set)

;      At eng-z21 aybuke says -- I take problem-set from eng-z21 
;    > (Ask me 'go 'out)

;      aybuke moves from eng-z21 to eng-building 
;      At eng-building aybuke says -- Hi alyssa-p-hacker 
;      An earth-shattering, soul-piercing scream is heard... 
;      alyssa-p-hacker moves from eng-building to soccer-field 
;      At eng-building alyssa-p-hacker says -- Hi aybuke 
;      --- the-clock Tick 7 --- 
;      You are in eng-building 
;      You are holding: problem-set 
;      There is no stuff in the room. 
;      You see other people: alyssa-p-hacker 
;      The exits are in directions: south in west north #t
;    > (ask me 'go 'south)

;      aybuke moves from eng-building to sci-building 
;      At sci-building aybuke says -- Hi prof-yuret 
;      An earth-shattering, soul-piercing scream is heard... 
;      At sci-building aybuke says -- Ouch! 1 hits is more than I want! 
;      prof-yuret moves from sci-building to eng-building 
;      --- the-clock Tick 8 --- 
;      You are in sci-building 
;      You are holding: problem-set 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t
;    > (ask me 'go 'north)

;      aybuke moves from sci-building to eng-building 
;      At eng-building aybuke says -- Hi alyssa-p-hacker prof-yuret 
;      At eng-building aybuke says -- Ouch! 1 hits is more than I want! 
;      prof-yuret moves from eng-building to sci-building 
;      alyssa-p-hacker moves from eng-building to sci-building 
;      --- the-clock Tick 9 --- 
;      You are in eng-building 
;      You are holding: problem-set 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south in west north #t
;    > (ask me 'go 'south)

;      aybuke moves from eng-building to sci-building 
;      At sci-building aybuke says -- Hi prof-yuret 
;      prof-yuret moves from sci-building to eng-building 
;      --- the-clock Tick 10 --- 
;      You are in sci-building 
;      You are holding: problem-set 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t
;    > (ask me 'go 'south)

;      aybuke moves from sci-building to sos-building 
;      At sos-building alyssa-p-hacker says -- Hi aybuke 
;      alyssa-p-hacker moves from sos-building to amphitheater 
;      --- the-clock Tick 11 --- 
;      You are in sos-building 
;      You are holding: problem-set 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: east south north #t
;    > (ask me 'go 'south)

;      aybuke moves from sos-building to cas-building 
;      An earth-shattering, soul-piercing scream is heard... 
;      At cas-building aybuke says -- Ouch! 2 hits is more than I want! 
;      At cas-building aybuke says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;      At cas-building aybuke says -- I lose problem-set 
;      At cas-building aybuke says -- Yaaaah! I am upset! 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 12 ---                                                 ; SECOND REINCARNATION
;      You are in deans-office 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      You see other people: prof-yuret 
;      The exits are in directions: down #t
;    > (ask me 'go 'down)

;      aybuke moves from deans-office to eng-z21 
;      An earth-shattering, soul-piercing scream is heard... 
;      At eng-z21 aybuke says -- Ouch! 2 hits is more than I want! 
;      At eng-z21 prof-yuret says -- Hi aybuke 
;      --- the-clock Tick 13 --- 
;      You are in eng-z21 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      You see other people: prof-yuret 
;      The exits are in directions: up down south out #t
;    > (ask me 'go 'south)

;      aybuke moves from eng-z21 to eng-auditorium 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 14 --- 
;      You are in eng-auditorium 
;      You are not holding anything. 
;      You see stuff in the room: final-exam 
;      There are no other people around you. 
;      The exits are in directions: north #t
;    > (ask me 'go 'north)

;      aybuke moves from eng-auditorium to eng-z21 
;      At eng-z21 prof-yuret says -- Hi aybuke 
;      --- the-clock Tick 15 --- 
;      You are in eng-z21 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      You see other people: prof-yuret 
;      The exits are in directions: up down south out #t
;    > (ask me 'go 'up)

;      aybuke moves from eng-z21 to deans-office 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 16 --- 
;      You are in deans-office 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: down #t

;    > (ask me 'go 'down)

;      aybuke moves from deans-office to eng-z21 
;      An earth-shattering, soul-piercing scream is heard... 
;      At eng-z21 prof-yuret says -- Hi aybuke 
;      --- the-clock Tick 17 --- 
;      You are in eng-z21 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      You see other people: prof-yuret 
;      The exits are in directions: up down south out #t
;    > (ask me 'go 'out)

;      aybuke moves from eng-z21 to eng-building 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 18 --- 
;      You are in eng-building 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south in west north #t
;    > (ask me 'go 'south)

;      aybuke moves from eng-building to sci-building 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 19 --- 
;      You are in sci-building 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t

;    > (ask me 'go 'south)

;      aybuke moves from sci-building to sos-building 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 20 --- 
;      You are in sos-building 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: east south north #t
;    > (ask me 'go 'south)

;      aybuke moves from sos-building to cas-building 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 21 --- 
;      You are in cas-building 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south north #t
;    > (ask me 'go 'south)

;      aybuke moves from cas-building to great-court 
;      An earth-shattering, soul-piercing scream is heard... 
;      At great-court alyssa-p-hacker says -- Hi aybuke 
;      --- the-clock Tick 22 --- 
;      You are in great-court 
;      You are not holding anything. 
;      You see stuff in the room: transcript flag-pole 
;      You see other people: alyssa-p-hacker 
;      The exits are in directions: up east west south north #t
;    > (ask me 'go 'east)

;      aybuke moves from great-court to student-center 
;      At student-center aybuke says -- Hi lambda-man 
;      An earth-shattering, soul-piercing scream is heard... 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 23 --- 
;      You are in student-center 
;      You are not holding anything. 
;      You see stuff in the room: profiterol milk 
;      You see other people: lambda-man 
;      The exits are in directions: in west #t
;    > (ask me 'get 'profiterol)

;      At student-center aybuke says -- I take profiterol from student-center 
;    > (ask me 'go 'in)

;      aybuke moves from student-center to suzy-cafe 
;      At suzy-cafe aybuke says -- Hi cici lambda-man ben-bitdiddle 
;      At suzy-cafe cici says -- Prepare to suffer, lambda-man ! 
;      An earth-shattering, soul-piercing scream is heard... 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 24 --- 
;      You are in suzy-cafe 
;      You are holding: profiterol 
;      You see stuff in the room: coke 
;      You see other people: cici lambda-man ben-bitdiddle 
;      The exits are in directions: down east out #t
;    > (ask me 'go 'down)

;      aybuke moves from suzy-cafe to cici-bufe 
;      An earth-shattering, soul-piercing scream is heard... 
;      An earth-shattering, soul-piercing scream is heard... 
;      --- the-clock Tick 25 --- 
;      You are in cici-bufe 
;      You are holding: profiterol 
;      You see stuff in the room: kofte 
;      There are no other people around you. 
;      The exits are in directions: down north west up #t
;    > (ask me 'go 'north)

;      aybuke moves from cici-bufe to migros 
;      --- the-clock Tick 26 --- 
;      You are in migros 
;      You are holding: profiterol 
;      There is no stuff in the room. 
;      There are no other people around you. 
;      The exits are in directions: south #t
;    > (ask me 'go 'south)

;      aybuke moves from migros to cici-bufe 
;      At cici-bufe aybuke says -- Hi cici 
;      At cici-bufe cici says -- Prepare to suffer, aybuke ! 
;      At cici-bufe aybuke says -- Ouch! 1 hits is more than I want! 
;      At cici-bufe aybuke says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;      At cici-bufe aybuke says -- I lose profiterol 
;      At cici-bufe aybuke says -- Yaaaah! I am upset! 
;      An earth-shattering, soul-piercing scream is heard... 
;      aybuke moves from cici-bufe to heaven 
;      At heaven aybuke says -- Hi ben-bitdiddle comp200-student lambda-man 
;      --- the-clock Tick 27 ---                                                 ; THIRD DYING : HEAVEN
;      You are in heaven 
;      You are not holding anything. 
;      There is no stuff in the room. 
;      You see other people: ben-bitdiddle comp200-student lambda-man 
;      There are no exits... you are dead and gone to heaven! #t 	  	   	 

;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;::;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;::;:::
;;; Computer exercise 5: Perhaps to arm oneself against a sea of .... ;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;:::;;;
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
(define (make-weapon name location damage)
  (let ((mobile-part (make-mobile-thing name location)))
    (lambda (message)
      (case message
        ((WEAPON?) (lambda (self) #T))
        ((DAMAGE) (lambda (self) damage))
        ((HIT) (lambda (self whom victim) (ask victim 'suffer (+ (random damage) 1)) (ask self 'emit whom victim)))
        ((EMIT) (lambda (self whom victim)
                  (ask whom 'say (list "I hitted " (ask victim 'name) " with " (ask self 'name) " !"))))
      (else (find-method message mobile-part))))))
(define (create-weapon name location damage)
  (create make-weapon name location damage))
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;;;:::;;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; Weapon is a mobile-thing because it can be transported from place to place. Then it
; should have a mobile-part and inherit from it. Weapons have three methods. First one
; is asking type. Second one shows the capacity of damage. And the last one is the hit
; method. Hit method has two arguments. First one is self, and the second one is who.
; who shows who will be targeted. hit method causes who suffers. Suffer damage should be
; choosen randomly accordingly pdf, then random generator take random number from [0,n)
; then we can add 1 to random number to transfer it to [1,n] integer interval.
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;;;;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
;     --- the-clock Tick 0 --- 
;     You are in great-court 
;     You are not holding anything. 
;     You see stuff in the room: inflatable-lambda flag-pole 
;     You see other people: comp200-student 
;     The exits are in directions: up east west south north #t
;   > (ask me 'get 'inflatable-lambda)

;     At great-court aybüke says -- I take inflatable-lambda from great-court 
;   > (ask (thing-named 'inflatable-lambda) 'hit me (thing-named 'comp200-student))

;     At great-court comp200-student says -- Ouch! 1 hits is more than I want! 
;     At great-court aybüke says -- I hitted  comp200-student  with  inflatable-lambda  ! said-and-heard  	  	   	 
;   > (ask me 'look-around)

;     You are in great-court 
;     You are holding: inflatable-lambda 
;     You see stuff in the room: flag-pole 
;     You see other people: comp200-student 
;     The exits are in directions: up east west south north ok

;   > (ask (thing-named 'inflatable-lambda) 'hit me (thing-named 'comp200-student))

;     At great-court comp200-student says -- Ouch! 2 hits is more than I want! 
;     At great-court comp200-student says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;     At great-court comp200-student says -- I lose chair-of-the-faculty 
;     At great-court comp200-student says -- Yaaaah! I am upset! 
;     An earth-shattering, soul-piercing scream is heard... 
;     At great-court aybüke says -- I hitted  comp200-student  with  inflatable-lambda  ! said-and-heard   	  	   	 
;     --- the-clock Tick 4 --- 
;     You are in sci-building 
;     You are holding: chair-of-the-faculty 
;     There is no stuff in the room. 
;     You see other people: ben-bitdiddle prof-yuret 
;     The exits are in directions: south north #t
;   > (ask (thing-named 'chair-of-the-faculty) 'hit me (thing-named 'ben-bitdiddle))

;     At sci-building ben-bitdiddle says -- Ouch! 1 hits is more than I want! 
;     At sci-building aybüke says -- I hitted  ben-bitdiddle  with  chair-of-the-faculty  ! said-and-heard
;   > (ask (thing-named 'chair-of-the-faculty) 'hit me (thing-named 'ben-bitdiddle))

;     At sci-building ben-bitdiddle says -- Ouch! 1 hits is more than I want! 
;     At sci-building aybüke says -- I hitted  ben-bitdiddle  with  chair-of-the-faculty  ! said-and-heard
;   > (ask (thing-named 'chair-of-the-faculty) 'hit me (thing-named 'ben-bitdiddle))

;     At sci-building ben-bitdiddle says -- Ouch! 2 hits is more than I want! 
;     At sci-building ben-bitdiddle says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;     At sci-building ben-bitdiddle says -- I lose home-made 
;     At sci-building ben-bitdiddle says -- Yaaaah! I am upset! 
;     An earth-shattering, soul-piercing scream is heard... 
;     At sci-building aybüke says -- I hitted  ben-bitdiddle  with  chair-of-the-faculty  ! said-and-heard
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;;;:
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;;:;
;;;;;;;; Computer exercise 6: Good thing I'm armed and dangerous ;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;;::
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
 (define (make-violent-person name birthplace activity miserly freq)
  (let ((autonomous-part (make-autonomous-player name birthplace activity miserly)))
    (lambda (message)
      (case message
        ((VIOLENT-PERSON?) (lambda (self) #T))
        ((INSTALL) (lambda (self)
                    (ask clock 'ADD-CALLBACK
                          (make-clock-callback 'attack self 'attack))
                     (delegate autonomous-part self 'install)))
        ((ATTACK)    	  	   	 
         (lambda (self)    	  	   	 
           (let ((others (ask self 'PEOPLE-AROUND))
                 (objs (myfilter (lambda (x) (is-a x 'weapon?))
			       (ask (ask self 'location) 'things))))
             (if (and (not (null? others)) (= (random freq) 0))
                 (let ((victim (pick-random others))
                           (weapon (if (null? objs) (create-weapon 'violencegun (ask self 'location) (+ (random 2) 1)) (pick-random objs)))) ; assuming there is always a weapon
                       (ask self 'SAY (list "Prepare for violence,"
                                        (ask victim 'NAME) "!"))
                   (ask weapon 'hit self victim)))
             'violence-is-inside-the-person)))
        	((DIE)    	  	   	 
	 (lambda (self)    	  	   	 
	   (ask clock 'REMOVE-CALLBACK self 'attack)
	   (delegate autonomous-part self 'DIE)))
        (else (get-method message autonomous-part))))))
(define (create-violent-person name birthplace activity miserly freq)
  (create make-violent-person name birthplace activity miserly freq))

; Changes in setup.scm
; I added violent person in the populate-player procedure.
;   (create-violent-person 'murderer (pick-random rooms)
;                         3 2 4)
;  (create-violent-person 'psyco (pick-random rooms)
;                         2 2 4)
; That ones are the example of violent person. 


    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;:;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; Violent person is an autonomous person which means it is inherited from autonomoud person.
; It has 2 new method and a modified method. Install method makes callback for atack method
; additining to autonomous install method and delegate other things from autonomous.
; It has type question and attack method. Attack method first find the people in the room,
; and choose one of them randomly. It chooses the weapon randomly from its weapons.
; There is a frequency for attacking. A number is choosed randomly from the interval [0,freq)
; If it is 0, then the violent person attacks. That means there is a 1/freq chance to attacking.
; It inherits other methods from autonomous part.
; I added a default weapon because finding a gun, person and the frequancy at the same time
; is really little chance, then i couldn't show the what happen when i attack. 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;:;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
;
;     ...
;     At eng-building murderer says -- Hi prof-yuret 
;     At eng-building murderer says -- Prepare for violence, prof-yuret ! 
;     At eng-building prof-yuret says -- Ouch! 1 hits is more than I want! 
;     At eng-building murderer says -- I hitted  prof-yuret  with  violencegun  !
;     ...
;     At eng-z21 psyco says -- Prepare for violence, alyssa-p-hacker ! 
;     At eng-z21 alyssa-p-hacker says -- Ouch! 1 hits is more than I want! 
;     At eng-z21 psyco says -- I hitted  alyssa-p-hacker  with  violencegun  ! 
;     ...
;     At great-court murderer says -- Prepare for violence, alyssa-p-hacker ! 
;     At great-court alyssa-p-hacker says -- Ouch! 2 hits is more than I want! 
;     At great-court murderer says -- I hitted  alyssa-p-hacker  with  violencegun  ! 
    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;::;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;::;:::
;;; Computer exercise 7: A good hacker could defuse this situation ;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;:::;;;
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 
(define (make-bomb name location damage)
  (let ((aware-part (make-aware-thing))
        (mobile-part (make-mobile-thing name location))
        (weapon '()))
    (lambda (message)
      (case message
        ((ARM) (lambda (self) (set! weapon '(armed))))
        ((DISARM) (lambda (self) (set! weapon '())))
        ((TRIGGER) (lambda (self) (if (not (eq? weapon nil)) (ask self 'activate))))
        ((HEARD-NOISE) (lambda (self who) (ask self 'trigger)))
        ((ACTIVATE) (lambda (self)
                      (let* ((people-in-room (myfilter (lambda (x) (is-a x 'PERSON?)) (ask (ask self 'location) 'things)))
                            (people-name-list (map (lambda (x) (ask x 'name)) people-in-room)))
                        (map (lambda (x) (ask x 'suffer damage)) people-in-room)
                        (if (not (null? people-name-list)) (ask self 'emit (list "a bomb " name " causes " people-name-list " suffer and even die.")))
                        (delegate mobile-part self 'destroy))))
        (else (find-method message mobile-part aware-part))))))
(define (create-bomb name location damage)
  (create make-bomb name location damage))
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;;:;:::;;:;:::;;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; A bomb is an aware thing and a mobile thing in the same time. Then it should have
; both parts. That means it inherit from both class. ARM method sets the weapon '(armed)
; (i called it weapon because it damages, so it fits. i.e. it is not the weapon class).
; DISARM method sets the weapon empty. TRIGGER method ACTIVATE itself if it is armed.
; If it is HEARD-NOISE, then it TRIGGER itself.
; If it ACTIVATE, first it has a local variable that contains the people in that location.
; Then suffer them, shows some informational about what happens and destroys itself.
 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;;;;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
     ; case 1
;     > (setup 'aybüke)
;       ready
;     > (Ask me 'look-around)

;       You are in eng-b30 
;       You are not holding anything. 
;       You see stuff in the room: c4 lecture-notes white-board 
;       There are no other people around you. 
;       The exits are in directions: up ok
;     > (ask (thing-named 'c4) 'activate)

;       At eng-b30 aybüke says -- Ouch! 2 hits is more than I want! 
;       At eng-b30 a bomb  c4  causes  (aybüke)  suffer and even die. destroyed
;     > (ask me 'look-around)

;       You are in eng-b30 
;       You are not holding anything. 
;       You see stuff in the room: lecture-notes white-board    -------> c4 is destroyed.
;       There are no other people around you. 
;       The exits are in directions: up ok    	  	   	 
    	     ; case 2
;   > (setup 'pinky)
;     ready
;   > (ask me 'look-around)

;     You are in adm-building 
;     You are not holding anything. 
;     You see stuff in the room: hand-bomb 
;     There are no other people around you. 
;     The exits are in directions: in south north ok
;     > (ask (thing-named 'hand-bomb) 'arm)
;     > (ask (thing-named 'hand-bomb) 'trigger)

;     At adm-building pinky says -- Ouch! 7 hits is more than I want! 
;     At adm-building pinky says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;     An earth-shattering, soul-piercing scream is heard... 
;     At adm-building a bomb  hand-bomb  causes  (pinky)  suffer and even die. destroyed
;  > (ask me 'look-around)

;     You are in adm-building 
;     You are not holding anything. 
;     There is no stuff in the room. 
;     There are no other people around you. 
;     The exits are in directions: in south north ok
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;;;:
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;;:;
;;;; Computer exercise 8: Well, maybe only if they have enough time ;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;;::
;;    	  	   	 
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 

(define (make-bomb-with-timer name location timer)
  (let ((bomb-part (make-bomb name location 3))
        (triggered? '()))
    (lambda (message)
      (case message
        ((INSTALL) (lambda (self)
                     (ask clock 'ADD-CALLBACK
                          (make-clock-callback 'do-it self 'do-it))
                     (delegate bomb-part self 'install)))
        ((DO-IT) (lambda (self) (if (not (eq? triggered? nil)) (ask self 'activate))))
       ; ((HEARD-NOISE)
        ((TRIGGER) (lambda (self)
                     (set! triggered? '(triggered))))
        ((ACTIVATE) (lambda (self)
                       (if (> timer 1)
                           (begin (set! timer (- timer 1)) (ask self 'emit (list timer "ticks left for" name)))
                           (ask bomb-part 'activate))))
        (else (get-method message bomb-part))))))
(define (create-bomb-with-timer name location timer)
  (create make-bomb-with-timer name location timer))
                           
    	  	   	 	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;:;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
; Bomb-with-timer is a kind of a bomb, than it inherits from bomb class.
; Install method has an addition: it sends a callback to "do-it" method and then,
; delegates bomb-part installation.
; Do-it method will be calling every tick of the clock. Then, if it is triggered, then
; it must bu activated. But there is a timer, then do-it method ask for the activate method,
; if timer is not 1, it won't we activated, just timer counts down and shows on the consol.
; When timer is 1, then bomb will be activated.
; Trigger method must be implement again, because we cannot call trigger function every tick,
; then we must have a thing to show bomb was triggered. Then i defined a empty list to show
; it is not triggered. When trigger message come in, then triggered? variable will be setted
; as '(triggered).

    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;:;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
;     ...
;     aybüke moves from great-court to cas-building 
;     At cici-bufe suzy says -- Prepare to suffer, cici ! 
;     At cici-bufe cici says -- Ouch! 1 hits is more than I want! 
;     lambda-man moves from suzy-cafe to student-center 
;     lambda-man moves from student-center to great-court 
;     At great-court lambda-man says -- Hi prof-yuret 
;     At great-court lambda-man says -- I try but cannot take flag-pole 
;     comp200-student moves from eng-building to eng-z21 
;     comp200-student moves from eng-z21 to eng-b30 
;     At eng-b30 comp200-student says -- I try but cannot take white-board 
;     prof-yuret moves from great-court to adm-building 
;     alyssa-p-hacker moves from bursar-office to registrar-office 
;     ben-bitdiddle moves from eng-building to sci-building 
;     ben-bitdiddle moves from sci-building to eng-building 
;     At registrar-office 19 ticks left for tbomb6                       TBOMB6 TRIGGERED 
;     At registrar-office 9 ticks left for tbomb1                        TBOMB1 TRIGGERED
;     --- the-clock Tick 1 --- 
;     You are in cas-building 
;     You are not holding anything. 
;     There is no stuff in the room. 
;     There are no other people around you. 
;     The exits are in directions: south north #t	   	 
;     ...

;     ...
;   > (run-clock 6)
;     ...
;     At divan 1 ticks left for tbomb5 
;     At student-center 94 ticks left for tbomb4 
;     At comp200-student 1 ticks left for tbomb3 
;     --- the-clock Tick 6 --- done
;   > (run-clock 1)
;     ...
;     At divan cici says -- Ouch! 3 hits is more than I want! 
;     At divan cici says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;     An earth-shattering, soul-piercing scream is heard... 
;     At divan ben-bitdiddle says -- Ouch! 3 hits is more than I want! 
;     At divan ben-bitdiddle says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;     An earth-shattering, soul-piercing scream is heard... 
;     ben-bitdiddle moves from divan to heaven 
;     At divan a bomb  tbomb5  causes  (cici ben-bitdiddle)  suffer and even die. 
;     At student-center 93 ticks left for tbomb4 
;     --- the-clock Tick 7 --- done
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;::;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;::;:::
;;;;;;;;; Computer Exercise 9: Even you can change the world! ;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;:::;;;
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;;;:::;;:
;;;;;;;;;;;;; DESCRIPTION: ;;;;;;;;;;;;;
;;    	  	   	 
; I made bonus lives for avatar. I changed the avatar's get method. Lives can be take only "get"
; method. Lives are created random place and random times. If avatar sees and gets the lives, it
; lives increase 1. 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;;;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    	  	   	 

(define (make-lives numberoflives rooms)
  (let* ((location (pick-random rooms))
        (time (+ (random 9)))
        (mobile-part (make-mobile-thing 'lives location)))
    (lambda (message)
      (case message
        ((INSTALL) (lambda (self)
                     (ask clock 'ADD-CALLBACK
                          (make-clock-callback 'creation self 'creation))))
        ((LIVES?) (lambda (self) #T))
        ((CREATION) (lambda (self)
                      (if (> numberoflives 0)
                          (if (= time 0)
                              (begin (begin (set! time (+ (random 9))) (delegate mobile-part self 'destroy)) (make-lives (- numberoflives 1) rooms))
                              (set! time (- time 1))))
                      (ask clock 'remove-callback self 'creation)))
        (else (get-method message mobile-part))))))
(define (create-lives numberoflives rooms)
  (create make-lives numberoflives rooms))

; Changes in setup.scm
; (define (populate-lives rooms)
;   (create-lives 6 rooms))
; adding  (populate-lives rooms) in the setup procedure. 

; Changes in make-avatar class in objypes.scm
;        	((LIVES-AROUND)		
;	 (lambda (self)    	  	   	 
;	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
;		  (life! (myfilter (lambda (x) (is-a x 'LIVES?)) in-room)))
;	    (if (not (null? life!) (ask self 'get life!))))))
; 	((GET)    	  	   	 
;	 (lambda (self tname)    	  	   	 
;	   (let* ((objs (myfilter (lambda (x) (eq? (ask x 'name) tname))
;			       (ask (ask self 'location) 'things)))
;                  (life! (myfilter (lambda (x) (eq? x 'lives)) objs)))
;	     (if (null? objs)    	  	   	 
;		 (ask self 'say `(I do not see a ,tname here))
;		 (ask self 'take (car objs)))
;            (if (not (null? life!))
;                (begin (set! lives (+ lives (length life!))) (ask (car life!) 'destroy))
;                ))))
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;;;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    	  	   	 
    	  	   	 
;	make-lives htakes one argument, it is the number of lives.
; We create local variables location, time and mobile-part. Mobile-part means, lives inherit
; from mobile-things. Insallation has a callback for creation method.
; Creation method, if numberoflives is bigger than 0, looks the time of the lives. If time equals
; 0, then first sets the time a new random number 1-10, then destroy itself and it creates a new
; one with decreasing numberoflives. If time is not 0, it sets the time, time minus 1.
; If numberoflives equals 0, then it removes callback for creation method. 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;;:;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    	  	   	 
;   	  	   	 
; Taking lives does not show in the consol because they'll be destroyed if avatar takes it.     	  	   	 
;    	  	   	 
;;    	  	   	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;;::
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;:;;
;# DO NOT FORGET TO SUBMIT YOUR WORK BEFORE THE DEADLINE!         #
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;:;:
;# GOOD LUCK!                                                     #
;;;;;;;::;;;;:::;;;;:::;:;::::;;::::::;:;:::;::;;;::;;;:;::;;::;::;;:;;::;;;:;::;::;
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
    	  	   	 
