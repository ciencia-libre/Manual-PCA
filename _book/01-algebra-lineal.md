# Algunas operaciones básicas de álgebra lineal 

En este capítulo veremos algunas operaciones de álgebra lineal. Esto será suficiente para posteriormente abordar el análisis de componentes principales desde sus bases. Si no tienes mucha o ninguna experiencia con esta rama de las matemáticas, te recomiendo publicaciones como *Nociones de geometría analítica y álgebra lineal* o canales en *YouTube* como *3Blue1Brown* (solo en inglés, pero con subtítulos en español).  

## Operaciones con vectores

### Crear vectores 

En *R* podemos definir vectores numéricos de manera muy sencilla con la función `c()`. 


```r
x <- c(30, 20, 40, 10)
y <- c(20, 15, 18, 40)
```

### Suma de vectores

Para sumar un par de vectores utilizamos el operador `+` de la manera usual. Nota que cada elemento en el vector `x` se suma con el elemento en la misma posición que en el vector `y`.


```r
x + y
```

```
## [1] 50 35 58 50
```

En *R*, si intentamos sumar vectores con una longitud distinta, los elementos del vector más pequeño se reciclan para corresponder con el número de elementos del vector de mayor longitud. Esto se ve más claramente al realizar la operación en la consola de *R*.


```r
# Vector con dos elementos
v2 <- c(10, 40)

x + v2
```

```
## [1] 40 60 50 50
```

El vector `v2` se utilizó dos veces de la forma `c(10, 40, 10, 40)` para corresponder con los elementos de `x`. Si el vector más largo tiene un número de elementos que no es un múltiplo del número de elementos del vector más pequeño, *R* desplegará un mensaje de advertencia.  


```r
# Vector con tres elementos
v3 <- c(10, 40, 15)

x + v3
```

```
## Warning in x + v3: longitud de objeto mayor no es múltiplo de la longitud de uno
## menor
```

```
## [1] 40 60 55 20
```

Esto es un recordatorio de que al intentar reutilizar los elementos del vector más pequeño, algunos serán omitidos. En el ejemplo anterior, los elementos de `v3` se utilizaron de la forma `c(10, 40, 15, 10)` para corresponder con la longitud de `x`.  

### Multiplicación de un vector por un escalar

Para multiplicar un vector por un escalar utilizamos el operador `*`.  


```r
100 * x
```

```
## [1] 3000 2000 4000 1000
```

Aquí cada elemento en `x` se multiplicó por nuestro escalar `100`.  

### Producto punto o producto interno

Para obtener el producto interno o producto punto de dos vectores, utilizamos el operador `%*%`.  


```r
z <- x %*% y
z
```

```
##      [,1]
## [1,] 2020
```

Esta operación devuelve un objeto de las clases matriz y arreglo, o `matrix` y `array` en inglés.  


```r
class(z)
```

```
## [1] "matrix" "array"
```

Para obtener solo el valor numérico, utilizamos la función `as.numeric()`.  


```r
as.numeric(z)
```

```
## [1] 2020
```

De manera un poco extendida o desglosada, al realizar el producto punto entre dos vectores cada elemento en el vector `x` se multiplica por el elemento en la misma posición que en el vector `y` y posteriormente cada producto se suma para obtener el total. En la consola de *R* lo anterior podría definirse de la siguiente forma.  


```r
# Vectores "x" y "y"
x <- c(30, 20, 40, 10)
y <- c(20, 15, 18, 40)

# Producto punto desglosado
30*20 + 20*15 + 40*18 + 10*40
```

```
## [1] 2020
```

También debemos resaltar que los vectores deben tener el mismo número de elementos. De otra forma *R* nos mostrará un mensaje de error. 


```r
x %*% v2
```

```
## Error in x %*% v2: argumentos no compatibles
```

### Norma o magnitud de un vector

Para obtener la magnitud o *norma* de una vector podemos obtener la raíz cuadrada del producto punto del vector por sí mismo.  


```r
sqrt(x %*% x)
```

```
##          [,1]
## [1,] 54.77226
```

También podemos utilizar la función `norm()`, pero primero debemos asegurarnos que nuestro vector posea la clase matriz.  


```r
x_m <- as.matrix(x)

norm(x_m, type = "F")
```

```
## [1] 54.77226
```

## Operaciones con matrices

