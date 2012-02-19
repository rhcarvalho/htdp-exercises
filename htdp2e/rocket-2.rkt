;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-2) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
; properties of the “world”
(define WIDTH 400)
(define HEIGHT 600)

; properties of the descending rocket
(define Vx 1)
(define Vy 3)
(define DECELERATION 1)

; various other constants
(define MTSCN  (empty-scene WIDTH HEIGHT))

(define (create-ufo color1 color2)
  (overlay
   (overlay/align "center" "middle"
                  (beside
                   (circle 2 "solid" color2)
                   (circle 1 "solid" color2)
                   (circle 2 "solid" color2)
                   (circle 1 "solid" color2)
                   (circle 2 "solid" color2)
                   (circle 1 "solid" color2)
                   (circle 2 "solid" color2))
                  (circle 10 "solid" color1))
   (rectangle 44 1 "solid" color1)
   (rectangle 42 2 "solid" color1)
   (rectangle 40 4 "solid" color1)))

(define (create-shadowed-ufo color1 color2 shadow-color)
  (overlay/offset (create-ufo color1 color2)
                  1 1
                  (create-ufo shadow-color shadow-color)))

(define UFO (create-shadowed-ufo "lime" "red" "black"))



(define ROCKET-CENTER-TO-BOTTOM
  (- HEIGHT (/ (image-height UFO) 2)))

; programs
(define (create-ufo-scene t)
  (place-image UFO (x t) (y t) MTSCN))

(define (x* t)
  (+ (/ WIDTH 2) ; center on screen
     (* (* 3/4 (/ WIDTH 2)) ; wave amplitude
        (cos (/ (* 2 pi Vx t) ; 2 * pi * Vx * t
                (/ HEIGHT 4)))))) ; wave length

(define (y* t)
  (* Vy t))

(define (x t)
  (cond [(stop? t) (/ WIDTH 2)]
        [else (x* t)]))

(define (y t)
  (cond [(stop? t) HEIGHT]
        [else (y* t)]))

(define (stop? t)
  (> (y* t) HEIGHT))

; run program run
(animate create-ufo-scene)
