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

-- Ejercicio 11

-- la estructural es foldr, la global es recr. La global la uso cuando me falta info, cuando necesito mas que solo los
-- elementos para hacer la recursion. DUDOSA AFIRMACION DUDOSISIMA. BUSCAR LO DE FIBONACCI EN LOGICA? PREGUNTAR A PAU?
-- A GALI? A TEO?

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs then [x] else x:elementosEnPosicionesPares (tail xs)

-- esta no la puedo hacer con recursion estructural, requiere usar recursion global, no puedo hacer recursion estructural
-- porque se va saltando numeros y la informacion queda mal si hago recursion estructural. Ejemplo:
-- tengo la lista [1,2,3,4,5,6] -> el resultado que quiero es [1,3,5], pero siguiendo un esquema de recursion estructural
-- las cosas me van a dar mal, porque voy a estar usando el elemeto actual y queriendolo concatenar con el resultado
-- de la recursion en el resto de la lista, es decir:
-- foldr (\x r -> x:r) no sirve porque daria 1:[2,4,6] que son las posiciones pares de la lista [2,3,4,5,6]
-- por ende el resultado da mal, deberia tener una manera de saber si es o no par. cuestion, necesito induccion global

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys then x:(entrelazar xs []) else x:head ys:entrelazar xs (tail ys)

-- esta si la puedo hacer haciendo recursion estructural
entrelazar2 :: [a] -> [a] -> [a]
entrelazar2 = foldr extender id
        where extender = (\x r l -> if null l then x:(r []) else x:head l:(r (tail l))) 

-- EJEMPLO: entrelazar2 [1,2,3] [A,B,C] = (foldr extender id [1,2,3]) [A,B,C]

-- PASO 1 -> extender toma la x, la r que es una funcion y la segunda lista 
-- extender 1 (extender 2 (extender 3 id)) [A,B,C] = if null [A,B,C] then 1:(extender 2 (extender 3 id)) []) 
--                                                     else 1:A:((extender 2 (extender 3 id)) [B,C])

-- Hasta ahora tenemos 1:A:((extender 2 (extender 3 id)) [B,C])
-- PASO 2 -> la recursion del resultado del paso 1: extender 2 (extender 3 id)) [B,C]
-- extender 2 (extender 3 id) [B,C] = if null [B,C] then 2:((extender 3 id) []) else 2:B:((extender 3 id) [C])

-- Ahora tenemos 1:A:2:B:((extender 3 id) [C])
-- PASO 3 -> la recursion del resultado del paso 2: extender 3 id [C]
-- extender 3 id [C] = if null [C] then 3:(id [C]) else 3:C:(id []))

-- Finalmente queda 1:A:2:B:3:C:[] = [1,A,2,B,3,C]

-- Ejercicio 12
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs r -> if x == e then xs else x:r) []

-- foldr no sirve para este esquema porque necesito tener la original, foldr no me dejaria hacer la comparacion con 
-- una sola aparicion, lo hace con todas, por que sacaria todas las apariciones de un elemento. Con recr, tengo acceso
-- a la original ademas de la recursiva.

sacarTodas :: Eq a => a -> [a] -> [a]
sacarTodas e = foldr (\x r -> if x == e then r else x:r) []

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs r -> if x < e then (if r == [] then [x,e] else x:r) else e:x:xs) []

-- para hacer las listas que suman 4, tengo que agregarle el 1 a las que suman 3, el 2 a las que suman 2, el 3 a las que
-- suman 4 y el 4 a las que suman 0
-- no se man, creo que no, no se me ocurre manera de hacerlo.





