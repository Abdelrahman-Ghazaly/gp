import { Grid, TextField } from '@mui/material';
import React , { useRef, useState, useEffect  , memo, useCallback , useMemo} from 'react'
import {AddImageButton , ImageStyle} from '../../../Styles/forms'

const UploadImage = memo(({ imageValue }) => {
  const [imageList, setImageList] = useState([]);
  const fileInputRef = useRef();

  const handleImageInput = useCallback((e) => {
    const files = e.target.files;
      const uploadedImages = Array.from(files).map((file) =>
      URL.createObjectURL(file)
    );
    setImageList(prev => [...prev , ...uploadedImages]);

  } , [])


  useEffect(() => {
    if(imageList !== []){
      imageValue(imageList)
    }
  },[imageList])

console.log("Many Rerenders In Upload Image")


  const renderLoop = useMemo(() => {
    return imageList?.map((i, index) => {
      return (
        <Grid item xs={2} sm={4} md={4} key={index}>
          <img
            src={i}
            style={ImageStyle}
            alt=""
          />
          <div style={{ textAlign: "center" }}>{index + 1}</div>
        </Grid>
      );
    });
  } , [imageList])


  return (
    <div style={{ padding: "40px 0" }}>
      <AddImageButton
        onClick={(event) => {
          event.preventDefault();
          fileInputRef.current.click();
        }}
      >
        Add Image
      </AddImageButton>
      <Grid
        container
        spacing={{ xs: 2, md: 3 }}
        columns={{ xs: 4, sm: 8, md: 12 }}
      >
        {imageList.length > 0 && renderLoop}
        <input
          hidden
          type="file"
          required
          style={{ display: "none" }}
          ref={fileInputRef}
          accept="image/*"
          onChange={(e) => {
            handleImageInput(e);
          }}
        />

      </Grid>
    </div>
  );
});

export default UploadImage;