### Definir matrices

Para definir una matriz en *R* usamos la función `matrix()` con un vector numérico como argumento.


```r
# Define un vector numérico
v_n <- c(7, -6, 12, 8)

# Define la matriz
m <- matrix(
  v_n,
  nrow = 2,     # Número de renglones en nuestra matriz
  byrow = TRUE, # Ordenar cada elemento por renglón
)

m
```

```
##      [,1] [,2]
## [1,]    7   -6
## [2,]   12    8
```

Si el argumento `byrow` se establece como falso (`FALSE`), los elementos se ordenarán por columna.


```r
matrix(v_n, nrow = 2, byrow = FALSE)
```

```
##      [,1] [,2]
## [1,]    7   12
## [2,]   -6    8
```

### Multiplicar una matriz por un vector

Para multiplicar una matriz por un vector utilizamos el operador `%*%`. Debemos cuidar que el número de elementos del vector sea igual al número de columnas en nuestra matriz.  


```r
# Define una matriz
m2 <- matrix(
  c(8, 4, 5, 3, 1, 2),
  nrow = 3,
  byrow = TRUE
)

m2
```

```
##      [,1] [,2]
## [1,]    8    4
## [2,]    5    3
## [3,]    1    2
```


```r
# Define un vector
z <- c(3, 4)

# Multiplica usando %*%
m2 %*% z
```

```
##      [,1]
## [1,]   40
## [2,]   27
## [3,]   11
```

Como puede verse, el resultado es un *vector columna*, que no es otra cosa que un objeto de la clase matriz con una sola columna. Al realizar este tipo de multiplicación debemos recordar que el orden del producto sí importa, tanto para la multiplicación de un vector por una matriz como para el producto entre matrices. Esto lo veremos con un poco de detalle más adelante.  

Para calcular cada elemento en el vector que obtuvimos en el ejemplo anterior, tomamos cada renglón de la matriz y realizamos el producto punto con el vector `z`.    


```r
# Primer renglón de la matriz
r1 <- c(8, 4)

# Segundo renglón
r2 <- c(5, 3)

# Tercer renglón
r3 <- c(1, 2)

# Elementos en el vector columna resultante
cat("Primer elemento:", r1 %*% z, "\n")
```

```
## Primer elemento: 40
```

```r
cat("Segundo elemento:", r2 %*% z, "\n")
```

```
## Segundo elemento: 27
```

```r
cat("Tercer elemento:", r3 %*% z)
```

```
## Tercer elemento: 11
```

### Multiplicación de matrices

Para multiplicar dos matrices utilizamos el operador `%*%`. También debemos asegurarnos de que el número de columnas en la primera matriz sea igual número de renglones en la segunda.  


```r
# Una matriz de dos renglones y tres columnas (2 X 3)
A <- matrix(c(1, 2, 3, 4, 0, 1), nrow = 2, byrow = TRUE)

# Una matriz de tres renglones y tres columnas (3 X 3)
B <- matrix(c(1, 1, 0, 0, 1, 1, 1, 0, 1), nrow = 3, byrow = TRUE)

# Producto de ambas matrices
A %*% B
```

```
##      [,1] [,2] [,3]
## [1,]    4    3    5
## [2,]    5    4    1
```

De manera desglosada, cada elemento en la matriz resultante se calculó realizando el producto punto entre cada renglón de la matriz `A` por cada columna de la matriz `B`. Por ejemplo, calculemos el primer elemento, el número 4, en el resultado anterior. 


```r
# Primer renglón de la matriz A
ar_1 <- c(1, 2, 3)

# Primera columna de la matriz B
bc_1 <- c(1, 0, 1)

# Producto punto entre ambos vectores
ar_1 %*% bc_1
```

```
##      [,1]
## [1,]    4
```

Lo anterior se repite para obtener cada elemento de la matriz resultante. De manera general si la primera matriz tiene *a* renglones y *b* columnas (una matriz *a X b*) y la segunda matriz tiene *b* columnas y *c* renglones (una matriz *b X c*), la matriz que obtengamos de la multiplicación de ambas tendrá *a* renglones y *c* columnas (una matriz *a X c*).   

Pare terminar esta sección, retomemos lo que mencioné anteriormente, el orden de los factores en la multiplicación de matrices si altera el resultado. Esto se puede demostrar fácilmente definiendo un par de matrices de 2 X 2 (dos renglones y dos columnas).  


