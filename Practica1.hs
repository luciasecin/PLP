module Practica1 where
import Practica0


-- Ejercicio 2
--La currificación es una transformación de funciones que traduce una función invocable 
--como f(a, b, c) a invocable como f(a)(b)(c)

-- funcion (x,y) = x+y
-- :t funcion
-- funcion :: Num a => (a, a) -> a
-- :t curry funcion
-- curry funcion :: Num c => c -> c -> c
-- curry funcion 3 4 --> aplicacion es asociativa a izquierda entonces hace curry funcion y a lo que devuelve le pasa
-- los argumentos 3 y 4
-- 7

curryPractica :: ((a,b) -> c) -> a -> b -> c
curryPractica f x y = f(x,y)

-- funcion x y = x+y
-- :t funcion
-- :t uncurry funcion
-- uncurry funcion :: Num c => (c, c) -> c
-- uncurry funcion (4,5) --> aplicacion es asociativa a izquierda entonces hace curry funcion y a lo que devuelve le pasa
-- el argumento (4,5)
-- 9

uncurryPractica :: (a -> b -> c) -> (a,b) -> c
uncurryPractica f (x,y) = f x y

-- Se podría definir una función curryN, que tome una función de un número arbitrario de argumentos y
-- devuelva su versión currificada? No, excepto que lo quieras hacer de maneras ilegales rancias sin tuplas y 
-- cosas raras.

-- Ejercicio3
listaEj3 = [x | x <- [1..3], y <- [x..3], (x + y) `mod` 3 == 0]
-- [1,3]

-- Ejercicio4 
-- esta definicion no esta buena porque todos los numeros son parte de un conjunto infinito de valores. al no haber cotas, hay
-- uno solo de los numeros que avanzan y otro que se queda siempre en 1.
pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a, b, c) | a <- [1..], b <-[1..], c <- [1..], a^2 + b^2 == c^2]

listaEj4 = [(a, b, c) | c <- [1..], a <- [1..c], b <- [1..c], a^2 + b^2 == c^2]

-- Ejercicio 5
listaEj5 = take (1000) [n | n <- [2..], esPrimo n]

-- Ejercicio 6
sublista :: [a] -> Int -> Int -> [a]
sublista x i j = (drop i . take j) x

partir :: [a] -> [([a], [a])]
partir l = [(xs1,xs2) | x <- [0..(length l)], 
          let xs1 = sublista l 0 x,
          let xs2 = sublista l x (length l)]

partirCheta :: [a] -> [([a], [a])]
partirCheta l = [(take x l, drop x l) | x <- [0..(length l)]]