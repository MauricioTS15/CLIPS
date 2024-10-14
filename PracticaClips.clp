;;; Hechos Iniciales
(deffacts vuelos
    (vuelo 06:30 09:00 CDG BER Air-France AF101 a-tiempo)
    (vuelo 10:15 12:45 CDG BER Air-France AF102 retrasado)
    (vuelo 14:00 16:30 HND SIN Singapore-Airlines SQ303 cancelado)
    (vuelo 18:00 20:15 AMS IST KLM KL404 a-tiempo)
    (vuelo 11:30 13:50 FRA SVO Lufthansa LH505 retrasado)
    (vuelo 08:45 11:20 AMS DXB Emirates EK606 a-tiempo)
    (vuelo 22:00 00:30 SYD AKL Qantas QF707 cancelado)
    (vuelo 09:15 11:45 EZE LIM LATAM LA808 retrasado)
    (vuelo 16:50 19:30 YYZ ORD Air-Canada AC909 a-tiempo)
    (vuelo 12:20 14:55 EZE SCL LATAM LA010 cancelado)
    (vuelo 07:45 10:15 CDG BER Air-France AF103 a-tiempo)
    (vuelo 13:30 16:00 LHR DXB British-Airways BA212 retrasado)
    (vuelo 19:00 21:30 HKG LAX Cathay-Pacific CX313 a-tiempo)
    (vuelo 05:15 07:45 ORD MEX American-Airlines AA414 cancelado)
    (vuelo 09:50 12:20 ICN PEK Korean-Air KE515 a-tiempo)
    (vuelo 16:25 18:55 LAX DFW Ameqrican-Airlines AA616 retrasado)
    (vuelo 08:10 10:40 CAI JNB EgyptAir MS717 cancelado)
    (vuelo 14:45 17:15 EZE LIM LATAM LA808 a-tiempo)
    (vuelo 11:00 13:30 DME LED Aeroflot SU919 retrasado)
    (vuelo 21:15 23:45 DFW DEN United-Airlines UA020 a-tiempo)
    (vuelo 07:30 09:50 AMS ZRH Swiss LX121 cancelado)
    (vuelo 12:50 15:20 LIM SCL LATAM LA222 a-tiempo)
    (vuelo 17:35 19:55 DEL CMB SriLankan-Airlines UL323 retrasado)
    (vuelo 06:45 09:15 SFO YVR Air-Canada AC424 a-tiempo)
    (vuelo 10:30 13:00 MEX SJO Aeroméxico AM525 cancelado)
    (vuelo 15:25 18:00 MAD FCO Iberia IB626 a-tiempo)
    (vuelo 19:40 22:10 NRT HKG Japan-Airlines JL727 retrasado)
    (vuelo 08:30 11:00 IST VIE Turkish-Airlines TK828 cancelado)
    (vuelo 13:20 15:50 SCL EZE LATAM LA929 a-tiempo)
    (vuelo 22:10 00:40 GMP KIX Korean-Air KE030 retrasado)
    (vuelo 06:00 08:30 MEX JFK Aeromexico AM001 retrasado)
    (vuelo 07:30 10:15 CDG AMS KLM KL101 cancelado)
    (vuelo 08:45 11:20 AMS DXB Emirates EK606 a-tiempo)
    (vuelo 10:15 12:45 CDG BER Air-France AF102 retrasado)
    (vuelo 14:00 16:30 HND SIN Singapore-Airlines SQ303 cancelado)
)

;;; Hechos independientes
(defrule agregar-nuevos-vuelos
    ; Declaramos que inicie al principio de la ejecución 
    (declare (salience 1000))
    =>
    ; Añadimos nuevas variables que se mostraran en la regla 4
    (assert (vuelo 17:00 19:00 VIT LHR Lufthansa LH506 a-tiempo))
    (assert (vuelo 20:30 23:00 VIT LHR Lufthansa LH507 cancelado))
)

;;; Reglas