```r
C <- matrix(c(2, 4, 6, 0), nrow = 2)
D <- matrix(c(1, 3, 0, 9), nrow = 2)
```

La multiplicación `C %*% D`:  


```r
C %*% D
```

```
##      [,1] [,2]
## [1,]   20   54
## [2,]    4    0
```

La multiplicación `D %*% C`:  


```r
D %*% C
```

```
##      [,1] [,2]
## [1,]    2    6
## [2,]   42   18
```

### Multiplicación de un escalar por una matriz

La multiplicación de un escalar por una matriz se hace de la misma forma que para vectores.  


```r
100 * A
```

```
##      [,1] [,2] [,3]
## [1,]  100  200  300
## [2,]  400    0  100
```

### Transpuesta de una matriz

Para obtener la *transpuesta* de una matriz usamos la función `t()`.  Esta operación solo "intercambia" los renglones y columnas en la matriz original. Cada renglón pasa a ser una columna o viceversa, cada columna pasa a ser un renglón.  

Matriz original:  


```r
A
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    0    1
```

Matriz transpuesta:  


```r
t(A)
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    0
## [3,]    3    1
```

### Matriz identidad

En ocasiones puede ser útil definir una matriz *identidad* o *diagonal*. Para esto utilizamos la función `diag()`.   


```r
I <- diag(nrow = 5)
I
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    0    0    0    0
## [2,]    0    1    0    0    0
## [3,]    0    0    1    0    0
## [4,]    0    0    0    1    0
## [5,]    0    0    0    0    1
```

Como puede observarse, la matriz identidad tiene el mismo número de renglones y columnas y todos los elementos en la diagonal son 1.  

### Valores y vectores propios de una matriz

La obtención de los valores y vectores propios de una matriz resulta una operación central al realizar análisis de componentes principales.  

De manera muy general, podemos pensar en una matriz como una función que puede modificar la dirección y magnitud de un vector o vectores dados. Por ejemplo, si definimos una matriz con dos columnas y dos renglones, esta podrá multiplicarse por vectores de dos elementos. Dichos vectores, a excepción del vector (0, 0), verán modificada su dirección y posiblemente su magnitud dependiendo de los elementos de la matriz.


```r
M  <- matrix(c(4, 0, 1, -1), nrow = 2, byrow = TRUE)
v4 <- c(3, 4)

v4 %*% M
```

```
##      [,1] [,2]
## [1,]   16   -4
```

En el ejemplo anterior, el vector resultante tiene coordenadas o elementos distintos, y si obtenemos la norma o magnitud de ambos vectores en este caso también resultarán diferentes.  

Ahora bien, un *vector propio* no verá modificada su dirección al multiplicarse por una matriz y en cuanto a su magnitud, esta podrá aumentar o disminuir por una constante o constantes dadas. Dichas constantes son los *valores propios*. Para decirlo de otra manera, los vectores propios son una especie de ejes que permanecen inmóviles al multiplicarse por un matriz y estos solo se estiran o contraen dependiendo de los valores propios.   

En *R* para obtener los vectores y valores propios de una matriz, utilizamos la función `eigen()`. Para nuestro ejemplo, definamos una matriz pequeña de dos renglones y dos columnas.


```r
A <- matrix(c(3, 4, 0, 5), nrow = 2, byrow = TRUE)
A
```

```
##      [,1] [,2]
## [1,]    3    4
## [2,]    0    5
```

Al utilizar la función `eigen()`, esta devolverá un listado con los vectores y valores propios.  


```r
eA <- eigen(A) 
```

Para acceder a los elementos de este listados utilizamos el operador `$`. Primero guardemos los valores propios en otro objeto.  


```r
eA_vls <- eA$values
eA_vls
```

```
## [1] 5 3
```

Después hacemos lo mismo para los vectores.  


```r
eA_vcs <- eA$vectors
eA_vcs
```

```
##           [,1] [,2]
## [1,] 0.8944272    1
## [2,] 0.4472136    0
```

En esta matriz cada columna es un vector propio. Si tomamos el segundo vector propio y los multiplicamos por el segundo valor propio, veremos que el vector apunta al mismo lugar, pero tendrá una longitud mayor.  


