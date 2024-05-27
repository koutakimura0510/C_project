# -*- coding: utf-8 -*-
import os

def remove_spaces_and_brackets(folder_path):
    # �t�H���_���̃t�@�C���𑖍�����
    for filename in os.listdir(folder_path):
        # �t�@�C���̃t���p�X���쐬
        full_path = os.path.join(folder_path, filename)
        
        # �V�����t�@�C�������쐬����
        new_filename = filename.replace(' ', '').replace('(', '').replace(')', '')
        
        # �Â��t�@�C�����ƐV�����t�@�C�������قȂ�ꍇ�ɂ̂ݕύX����
        if new_filename != filename:
            try:
                # �t�@�C������ύX����
                os.rename(full_path, os.path.join(folder_path, new_filename))
                print(f"{filename} �� {new_filename} �ɕύX���܂����B")
            except Exception as e:
                print(f"�G���[���������܂���: {e}")

if __name__ == "__main__":
	folder_path = "D:/Game/Character/minoriko/PNG/"
	remove_spaces_and_brackets(folder_path)