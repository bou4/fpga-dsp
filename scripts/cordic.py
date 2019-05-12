# Scientific computing
import numpy as np

# Convert magnitude in range [-1, 1) to 32-bit value
def binaryMagnitude(magnitude):
    return np.int32(magnitude * 2 ** 31)

# Convert phase in range [-pi, pi) to 32-bit value
def binaryPhase(phase):
    return np.int32(phase / np.pi * 2 ** 31)

# Calculate gain of CORDIC algorithm
def calculateGain(n):
    A = np.sqrt(2)

    for i in range(1, n):
        A = A * np.sqrt(1 + 2 ** (-2 * i))

    return A

# Get entry in lookup table
def lookupTable(i):
    return binaryPhase(np.arctan(2 ** -i))

# CORDIC algorithm
def cordic(x, y, z, iterations):
    current_x = x
    current_y = y
    current_z = z

    for i in range(0, iterations):
        if (current_z < 0):
            di = -1
        else:
            di = +1

        next_x = current_x - di * np.right_shift(current_y, i)
        next_y = current_y + di * np.right_shift(current_x, i)
        next_z = current_z - di * lookupTable(i)

        current_x = next_x
        current_y = next_y
        current_z = next_z

    return current_x, current_y, current_z
