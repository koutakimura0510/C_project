################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/sound/dtm.c 

OBJS += \
./src/sound/dtm.o 

C_DEPS += \
./src/sound/dtm.d 


# Each subdirectory must supply rules for building sources it contributes
src/sound/%.o: ../src/sound/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/Barrage_Platform/export/Barrage_Platform/sw/Barrage_Platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


