import streamlit as st

page_by_img = """
<style>
[data-testid-"st.AppViewContainer"]{
background-image: url("https://unsplash.com/photos/nimElTcTNyY):
background-size: cover;
}
</style>
"""

st.markdown(page_bg_img,unsafe_allow_html=True)
st.title('FashCam')

#st.image('./fashion.jpg')

picture = st.camera_input("Take a picture")

if picture:
    st.image(picture)
