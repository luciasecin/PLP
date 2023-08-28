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

-- Ejercicio 7
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [(x:xs) | x <- [1..n], xs <- listasQueSuman (n-x)]

--listas que suman 3
-- lQS(1) = [1]
-- lQS(2) = [1:lQS(1), 2:lQS(0)] = [[1,1], [2]]
-- lQS(3) = [1:lQS(2), 2:lQS(1), 3:lQS(0)] = [[1,1,1], [1,2], [2,1], [3]]
-- lQS(4) = [1:lQS(3), 2:lQS(2), 3:lQS(1), 4:lqs(0)] = [[1,1,1,1], [1,1,2], [1,2,1], [1,3], [2,1,1], [2,2], [3,1], [4]]

-- Ejercicio 8
listasEnterosPositivos = concat [listasQueSuman x | x <- [1..]]

-- Ejercicio 9
-- foldr: it takes the second argument and the last item of the list and applies the function, 
-- then it takes the penultimate item from the end and the result, and so on.

-- Input: foldr (/) 2 [8,12,24,4]
-- Output: 8.0
-- hace 4/2 = 2 --> 24/2 --> 12/12 --> 8/1 --> 8 = 8/(12/(24/(4/2)))

-- sumFold = foldr (+) 0 directo en consola funciona pero si lo queres compilar tenes que poner el tipo sino llora
sumFold :: (Num a) => [a] -> a
sumFold = foldr (+) 0
-- este si compila sin el tipo, no llora
elemFold n = foldr (\x r-> x == n || r) False
masmas l1 l2 = foldr (\x r -> x:r) l2 l1
filterFold p = foldr (\x r -> if (p x) then x:r else r) []
mapFold f = foldr (\x r -> (f x):r) []
masmas2 l1 l2 = foldr (:) l2 l1

mejorSegunFold :: (a -> a -> Bool) -> [a] -> a
mejorSegunFold p = foldr1 (\x r -> if p x r then x else r)

-- foldl TIENE LOS ARGUMENTOS AL REVES LA FUNCION
sumasParciales :: Num a => [a] -> [a]
sumasParciales l = tail (foldl (\r x -> r ++ [x + last r]) [0] l)

sumasParciales2 :: Num a => [a] -> [a]
sumasParciales2 = foldr (\x r -> x:(map (+x) r)) []

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (\x r -> x - r) 0

sumaAltInv :: Num a => [a] -> a
sumaAltInv = foldl (\r x -> x - r) 0

sumaAltInv2 = sumaAlt . reverse

meteEnElMedio n l = [take x l ++ n:(drop x l) | x <- [0..(length l)]]

permutaciones ::[a] -> [[a]]
permutaciones = foldr (\x r -> concatMap (\l -> meteEnElMedio x l) r) [[]]

-- Ejercicio 10
partes :: [a] -> [[a]]
partes = foldr (\x r -> (map (\l -> x:l) r) ++ r) [[]]

prefijos :: [a] -> [[a]]
prefijos = foldl (\r x -> ((head r)++[x]):r) [[]]

sufijos :: [a] -> [[a]]
sufijos = foldr (\x r -> (x:head r):r) [[]]

sublistas :: [a] -> [[a]]
sublistas l = [] : filter (not.null) (concatMap prefijos (sufijos l))