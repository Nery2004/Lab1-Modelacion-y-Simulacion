
using JuMP
using HiGHS
using Ipopt
using Optimization

model = Model()

# Variables de decisión
@variable(model, x1 >= 0)
@variable(model, x2 >= 0)
@variable(model, x3 >= 0)
@variable(model, x4 >= 0)
@variable(model, x5 >= 0)
@variable(model, x6 >= 0)

# Restricciones
@constraint(model, x1 + x6 >= 4)
@constraint(model, x1 + x2 >= 8)
@constraint(model, x2 + x3 >= 10)
@constraint(model, x3 + x4 >= 7)
@constraint(model, x4 + x5 >= 12)
@constraint(model, x5 + x6 >= 4)

#Función objetivo
@objective(model, Min, x1 + x2 + x3 + x4 + x5 + x6)

set_optimizer(model, HiGHS.Optimizer)

optimize!(model)

# Resultados
print("Resultados óptimos:\n")
print("x1 = ", value.(x1), "\n")
print("x2 = ", value.(x2), "\n")
print("x3 = ", value.(x3), "\n")
print("x4 = ", value.(x4), "\n")
print("x5 = ", value.(x5), "\n")
print("x6 = ", value.(x6), "\n")

print("z = ", objective_value(model))