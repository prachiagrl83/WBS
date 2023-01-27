import streamlit as st

st.title('FashCam')

#st.image('./fashion.jpg')

picture = st.camera_input("Take a picture")

if picture:
    st.image(picture)
