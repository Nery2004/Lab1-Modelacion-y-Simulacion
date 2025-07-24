using JuMP, GLPK

# Datos
d = [180, 250, 190, 140, 220, 250]  # Demandas
c = [50, 45, 55, 52, 48, 50]         # Costos de producción
h = [8, 10, 10, 10, 8, 8]            # Costos de almacenamiento
Cap = 225                            # Capacidad máxima

model = Model(GLPK.Optimizer)
@variable(model, x[1:6] >= 0)         # Producción
@variable(model, I[0:6] >= 0)         # Inventario (I[0] = 0)
@objective(model, Min, sum(c[t] * x[t] + h[t] * I[t] for t in 1:6))
@constraint(model, [t in 1:6], I[t] == I[t-1] + x[t] - d[t])
@constraint(model, [t in 1:6], x[t] <= Cap)
optimize!(model)

println("Producción óptima: ", value.(x))
println("Inventario óptimo: ", value.(I[1:6]))
println("Costo total óptimo: \$", objective_value(model))