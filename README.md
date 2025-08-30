# Ejercicio de Evaluación Continua 2025  
### Ingeniería Mecatrónica

## 📌 Descripción
Programación de un **ATmega328P** para controlar un **panel de iluminación DOLANG**, mostrando secuencias en la sección superior de LEDs y figuras en la matriz.

## 🎯 Objetivo
Controlar el panel DOLANG desde el ATmega328P con **secuencias dinámicas** y **figuras** definidas.

## 📋 Requerimientos

### 🔹 Sección Superior (barras de LEDs)
1. **Desplazamiento Izq→Der**: un único LED encendido moviéndose.
2. **Encendido secuencial Izq→Der**: se van sumando sin apagar los anteriores.
3. **Extremos→Centro (y regreso)**: pares desde extremos al centro y apagado inverso.

### 🔹 Matriz de LEDs
1. **Cara feliz 😀**
2. **Cara triste ☹️**
3. **Corazón ❤️**
4. **Rombo 🔷**
5. **Alien (Space Invaders 👾)**

## 🛠️ Metodología
- **Lenguaje**: Ensamblador (ATmega328P) para optimización.
- **Diseño modular**: una rutina por secuencia/figura.
- **Control temporal**: bucles y comparaciones para tiempos y orden.

## ✅ Resultados Esperados
- Visualización **fluida y precisa** de secuencias/figuras.
- Código **estructurado y comentado**.
- Entrega en GitHub dentro de `Evaluación Continua/`.


---

## 👨‍💻 Autores  
- David Alvarez  
- Joaquin Utmazian  

---

## 📂 Estructura del Repositorio