; Regla 1: Mostrar lista de vuelos entre las 12:00 y las 14:00
(defrule vuelos-rango-horas
    ; Declaramos que esta rega sea lo ultimo en ejecutarse
    (declare (salience 15))
    ; Recogemos en una variable todas las variables de un vuelo que este a tiempo
    ?var1 <- (vuelo ?hora-salida ?hora-llegada ?origen ?destino ?aerolinea ?codigo a-tiempo)
    ; Las condiciones marcaran el rango de horas
    ; Al no poder condicionar un rango de horas con <, >, =, ya que solo se podria si fuesen INT o FLOAT, hemos optado por hacer de esta forma
    (test (or (eq ?hora-salida 12:00)
              (eq ?hora-salida 12:05)
              (eq ?hora-salida 12:10)
              (eq ?hora-salida 12:15)
              (eq ?hora-salida 12:20)
              (eq ?hora-salida 12:25)
              (eq ?hora-salida 12:30)
              (eq ?hora-salida 12:35)
              (eq ?hora-salida 12:40)
              (eq ?hora-salida 12:45)
              (eq ?hora-salida 12:50)
              (eq ?hora-salida 12:55)
              (eq ?hora-salida 13:00)
              (eq ?hora-salida 13:05)
              (eq ?hora-salida 13:10)
              (eq ?hora-salida 13:15)
              (eq ?hora-salida 13:20)
              (eq ?hora-salida 13:25)
              (eq ?hora-salida 13:30)
              (eq ?hora-salida 13:35)
              (eq ?hora-salida 13:40)
              (eq ?hora-salida 13:45)
              (eq ?hora-salida 13:50)
              (eq ?hora-salida 14:00)
    )
    )
    =>
    ; Mostramos un titulo distintivo para esta regla
    (printout t "Lista de vuelos en horario 12:00 / 14:00" crlf)
    ; Mostramos la informacion de los vuelos que cumplan las reglas
    (printout t "Hora salida: " ?hora-salida " | origen: " ?origen " | aerolinea: " ?aerolinea " | código: " ?codigo crlf)
)


; Regla 2: Mostrar Todos los Vuelos desde un Origen Específico
(defrule vuelos-origen-especifico
    ; Recogemos la toda la informacion de los vuelos
    (vuelo ?hora-salida ?hora-llegada ?origen ?destino ?aerolinea ?codigo ?estado-vuelo)
    ; Condicionamos los vuelos, solo pasaran los que cumplan la condicion origen = MEX
    (test (eq ?origen MEX))
    =>
    ; Mostramos un titulo distintivo para esta regla
    (printout t "✈️Los vuelos desde el origen " ?origen " son: " crlf)
    ; Mostramos la informacion de los vuelos que cumplan las reglas
    (printout t "Codigo: " ?codigo " |  Estado vuelo: " ?estado-vuelo " ✈️" crlf)
)
; Regla 3: Identificar Congestión Potencial en un Aeropuerto
(defrule congestion-aeropuerto
    ; Condicionamos directamente los vuelos que tengan un retraso o se hayan cancelado que tengan un mismo origen
  (or (vuelo ?hora1 ?hora2 ?origen ?destino ?aerolinea ?codigo retrasado)
      (vuelo ?hora1 ?hora2 ?origen ?destino ?aerolinea ?codigo cancelado))
  (or (vuelo ?hora3 ?hora4 ?origen ?destino2 ?aerolinea2 ?codigo2 retrasado)
      (vuelo ?hora3 ?hora4 ?origen ?destino2 ?aerolinea2 ?codigo2 cancelado))
  (or (vuelo ?hora5 ?hora6 ?origen ?destino3 ?aerolinea3 ?codigo3 retrasado)
      (vuelo ?hora5 ?hora6 ?origen ?destino3 ?aerolinea3 ?codigo3 cancelado))
  =>
  ; Mostramos la informacion de los vuelos que cumplan las reglas
  (printout t "⚠️Congestión potencial detectada en el aeropuerto: " ?origen " ⚠️" crlf))

