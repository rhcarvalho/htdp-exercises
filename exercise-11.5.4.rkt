;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-11.5.4) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp")))))
; Exercise 11.5.4. Deep lists (see exercise 11.2.4) are another 
; representation for natural numbers. Show how to represent 0, 3, and 8. 
; 
; Develop the function addDL, which consumes two deep lists, representing 
; the natural numbers n and m, and produces a deep list representing n + m. 

;--------------------------------------------------------------------------

; 0 => 'deep-list
; 1 => (cons 'deep-list empty)
; 3 => (cons (cons (cons 'deep-list empty) empty) empty)
; 8 => (cons (cons (cons (cons (cons (cons (cons (cons 'deep-list empty) empty) empty) empty) empty) empty) empty) empty)

(define (addDL dl1 dl2)
  (cond
    [(symbol? dl1) dl2]
    [else (cons (addDL (first dl1) dl2) empty)]))

; 0 + 0 = 0
(check-expect (addDL 'deep-list 'deep-list) 'deep-list)
; 0 + 1 = 1
(check-expect (addDL 'deep-list (cons 'deep-list empty)) (cons 'deep-list empty))
; 3 + 2 = 5
(check-expect (addDL (cons (cons (cons 'deep-list empty) empty) empty) (cons (cons 'deep-list empty) empty))
              (cons (cons (cons (cons (cons 'deep-list empty) empty) empty) empty) empty))