import React , {useState} from 'react'
import {
  Drawer,
  IconButton,
  Divider,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Collapse
} from "@mui/material";

// Import Icons
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import AccountBoxIcon from '@mui/icons-material/AccountBox';
import InventoryIcon from '@mui/icons-material/Inventory';
import StorefrontIcon from '@mui/icons-material/Storefront';
import ExpandLess from '@mui/icons-material/ExpandLess';
import ExpandMore from '@mui/icons-material/ExpandMore';
import CategoryIcon from '@mui/icons-material/Category';

import { useTheme } from '@mui/material/styles'
import { useMediaQuery } from '@mui/material'
import { styled } from '@mui/material/styles';


const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'flex-end',
}));

const ListItems = [
  {
    name : 'inbox',
    icon : <InboxIcon />,
    link : '/inbox'
  },
  {
    name : 'Auction',
    icon : <StorefrontIcon />,
    link : '/auction'
  },
  {
    name : 'View Profile',
    icon : <AccountBoxIcon />,
    link : '/viewprofile'
  },
  {
    name : 'Products Uploaded',
    icon : <InventoryIcon />,
    link : '/uploaded'
  }
]

const DrawerNav = ({open , handleDrawerClose , Categories}) => {
  const theme = useTheme()
  const match = useMediaQuery(theme.breakpoints.down('sm'))

  const [openNestedList, setOpenNestedList] = useState(false);

  const handleClick = () => {
    setOpenNestedList(!openNestedList);
  };

  const drawerWidth = 240;

  return (
    <Drawer
      sx={{
        width: drawerWidth,
        flexShrink: 0,
        "& .MuiDrawer-paper": {
          width: drawerWidth,
          boxSizing: "border-box",
        },
      }}
      variant="persistent"
      anchor="left"
      open={open}
    >
      <DrawerHeader>
        <h2 style={{ marginRight: "20px" }}>Furniture</h2>
        <IconButton onClick={handleDrawerClose}>
          <ChevronLeftIcon />
        </IconButton>
      </DrawerHeader>

      <Divider />

      <List>
        {ListItems.slice(0, 2).map((data) => (
          <ListItem key={data.name} disablePadding>
            <ListItemButton>
              <ListItemIcon>{data.icon}</ListItemIcon>
              <ListItemText primary={data.name} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>

      {match && (
        <List>
          <ListItemButton onClick={handleClick}>
            <ListItemIcon>
              <CategoryIcon />
            </ListItemIcon>
            <ListItemText primary="Categories" />
            {openNestedList ? <ExpandLess /> : <ExpandMore />}
          </ListItemButton>
          <Collapse in={openNestedList} timeout="auto" unmountOnExit>
            <List component="div" disablePadding>
              {Categories.map((cat) => (
                <ListItemButton key={cat.categoryName} sx={{ pl: 4 }}>
                  <ListItemIcon>{cat.icon}</ListItemIcon>
                  <ListItemText primary={cat.categoryName} />
                </ListItemButton>
              ))}
            </List>
          </Collapse>
        </List>
      )}

      <Divider />

      <List>
        {ListItems.slice(-2).map((data) => (
          <ListItem key={data.name} disablePadding>
            <ListItemButton>
              <ListItemIcon>{data.icon}</ListItemIcon>
              <ListItemText primary={data.name} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </Drawer>
  );
}

export default DrawerNav


