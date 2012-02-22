;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-12.4.2) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp")))))
; Exercise 12.4.2. Develop the function insert-everywhere/in-all-words. It 
; consumes a symbol and a list of words. The result is a list of words 
; like its second argument, but with the first argument inserted between 
; all letters and at the beginning and the end of all words of the second 
; argument. 


; A word is either
;  1. empty, or
;  2. (cons a w) where a is a symbol ('a, 'b, ..., 'z) and w is a word.

; A list-of-words is either
;  1. empty, or
;  2. (cons word list-of-words)

;--------------------------------------------------------------------------

;; arrangements : word  ->  list-of-words
;; create a list of all rearrangements of the letters in a-word
(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word) 
                                          (arrangements (rest a-word)))]))

(check-expect (arrangements empty) (cons empty empty))
(check-expect (arrangements (cons 'a empty)) (cons (cons 'a empty) empty))
(check-expect (arrangements (cons 'a (cons 'b empty))) (cons (cons 'a (cons 'b empty))
                                                             (cons (cons 'b (cons 'a empty))
                                                                   empty)))

;--------------------------------------------------------------------------

;; insert-everywhere/in-all-words : symbol  list-of-words -> list-of-words
;; insert symbol s before, after and between letters of all words from alow
(define (insert-everywhere/in-all-words s alow)
  (cond
    [(empty? alow) empty]
    [else (append (insert-everywhere/in-a-single-word s (first alow))
                  (insert-everywhere/in-all-words s (rest alow)))]))

; insert 'x everywhere in no words => empty list
(check-expect (insert-everywhere/in-all-words 'x empty) empty)
; insert 'a everywhere in the empty word => one-letter word (cons 'a empty)
(check-expect (insert-everywhere/in-all-words 'a (cons empty empty)) (cons (cons 'a empty) empty))
; insert 'b everywhere in a list with one one-letter word => list with two two-letter words
(check-expect (insert-everywhere/in-all-words 'b (cons (cons 'a empty) empty)) (cons (cons 'b (cons 'a empty))
                                                                                     (cons (cons 'a (cons 'b empty))
                                                                                           empty)))
; insert 'c everywhere in a list with two two-letter words => list with six three-letter words
(check-expect (insert-everywhere/in-all-words 'c (cons (cons 'b (cons 'a empty))
                                                       (cons (cons 'a (cons 'b empty))
                                                             empty)))
              (cons (cons 'c (cons 'b (cons 'a empty)))
                    (cons (cons 'b (cons 'c (cons 'a empty)))
                          (cons (cons 'b (cons 'a (cons 'c empty)))
                                (cons (cons 'c (cons 'a (cons 'b empty)))
                                      (cons (cons 'a (cons 'c (cons 'b empty)))
                                            (cons (cons 'a (cons 'b (cons 'c empty)))
                                                  empty)))))))



;; insert-everywhere/in-a-single-word : symbol word -> list-of-words
;; create a list of words by inserting s at every possible position in a-word
(define (insert-everywhere/in-a-single-word s a-word)
  (cond
    [(empty? a-word) (cons (cons s empty) empty)]
    [else (append (cons (cons s a-word) empty)
                  (insert-in-front/in-all-words (first a-word) (insert-everywhere/in-a-single-word s (rest a-word))))]))

(check-expect (insert-everywhere/in-a-single-word 'c (cons 'b (cons 'a empty))) (cons (cons 'c (cons 'b (cons 'a empty)))
                                                                          (cons (cons 'b (cons 'c (cons 'a empty)))
                                                                                (cons (cons 'b (cons 'a (cons 'c empty)))
                                                                                      empty))))

;; insert-in-front/in-all-words : symbol list-of-words -> list-of-words
;; insert symbol s in front of every word from alow
(define (insert-in-front/in-all-words s alow)
  (cond
    [(empty? alow) empty]
    [else (cons (cons s (first alow)) (insert-in-front/in-all-words s (rest alow)))]))

(check-expect (insert-in-front/in-all-words 'c (cons (cons 'b (cons 'a empty))
                                        (cons (cons 'a (cons 'b empty))
                                              empty)))
              (cons (cons 'c (cons 'b (cons 'a empty)))
                    (cons (cons 'c (cons 'a (cons 'b empty)))
                          empty)))