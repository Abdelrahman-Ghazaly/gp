import React, { useState } from "react";
import DrawerNav from "./DrawerNav.js";
import Actions from "./actions.js";
import Search from "../Search";
import useFetch from "../../../CustomHooks/api/useFetch.js";
import ProductList from "../../UI/ProductList.js";
import { AppContainer } from "../../../Styles/appbar.js";

import { Container, AppBar, IconButton, Typography, Box } from "@mui/material";

import MenuIcon from "@mui/icons-material/Menu";

// Import Icons
import ChairAltIcon from '@mui/icons-material/ChairAlt';
import KingBedIcon from '@mui/icons-material/KingBed';
import LightIcon from '@mui/icons-material/Light';
import ViewComfyAltIcon from '@mui/icons-material/ViewComfyAlt';
import TableBarIcon from '@mui/icons-material/TableBar';
import WeekendIcon from '@mui/icons-material/Weekend';

// Import Categories Thumbnail
import SofaThumbnail from '../../../assets/CategoriesThumnail/Sofa.jpg'
import ChairThumbnail from '../../../assets/CategoriesThumnail/Chair.png'
import LampThumbnail from '../../../assets/CategoriesThumnail/Lamp.jpeg'
import TableThumbnail from '../../../assets/CategoriesThumnail/Table.jpg'
import BedThumbnail from '../../../assets/CategoriesThumnail/Bed.jpg'
import DresserThumbnail from '../../../assets/CategoriesThumnail/Dresser.jpeg'
import { Link } from "react-router-dom";

const Categories = [
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

const AppBarMobile = ({ match }) => {
  const [termValue, setTermValue] = useState("");
  const [open, setOpen] = useState(false);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  const { data } = useFetch(
    `http://localhost:8000/Products?q=${termValue !== "" ? termValue : null}`
  );

  const getTerm = (value) => {
    setTermValue(value);
  };

  const renderSearchResult = () => {
    return (
      <Box
        style={{
          borderRadius: "15px",
          backgroundColor : '#e6e6e6',
          position: "fixed",
          zIndex: "1000",
          width: "100%",
          margin: "auto",
        }}
      >
        {data.map((res) => {
          return (
            <div key={res.id} style={{ padding: "5px" }}>
              <ProductList item={res} />
            </div>
          );
        })}
      </Box>
    );
  };

  return (
    <>
      <AppContainer sx={{ marginBottom: "4rem" }}>
        <AppBar
          position="fixed"
          sx={{
            backgroundColor: "#F7F8F8",
            boxShadow: "5px 1px",
            color: "black",
          }}
        >
          <Container
            sx={{
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <IconButton
              size="large"
              edge="start"
              color="inherit"
              aria-label="open drawer"
              onClick={handleDrawerOpen}
              sx={{ mr: 0 }}
            >
              <MenuIcon />
            </IconButton>
            {/* <Typography variant="h5" wrap="true" sx={{ padding: "12px 8px" }}>
              Furniture
            </Typography> */}
            <Link to="/">
            <h2
              style={{
                padding: "12px 8px",
                fontSize: "22px",
                flexWrap: "true",
              }}
            >
              Furniture
            </h2>
            </Link>

            <Search getTerm={getTerm} />
          </Container>
        </AppBar>

        {open ? (
          <DrawerNav
            open={open}
            handleDrawerClose={handleDrawerClose}
            Categories={Categories}
          />
        ) : null}
      </AppContainer>
      <Actions match={match} />
      {renderSearchResult()}
    </>
  );
};

export default AppBarMobile;
