import { ListItemButton, ListItemIcon, Divider , Badge , Box } from "@mui/material";
import React  from "react";
import { Link, useNavigate } from "react-router-dom";
import {
  ActionIconsContainerMobile,
  ActionIconsContainerDesktop,
  SellButton,
  MyList,
} from "../../../Styles/appbar.js";
import AccountCircle from "@mui/icons-material/AccountCircle";
import LogoutIcon from '@mui/icons-material/Logout';
import FavoriteIcon from "@mui/icons-material/Favorite";
import AddIcon from "@mui/icons-material/Add";
import { useDispatch , useSelector } from "react-redux";
import { authSliceAction } from "../../../Store/authReducer/index.js";


const Actions = ({ match }) => {
  const dispatch = useDispatch()
  const navigate = useNavigate();
  const favList = useSelector(state => state.favorite.favList)
  const {userData} = useSelector(state => state.auth)

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
        <Box style={{all : 'unset'}} onClick={() => navigate(`${userData ? "/" : "/auth/login"}`)}>
        <ListItemButton
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
            onClick={() => dispatch(authSliceAction.logout())}
          >
            {userData ? <LogoutIcon /> : <AccountCircle />}
          </ListItemIcon>
        </ListItemButton>
        </Box>
      </MyList>
    </Component>
  );
};

export default Actions;
