import os
import shutil

# 获取当前脚本所在目录，假设脚本放在dishes目录下
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

for category in os.listdir(BASE_DIR):
    category_path = os.path.join(BASE_DIR, category)
    if not os.path.isdir(category_path):
        continue
    # 遍历二级目录
    for dish in os.listdir(category_path):
        dish_path = os.path.join(category_path, dish)
        if not os.path.isdir(dish_path):
            continue
        # 查找与目录同名的md文件
        md_file = os.path.join(dish_path, f"{dish}.md")
        index_file = os.path.join(dish_path, "index.md")
        if os.path.isfile(md_file):
            # 复制为index.md，覆盖原有内容
            shutil.copyfile(md_file, index_file)
            print(f"Copied {md_file} -> {index_file}") 