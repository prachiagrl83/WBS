import streamlit as st

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
    image1 = "./48313.jpg"
    new1 = image1.resize(600, 400)
    st.image(new1)
    #st.image("./48318.jpg")
    #st.image("./48319.jpg")
    #st.image("./48320.jpg")
