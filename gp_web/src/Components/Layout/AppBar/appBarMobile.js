import React, { useState } from "react";
import DrawerNav from "./DrawerNav.js";
import Actions from "./actions.js";
import Search from "../Search";
import { AppContainer } from "../../../Styles/appbar.js";
import { Link } from "react-router-dom";
import { Container, AppBar, IconButton } from "@mui/material";
import { Categories } from "../../../Utilities/CommonVariables/categoriesVariableList.js";
import MenuIcon from "@mui/icons-material/Menu";

const AppBarMobile = ({ match }) => {
  const [open, setOpen] = useState(false);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
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

            <Search  />

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
    </>
  );
};

export default AppBarMobile;
