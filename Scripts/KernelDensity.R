## Script para producir animacións da estimación de densidade en 2D (multivariate kernel density)
## Eduardo Corbelle, 27 de febreiro de 2016
## Elaborado a partir de: https://www.unt.edu/benchmarks/archives/2003/february03/rss.htm

library(MASS)
library(scales)

## Cor dos gráficos
Color <- "red"

## Creamos un conxunto de puntos sobre un espazo bidimensional
set.seed(321)
x.y <- mvrnorm(n=100, 
               mu=c(0,0), 
               Sigma=matrix(c(1,.6,.6,1), ncol=2),
               empirical=TRUE)
x <- x.y[,1]
y <- x.y[,2]


## Estimación de densidade en 2D
densidade <- function(x, y, banda) {
  f <- kde2d(x, y, banda, n=50)
  return(f)
}

#### Creamos uns gráficos de saída ####
i=0
for(B in seq(0.1, 3, 0.1)) {
i = i+1
pdf(paste("./Scripts/Figures/KernelDensity", i, ".pdf", sep=""),
    width=14, height=7)
par(mfrow=c(1,2), 
    mar=c(4,4,4,1))
# Isoliñas en 2D
plot(x, y,
     pch=19,
     col=alpha(Color, .4))
par(new=TRUE)

f <- densidade(x, y, B)
contour(f$x, f$y, f$z, col=Color,
        main=paste("Bandwith = ", B, sep=""))

# Perspectivas
persp(f$x, f$y, f$z, shade=.3, theta=300, phi=45,
      expand=0.5, col=Color,
      main=paste("Bandwith = ", B, sep=""))
# Pechamos o gráfico
dev.off()
}
