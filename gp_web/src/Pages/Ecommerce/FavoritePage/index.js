import React, { useEffect } from 'react'
import {useDispatch , useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import AppBar from '../../../Components/Layout/AppBar';
import LoadingSpinner from '../../../Components/UI/Common/LoadingSpinner';
import FavoriteImage from '../../../assets/favoriteImage.png'
import { Box, Container , Button} from '@mui/material';
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { removeFromFavorites  , fetchFavList} from '../../../Store/Ecommerce/favoriteReducer';

const FavoritePage = () => {
    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));
    const dispatch = useDispatch()
    const userData = useSelector(state => state.auth)
    let tokenId = userData.userData?.accessToken

    useEffect(() => {
        dispatch(fetchFavList(tokenId))
    },[dispatch , tokenId])


    const list = useSelector(state => state.favorite.favList)
    const listLength = list.length
    const loading = useSelector(state => state.favorite.loading)

    const removeItem = (itemId) => {
      console.log(itemId)
        dispatch(removeFromFavorites(itemId))
    }

  const renderFavList = () => {
        return (
            <div style={{marginTop : '45px'}}>
                {list.map((item) => {
                    return (
                        <div key={item._id} style={{display : 'flex' , justifyContent: 'space-around' , alignItems : 'center' , marginBottom : '20px'}}>
                            <div style={{width : '30%'}}>
                                <Link to={`/product/${item._id}`}>
                                    <img style={{aspectRatio : '3/2' , objectFit : 'contain' ,  width: `${match ? "100% " : "50%"}`}} src={typeof item.imgURL == "string" ?  item.imgURL : item.imgURL[0]} alt={item.title}/>
                                </Link>
                            </div>
                                <div style={{width : '100%' , fontSize : `${match ? "13px" : "20px"}`}}>
                                    <Link to={`/product/${item._id}`}>
                                        <h2 style={{textTransform : 'capitalize'}}>{item.title}</h2>
                                        <h3>{item.price}$</h3>
                                    </Link>
                                </div>
                            <div>
                                <Button variant='contained' color="error" onClick={() => removeItem(item._id)}>Remove</Button>
                            </div>
                        </div>
                    )
                })}
            </div>
        )
    }

  return (
    <>
      <AppBar />
      <Container>
        {loading ? (
          <LoadingSpinner />
        ) : listLength >= 1 ? (
          <Box>{renderFavList()}</Box>
        ) : (
          <h2 style={{ display : 'flex' , justifyContent : 'center' , alignItems : 'center' , margin : '150px 0' }}>
            <img style={{width : '20%'}} src={FavoriteImage} alt="img"/>
          </h2>
        )}
      </Container>
    </>
  );
}

export default FavoritePage