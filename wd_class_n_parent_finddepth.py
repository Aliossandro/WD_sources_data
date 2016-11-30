all_hierarchies_dict_file = file("wd_class_hierarchies_DICT.txt","r").read()
all_hierarchies_dict=eval(all_hierarchies_dict_file)


def finddepth(class_id, all_hierarchies_dict):
    if class_id in all_hierarchies_dict:
        parents = all_hierarchies_dict[class_id]
        return len(parents)
    else:
        return "none"


### example usage
print finddepth("Q891793", all_hierarchies_dict)


