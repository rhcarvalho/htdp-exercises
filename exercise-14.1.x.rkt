;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-14.1.x) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp")))))
; Exercises from section 14.1

; A family-tree-node (short: ftn) is either
;  1. empty; or
;  2. (make-child f m na da ec)
;     where f and m are ftns, na
;     and ec are symbols, and da is a number.
(define-struct child (father mother name date eyes))

;; Oldest Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Middle Generation:
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))


;; fun-for-ftn : ftn  ->  ???
;(define (fun-for-ftn a-ftree)
;  (cond
;    [(empty? a-ftree) ...]
;    [else
;      ... (fun-for-ftn (child-father a-ftree)) ...
;      ... (fun-for-ftn (child-mother a-ftree)) ...
;      ... (child-name a-ftree) ...
;      ... (child-date a-ftree) ...
;      ... (child-eyes a-ftree) ...]))

;-----------------------------------------------------------------------------
; Exercise 14.1.3. Develop count-persons. The function consumes a family 
; tree node and produces the number of people in the corresponding family 
; tree.

;; count-persons : ftn -> number
;; produces the number of people in the family tree a-ftree
(define (count-persons a-ftree)
  (cond
    [(empty? a-ftree) 0]
    [else (+ 1
             (count-persons (child-father a-ftree))
             (count-persons (child-mother a-ftree)))]))

(check-expect (count-persons empty) 0)
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Gustav) 5)


;-----------------------------------------------------------------------------
; Exercise 14.1.4. Develop the function average-age. It consumes a family 
; tree node and the current year. It produces the average age of all 
; people in the family tree. 

;; average-age : ftn number -> number
;; produces the average age of all people in the family tree a-ftree in year
(define (average-age a-ftree year)
  (cond
    [(empty? a-ftree) 0]
    [else (/ (sum-age a-ftree year)
             (count-persons a-ftree))]))

(check-expect (average-age empty 2012) 0)
(check-expect (average-age Carl 2012) 86)
(check-expect (average-age Adam 2012) (/ (+ 62 86 86) 3))

;; sum-age : ftn number -> number
;; produces the sum of ages of all people in the family tree a-ftree in year
(define (sum-age a-ftree year)
  (cond
    [(empty? a-ftree) 0]
    [else (+ (- year (child-date a-ftree))
             (sum-age (child-father a-ftree) year)
             (sum-age (child-mother a-ftree) year))]))

(check-expect (sum-age empty 2012) 0)
(check-expect (sum-age Carl 2012) 86)
(check-expect (sum-age Adam 2012) (+ 62 86 86))


;-----------------------------------------------------------------------------
; Exercise 14.1.5. Develop the function eye-colors, which consumes a 
; family tree node and produces a list of all eye colors in the tree. An 
; eye color may occur more than once in the list. 
; 
; Hint: Use the Scheme operation append, which consumes two lists and 
; produces the concatenation of the two lists. For example:
;     (append (list 'a 'b 'c) (list 'd 'e)) 
;   = (list 'a 'b 'c 'd 'e)

;; eye-colors : ftn -> (symbol ...)
;; produces a list of all eye colors in the tree a-ftree
(define (eye-colors a-ftree)
  (cond
    [(empty? a-ftree) empty]
    [else (append (list (child-eyes a-ftree))
                  (eye-colors (child-father a-ftree))
                  (eye-colors (child-mother a-ftree)))]))

(check-expect (eye-colors empty) empty)
(check-expect (eye-colors Carl) '(green))
(check-expect (eye-colors Gustav) '(brown pink blue green green))