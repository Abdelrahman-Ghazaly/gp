import React , {useState } from 'react'
import { MyList , AppContainer } from '../../../Styles/appbar.js';
import DrawerNav from './DrawerNav.js';
import Search from  '../Search'
import {
  Container,
  AppBar,
  IconButton,
  Modal,
  Box,
} from "@mui/material";

import MenuIcon from '@mui/icons-material/Menu';
import Actions from './actions.js';
import { Link } from 'react-router-dom';
import Logo from '../../../assets/logo_transparent.jpg'

const AppBarDesktop = ({match}) => {
    const [open, setOpen] = useState(false);

    const handleDrawerOpen = () => {
        setOpen(true);
    };

      const handleDrawerClose = () => {
        setOpen(false);
    };

  return (
        <>
        <AppContainer sx={{marginBottom : '5rem' , position : 'relative'}}>
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
                    justifyContent: "center",
                    alignItems: "center",
                  }}
                >
                  <IconButton
                    size="large"
                    edge="start"
                    color="inherit"
                    aria-label="open drawer"
                    onClick={handleDrawerOpen}
                    sx={{ mr: 2 }}
                  >
                    <MenuIcon />
                  </IconButton>
                  {/* <Typography variant="h4" wrap="true" sx={{ padding: "12px 8px" }}>
                    Furniture
                  </Typography> */}
                  <Link to="/">
                      <h2 style={{padding: "12px 8px" , fontSize : '35px'}}>
                        Furniture
                      </h2>
                  </Link>
                  <MyList type="row">

                  <Search />

                  <Actions match={match} />

                  </MyList>
                </Container>
              </AppBar>
              {open ? (
                <DrawerNav open={open} handleDrawerClose={handleDrawerClose} />
              ) : null}
            </AppContainer>
        </>
  );
}

export default AppBarDesktop