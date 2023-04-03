import { Grid, Container } from "@mui/material";
import React, { useEffect } from "react";
import ProductCard from "../../Components/UI/ProductCard";
import { useSelector , useDispatch } from "react-redux";
import AppBar from "../../Components/Layout/AppBar";
import Footer from "../../Components/Layout/Footer";
import SearchImage from '../../assets/searchImage.jpg'

const SearchResult = () => {
  const items = useSelector((state) => state.search.data);

  // useEffect(() => {
  //     dispatch(fetchDataByTitle(items))
  // } , [dispatch])

  return (
    <>
      <AppBar />
      <Container style={{marginBottom : '15px'}}>
          {items.length === 0 ? (<div style={{display : 'flex' , justifyContent : 'center' , alignItems : 'center' , flexDirection : 'column'}}>
            <img style={{width : '50%'}} src={SearchImage} alt="img"/>
          </div>) : (
            <Grid
            container
            spacing={{ xs: 2, md: 1 }}
            columns={{ xs: 12, sm: 12, md: 12 }}
            >
            {items.map((item) => {
              return (
                <Grid item xs={12} sm={6} md={4} key={item.id}>
                  <ProductCard item={item} />
                </Grid>
              );
            })}
            </Grid>
          )}
      </Container>
      <Footer />
    </>
  );
};

export default SearchResult;

