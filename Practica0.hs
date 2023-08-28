module Practica0 where

--Ejercicio 2
--a
valorAbsoluto :: Float -> Float
valorAbsoluto x = abs x

-- b
bisiesto :: Int -> Bool
bisiesto x  | (x `mod` 400 == 0) = True
            | (x `mod` 4 == 0) && (x `mod` 100 /= 0) = True
            | otherwise = False

--c
factorial :: Int -> Int 
factorial 0 = 1
factorial x = x * factorial (x-1)

--d
cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos x   | (x `mod` x-1 == 0) && esPrimo (x-1) = 1 + cantDivisoresPrimos x-1
                        | otherwise = cantDivisoresPrimos x-1

esPrimo :: Int -> Bool
esPrimo x   | cantDivisoresHasta x x > 2 = False
            | otherwise = True

cantDivisoresHasta :: Int -> Int -> Int
cantDivisoresHasta x y | (y <= 0) = 0
cantDivisoresHasta x y  | (x `mod` y == 0) = 1 + cantDivisoresHasta x (y-1)
                        | otherwise = cantDivisoresHasta x (y-1)

--Ejercicio 3
--a
inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso x = Just (1/x)

--b
-- aEntero (Right True)
-- aEntero (Left 3)
aEntero :: Either Int Bool -> Int
aEntero (Left x) = x
aEntero (Right y) = if y then 1 else 0

--Ejercicio 4
--a
--funcion que chequea que un char no aparece en una string, recordr que string es arreglo de chars
noAparece :: String -> Char -> Bool
noAparece [] _ = True
noAparece (x:xs) c = x /= c && noAparece xs c

--aca le mando un filter con la funcion noAparece mas la string de argumento, esto recorre la segunda string y
--caracter por caracter lo elimina si aparece en la primera
limpiar :: String -> String -> String
limpiar x y = filter (noAparece x) y

--b
promedio :: [Float] -> Float
promedio x = sum x / (fromIntegral (length x))

difPromedio :: [Float] -> [Float]
difPromedio x = map (\y -> (y - (promedio x))) x

todosIguales :: [Int] -> Bool
todosIguales x = all (\y -> y == (head x)) x

--Ejercicio 5
--deriving sho sirve para que imprima asi como esta
data AB a = Nil | Bin (AB a) a (AB a) deriving Show

--a
vacioAB :: AB a -> Bool 
vacioAB Nil = True
vacioAB _ = False

--b
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin izq root der) = Bin (negacionAB izq) (not root) (negacionAB der)

--c
productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin izq root der) = root * (productoAB izq) * (productoAB der)

--un print rancio rancio que con el deriving ya no necesito
printAB :: AB Bool -> String
printAB Nil = ""
printAB (Bin izq root der) = (boolToString root) ++ " izq: " ++ (printAB izq) ++ " der: " ++ (printAB der)

boolToString :: Bool -> String
boolToString True = "TRUE"
boolToString False = "FALSE"

