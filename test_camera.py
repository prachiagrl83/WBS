import streamlit as st
from PIL import Image

st.title(':red[_FashCam_] :sunglasses:')

st.set_page_config(page_title="Image Uploader",page_icon=":camera:", layout="wide")

# Upload the image file
uploaded_file = st.file_uploader(
    "Choose an image...", type=["jpg", "jpeg", "png"])
if uploaded_file is not None:
    # Save the image to disk
    # save image using pil library
    img = Image.open(uploaded_file)
    # image.save_img(uploaded_file.name, uploaded_file)
    st.success("Image saved!")
    st.image(img, width=250, caption="Uploaded Image.")
    # Now display four more images
    row = []
    for i in range(1, 4):
        img = Image.open(f"image{i}.jpg")
        row.append(img)
    st.image(row, width=250, caption=[
             "similarity 78%", "similarity 79%", "similarity 60%"])
else:
    st.warning("Please upload an image.")

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
