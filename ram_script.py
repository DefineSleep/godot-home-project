import psutil



def get_total_memory():
    return psutil.virtual_memory().total / (1024 ** 3)  # Return GB

get_total_memory()