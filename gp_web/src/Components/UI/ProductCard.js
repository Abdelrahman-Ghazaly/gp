import {
  Card,
  CardActions,
  CardContent,
  CardMedia,
  Typography,
  IconButton,
  Alert,
  Stack,
  Fade,
  AlertTitle,
} from "@mui/material";
import FavoriteIcon from "@mui/icons-material/Favorite";
import { styled } from "@mui/material/styles";
import React , {useState } from "react";
import {Link} from 'react-router-dom'
import { useDispatch , useSelector} from "react-redux";
import { addToFavorites } from "../../Store/favoriteReducer";

const ActionContainer = styled(CardActions)(() => ({
  display: "flex",
  justifyContent: "space-between",
  marginLeft : '10px'
}));

const ProductCard = ({ item }) => {
  const [show , setIsShow] = useState(false)
  const dispatch = useDispatch();
  const {userData} = useSelector(state => state.auth)
  
  const AddProduct = (itemId) => {
     dispatch(
       addToFavorites(itemId)
     );
  }

  const rednerToast = () => {
    return (
      <Fade
        in={show}
        timeout={{ enter: 1000, exit: 1000 }}
        addEndListener={() => {
          setTimeout(() => {
            setIsShow(false);
          }, 4000);
        }}
      >
        <Alert severity="warning" variant="standard" className="alert">
          <AlertTitle>Warning</AlertTitle>
          Please login first to add item to favorite
        </Alert>
      </Fade>
    );
  }


  return (
    <Card sx={{ maxWidth : '483px' , borderRadius : '15px' , border : 'none' , userSelect : 'none'}}>
       <Link to={`/product/${item._id}`}>
      <CardMedia
        component="img"
        alt="green iguana"
        height="250px"
        image={typeof item.imgURL == "string" ?  item.imgURL : item.imgURL[0]}
        sx={{objectFit : "contain" , background : '#F5F5F5'}}
      />
      </Link>
      <CardContent>
      <Link to={`/product/${item._id}`}>
        <Typography gutterBottom  sx={{fontSize : '24px' , fontWeight : '700'}} component="div">
          {item.title}
        </Typography>
        </Link>
        <Typography variant="body1" color="text.secondary">
          {item.description}
        </Typography>
      </CardContent>
      <ActionContainer>
        <Typography variant="h5" color="#4BB4B4" style={{fontWeight : 'bold'}}>
          {item.price.$numberDecimal || item.price}$
        </Typography>

        <IconButton aria-label="add to favorites" sx={{"&:hover" : {color : 'red'} }} onClick={userData ? () => AddProduct(item._id) : () => setIsShow(true)}>
          <FavoriteIcon sx={{fontSize : '30px'}}/>
        </IconButton>
      </ActionContainer>
      {show && rednerToast()}
    </Card>
  );
};

export default ProductCard;