; Regla 4: Identificar Conexiones Alternativas para Vuelos Cancelados
(defrule conexiones-alternativas
    ; Declaramos que sea esta la regla que se ejecute despues de ejecutar los asserts al inicio del programa
    (declare (salience 50))
    ; Recogemos la informacion de los vuelos cancelados en una variable
    ?var2 <- (vuelo ?hora-salida1 ?hora-llegada1 ?origen ?destino ?aerolinea1 ?codigo1 cancelado)
    ; Recogemos la informacion de los vuelos que esten a tiempo y tengan el origen y destino igual a los vuelos que han sido cancelados
    (vuelo ?hora-salida2 ?hora-llegada2 ?origen ?destino ?aerolinea2 ?codigo2 a-tiempo)
    ; Condicionamos la hora de salida de estos vuelos
    (test (neq ?hora-salida1 ?hora-salida2))
    =>
    ; Al igual que la regla 3 no podemos filtrar la hora con <, > o =, por lo que hemos optado por filtrar por horas que no sean iguales
    ; Teniendo esto en cuenta, hemos decidido que este mensaje se mostrara 1 o X dias con anterioridad
    ; Mostramos los vuelos que han sido cancelados
    (printout t "🔀Vuelos con origen: " ?origen " y destino: " ?destino " han sido cancelados, conexiones alternativas: " crlf)
    ; Mostramos informacion acerca del vuelo cancelado y la nueva alternativa
    (printout t "➡️ Horario cancelado: " ?hora-salida1 " con código: " ?codigo1 " | Horario alternativo: " ?hora-salida2 " con código: " ?codigo2 " 🔀" crlf)
    ; Eliminamos los vuelos que han sido cancelados
    (retract ?var2)
)

;Reglas 5/6: Contador de retrasos y cancelaciones por aerolínea
(deffacts inicial-contadores
    ;"Inicializa los contadores de vuelos retrasados y cancelados por aerolínea"
    (contador Air-France 0 0)
    (contador Singapore-Airlines 0 0)
    (contador KLM 0 0)
    (contador Lufthansa 0 0)
    (contador Emirates 0 0)
    (contador Qantas 0 0)
    (contador LATAM 0 0)
    (contador British-Airways 0 0)
    (contador Cathay-Pacific 0 0)
    (contador American-Airlines 0 0)
    (contador Korean-Air 0 0)
    (contador Aeroflot 0 0)
    (contador United-Airlines 0 0)
    (contador Swiss 0 0)
    (contador SriLankan-Airlines 0 0)
    (contador Air-Canada 0 0)
    (contador Aeromexico 0 0)
    (contador Iberia 0 0)
    (contador Japan-Airlines 0 0)
    (contador Turkish-Airlines 0 0))

;"Cuenta cuántos vuelos de cada aerolínea están retrasados o cancelados"
(defrule contar-vuelos-retrasados-o-cancelados
    ; Declaramos cuando se va a ejecutar
    (declare (salience 30))
    ; Recogemos la informacion de los vuelos y comparamos la variable estado con los vuelos retrasados y cancelados
    ?fact <- (vuelo ?hora-salida ?hora-llegada ?origen ?destino ?aerolinea ?numero-vuelo ?estado&:(or (eq ?estado retrasado) (eq ?estado cancelado)))
    ; Asignamos a una variable contador el conteo de los retrasos y vuelos cancelados en INT
    ?contador <- (contador ?aerolinea ?retrasados ?cancelados)
    =>
    ; Eliminamos el contador
    (retract ?contador)
    ; Condiciones para aumentar el contador de los vuelos retrasados y cancelados
    (if (eq ?estado retrasado) then
        (bind ?nuevo-retrasados (+ ?retrasados 1))
        (assert (contador ?aerolinea ?nuevo-retrasados ?cancelados)))
    (if (eq ?estado cancelado) then
        (bind ?nuevo-cancelados (+ ?cancelados 1))
        (assert (contador ?aerolinea ?retrasados ?nuevo-cancelados)))
    ; Eliminamos la informacion de la variable ?fact
    (retract ?fact))
