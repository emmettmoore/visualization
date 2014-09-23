import sys
import json

AMOUNT = 3

def main():
    order = [0, 1, 2] # TODO: programmatically defined order
    fields = ['department', 'sponsor', 'year', 'amount'] 
    first_row = True
    funds = []

    # CSV -> Python List
    with open('soe.csv', 'rb') as f:
        for row in f:
            if first_row:
                first_row = False 
                continue
            if row.split(',')[0] != '':
                fund = row.split(',')
                for i, field in enumerate(fund):
                    fund[i].rstrip()
                    if i > 1:
                        fund[i] = int(fund[i])
                funds.append(fund)

    # Python List -> SHF
    tree = {}
    for fund in funds:
        add_node(fields, fund, order, 0, tree)
    print json.dumps(tree, sort_keys=True, indent=2)

def add_node(fields, fund, order, curr_id, curr_root):
    # leaf
    if len(order) <= 0:
        if fields[AMOUNT] not in curr_root:
            curr_root[fields[AMOUNT]] = fund[AMOUNT]
        else:
            curr_root[fields[AMOUNT]] += fund[AMOUNT]
        return fund[AMOUNT]

    else:
        if fund[order[0]] not in curr_root:
            curr_root[fund[order[0]]] = {}
        added_value = add_node(fields, fund, order[1:], curr_id, curr_root[fund[order[0]]])
        if fields[AMOUNT] not in curr_root:
            curr_root[fields[AMOUNT]] = added_value
        else:
            curr_root[fields[AMOUNT]] += added_value
        return added_value



if __name__ == '__main__': main()
