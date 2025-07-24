using JuMP
using HiGHS

model = Model()

# Definir variables
@variable(model, x1 >= 0)
@variable(model, x2 >= 0)
@variable(model, x3 >= 0)
@variable(model, x4 >= 0)

# Restricciones
@constraint(model, x1 + 2x2 - 3x3 + 5x4 <= 4)
@constraint(model, 5x1 - 2x2 + 6x4 <= 8)
@constraint(model, 2x1 + 3x2 - 2x3 + 3x4 <= 3)
@constraint(model, -x1 + x3 +2x4 <= 0)

# Función objetivo (maximizar 5x1 + 2x2)
@objective(model, Max, x1 + x2 + 3x3 +2x4)

# Configurar el solver (HiGHS)
set_optimizer(model, HiGHS.Optimizer)

# Resolver el modelo
optimize!(model)

# Mostrar resultados
println("Solución óptima:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x3 = ", value(x3))
println("x4 = ", value(x4))
println("Valor objetivo (Z) = ", objective_value(model))