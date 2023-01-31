import streamlit as st
from PIL import Image
import tensorflow as tf
import time
from PIL import Image, ImageOps
import numpy as np
import webbrowser

st.set_page_config(page_title="Image Recommendation System",layout="wide")

col1,mid,col2 = st.columns([1,15,100])
with col1:
    st.image('Fashion_Camera2.jpg', width=150)
with col2:
    #st.write('A Name')
    st.markdown('<h1 style="color: red;font-size: 70px;">FashCam</h1>',
                            unsafe_allow_html=True)
    st.markdown('<h1 style="color: black;font-size: 30px;">...an Image Search Engine</h1>',
                            unsafe_allow_html=True)
    
    st.markdown("Our idea is to build a new search engine **:red[_FashCam_]**:camera:. We know that online shopping can be frustrating, especially when you're trying to find fashion products that are similar to ones you've seen in real life. That's why we have developed a cutting-edge image recognition technology that makes it easy to find the fashion you want.") 
    st.markdown("With **:red[_FashCam_]**:camera:, you can simply take a picture of an item or upload an image and our algorithm will match it with similar products available for purchase online. It's that simple!")
st.sidebar.write("## Upload or Take a Picture")


# Upload the image file
uploaded_file = st.sidebar.file_uploader(
    "1.Choose an image from your computer", type=["jpg", "jpeg", "png"])
if uploaded_file is not None:
    # Save the image to disk
    # save image using pil library
    img = Image.open(uploaded_file)
    # image.save_img(uploaded_file.name, uploaded_file)
    #st.sidebar.success("Image saved!")
    st.image(img, width=250, caption="Uploaded Image.")
    st.title('Top Similar products:camera:')
    
    def App():
    
    @st.cache(allow_output_mutation=True)
    def load_model():
        model=tf.keras.models.load_model("./model_fashion.h5")
        return model

    with st.spinner('Please wait, while the model is being loaded..'):
      model=load_model()

    def main():
      st.header(":red[Prediction_]")
    
    if __name__ == '__main__':
      main()

    file = st.file_uploader(" ", accept_multiple_files=False, help="Only one file at a time. The image should be of good quality")

    if file is None:
      st.subheader("Please upload a product image using the browse button :point_up:")
      st.write("Sample images can be found [here](https://github.com/prachiagrl83/WBS/tree/Prachi/Sample_images) !")
      #image1 = Image.open('./web_img/compared.JPG')
      #st.image(image1, use_column_width=True)
    
    else:
      st.subheader("Thank you for uploading the image. Below you see image which you have just uploaded!")
      st.subheader("Scroll down to see the prediction results...")  
      with st.spinner('Processing your image now.......'):

        path = file

        img = tf.keras.utils.load_img(
        path, target_size=(180, 180)
        )

        st.image(img, use_column_width=True)

        img_array = tf.keras.utils.img_to_array(img)
        img_array = tf.expand_dims(img_array, 0) # Create a batch

        predictions = model.predict(img_array)
        score = tf.sigmoid(predictions)

        time.sleep(2)
        st.success('Prediction complete!')
        st.subheader(
        f"This product image most likely belongs to...!"
        )

picture = st.sidebar.camera_input("2.Take a picture")
if picture is not None:
    #img = Image.open(picture)
    #st.sidebar.success("Image saved!")
    st.image(picture, width=250, caption="Picture Taken.")
    st.title('Top Similar products:camera:')    
    # Now display four more images
    row = []
    for i in range(1, 4):
        img = Image.open(f"pic{i}.jpg")
        row.append(img)
    st.image(row, width=250, caption=[
             "similarity 90%", "similarity 89%", "similarity 88%"])
else:
    st.sidebar.warning("Please take a picture.")
