# Código desarrollado
En esta carpeta se encuentra el código desarrollado para el funcionamiento de la segunda versión del radar. Es similar a la primera versión pero incluye la banda base compleja. 
La mayoría del código ha sido escrito en MATLAB. Ejemplos del uso de este código se pueden encontrar en la guía de usuario.

A continuación se describen cada una de las funciones:	
- **captura_datos.m**: Script que captura los datos transmitidos por el radar y los guarda en un fichero. No configura el radar, hay que hacerlo antes de ejecutar esta función. Es un bucle infinito, cuando se quiera dejar de capturar, se mata el proceso.	
- **captura_doppler.m**: Script que configura el radar en modo doppler, procesando la captura y representándolo en tiempo real. 
- **captura_fmcw.m**: Script que configura el radar en modo FMCW, procesando la captura y representándola en tiempo real. 		
- **crc_mex.c**: Función en C para agilizar la velocidad de desempaquetado. Ha sido pre compilada para Windows y MacOS.
- **crc_mex32.c**: Igual que la anterior.	
- **lineal_ramp.m**: Una función que genera una rampa lineal en frecuencia entre las frecuencias especificadas y de una duración deseada. Después, es cargada al microcontrolador usando la función set_ramp.	
- **packet_decode.m**: Decodifica los paquetes del protocolo. Se le pasa el buffer de entrada y devuelve los paquetes así como el numero de errores detectados.		
- **postprocess_doppler.m**: Script para procesar los datos doppler capturados con captura_datos.m. Genera un espectrograma.	
- **postprocess_fmcw.m**: Script para procesar las rampas capturados con captura_datos.m. Genera un espectrograma.	
- **set_ramp.m**: Se usa para cargar una rampa al microcontrolador. Se le pasas el objeto serial al que esta conectado el microcontrolador, el vector con los valores digitales en de tensión y el numero de muestras de este. La duración temporal está determinada por la longitud del vector, ya que el DAC funciona a una frecuencia fija de 1 MSPS.	
- **vco_caracterizacion.txt**: Curva de tuning del VCO. Se utiliza para compensar el VCO y obtener rampas lineales en frecuencia. Contiene la relación medida entre tensión y frecuencia de salida del VCO. La estructura para cada fila es la siguiente: Valor DAC [0-4096], Voltaje a la entrada del VCO [V], Frecuencia [GHz].	
