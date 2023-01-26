import streamlit as st

st.markdown(   f”””   <style>
   p {
   background-image: url('fashion.jpg');
   }
   </style>   ”””,   unsafe_allow_html=True)

picture = st.camera_input("Take a picture")

if picture:
    st.image(picture)
