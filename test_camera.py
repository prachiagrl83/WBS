import streamlit as st

from camera_input_live import camera_input_live

def camera_input_live(
    debounce: int = 1000,
    height: int = 530,
    width: int = 704,
    key: Optional[str] = None,
    show_controls: bool = True,
    start_label: str = "Start capturing",
    stop_label: str = "Pause capturing")

image = camera_input_live()

st.image(value)
