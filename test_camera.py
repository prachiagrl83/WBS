import streamlit as st
from PIL import Image

#st.set_page_config(layout="wide")

page_bg_img = """
<style>
[data-testid-"stAppViewContainer"]{
background-image: url("https://unsplash.com/photos/nimElTcTNyY.png");
background-size: cover;
}
</style>
"""

st.markdown(page_bg_img, unsafe_allow_html=True)
 home_img = "https://th.bing.com/th/id/OIP.P_SRM8TgPRk1jWMYSkeQxQHaFR?pid=ImgDet&rs=1"
 st.image(home_img, width=800)

st.title(':red[_FashCam_] :sunglasses:')

#st.image('./fashion.jpg')

picture = st.camera_input("Take a picture")
if picture:
    st.title('Top Similar products') 
    st.balloons()
    #col1, col2, col3 = st.columns(4)
    #with col1:
    image1 = Image.open("./48313.jpg")
    new1 = image1.resize((500, 300))    
    st.image(new1)
    #with col2:
    image2 = Image.open("./48318.jpg")
    new2 = image2.resize((500, 300))    
    st.image(new2)
    #with col3:
    image3 = Image.open("./48319.jpg")
    new3 = image3.resize((500, 300))    
    st.image(new3)
    #with col4:
    image4 = Image.open("./48320.jpg")
    new4 = image4.resize((500, 300))    
    st.image(new4)
    

    
    
    
