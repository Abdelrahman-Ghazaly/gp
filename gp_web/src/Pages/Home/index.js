import React , {useState , useEffect} from 'react'
import AppBar from '../../Components/Layout/AppBar'
import HomeBanner from './HomeBanner'
import HomeCategories from './HomeCategories';
import HomeProductsSlider from './HomeProductsSlider';
import Footer from '../../Components/Layout/Footer';

import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { Container } from '@mui/system';
// Import Icons
import ChairAltIcon from '@mui/icons-material/ChairAlt';
import KingBedIcon from '@mui/icons-material/KingBed';
import LightIcon from '@mui/icons-material/Light';
import ViewComfyAltIcon from '@mui/icons-material/ViewComfyAlt';
import TableBarIcon from '@mui/icons-material/TableBar';
import WeekendIcon from '@mui/icons-material/Weekend';
import useFetch from "../../CustomHooks/api/useFetch";

// Import Categories Thumbnail
import SofaThumbnail from '../../assets/CategoriesThumnail/Sofa.jpg'
import ChairThumbnail from '../../assets/CategoriesThumnail/Chair.png'
import LampThumbnail from '../../assets/CategoriesThumnail/Lamp.jpeg'
import TableThumbnail from '../../assets/CategoriesThumnail/Table.jpg'
import BedThumbnail from '../../assets/CategoriesThumnail/Bed.jpg'
import DresserThumbnail from '../../assets/CategoriesThumnail/Dresser.jpeg'

const CategoriesList = [
    {
      categoryName : 'Beds',
      icon : <KingBedIcon />,
      link : '/beds',
      Thumbnail : BedThumbnail
    },
    {
      categoryName : 'Chairs',
      icon : <ChairAltIcon />,
      link : '/chairs',
      Thumbnail : ChairThumbnail
    },
    {
      categoryName : 'Dressers',
      icon : <ViewComfyAltIcon />,
      link : '/dressers',
      Thumbnail : DresserThumbnail
    },
    {
      categoryName : 'Tables',
      icon : <TableBarIcon />,
      link : '/tables',
      Thumbnail : TableThumbnail
    },
    {
      categoryName : 'Sofas',
      icon : <WeekendIcon />,
      link : '/sofas',
      Thumbnail : SofaThumbnail
    },
    {
      categoryName : 'Lamps',
      icon : <LightIcon />,
      link : '/lamps',
      Thumbnail : LampThumbnail
    },
  ]

const Home = () => {
  const theme = useTheme();
  const match = useMediaQuery(theme.breakpoints.down("sm"));
  console.log("home");
  return (
    <div>
        <AppBar Categories={CategoriesList}/>
        <Container>
            <HomeBanner match={match} Categories={CategoriesList}/>
            <HomeCategories match={match} Categories={CategoriesList}/>
            <HomeProductsSlider  match={match} />
        </Container>
        <Footer match={match} />
    </div>
  )
}

export default Home