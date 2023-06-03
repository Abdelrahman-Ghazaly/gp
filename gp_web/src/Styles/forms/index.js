import { Box , Typography  ,Button} from "@mui/material";
import { styled } from '@mui/material/styles';

export const UploadFormContainer = styled(Box)(({theme}) => ({
    // zIndex : '5000000',
    // overflow : 'auto',
    // outline : 'none',
    // position: 'absolute',
    margin : '25px auto',
    borderRadius : '15px',
    width: '50%',
    backgroundColor: 'white',
    border: '2px solid #000',
    boxShadow: 24,
    padding: '30px',
    [theme.breakpoints.down('sm')]: {
        width : '100%',
        overflow : 'auto',
        margin : '15px auto'
    }

}))

export const UploadFormTitle = styled(Typography)(({ theme }) => ({
  overflow : 'auto',
  fontSize: "30px",
  textAlign: "center",
  backgroundColor: "#54E5A2",
  borderRadius: "50px",
  padding: "8px 0px",
  width : '100%',
  [theme.breakpoints.down('sm')]: {
    fontSize : '20px',
    width : '100%',
  }
}));

// Upload Image Style

export const AddImageButton = styled(Button)(({theme}) => ({
    display : 'flex',
    flexGrow : 1,
    height : '200px',
    width : '200px',
    margin : '0 auto',
    textAlign : 'center',
    backgroundColor : 'grey',
    color : 'white',
    fontSize : '20px',
    borderRadius : '15px',
    "&:hover" : {
        backgroundColor : '#54E5A2',
        color : 'black',
    }
}))

export const ImageListCOntainer = styled(Button)(({theme}) => ({
    overflow : 'auto',
    display : 'grid',
    justifyContent : 'center',
    alignItems : 'center',
    border : '2px solid black',
    width : '100%',
    height : 'auto'
}))

export const ImageStyle = {
    position: 'relative',
    aspectRatio: '3/3',
    objectFit: 'cover',
    overflow: 'auto',
    borderRadius: '15px',
    width: '100%',
    padding: '12px',
}

export const Overlay = {
    display : 'block',
    textAlign : 'center'
};

