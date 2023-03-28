import { ListItemButton, ListItemIcon, Divider, Container, Box } from "@mui/material";
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
import AddProductForm from "../../../Pages/AddProductForm/index.js";

const Actions = ({ match }) => {
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const [showComponent , setShowComponent] = useState(false)

  // const handleToggleModal = () => {
  //   setShowComponent(true)
  //   setOpen(prevState => !prevState);
  // }
  // const Toggle = () => {
  //   setShowComponent(true)
  // }
  const Component = match
    ? ActionIconsContainerMobile
    : ActionIconsContainerDesktop;

  return (
    <Component>
      <MyList type="row">
        {match ? (
          <>
            <ListItemButton
              onClick={() => navigate("/")}
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
                <FavoriteIcon />
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
              onClick={() => navigate("/")}
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
                <FavoriteIcon />
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
