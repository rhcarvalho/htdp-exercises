;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-11.2.4) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp")))))
; Exercise 11.2.4. Lists may contain lists that contain lists and so on. 
; Here is a data definition that takes this idea to an extreme: 
; 
; A deep-list is either 
;  1. s where s is some symbol or 
;  2. (cons dl empty), where dl is a deep list. 
; 
; Develop the function depth, which consumes a deep list and determines 
; how many times cons was used to construct it. 
; 
; Develop the function make-deep, which consumes a symbol s and a natural 
; number and produces a deep list containing s and constructed with n 
; conses. 


; depth : deep-list -> number
; determines how many times cons was used to construct the deep list dl
(define (depth dl)
  (cond
    [(symbol? dl) 0]
    [else (add1 (depth (first dl)))]))

(check-expect (depth (cons (cons 'sheep empty) empty)) 2)

; make-deep : symbol number -> deep-list
(define (make-deep s n)
  (cond
    [(zero? n) s]
    [else (cons (make-deep s (sub1 n)) empty)]))

(check-expect (make-deep 'nothing 0) 'nothing)
(check-expect (make-deep 'scheme 3) (cons (cons (cons 'scheme empty) empty) empty))
(check-expect (make-deep 'racket 5) (cons (cons (cons (cons (cons 'racket empty) empty) empty) empty) empty))