################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/system/hardware/fpga/mapchip.c \
../src/system/hardware/fpga/vdma.c 

OBJS += \
./src/system/hardware/fpga/mapchip.o \
./src/system/hardware/fpga/vdma.o 

C_DEPS += \
./src/system/hardware/fpga/mapchip.d \
./src/system/hardware/fpga/vdma.d 


# Each subdirectory must supply rules for building sources it contributes
src/system/hardware/fpga/%.o: ../src/system/hardware/fpga/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/RpgPlatform/export/RpgPlatform/sw/RpgPlatform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

