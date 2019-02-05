################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/adc.c \
../Src/command_receive.c \
../Src/comms_process.c \
../Src/config_commands.c \
../Src/config_ramp.c \
../Src/dac.c \
../Src/dma.c \
../Src/freertos.c \
../Src/gpio.c \
../Src/main.c \
../Src/main_process.c \
../Src/pga.c \
../Src/spi.c \
../Src/stm32f2xx_hal_msp.c \
../Src/stm32f2xx_it.c \
../Src/strfunc.c \
../Src/system_stm32f2xx.c \
../Src/tim.c \
../Src/usart.c \
../Src/usb_device.c \
../Src/usbd_cdc_if.c \
../Src/usbd_conf.c \
../Src/usbd_desc.c 

OBJS += \
./Src/adc.o \
./Src/command_receive.o \
./Src/comms_process.o \
./Src/config_commands.o \
./Src/config_ramp.o \
./Src/dac.o \
./Src/dma.o \
./Src/freertos.o \
./Src/gpio.o \
./Src/main.o \
./Src/main_process.o \
./Src/pga.o \
./Src/spi.o \
./Src/stm32f2xx_hal_msp.o \
./Src/stm32f2xx_it.o \
./Src/strfunc.o \
./Src/system_stm32f2xx.o \
./Src/tim.o \
./Src/usart.o \
./Src/usb_device.o \
./Src/usbd_cdc_if.o \
./Src/usbd_conf.o \
./Src/usbd_desc.o 

C_DEPS += \
./Src/adc.d \
./Src/command_receive.d \
./Src/comms_process.d \
./Src/config_commands.d \
./Src/config_ramp.d \
./Src/dac.d \
./Src/dma.d \
./Src/freertos.d \
./Src/gpio.d \
./Src/main.d \
./Src/main_process.d \
./Src/pga.d \
./Src/spi.d \
./Src/stm32f2xx_hal_msp.d \
./Src/stm32f2xx_it.d \
./Src/strfunc.d \
./Src/system_stm32f2xx.d \
./Src/tim.d \
./Src/usart.d \
./Src/usb_device.d \
./Src/usbd_cdc_if.d \
./Src/usbd_conf.d \
./Src/usbd_desc.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft '-D__weak=__attribute__((weak))' '-D__packed=__attribute__((__packed__))' -DUSE_HAL_DRIVER -DSTM32F205xx -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Inc" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Drivers/STM32F2xx_HAL_Driver/Inc" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Drivers/STM32F2xx_HAL_Driver/Inc/Legacy" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Middlewares/ST/STM32_USB_Device_Library/Core/Inc" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Drivers/CMSIS/Device/ST/STM32F2xx/Include" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Middlewares/Third_Party/FreeRTOS/Source/include" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Drivers/CMSIS/Include" -I"C:/Users/LuisAlberto/Dropbox/GMR/Practica RADAR/firmware/practica radar/Inc"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


