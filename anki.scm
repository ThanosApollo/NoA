;; Import the GTK library and its dependencies
(use-modules (gtk)
             (gtk gtk))

;; Import the SRFI-1 library for lists
(use-modules (srfi srfi-1))

;; Import the SRFI-13 library for string manipulation
(use-modules (srfi srfi-13))

;; Define the main function
(define (main)
  (let ((flashcards (make-hash)))

    ;; Create the main window
    (let ((window (make-window "Flashcards")))

      ;; Create a table to hold the GUI elements
      (let ((table (make-table 2 2)))

        ;; Create a label for the term field
        (let ((term-label (make-label "Term: ")))
          (table-attach table term-label 0 1 0 1))

        ;; Create a text entry field for the term
        (let ((term-field (make-entry)))
          (table-attach table term-field 1 2 0 1))

        ;; Create a label for the definition field
        (let ((definition-label (make-label "Definition: ")))
          (table-attach table definition-label 0 1 1 2))

        ;; Create a text entry field for the definition
        (let ((definition-field (make-entry)))
          (table-attach table definition-field 1 2 1 2))

        ;; Add the table to the window
        (window-add window table))

      ;; Create a button for adding flashcards
      (let ((add-button (make-button "Add")))

        ;; Define the function to be called when the button is clicked
        (button-set-callback add-button
          (lambda (button)
            (let ((term (entry-get-text term-field))
                  (definition (entry-get-text definition-field)))
              (hash-set! flashcards term definition)
              (display "Flashcard added.\n"))))

        ;; Add the button to the window
        (window-add window add-button))

      ;; Create a button for reviewing flashcards
      (let ((review-button (make-button "Review")))

        ;; Define the function to be called when the button is clicked
        (button-set-callback review-button
          (lambda (button)
            (let ((term (entry-get-text term-field)))
              (let ((definition (hash-ref flashcards term #f)))
                (if definition
                    (display "Definition: " definition "\n")
                    (display "Term not found.\n"))))))

        ;; Add the button to the window
        (window-add window review-button))

      ;; Show the window and enter the main GTK loop
      (window-show window)
      (main-iteration))))

(main)
