module Notas where

import Practica0


--porque estas dos cosas tienen el mismo tipo
prod :: Int -> Int -> Int
prod x y = x*y

--Tipos de funciones y maneras de definirlas

doble1 x = prod 2 x
doble2 = prod 2

--Main> :t doble1
--doble1 :: Int -> Int
--Main> :t doble2
--doble2 :: Int -> Int

-- Ambas funciones son del mismo tipo, doble1 es la normal, la clasica, le das el argumento y te devuelve el doble
-- ahora si usas el doble2 y no le pasas ningun argumento entonces eso te va a devolver una funcion Int->Int, que es 2*algo,
-- si es una funcion INt->INt le puedo pasar un argumento, si hago doble2 10, esto retorna una funcion a la que se le pasa el
-- argumento 10, y termina devolviendo 20. Son lo mismo, una te pide que le pases el argumento y la otra solo te devuelve la 
-- funcion y es esa a la que le pasas el argumento, se reducen de la misma forma solo se puede describir de manera distinta.
-- "doble1 toma un argumento y devuele una funcion, doble2 es esa funcion"

sucesor = (+) 1
-- nos devuelve la funcion aplicada parcialmente, la duncion suma que ya tiene instanciado el 1
sucesorLambda = (\x -> x+1)
-- misma funcion escrita como funcion lambda, transforma a x en x+1

triple :: Float -> Float
triple = (*) 3

esMayorDeEdad = flip (>=) 18
-- (>=) a b ---> a >= b ---> (>=) 18 = 18 >= x ---> esto va a dar al reves, por eso pongo el flip, para que el 18 sea el
-- segundo argumento. Tambien se puede escribir como:
-- (>= 18) hace una transformacion sintactica para pasarlo como segundo parametro en vez de primero (solo para binarios)
-- (<=) 17

-- Ord a => a significa que el argumento a tiene que tener una funcion de orden
-- funcion fija: funcion x y. para pasar a infija es x `funcion` y.
-- funcion infija: x funcion y. para pasar a fija es (funcion) x y ---> para definir esta, en la definicion pongo el nombre
-- entre parentesis

-- aplicacion asocia a izquierda el tipo asocia a derecha

-- Funcion para concatenar funciones (ya esta definida)
-- f(g(x)): tipof -> tipog -> tipox -> tipo f(y)
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- (.) f g = f \x -> g x = \x -> f (g x)

sumar3 = (+1) . (+2)

-- la funcion $
-- f 5 $ g 8 = (f 5) (g 8)
-- sin nada se interpreta como f 5 h 8 g 2 = (((((f 5) h) 8) g) 2)
-- f (g x) = f $ g x

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun _ [x] = x
mejorSegun f (x:xs) = if f x rec
                      then x
                      else rec
                        where rec = (mejorSegun f xs)

-- Definicion de listas
-- por extension
lista1 = [1,2,3,4]

-- secuencias
lista2 = [[3..7],[2, 5..18]]

-- por comprension, esto da la lista de los pares que suman 4 en los que el primer elemento va de 0 a 5 y el segundo de 0 a 3
lista3 = [(x,y) | x <- [0..5], y <- [0..3], x+y == 5]

-- listas infinitas
naturales = [1..]
multiplosDeTres = [0,3..]
hola = repeat "hola"
primos = [n | n <- [2..], esPrimo n]

-- Evaluacion Lazy
-- takeClase = take solo la queria compilar sin que llore
takeClase :: Int -> [a] -> [a]
takeClase 0 _ = []
takeClase _ [] = []
takeClase n (x:xs) = x : takeClase (n-1) xs

infinitosUnos :: [Int]
infinitosUnos = 1 : infinitosUnos

nUnos :: Int -> [Int]
nUnos n = take n infinitosUnos

-- Mostrar los pasos necesarios para reducir nUnos 2, que deberia dar [1,1]
-- nUnos 2 ~>
-- take 2 infinitosUnos ~>
-- take 2 (1:infinitosUnos) ~>  
-- 1 : take (2-1) infinitosUnos ~>
-- 1 : take (1) infinitosUnos ~>
-- 1 : take (1) (1:infinitosUnos) ~>
-- 1 : 1 : take (1-1) infinitosUnos ~>
-- 1 : 1 : take (0) (1:infinitosUnos) ~>
-- 1 : 1 : [] = [1,1]

