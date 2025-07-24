# Universidad del Valle de Guatemala
# Modelacion y Simulación
# Laboratorio 1 - Ejercicio 4 apartado (c) & (d)

# c) Resolver el problema en variables enteras, y comparar la solución con la de (b)
using JuMP, HiGHS

model_int = Model(HiGHS.Optimizer)

@variable(model_int, x1 >= 0, Int)
@variable(model_int, x2 >= 0, Int)
@variable(model_int, x3 >= 0, Int)
@variable(model_int, x4 >= 0, Int)

@objective(model_int, Max, 1000x1 + 1900x2 + 2700x3 + 3400x4)

@constraint(model_int, area, 0.18x1 + 0.28x2 + 0.4x3 + 0.5x4 <= 63.75)
@constraint(model_int, comp1, x3 + x4 >= 0.25*(x1 + x2 + x3 + x4))
@constraint(model_int, comp2, x1 >= 0.20*(x1 + x2 + x3 + x4))
@constraint(model_int, comp3, x2 >= 0.10*(x1 + x2 + x3 + x4))
@constraint(model_int, budget, 50000x1 + 70000x2 + 130000x3 + 160000x4 <= 14400000)

optimize!(model_int)

println("solucion optima entera:")
println("x1 = ", round(value(x1), digits=2))
println("x2 = ", round(value(x2), digits=2))
println("x3 = ", round(value(x3), digits=2))
println("x4 = ", round(value(x4), digits=2))
println("recaudacion total = \$", round(objective_value(model_int), digits=2))

# d) Discuta sus resultados
#La distribucion optima con variables entwras es igual de eficiente que la teórica continua
#La solucion entera propone construir 35 casas sencillas, 96 dobles, 37 triples y 7 cuaruples, cumpliendo todas las restricciones (area, presupuesto y proporciones)
#Aunque la total disminuye ligeramente de $341,333.33 en el modelo continuo a $341,100.00 en el modelo entero, la diferencia es mínima (solo $233.33 o un 0.07 %)
#El modelo es robusto y viable en la prráctica.
#Como en la realidad solo pueden construirse cantidades enteras de viviendas, esta solucion entera representa una planificacion realista con un impacto tributario casi igual al ideal