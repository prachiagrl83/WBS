import streamlit as st
from PIL import Image

st.set_page_config(page_title="Image Uploader",page_icon=":camera:")

col1,mid,col2 = st.columns([1,20,100])
with col1:
    st.image('Fashion_Camera1.jpg', width=180)
with col2:
    #st.write('A Name')
    st.markdown('<h1 style="color: red;font-size: 100px;">FashCam</h1>',
                            unsafe_allow_html=True)



# Upload the image file
uploaded_file = st.file_uploader(
    "1.Choose an image from your computer", type=["jpg", "jpeg", "png"])
if uploaded_file is not None:
    # Save the image to disk
    # save image using pil library
    img = Image.open(uploaded_file)
    # image.save_img(uploaded_file.name, uploaded_file)
    st.success("Image saved!")
    st.image(img, width=250, caption="Uploaded Image.")
    st.title('Top Similar products')
    # Now display four more images
    row = []
    for i in range(1, 4):
        img = Image.open(f"image{i}.jpg")
        row.append(img)
    st.image(row, width=250, caption=[
             "similarity 78%", "similarity 79%", "similarity 60%"])
else:
    st.warning("Please upload an image.")

picture = st.camera_input("2.Take a picture")
if picture is not None:
    #img = Image.open(picture)
    st.success("Image saved!")
    st.image(picture, width=250, caption="Picture Taken.")
    st.title('Top Similar products')    
    # Now display four more images
    row = []
    for i in range(1, 4):
        img = Image.open(f"pic{i}.jpg")
        row.append(img)
    st.image(row, width=250, caption=[
             "similarity 90%", "similarity 89%", "similarity 88%"])
else:
    st.warning("Please take a picture.")
