;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-9.5.5) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp")))))
; Exercise 9.5.5. Develop the function convert. It consumes a list of 
; digits and produces the corresponding number. The first digit is the 
; least significant, and so on. 
; 
; Also develop the function check-guess-for-list. It implements a general 
; version of the number-guessing game of exercise 5.1.3. The function 
; consumes a list of digits, which represents the player's guess, and a 
; number, which represents the randomly chosen and hidden number. 
; Depending on how the converted digits relate to target, 
; check-guess-for-list produces one of the following three answers: 
; 'TooSmall, 'Perfect, or 'TooLarge. 
; 
; The rest of the game is implemented by guess.ss. To play the game, use 
; the teachpack to guess.ss and evaluate the expression 
; 
;(guess-with-gui-list 5 check-guess-for-list) 
; 
; after the functions have been thoroughly developed. 


; convert : list-of-digits -> number
(define (convert lod)
  (cond
    [(empty? lod) 0]
    [else (+ (first lod) (* 10 (convert (rest lod))))]))

(check-expect (convert empty) 0)
(check-expect (convert (cons 1 (cons 2 (cons 3 empty)))) 321)
(check-expect (convert (cons 7 (cons 5 (cons 8 (cons 2 (cons 4 (cons 1 empty))))))) 142857)


; check-guess-for-list : list-of-digits number -> symbol
; determines whether the guess is 'TooSmall, 'Perfect, or 'TooLarge compared to a hidden target
(define (check-guess-for-list guess target)
  (cond
    [(= (convert guess) target) 'Perfect]
    [(< (convert guess) target) 'TooSmall]
    [(> (convert guess) target) 'TooLarge]))

(check-expect (check-guess-for-list (cons 5 empty) 5) 'Perfect)
(check-expect (check-guess-for-list (cons 0 (cons 5 empty)) 5) 'TooLarge)
(check-expect (check-guess-for-list (cons 1 empty) 5) 'TooSmall)

(guess-with-gui-list 5 check-guess-for-list)