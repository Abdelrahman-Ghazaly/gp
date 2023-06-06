import { Grid, IconButton } from '@mui/material';
import React , { useRef, useState, useEffect  , memo , useMemo} from 'react'
import {AddImageButton , ImageStyle , Overlay} from '../../../Styles/forms'
import DeleteIcon from '@mui/icons-material/Delete';
import useSendRequest from '../../../CustomHooks/api/useSendRequest'


const UploadImage = memo(({ imageValue }) => {
  const {data, statusCode , error , loading , sendRequest} = useSendRequest()

  const [image, setImage] = useState();
  const [imageList, setImageList] = useState('');
  const [imageFiles, setImageFiles] = useState();

  const fileInputRef = useRef();

  // Get The Image File From User
  const handleImageInput = async (e) => {
    let files = e.target.files;
    setImageFiles([files]);
    //await sendRequest( e.target.files[0] , "https://api.edenai.run/v2/image/object_detection" , "POST")
    let singleFile = e.target.files[0]
    if (singleFile && singleFile.type.substr(0, 5) === "image" ) {
      setImage(singleFile);
    } else {
      setImage(null);
    }
  };

  // View an IMage to The Client
  useEffect(() => {
    if (image) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageList(() => [reader.result.toString()]);
      };
      reader.readAsDataURL(image);
    }
  }, [image])

  // Send The Image To The AddProductForm Component
  useEffect(() => {
    // console.log(data)
    // console.log(statusCode)
    imageValue(imageFiles)
  },[imageFiles])



  const renderLoop = useMemo(() => {
      return (
        <Grid item xs={12} sm={4} md={6} style={{ margin: "0 auto" }}>
          <div
            style={{
              position: "relative",
              display: "inline-block",
            }}
          >
            <img src={imageList} style={ImageStyle} alt="" />

            <div style={Overlay}>
              <IconButton
                onClick={() => {
                  setImageFiles(null);
                  setImageList(null);
                }}
                aria-label="delete"
                size="large"
                color="error"
              >
                <DeleteIcon fontSize="inherit" />
              </IconButton>
            </div>
          </div>
        </Grid>
      );

  } , [imageList])


  return (
    <div style={{ padding: "25px 0"}}>
      {!imageFiles && (
        <AddImageButton
          onClick={(event) => {
            event.preventDefault();
            fileInputRef.current.click();
          }}
        >
          Add Image
        </AddImageButton>
      )}
      <Grid
        container
        spacing={{ xs: 2, md: 3 }}
        columns={{ xs: 4, sm: 8, md: 12 }}
      >
        {imageList && renderLoop}
        <input
          hidden
          type="file"
          style={{ display: "none" }}
          ref={fileInputRef}
          accept="image/jpeg , image/png , image/jpg"
          onChange={(e) => {
            handleImageInput(e);
          }}
        />
      </Grid>
    </div>
  );
});

export default UploadImage;