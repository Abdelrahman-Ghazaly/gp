import React , {useState } from 'react'
import { MyList , AppContainer } from '../../../Styles/appbar.js';
import DrawerNav from './DrawerNav.js';
import Search from  '../Search'
import useFetch from '../../../CustomHooks/api/useFetch.js';
import ProductList from '../../UI/ProductList.js';
import {
  Container,
  AppBar,
  IconButton,
  Typography,
  Box,
} from "@mui/material";

import MenuIcon from '@mui/icons-material/Menu';
import Actions from './actions.js';
import { Link } from 'react-router-dom';

const AppBarDesktop = ({match}) => {
    const [termValue , setTermValue] = useState('')
    const [open, setOpen] = useState(false);

    const handleDrawerOpen = () => {
        setOpen(true);
    };

      const handleDrawerClose = () => {
        setOpen(false);
    };

    const {data} = useFetch(`http://localhost:8000/Products?q=${termValue !== '' ? termValue : null}`)
  
    const getTerm = (value) => {
      setTermValue(value)
    }

    const renderSearchResult = () => {
    return (
      <Box
        style={{
          borderRadius: "15px",
          backgroundColor: "#e6e6e6",
          position: "fixed",
          zIndex: "1000",
          width: "50%",
          margin: "auto 50px",
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
  }

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

          <Search getTerm={getTerm}/>

          <Actions match={match} />

          </MyList>
        </Container>
      </AppBar>
      {open ? (
        <DrawerNav open={open} handleDrawerClose={handleDrawerClose} />
      ) : null}
    </AppContainer>
    <Container>
    {renderSearchResult()}
    </Container>
</>
  );
}

export default AppBarDesktop