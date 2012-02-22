;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-9.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 9.3.3. Develop the function contains?, which consumes a symbol 
; and a list of symbols and determines whether or not the symbol occurs in 
; the list. 

; A list-of-symbols is either
;  1. the empty list, empty, or
;  2. (cons s los) where s is a symbol and los is a list of symbols.

; contains? : symbol list-of-symbols -> boolean
; determines whether or not the symbol s occurs in the list los.
(define (contains? s los)
  (cond
    [(empty? los) false]
    [else (or (symbol=? (first los) s)
              (contains? s (rest los)))]))

(check-expect (contains? 'doll (cons 'ball (cons 'doll empty))) true)
(check-expect (contains? 'doll (cons 'ball (cons 'arrow empty))) false)