# Universidad del Valle de Guatemala
# Modelacion y Simulación
# Laboratorio 1 - Ejercicio 4 apartado (a) & (b)

# a) Formular el problema de programación lineal
#x1 - unidades senccillas ; x2 -unidades dobles ; x3 - unidades triples ; x4 - unidades cuadruples
#objetivo - maximizar Z = 1000x1 + 1900x2 + 2700x3 + 3400x4
#restriccionws:
    #area util: 0.18x1 ​+ 0.28x2 ​+ 0.4x3 ​+ 0.5x4 ​<= 63.75 (300 casas × 0.25 acres × 0.85 (85% util)
    #composicion:
        #x3 + x4 >= 0.25(x1 + x2 + x3 + x4)  (triples yc uadruples ≥ 25%)
        #x1 >= 0.20(x1 + x2 + x3 + x4)      (sencillas ≥ 20%)
        #x2 >= 0.10(x1 + x2 + x3 + x4)      (dobles ≥ 10%)
    #presupuesto: 50000x1 ​+ 70000x2​ + 130000x3 ​+ 160000x4 ​<= 14400000 (15M - 600K demolicion)

# b) Resolver el problema usando la librería JuMP o Pulp, en variables continuas, y determinar la distribución óptima
using JuMP, HiGHS

model = Model(HiGHS.Optimizer)

@variable(model, x1 >= 0)
@variable(model, x2 >= 0)
@variable(model, x3 >= 0)
@variable(model, x4 >= 0)

@objective(model, Max, 1000x1 + 1900x2 + 2700x3 + 3400x4)

@constraint(model, area, 0.18x1 + 0.28x2 + 0.4x3 + 0.5x4 <= 63.75)
@constraint(model, comp1, x3 + x4 >= 0.25*(x1 + x2 + x3 + x4))
@constraint(model, comp2, x1 >= 0.20*(x1 + x2 + x3 + x4))
@constraint(model, comp3, x2 >= 0.10*(x1 + x2 + x3 + x4))
@constraint(model, budget, 50000x1 + 70000x2 + 130000x3 + 160000x4 <= 14400000)

optimize!(model)

println("solucion optima continua:")
println("x1 = ", round(value(x1), digits=2))
println("x2 = ", round(value(x2), digits=2))
println("x3 = ", round(value(x3), digits=2))
println("x4 = ", round(value(x4), digits=2))
println("recaudacion total = \$", round(objective_value(model), digits=2))