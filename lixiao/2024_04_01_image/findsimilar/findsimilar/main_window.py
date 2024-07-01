import sys
import io
import os
import re
import webbrowser
import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import fastdup
from ttkthemes import ThemedTk

class App(ThemedTk):
    def __init__(self):
        # 'breeze', 'clam', 'radiance'
        super().__init__(theme="breeze")

        self.title("Findsimilar")
        self.geometry("800x800")

        self.label_wd_hint = ttk.Label(self, text="Enter searching path:")
        self.label_wd_hint.pack(pady=5)

        self.textbox_wd = ttk.Entry(self)
        self.textbox_wd.pack(fill="x", padx=10, pady=5)
        self.textbox_wd.bind("<KeyRelease>", self.check_path)

        self.select_wd_button = ttk.Button(self, text="Select searching directory", command=self.select_wd)
        self.select_wd_button.pack(pady=5)

        self.textbox_output = ttk.Entry(self)
        self.textbox_output.pack(fill="x", padx=10, pady=5)
        self.textbox_output.bind("<KeyRelease>", self.check_path)

        self.select_output_button = ttk.Button(self, text="Select output directory", command=self.select_output)
        self.select_output_button.pack(pady=5)

        self.run_button = ttk.Button(self, text="Run", command=self.run)
        self.run_button.pack(pady=10)
        self.run_button["state"] = "disabled"

        self.create_gallery_buttons()

        self.help_button = ttk.Button(self, text="Help", command=self.show_help)
        self.help_button.pack(pady=10)

        self.params_frame = ttk.LabelFrame(self, text="Parameters")
        self.params_frame.pack(fill="x", padx=10, pady=10)

        self.parameters = {
            "threshold (float)": 0.95,
            "cc_threshold (float)": 0.9,
            "distance (str)": "cosine",
            "high_accuracy (boolean)": "False",
            "nearest_neighbors_k (int)": 2,
        }
        self.param_inputs = {}
        for param, default in self.parameters.items():
            row = ttk.Frame(self.params_frame)
            label = ttk.Label(row, text=param)
            entry = ttk.Entry(row)
            entry.insert(0, str(default))
            row.pack(fill="x", padx=5, pady=5)
            label.pack(side="left", padx=5)
            entry.pack(side="right", fill="x", expand=True)
            self.param_inputs[param] = entry

        self.dialog = tk.Text(self, state="disabled", height=15, wrap="word")
        self.dialog.pack(fill="both", padx=10, pady=10, expand=True)

        self.clear_button = ttk.Button(self, text="Remove output", command=self.delete_output_files)
        self.clear_button.pack(pady=10)
        self.clear_button["state"] = "disabled"

        self.write_to_dialog("Usage:")
        self.write_to_dialog("Step 1: Select directory for searching.")
        self.write_to_dialog("Step 2: Select directory for output.")
        self.write_to_dialog("Step 3: Click 'Run'")
        self.write_to_dialog("Step 4: Click 'Similarity Gallery' show report in web browser.")
        self.write_to_dialog("...")
        self.write_to_dialog("")
        self.write_to_dialog("Note:")
        self.write_to_dialog("Minimum required images: 10")
        self.write_to_dialog("Supports: .png, .jpg, .jpeg, .gif, .giff, .tif, .tiff, .heic, .heif, .bmp, .webp, .jfif")
        self.fd = None
        self.galleries = {}

    def create_gallery_buttons(self):
        self.gallery_frame = ttk.Frame(self)
        self.gallery_frame.pack(pady=10)
        self.similarity_button = ttk.Button(self.gallery_frame, text="Similarity Gallery",
                                            command = lambda: self.show_gallery("similarity_gallery"),
                                            state="disabled")
        self.similarity_button.pack(side="left", padx=5)
        self.duplicates_button = ttk.Button(self.gallery_frame, text="Duplicates Gallery",
                                            command = lambda: self.show_gallery("duplicates_gallery"),
                                            state="disabled")
        self.duplicates_button.pack(side="left", padx=5)
        self.component_button = ttk.Button(self.gallery_frame, text="Component Gallery",
                                           command = lambda: self.show_gallery("component_gallery"),
                                           state="disabled")
        self.component_button.pack(side="left", padx=5)
        self.stats_button = ttk.Button(self.gallery_frame, text="Stats Gallery",
                                       command = lambda: self.show_gallery("stats_gallery"),
                                       state="disabled")
        self.stats_button.pack(side="left", padx=5)

    def write_to_dialog(self, text):
        self.dialog["state"] = "normal"
        self.dialog.insert("end", text + "\n")
        self.dialog["state"] = "disabled"
        self.dialog.see("end")

    def select_wd(self):
        folder_path = filedialog.askdirectory()
        if folder_path:
            self.textbox_wd.delete(0, tk.END)
            self.textbox_wd.insert(0, folder_path)
            self.check_path()

    def run(self):
        self.write_to_dialog("")
        self.write_to_dialog("Module fastdup is running, please wait...")
        self.fd = fastdup.create(self.textbox_output.get(), self.textbox_wd.get())
        params = {}
        for param, input_widget in self.param_inputs.items():
            value = input_widget.get()
            clean_param = re.sub(r"\s*\(.*?\)", "", param).strip()
            self.write_to_dialog(f"{param}: {value}")
            if "(int)" in param:
                params[clean_param] = int(value)
            elif "(float)" in param:
                params[clean_param] = float(value)
            elif "(boolean)" in param:
                params[clean_param] = str_to_bool(value)
            else:
                params[clean_param] = value
        try:
            self.fd.run(**params)
        except Exception as e:
            messagebox.showwarning("Error", f"Failed to delete files: {e}")

        self.similarity_button["state"] = "normal"
        self.duplicates_button["state"] = "normal"
        self.component_button["state"] = "normal"
        self.stats_button["state"] = "normal"

        self.clear_button["state"] = "normal"
        self.write_to_dialog("Running successfully!")

    def check_path(self, event=None):
        path_wd = self.textbox_wd.get()
        path_output = self.textbox_output.get()
        if path_wd and path_output and os.path.isdir(path_wd) and os.path.isdir(path_output):
            self.run_button["state"] = "normal"
        else:
            self.run_button["state"] = "disabled"

    def select_output(self):
        folder_path = filedialog.askdirectory()
        if folder_path:
            self.textbox_output.delete(0, tk.END)
            self.textbox_output.insert(0, folder_path)
            self.check_path()

    def delete_output_files(self):
        if messagebox.askyesno("Message", "Are you sure to delete all files in this folder?"):
            folder_path = self.textbox_output.get()
            try:
                for filename in os.listdir(folder_path):
                    file_path = os.path.join(folder_path, filename)
                    if os.path.isfile(file_path):
                        os.remove(file_path)
                    elif os.path.isdir(file_path):
                        for root, dirs, files in os.walk(file_path, topdown=False):
                            for name in files:
                                os.remove(os.path.join(root, name))
                            for name in dirs:
                                os.rmdir(os.path.join(root, name))
                        os.rmdir(file_path)
                messagebox.showinfo("Success", "All files deleted successfully.")
            except Exception as e:
                messagebox.showwarning("Error", f"Failed to delete files: {e}")

    def show_gallery(self, name):
        if name in self.galleries:
            abs_path = self.galleries[name]
            webbrowser.open(f'file://{abs_path}')
        elif self.fd:
            getattr(self.fd.vis, name)()
            prefix = re.sub("_gallery", "", name)
            self.galleries[name] = os.path.join(self.textbox_output.get(), "galleries", f"{prefix}.html")
            self.write_to_dialog("")
            self.write_to_dialog(name + ": " + self.galleries[name])
            webbrowser.open(f'file://{self.galleries[name]}')

    def show_help(self):
        old_stdout = sys.stdout
        sys.stdout = mystdout = io.StringIO()
        help(fastdup.run)
        sys.stdout = old_stdout
        help_text = mystdout.getvalue()

        help_window = tk.Toplevel(self)
        help_window.title("Help")
        text_widget = tk.Text(help_window, wrap="word")
        text_widget.insert("1.0", help_text)
        text_widget.pack(fill="both", expand=True)
        scroll = tk.Scrollbar(help_window, command=text_widget.yview)
        scroll.pack(side="right", fill="y")
        text_widget.config(yscrollcommand=scroll.set)

def str_to_bool(s):
    if s == "True":
        return True
    elif s == "False":
        return False
    else:
        raise ValueError("Invalid literal for boolean: {}".format(s))


