 # Importing Modules
import glob
import sys
import math


class b_return_obj:

    def __init__(self, delay, area, check, visited):
        # Instance-level variable
        self.delay = delay
        self.area = area
        self.check = check
        self.visited = visited
    # Instance method

    def print(self):
        return f"{self.delay}\t{self.area}\t{self.check}"


def read_inputs(file1, file2, file3, primary_inputs, primary_outputs, internal_signals, gates, forward_gates, gate_delays, delay_constraint, DFF_input, DFF_output, no_of_gates):
    # Reading Inputs Using Python

    gates_file = glob.glob(file1)[0]
    gate_delays_file = glob.glob(file2)[0]
    delay_constraint_file = glob.glob(file3)[0]
    n = 0
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
                        n = n+1
                        gates[line_arr[2]] = {
                            'type': line_arr[0], 'inputs': line_arr[1]}
                        if (forward_gates.get(line_arr[1]) is not None):
                            element = forward_gates[line_arr[1]]
                            element.append({
                                'type': line_arr[0], 'output': line_arr[2]})
                        else:
                            forward_gates[line_arr[1]] = [{
                                'type': line_arr[0], 'output': line_arr[2]}]
                    elif (line_arr[0] == 'DFF'):
                        n = n+1
                        DFF_input.append(line_arr[1])
                        DFF_output.append(line_arr[2])
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
                        n = n+1
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

    no_of_gates.append(n)
    # Reading Gate Delays
    with open(gate_delays_file) as f:
        for line in f:
            line_arr = line.strip().split()
            if (len(line_arr) == 0 or line_arr[0] == '//'):
                continue
            else:
                gate_delays[line_arr[0]] = [{
                    'type': line_arr[1], 'delay': float(line_arr[2]), 'area': float(line_arr[3])}]

    # Reading Required Delays
    with open(delay_constraint_file) as f:
        for line in f:
            line_arr = line.strip().split()
            if (len(line_arr) == 0 or line_arr[0] == '//'):
                continue
            else:
                delay_constraint.append(float(line_arr[0]))


def process_min_gate_delays(gate_delays, min_gate_delays):
    for each in gate_delays:
        type_v = gate_delays[each][0]['type']
        delay_v = gate_delays[each][0]['delay']
        min_gate_delays[type_v] = min(min_gate_delays[type_v], delay_v)


def a(gates, gate_delays, doublegates, forward_gates, primary_outputs, primary_inputs, DFF_output, DFF_input):
    longest_delay = float('-inf')
    for node in primary_outputs:
        longest_delay = max(a_helper(node, gates, gate_delays,
                            doublegates, primary_inputs, DFF_output), longest_delay)
    for node in DFF_input:
        longest_delay = max(
            a_helper(node, gates, gate_delays, doublegates, primary_inputs, DFF_output), longest_delay)
    return longest_delay


def a_helper(node, gates, gate_delays, doublegates, primary_inputs, DFF_output):
    if (node in primary_inputs or node in DFF_output):
        return 0
    component = gates[node]
    if (component['type'] in doublegates):
        return max([a_helper(inputn, gates, gate_delays, doublegates, primary_inputs, DFF_output) for inputn in component['inputs']]) + gate_delays[component['type']]
    elif component['type'] == 'INV':
        return a_helper(component['inputs'], gates, gate_delays, doublegates, primary_inputs, DFF_output) + gate_delays[component['type']]


def b(gates, gate_delays, doublegates, forward_gates, primary_outputs, primary_inputs, DFF_output, DFF_input, gate_delays_type, delay_constraint, no_of_gates):
    min_area = 0
    visited = {}
    for node in primary_outputs:
        obj = b_helper(node, gates, gate_delays,
                       doublegates, primary_inputs, DFF_output, gate_delays_type, delay_constraint, 0, 0, visited)
        min_area += obj.area
        visited = obj.visited

    for node in DFF_input:
        obj = b_helper(node, gates, gate_delays,
                       doublegates, primary_inputs, DFF_output, gate_delays_type, delay_constraint, 0, 0, visited)
        min_area += obj.area
        visited = obj.visited
    return min_area


