# Scientific computing
import numpy as np

# Convert magnitude in range [-1, 1) to 32-bit value
def binaryMagnitude(magnitude):
    return np.int32(magnitude * 2 ** 31)

# Convert 32-bit value to magnitude in range [-1, 1)
def floatMagnitude(magnitude):
    return magnitude / 2 ** 31

# Convert phase in range [-pi, pi) to 32-bit value
def binaryPhase(phase):
    return np.int32(phase / np.pi * 2 ** 31)

# Convert 32-bit value to phase in range [-pi, pi)
def floatPhase(phase):
    return phase * np.pi / 2 ** 31

# Calculate gain of CORDIC algorithm
def calculateGain(iterations):
    A = np.sqrt(2)

    for i in range(1, iterations):
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

# Calculate cosine via CORDIC
def binaryCos(z):
    iterations = 31

    x = binaryMagnitude(1 / calculateGain(iterations))
    y = 0

    return cordic(x, y, z, iterations)[0]

# Calculate sine via CORDIC
def binarySin(z):
    iterations = 31

    x = binaryMagnitude(1 / calculateGain(iterations))
    y = 0

    return cordic(x, y, z, iterations)[1]

# Export CORDIC arctan table
f = open("scripts/data/arctan.mem", "w+")

for i in range(0, 31):
    f.write("{}\n".format(np.binary_repr(lookupTable(i), 32)))

# Print x_0
print("x_0 = 32'b{}".format(np.binary_repr(binaryMagnitude(1 / calculateGain(31)), 32)))

# Calculate phase increment for sine of 440 Hz if sampled at 48 kHz
print("delta phi = 32'b{}".format(np.binary_repr(binaryPhase(2 * np.pi * 440 / 48000), 32)))
