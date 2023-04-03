import { ListItemButton, ListItemIcon, Divider, Container, Badge } from "@mui/material";
import React , {useState} from "react";
import { Link, useNavigate } from "react-router-dom";
import {
  ActionIconsContainerMobile,
  ActionIconsContainerDesktop,
  SellButton,
  MyList,
} from "../../../Styles/appbar.js";
import AccountCircle from "@mui/icons-material/AccountCircle";
import FavoriteIcon from "@mui/icons-material/Favorite";
import AddIcon from "@mui/icons-material/Add";
import { useSelector } from "react-redux";

const Actions = ({ match }) => {
  const navigate = useNavigate();
  const favList = useSelector(state => state.favorite.favList)
  const favLength = favList.length

  const Component = match
    ? ActionIconsContainerMobile
    : ActionIconsContainerDesktop;

  return (
    <Component>
      <MyList type="row">
        {match ? (
          <>
            <ListItemButton
                onClick={() => navigate("/favorite")}
              sx={{
                justifyContent: "center",
              }}
            >
              <ListItemIcon
                sx={{
                  display: "flex",
                  justifyContent: "center",
                  color: "inherit",
                }}

              >
               <Badge badgeContent={favLength} color="error">
                <FavoriteIcon />
               </Badge>
              </ListItemIcon>
            </ListItemButton>

            <Divider orientation="vertical" flexItem />

            <Link to="/upload">
            <ListItemIcon
              sx={{
                display: "flex",
                justifyContent: "center",
                userSelect: "none",
                marginLeft: "9px",
              }}
            >
              <SellButton>
                <AddIcon /> SELL
              </SellButton>
            </ListItemIcon>
            </Link>
          </>
        ) : (
          <>
          <Link to="/upload">
          <ListItemIcon
              sx={{
                display: "flex",
                justifyContent: "center",
              }}
            >
              <SellButton>
                <AddIcon /> SELL

              </SellButton>
            </ListItemIcon>
          </Link>

            <Divider orientation="vertical" flexItem />

            <ListItemButton
                onClick={() => navigate("/favorite")}
              sx={{
                justifyContent: "center",
              }}
            >
              <ListItemIcon
                sx={{
                  display: "flex",
                  justifyContent: "center",
                  color: "black",
                }}
              >
               <Badge badgeContent={favLength} color="error">
                <FavoriteIcon />
                </Badge>
              </ListItemIcon>
            </ListItemButton>
          </>
        )}

        <Divider orientation="vertical" flexItem />

        <ListItemButton
          onClick={() => navigate("/auth/login")}
          sx={{
            justifyContent: "center",
          }}
        >
          <ListItemIcon
            sx={{
              display: "flex",
              justifyContent: "center",
              color: "black",
            }}
          >
            <AccountCircle />
          </ListItemIcon>
        </ListItemButton>
      </MyList>
    </Component>
  );
};

export default Actions;
