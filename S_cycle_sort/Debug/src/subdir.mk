################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/S_cycle_sort.S 

OBJS += \
./src/S_cycle_sort.o 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler'
	as -g--gstabs  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


