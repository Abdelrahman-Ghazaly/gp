import {
  Card,
  CardActions,
  CardContent,
  CardMedia,
  Typography,
  IconButton,
} from "@mui/material";
import FavoriteIcon from "@mui/icons-material/Favorite";
import { styled } from "@mui/material/styles";
import React from "react";
import {Link} from 'react-router-dom'
import { useDispatch } from "react-redux";
import { addToFavorites } from "../../Store/favoriteReducer";

const ActionContainer = styled(CardActions)(() => ({
  display: "flex",
  justifyContent: "space-between",
  marginLeft : '10px'
}));

const ProductCard = ({ item }) => {
  const dispatch = useDispatch();

  const AddProduct = (itemId) => {
     dispatch(
       addToFavorites(itemId)
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
        <Typography variant="h5" color="#4BB4B4">
          {item.price.$numberDecimal}
        </Typography>

        <IconButton aria-label="add to favorites" sx={{"&:hover" : {color : 'red'} }} onClick={() => AddProduct(item._id)}>
          <FavoriteIcon sx={{fontSize : '30px'}}/>
        </IconButton>
      </ActionContainer>
    </Card>
  );
};

export default ProductCard;
