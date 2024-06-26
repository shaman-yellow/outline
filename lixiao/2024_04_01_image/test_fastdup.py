
import fastdup
fd = fastdup.create(input_dir = "./order_material/提供给生信组的相关资料-图片重复/")
fd.run(threshold = .3, cc_threshold = .3)
fd.vis.similarity_gallery()

import fastdup
fd = fastdup.create("workdir2", "/home/echo/disk_sda1/Downloads/C2022092003-l/C2022092003-l-细胞染色/C2022092003-l-2-2-1-TMRM细胞染色观察线粒体膜电位（MMP）的变化/")
fd.run(threshold = .95, cc_threshold = 0.95)
fd.run
fd.vis.similarity_gallery()

# tkinter test

import os
import shutil
shutil.rmtree("./workdir2")

import tkinter as tk
root = tk.Tk()
root.title("Simple GUI")

label = tk.Label(root, text="Hello, World!")
label.pack()

def on_button_click():
    label.config(text="Hello, Tkinter!")

button = tk.Button(root, text="Click Me", command=on_button_click)
button.pack()

button2 = tk.Button(root, text = "test me", command = on_button_click)
button2.pack()


# PyQt5 test
import sys
from PyQt5.QtWidgets import QApplication, QLabel, QPushButton, QVBoxLayout, QWidget

def on_button_click():
    label.setText("Hello, PyQt!")

app = QApplication(sys.argv)

window = QWidget()
window.setWindowTitle('Simple GUI')

layout = QVBoxLayout()

label = QLabel('Hello, World!')
layout.addWidget(label)

button = QPushButton('Click Me')
button.clicked.connect(on_button_click)
layout.addWidget(button)

window.setLayout(layout)
window.show()

# PyQt5 class

import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QLineEdit, QPushButton, QVBoxLayout, QWidget, QMessageBox, QFileDialog

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('PyQt5 Example')

        # Create a central widget and set it as the central widget of the main window
        central_widget = QWidget()
        self.setCentralWidget(central_widget)

        # Create a vertical layout
        layout = QVBoxLayout()

        # Create a label
        self.label = QLabel('Enter something:', self)
        layout.addWidget(self.label)

        # Create an input text box
        self.textbox = QLineEdit(self)
        layout.addWidget(self.textbox)

        # Create buttons
        self.button1 = QPushButton('Button 1', self)
        self.button1.clicked.connect(self.on_button1_click)
        layout.addWidget(self.button1)

        self.button2 = QPushButton('Button 2', self)
        self.button2.clicked.connect(self.on_button2_click)
        layout.addWidget(self.button2)

        self.button3 = QPushButton('Button 3', self)
        self.button3.clicked.connect(self.on_button3_click)
        layout.addWidget(self.button3)

        # Create a button to open the folder dialog
        self.folder_button = QPushButton('Select Folder', self)
        self.folder_button.clicked.connect(self.select_folder)
        layout.addWidget(self.folder_button)

        # Set the layout for the central widget
        central_widget.setLayout(layout)

    def on_button1_click(self):
        text = self.textbox.text()
        QMessageBox.information(self, 'Button 1', f'You entered: {text}')

    def on_button2_click(self):
        text = self.textbox.text()
        QMessageBox.information(self, 'Button 2', f'You entered: {text}')

    def on_button3_click(self):
        text = self.textbox.text()
        QMessageBox.information(self, 'Button 3', f'You entered: {text}')

    def select_folder(self):
        folder_path = QFileDialog.getExistingDirectory(self, 'Select Folder')
        if folder_path:
            self.textbox.setText(folder_path)

app = QApplication(sys.argv)
main_window = MainWindow()
main_window.show()

main_window.select_folder()
