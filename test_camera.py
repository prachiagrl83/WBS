import streamlit as st
from PIL import Image

page_bg_img = """
<style>
[data-testid-"stAppViewContainer"]{
background-image: url("https://unsplash.com/photos/nimElTcTNyY.png");
background-size: cover;
}
</style>
"""

st.markdown(page_bg_img, unsafe_allow_html=True)
st.title('FashCam')

#st.image('./fashion.jpg')

picture = st.camera_input("Take a picture")

if picture:
    st.title('Top Similar products')
    col1, col2, col3 = st.columns(4)
    with col1:
    image1 = Image.open("./48313.jpg")
    new1 = image1.resize((600, 400))    
    st.image(new1)
    with col2:
    image2 = Image.open("./48318.jpg")
    new2 = image2.resize((600, 400))    
    st.image(new2)
   
    image3 = Image.open("./48319.jpg")
    new3 = image3.resize((600, 400))
    with col3:
    st.image(new3)
    
    image4 = Image.open("./48320.jpg")
    new4 = image4.resize((600, 400))
    with col4:
    st.image(new4)