def b_helper(node, gates, gate_delays, doublegates, primary_inputs, DFF_output, gate_delays_type, delay_constraint, delay, area, visited):
    if (node in primary_inputs or node in DFF_output):
        if (delay <= delay_constraint[0]):
            return b_return_obj(delay, area, True, visited)
        else:
            return b_return_obj(delay, area, False, visited)
    component = gates[node]
    # final_delay
    # final_min_area
    # final_status 
    for each_val in gate_delays_type[component['type']]:
        if (component['type'] in doublegates):
            t = True
            initial_delay = delay
            intial_area = area
            if (node in visited):
                temp = [b_helper(inputn, gates, gate_delays, doublegates,
                                 primary_inputs, DFF_output, gate_delays_type, delay_constraint, initial_delay + each_val[0], intial_area + each_val[1], visited) for inputn in component['inputs']]
                for each in temp:
                    t = each.check and t
                if (t):
                    for each in temp:
                        area += each.area
                        delay += each.delay
                        visited.update(each.visited)
                    delay -= 2*each_val[0]
                    area -= 2*each_val[1]
                    delay -= 2*initial_delay
                    area -= 2*intial_area
                    d1 = visited[node][0]
                    a1 = visited[node][1]
                    d2 = each_val[0]
                    a2 = each_val[1]
                    if (a2 > a1):
                        delay = delay - d1 + d2
                        area = area - a1 + a2
                        visited[node] = [d2, a2]
         
                    # obj.visited = visited
                    # obj.area = area
                    # obj.delay = delay
                    return b_return_obj(delay, area, True, visited)
                else:
                    continue
            else:
                temp = [b_helper(inputn, gates, gate_delays, doublegates,
                                 primary_inputs, DFF_output, gate_delays_type, delay_constraint, delay + each_val[0], area + each_val[1], visited) for inputn in component['inputs']]
                for each in temp:
                    t = each.check and t
                if (t):
                    for each in temp:
                        area += each.area
                        delay += each.delay
                        visited.update(each.visited)
                    delay -= each_val[0]
                    area -= each_val[1]
                    delay -= 2*initial_delay
                    area -= 2*intial_area
                    visited[node] = [each_val[0], each_val[1]]
                    return b_return_obj(delay, area, True, visited)
                else:
                    continue
        elif component['type'] == 'INV':
            if (node in visited):
                obj = b_helper(component['inputs'], gates, gate_delays,
                               doublegates, primary_inputs, DFF_output, gate_delays_type, delay_constraint, delay + each_val[0], area + each_val[1], visited)
                if (obj.check):
                    d1 = visited[node][0]
                    a1 = visited[node][1]
                    d2 = each_val[0]
                    a2 = each_val[1]
                    af = 0
                    df = 0
                    if (a2 > a1):
                        af = a2
                        df = d2
                        delay = delay - d1 + d2
                        area = area - a1 + a2
                        visited[node] = [d2, a2]
                    
                    obj.visited = visited
                    obj.area = area
                    obj.delay = delay
                    return obj
                else:
                    continue
            else:
                obj = b_helper(component['inputs'], gates, gate_delays,
                               doublegates, primary_inputs, DFF_output, gate_delays_type, delay_constraint, delay + each_val[0], area + each_val[1], visited)
                if (obj.check):
                    visited[node] = [each_val[0], each_val[1]]
                    obj.visited = visited
                    return obj
                else:
                    continue

    return b_return_obj(delay, area, False, visited)


def main():
    # Constants
    doublegates = ['AND2', 'OR2', 'NAND2', 'NOR2']
    # Defining Storage
    primary_inputs = []
    primary_outputs = []
    internal_signals = []
    DFF_input = []
    DFF_output = []
    # --------------------------
    gates = {}
    forward_gates = {}
    gate_delays = {}
    min_gate_delays = {'INV': math.inf, 'NAND2': math.inf,
                       'NOR2': math.inf, 'OR2': math.inf, 'AND2': math.inf}
    gate_delays_type = {'INV': [], 'NAND2': [],
                        'NOR2': [], 'OR2': [], 'AND2': []}
    delay_constraint = []
    no_of_gates = []
    # --------------------------
    longest_delays_text = "longest_delays.txt"
    minimum_area_text = "minimum_area.txt"
    arg1 = sys.argv[1]
    arg2 = sys.argv[2]
    arg3 = sys.argv[3]
    arg4 = sys.argv[4]
    # arg1 = "B"
    # arg2 = "circuit.txt"
    # arg3 = "gate_delays.txt"
    # arg4 = "delay_constraint.txt"

    read_inputs(arg2, arg3, arg4, primary_inputs, primary_outputs,
                internal_signals, gates, forward_gates, gate_delays, delay_constraint, DFF_input, DFF_output, no_of_gates)
    for each in gate_delays:
        gate_delays_type[gate_delays[each][0]['type']].append(
            tuple([gate_delays[each][0]['delay'], gate_delays[each][0]['area']]))
    for each in gate_delays_type:
        gate_delays_type[each] = sorted(
            gate_delays_type[each], key=lambda x: x[1])
    process_min_gate_delays(gate_delays, min_gate_delays)
    if (arg1 == "A"):
        with open(longest_delays_text, "w") as file:
            ans = round(a(gates, min_gate_delays, doublegates,
                        forward_gates, primary_outputs, primary_inputs, DFF_output, DFF_input), 4)
            intans = int(ans)
            if (intans == ans):
                file.write(str(intans))
            else:
                file.write(str(ans))
    else:
        with open(minimum_area_text, "w") as file:
            ans = round(b(gates, gate_delays, doublegates,
                        forward_gates, primary_outputs, primary_inputs, DFF_output, DFF_input, gate_delays_type, delay_constraint,no_of_gates), 4)
            intans = int(ans)
            if (intans == ans):
                file.write(str(intans))
            else:
                file.write(str(ans))


# -----------------------------------------
main()
# -----------------------------------------