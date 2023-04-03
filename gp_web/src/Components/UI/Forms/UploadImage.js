import { Grid } from '@mui/material';
import React , { useRef, useState, useEffect  , memo, useCallback , useMemo} from 'react'
import {AddImageButton , ImageStyle} from '../../../Styles/forms'

const UploadImage = memo(({ imageValue }) => {
  const [image, setImage] = useState();
  const [imageList, setImageList] = useState([]);
  const fileInputRef = useRef();

  const handleImageInput = (e) => {
    const file = e.target.files[0];
    if (file && file.type.substr(0, 5) === "image" ) {
      setImage(file);
    } else {
      setImage(null);
    }
  };

  useEffect(() => {
    if (image) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageList(() => [...imageList, reader.result.toString()]);
      };
      reader.readAsDataURL(image);
    }
  }, [image]);

  useEffect(() => {
    imageValue(imageList)
  },[imageList])

console.log(imageList);

console.log("Many Rerenders In Upload Image")


  const renderLoop = useMemo(() => {
    return imageList?.map((i, index) => {
      return (
        <Grid item xs={2} sm={4} md={4} key={index}>
          <img
            src={i}
            style={ImageStyle}
            onClick={() => {
              setImage(null);
            }}
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