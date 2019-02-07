# Codigo desarrollado para la primera version
En esta carpeta se encuentra el codigo desarrollado para el funcionamiento de la primera version del radar.
La mayoria del codigo ha sido escrito en MATLAB. Ejemplos del uso de este codigo se pueden encontrar en la guia de usuario.

A continuacion se describen cada una de las funciones:	
- **captura_datos.m**: Script que captura los datos transmitidos por el radar y los guarda en un fichero. No configura el radar, hay que hacerlo antes de ejecutar esta función. Es un bucle infinito, cuando se quiera dejar de capturar, se mata el proceso.	
- **captura_doppler.m**: Script que configura el radar en modo doppler, procesando la captura y representandolo en tiempo real. 
- **captura_fmcw.m**: Script que configura el radar en modo FMCW, procesando la captura y representandola en tiempo real.	
- **crc_mex.c**: Función en C para agilizar la velocidad de desemaquetado. Ha sido precompilada para Windows y MacOS.
- **crc_mex32.c**: Igual que la anterior.	
- **lineal_ramp.m**: Una funcion que genera una rampa lineal en frecuencia entre las frecuencias especificadas y de una duracion deseada. Despues, es cargada al microcontrolador usando la funcion set_ramp.	
- **packet_decode.m**: Decodifica los paquetes del protocolo. Se le pasa el buffer de entrada y devuelve los paquetes asi como el numero de errores detectados.		
- **postprocess_doppler.m**: Script para procesar los datos doppler capturados con captura_datos.m. Genera un espectrograma.	
- **postprocess_fmcw.m**: Script para procesar las rampas capturados con captura_datos.m. Genera un espectrograma.	 	
- **set_ramp.m**: Se usa para cargar una rampa al microcontrolador. Se le pasas el objeto serial al que esta conectado el microcontrolador, el vector con los valores digitales en de tension y el numero de muestras de este. La duracion temporal está determinada por la longitud del vector, ya que el DAC funciona a una frecuencia fija de 1 MSPS.	
- **vco_caracterizacion.txt**: Curva de tuning del VCO. Se utiliza para compensar el VCO y obtener rampas lineales en frecuencia. Contiene la relacion medida entre tension y frecuencia de salida del VCO. La estructura para cada fila es la siguiente: Valor DAC [0-4096], Voltaje a la entrada del VCO [V], Frecuencia [GHz].	
