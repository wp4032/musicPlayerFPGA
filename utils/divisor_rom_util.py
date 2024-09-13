# The provided code generates binary approximations of numbers as fractions.
# The task is to ensure that 'shift_values' for each number has exactly 4 elements.

num_bits = 16

all_vals = {}
for x in range(100):
    binary_approximation = 0
    shift_values = []
    for i in range(1, num_bits):
        # Check if adding this power of 2 keeps us below or equal to the target value
        if binary_approximation + 1 / (2 ** i) <= ((x+1.0)/100.0):
            binary_approximation += 1 / (2 ** i)
            shift_values.append(i)  # Record the shift value
    
    # Ensure 'shift_values' has exactly 4 elements
    if len(shift_values) < 8:
        shift_values.extend([0] * (8 - len(shift_values)))  # Append zeros
    elif len(shift_values) > 8:
        shift_values = shift_values[:8]  # Keep only the first 4 elements

    all_vals[(x+1.0)/100.0] = shift_values
    
with open('divisor_rom_util4.txt', 'w') as file:
    # file.write('assign memory[0] = {4\'d15, 4\'d15, 4\'d15, 4\'d15, 4\'d15, 4\'d15, 4\'d15, 4\'d15};	// Decimal = 0.0\n')
    file.write('assign memory[0] = {4\'d15, 4\'d15, 4\'d15, 4\'d15};	// Decimal = 0.0\n')

    for i, (key, shift_values) in enumerate(all_vals.items()):
        formatted_values = ', '.join([f"4'd{val}" for val in shift_values[0:4]])
        file.write(f'assign memory[{i+1}] = {{{formatted_values}}};\t\t// Decimal = 0.{i+1}\n')



# print(all_vals)