```r
eA_vls[2] %*% eA_vcs[, 2]
```

```
##      [,1] [,2]
## [1,]    3    0
```

## Algunos extra

Para terminar con este capítulo, a continuación muestro algunas procedimientos que pueden ser de utilidad para el lector. Claro, utilizando operaciones de álgebra lineal.  

### Resolver sistemas de ecuaciones lineales

Digamos que queremos resolver el siguiente sistema de ecuaciones lineales con ayuda de *R*:  

$a + b + c = 15$  
$3a + 2b + c = 28$  
$2a + b + 2c = 23$  

En primer lugar, definimos una matriz con los coeficientes del sistema y un vector con los resultados o constantes de cada ecuación.  

En el caso de los coeficientes, cada renglón corresponderá a una ecuación y cada elemento corresponderá a un término, ya sea *a*, *b* o *c*. El orden de los coeficientes en cada renglón debe ser el mismo, en este caso se sigue el orden por abecedario.  


```r
MC <- matrix(c(1, 1, 1, 3, 2, 1, 2, 1, 2), nrow = 3, byrow = TRUE)
MC
```

```
##      [,1] [,2] [,3]
## [1,]    1    1    1
## [2,]    3    2    1
## [3,]    2    1    2
```

Para el vector de constantes también seguimos el orden por ecuación.  


```r
vc <- c(15, 28, 23)
vc
```

```
## [1] 15 28 23
```

El siguiente paso es obtener la *inversa* de la matriz de coeficientes. Para esto usamos a la función `solve()`.  


```r
MC_inv <- solve(MC)
MC_inv
```

```
##      [,1] [,2] [,3]
## [1,] -1.5  0.5  0.5
## [2,]  2.0  0.0 -1.0
## [3,]  0.5 -0.5  0.5
```

Y finalmente, para obtener la solución, multiplicamos la inversa por el vector de coeficientes.  


```r
sv <- MC_inv %*% vc
sv
```

```
##      [,1]
## [1,]    3
## [2,]    7
## [3,]    5
```

Entonces *a = 3*, *b = 7* y *c = 5*. Para verificar nuestra solución, podemos multiplicar *sv* por la matriz de coeficientes original (*MC*), lo que dará como resultado al vector de constantes (*vc*).  


```r
MC %*% sv
```

```
##      [,1]
## [1,]   15
## [2,]   28
## [3,]   23
```

### Promedio y varianza con operaciones de álgebra lineal

El álgebra lineal es fundamental y es utilizada para simplificar operaciones y reducir tiempos de computación. Muchas funciones y procedimientos estadísticos tienen en su centro operaciones de álgebra lineal.  

#### Promedio

Para calcular el promedio, primero simulemos un conjunto de 100 datos. La función `set.seed()` se utiliza para asegurar que cada vez que ejecutemos el mismo ejemplo obtengamos el mismo conjunto de datos.  


```r
set.seed(5)
vd <- runif(100, min = 10, max = 35)
```

Para obtener el promedio, necesitamos obtener la longitud del vector anterior y definir un vector de la misma longitud que solo contenga números 1.  


```r
# Longitud (número de elementos) del vector vd
ld <- length(vd) 

# Vector con números 1 
v1 <- rep(1, ld)
```

Multiplicamos el vector con nuestros datos por el vector de números 1, lo que resultará en la suma de todos los datos, y dividimos por la longitud del vector.  


```r
vd_promedio <- v1 %*% vd / ld
vd_promedio
```

```
##          [,1]
## [1,] 22.96092
```

Si utilizamos la función `mean()` con el vector *vd* como argumento obtendremos el mismo resultado.  


```r
mean(vd)
```

```
## [1] 22.96092
```

### Varianza  

Para calcular la varianza del mismo conjunto de datos, primero obtenemos la diferencia entre cada dato y el promedio.  


```r
d <- vd - as.numeric(vd_promedio)
```

Multiplicamos el vector de diferencias por sí mismo, lo que dará como resultado la suma de las diferencias al cuadrado, y dividimos entre el número de datos menos uno (los grados de libertad).  


```r
vd_varianza <- d %*% d / ld - 1
vd_varianza
```

```
##          [,1]
## [1,] 55.75781
```

Si utilizamos la función `var()` obtendremos el mismo resultado.  


```r
var(vd)
```

```
## [1] 57.33112
```

