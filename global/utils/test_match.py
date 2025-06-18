import sys

file_name = sys.argv[1]
file_path = ""
file_exp = file_path + file_name + ".exp"
file_err = file_path + file_name + "_err.exp"
errors = 0
count = 0
err = 0

with open(file_exp, "r") as file1:
    with open(file_err, "r") as file2:
        for line1, line2 in zip(file1.readlines(), file2.readlines()):
            try:
                f_list1 = [float(i) for i in line1.split(" ") if i.strip()]
                f_list2 = [float(i) for i in line2.split(" ") if i.strip()]
                for i in range(len(f_list1)):
                    count += 1
                    if f_list1[i] != f_list2[i]:
                        errors += 1
            except ValueError:
                err = 1
                break
            except IndexError:
                err = 2
                break
if err == 0:
    print("-" + file_name + ": " + str(errors) + " errors on " + str(count) + " (" + str(round(errors / count * 100, 2)) + "%)")
elif err == 1:
    print("-" + file_name + ": ValueError")
elif err == 2:
    print("-" + file_name + ": IndexError")