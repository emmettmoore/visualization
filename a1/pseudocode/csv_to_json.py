import sys
import json

AMOUNT = 3
fields = ['department', 'sponsor', 'year', 'amount'] 
curr_id = 0
print curr_id

def main():
    order = [0, 1, 2] # TODO: programmatically defined order
    first_row = True
    funds = []

    # CSV -> Python List
    with open('soe.csv', 'rb') as f:
        for row in f:
            if first_row:
                first_row = False 
                continue
            # CSV Line -> Array
            fund = row.split(',')
            for i, field in enumerate(fund):
                fund[i].rstrip()
                # str -> int (fields 2 and 3)
                if i > 1:
                    fund[i] = int(fund[i])
            funds.append(fund)

    # Python List -> SHF
    tree = {}
    leafmap = {}
    for fund in funds:
        add_node(fields, fund, order, tree)
    print json.dumps(leafmap, tree, sort_keys=True, indent=2)

def add_node(leafmap, fund, order, curr_root):
    global curr_id
    # leaf
    if len(order) <= 0:
        if 'id' not in curr_root:
            curr_root['id'] = curr_id
            curr_id += 1
        if fields[AMOUNT] not in curr_root:
            curr_root[fields[AMOUNT]] = fund[AMOUNT]
        else:
            curr_root[fields[AMOUNT]] += fund[AMOUNT]
        leafmap[str(curr_root['id'])] = curr_root[fields[AMOUNT]]
        return fund[AMOUNT]

    else:
        if 'id' not in curr_root:
            print curr_id
            curr_root['id'] = curr_id
            curr_id+= 1
        if fund[order[0]] not in curr_root:
            curr_root[fund[order[0]]] = {}
        added_value = add_node(fields, fund, order[1:], curr_root[fund[order[0]]])
        if fields[AMOUNT] not in curr_root:
            curr_root[fields[AMOUNT]] = added_value
        else:
            curr_root[fields[AMOUNT]] += added_value
        return added_value



if __name__ == '__main__': main()
