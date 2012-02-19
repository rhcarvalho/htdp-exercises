;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-5.1.5) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "guess.ss" "teachpack" "htdp") (lib "master.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "guess.ss" "teachpack" "htdp") (lib "master.ss" "teachpack" "htdp")))))
; Exercise 5.1.5. Develop the function check-color. It implements a key 
; portion of a color guessing game. One player picks two colors for two 
; squares; we call those targets. The other one tries to guess which color 
; is assigned to which square; they are guesses. The first player's 
; response to a guess is to check the colors and to produce one of the 
; following answers: 
; 
; 'Perfect, if the first target is equal to the first guess and the second 
; target is equal to the second guess; 
; 
; 'OneColorAtCorrectPosition, if the first guess is equal to the first 
; target or the second guess is equal to the second target; 
; 
; 'OneColorOccurs, if either guess is one of the two targets; and 
; 
; 'NothingCorrect, otherwise. 
; 
; These four answers are the only answers that the first player gives. The 
; second player is to guess the two chosen target colors with as few 
; guesses as possible. 
; 
; The function check-color simulates the first player's checking action. 
; It consumes four colors; for simplicity, we assume that a color is a 
; symbol, say, 'red. The first two arguments to check-color are 
; ``targets,'' the latter two are ``guesses.'' The function produces one 
; of the four answers. 
; 
; When the function is tested, use the teachpack to master.ss to play the 
; color-guessing game. The teachpack provides the function master. 
; Evaluate (master check-color) and choose colors with the mouse. 

;; check-color : sym sym sym sym -> sym
;; check whether the guessed colors match the target
(define (check-color target1 target2 guess1 guess2)
  (cond
    [(and (symbol=? target1 guess1)
          (symbol=? target2 guess2)) 'Perfect]
    [(or (symbol=? target1 guess1)
         (symbol=? target2 guess2)) 'OneColorAtCorrectPosition]
    [(or (symbol=? target1 guess2)
         (symbol=? target2 guess1)) 'OneColorOccurs]
    [else 'NothingCorrect]))

(check-expect (check-color 'red 'blue 'red 'blue) 'Perfect)
(check-expect (check-color 'red 'blue 'red 'yellow) 'OneColorAtCorrectPosition)
(check-expect (check-color 'red 'blue 'yellow 'blue) 'OneColorAtCorrectPosition)
(check-expect (check-color 'red 'blue 'yellow 'red) 'OneColorOccurs)
(check-expect (check-color 'red 'blue 'pink 'yellow) 'NothingCorrect)

(master check-color)