import React , {useState , useEffect} from 'react'
import AppBar from '../../Components/Layout/AppBar'
import HomeBanner from './HomeBanner'
import HomeCategories from './HomeCategories';
import HomeProductsSlider from './HomeProductsSlider';
import Footer from '../../Components/Layout/Footer';
import { Categories } from '../../Utilities/CommonVariables/categoriesVariableList';
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { Container } from '@mui/system';


const Home = () => {
  const theme = useTheme();
  const match = useMediaQuery(theme.breakpoints.down("sm"));
  console.log("home");

  return (
    <div>
        <AppBar Categories={Categories}/>
        <Container>
            <HomeBanner match={match} Categories={Categories}/>
            <HomeCategories match={match} Categories={Categories}/>
            <HomeProductsSlider  match={match} />
        </Container>
        <Footer match={match} />
    </div>
  )
}

export default Home