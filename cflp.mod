# Definición de conjuntos
set SR;  # Conjunto de regiones proveedoras
set DR;  # Conjunto de regiones demandantes

# Definición de parámetros
param fixcost{SR};    # Costo fijo para abrir una planta en cada región proveedora
param capacity{SR};   # Capacidad de las plantas en las regiones proveedoras
param demand{DR};     # Demanda en las regiones demandantes
param transp_cost{SR, DR};  # Costo de transporte entre regiones proveedoras y demandantes

# Variables de decisión
var Q{SR, DR} >= 0;  # Cantidad transportada de la región i a la región j
var y{SR} binary;    # Decisión de abrir o no la planta en la región i

# Función objetivo: minimizar el costo total
minimize Totalcost:
    sum{i in SR, j in DR} Q[i,j] * transp_cost[i,j] +
    sum{i in SR} y[i] * fixcost[i];

# Restricciones

# Satisfacer la demanda en todas las regiones demandantes
subject to Demand_Satisfaction{j in DR}:
    sum{i in SR} Q[i,j] == demand[j];

# No exceder la capacidad de las plantas abiertas
subject to Capacity_Limit{i in SR}:
    sum{j in DR} Q[i,j] <= capacity[i] * y[i];



# Solo una planta puede estar abierta
subject to SingleSource:
    sum{i in SR} y[i] == 1;
