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

const ActionContainer = styled(CardActions)(() => ({
  display: "flex",
  justifyContent: "space-between",
  marginLeft : '10px'
}));

const ProductCard = ({ item }) => {

  return (
    <Card sx={{ maxWidth : '483px' , borderRadius : '15px' , border : 'none' , userSelect : 'none'}}>
      <CardMedia
        component="img"
        alt="green iguana"
        height="250px"
        image={typeof item.image == "string" ?  item.image : item.image[0]}
        sx={{objectFit : "contain" , background : '#F5F5F5'}}
      />
      <CardContent>
        <Typography gutterBottom  sx={{fontSize : '24px' , fontWeight : '700'}} component="div">
          {item.title}
        </Typography>
        <Typography variant="body1" color="text.secondary">
          {item.description}
        </Typography>
      </CardContent>
      <ActionContainer>
        <Typography variant="h5" color="#4BB4B4">
          {item.price}
        </Typography>

        <IconButton aria-label="add to favorites" sx={{"&:hover" : {color : 'red'} }} >
          <FavoriteIcon sx={{fontSize : '30px'}}/>
        </IconButton>
      </ActionContainer>
    </Card>
  );
};

export default ProductCard;
