(defun naive-fib (i)
  (if (< i 2) 1
      (+ (naive-fib (- i 1))
         (naive-fib (- i 2)))))