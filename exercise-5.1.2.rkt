;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-5.1.2) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "guess.ss" "teachpack" "htdp")))))
; Exercise 5.1.2. Develop the function check-guess. It consumes two 
; numbers, guess and target. Depending on how guess relates to target, the 
; function produces one of the following three answers: 'TooSmall, 
; 'Perfect, or 'TooLarge. 
; 
; The function implements one part of a two-player number guessing game. 
; One player picks a random number between 0 and 99999. The other player's 
; goal is to determine this number, called target, with the least number 
; of guesses. To each guess, the first player responds with one of the 
; three responses that check-guess implements. 
; 
; The function check-guess and the teachpack guess.ss implement the first 
; player. The teachpack picks the random number, pops up a window in which 
; the second player can choose digits, and hands over the guess and the 
; target to check-guess. To play the game, set the teachpack to guess.ss 
; using the Language|Set teachpack option. Then evaluate the expression 
; 
;(guess-with-gui check-guess) 
; 
; after check-guess has been thoroughly tested. 

;; check-guess : num num -> sym
;; determines whether the guess is 'TooSmall, 
;; 'Perfect, or 'TooLarge compared to the target
(define (check-guess guess target)
  (cond
    [(= guess target) 'Perfect]
    [(< guess target) 'TooSmall]
    [(> guess target) 'TooLarge]))

(check-expect (check-guess 5 5) 'Perfect)
(check-expect (check-guess 50 5) 'TooLarge)
(check-expect (check-guess 1 5) 'TooSmall)

(guess-with-gui check-guess)