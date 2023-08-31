# Importing Modules
import glob
import sys

# Defining Dictionaries
gate_delays = {}
primary_inputs = []
primary_outputs = []
internal_signals = []
gates = {}
forward_gates = {}
required_delays = {}
doublegates = ['AND2', 'OR2', 'NAND2', 'NOR2']


def read_inputs(file1, file2, file3):
    # Reading
    # Inputs
    # Using
    # Python
    
    gates_file = glob.glob(file1)[0]
    gate_delays_file = glob.glob(file2)[0]
    required_delays_file = glob.glob(file3)[0]

    # Reading Gates
    with open(gates_file) as f:
        for line in f:
            line_arr = line.strip().split()
            if (len(line_arr) == 0 or line_arr[0] == '//'):
                continue
            else:
                if (line_arr[0] == 'PRIMARY_INPUTS'):
                    for i in range(1, len(line_arr)):
                        primary_inputs.append(line_arr[i])
                elif (line_arr[0] == 'PRIMARY_OUTPUTS'):
                    for i in range(1, len(line_arr)):
                        primary_outputs.append(line_arr[i])
                elif (line_arr[0] == 'INTERNAL_SIGNALS'):
                    for i in range(1, len(line_arr)):
                        internal_signals.append(line_arr[i])
                else:
                    if (line_arr[0] == 'INV'):
                        gates[line_arr[2]] = {
                            'type': line_arr[0], 'inputs': line_arr[1]}
                        if (forward_gates.get(line_arr[1]) is not None):
                            element = forward_gates[line_arr[1]]
                            element.append({
                                'type': line_arr[0], 'output': line_arr[2]})
                        else:
                            forward_gates[line_arr[1]] = [{
                                'type': line_arr[0], 'output': line_arr[2]}]
                    else:
                        gates[line_arr[3]] = {
                            'type': line_arr[0], 'inputs': line_arr[1:len(line_arr)-1]}
                        for each in line_arr[1:len(line_arr)-1]:
                            if (forward_gates.get(each) is not None):
                                element = forward_gates[each]
                                element.append({
                                    'type': line_arr[0], 'output': line_arr[len(line_arr)-1]})
                                forward_gates[each] = element
                            else:
                                forward_gates[each] = [{
                                    'type': line_arr[0], 'output': line_arr[len(line_arr)-1]}]

    # Reading Gate Delays
    with open(gate_delays_file) as f:
        for line in f:
            line_arr = line.strip().split()
            if (len(line_arr) == 0 or line_arr[0] == '//'):
                continue
            else:
                gate_delays[line_arr[0]] = float(line_arr[1])

    # Reading Required Delays
    with open(required_delays_file) as f:
        for line in f:
            line_arr = line.strip().split()
            if (len(line_arr) == 0 or line_arr[0] == '//'):
                continue
            else:
                required_delays[line_arr[0]] = float(line_arr[1])


def a(node, gates, doublegates):
    if node in primary_inputs:
        return 0
    component = gates[node]
    if (component['type'] in doublegates):
        return max([a(inputn, gates, doublegates) for inputn in component['inputs']]) + gate_delays[component['type']]
    elif component['type'] == 'INV':
        return a(component['inputs'], gates, doublegates) + gate_delays[component['type']]


def b(node, gates, doublegates):
    if node in primary_outputs:
        return required_delays[node]
    component = forward_gates[node]
    k = float('inf')
    temp = []
    for each in component:

        if (each['type'] in doublegates):
            k = b(each['output'], forward_gates, doublegates)
            k = k - gate_delays[each['type']]
            temp.append(k)
        elif each['type'] == 'INV':
            k = b(each['output'], forward_gates, doublegates)
            t = each['type']
            k = k - gate_delays[t]
            temp.append(k)
    k = min(temp)
    return k


def main(gate_delays,
         primary_inputs,
         primary_outputs,
         internal_signals,
         gates,
         required_delays, doublegates):
    output_delays_text = "output_delays.txt"
    input_delays_text = "input_delays.txt"
    args = sys.argv

    read_inputs(args[2], args[3], args[4])
    inputc = args[1]

    if (inputc == "A"):
        with open(output_delays_text, "w") as file:
            for each in primary_outputs:
                ans = a(each, gates, doublegates)
                ans = round(ans,2)
                intans = int(ans)
                if (intans == ans):
                    file.write(each+" "+str(intans))
                    if(each != primary_outputs[len(primary_outputs)-1]):
                        file.write("\n")
                else:
                    file.write(each+" "+str(ans))
                    if(each != primary_outputs[len(primary_outputs)-1]):
                        file.write("\n")
                 
    else:
        with open(input_delays_text, "w") as file:
            for each in primary_inputs:
                ans = b(each, gates, doublegates)
                ans = round(ans,2)
                intans = int(ans)
                if (intans == ans):
                    file.write(each + " " + str(intans))
                    if(each != primary_inputs[len(primary_inputs)-1]):
                        file.write("\n")
                else:
                    file.write(each + " " + str(ans))
                    if(each != primary_inputs[len(primary_inputs)-1]):
                        file.write("\n")
    gate_delays = {}
    primary_inputs = []
    primary_outputs = []
    internal_signals = []
    gates = {}
    forward_gates = {}
    required_delays = {}


main(gate_delays,
     primary_inputs,
     primary_outputs,
     internal_signals,
     gates,
     required_delays,
     doublegates)
