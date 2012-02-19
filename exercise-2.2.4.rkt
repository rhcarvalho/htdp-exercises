;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-2.2.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 2.2.4.   Define the program convert3. It consumes three digits, 
; starting with the least significant digit, followed by the next most 
; significant one, and so on. The program produces the corresponding number.
; For example, the expected value of

;(convert3 1 2 3) 

; is 321. Use an algebra book to find out how such a conversion works.

(define (convert3 a b c)
  (+ (* 10 (+ (* 10 c) b)) a))

(check-expect (convert3 1 2 3) 321)