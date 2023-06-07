// Import Icons
import ChairAltIcon from '@mui/icons-material/ChairAlt';
import KingBedIcon from '@mui/icons-material/KingBed';
import LightIcon from '@mui/icons-material/Light';
import ViewComfyAltIcon from '@mui/icons-material/ViewComfyAlt';
import TableBarIcon from '@mui/icons-material/TableBar';
import WeekendIcon from '@mui/icons-material/Weekend';
import DeckIcon from '@mui/icons-material/Deck';

// Import Categories Thumbnail
import SofaThumbnail from '../../assets/CategoriesThumnail/Sofa.jpg'
import ChairThumbnail from '../../assets/CategoriesThumnail/Chair.png'
import LampThumbnail from '../../assets/CategoriesThumnail/Lamp.jpeg'
import TableThumbnail from '../../assets/CategoriesThumnail/Table.jpg'
import BedThumbnail from '../../assets/CategoriesThumnail/Bed.jpg'
import DresserThumbnail from '../../assets/CategoriesThumnail/Dresser.jpeg'
import AccessoriesThumnail from '../../assets/CategoriesThumnail/Accessories.jpg'

export const Categories = [
  {
    categoryName : 'Bed',
    icon : <KingBedIcon />,
    link : '/beds',
    Thumbnail : BedThumbnail
  },
  {
    categoryName : 'Chair',
    icon : <ChairAltIcon />,
    link : '/chairs',
    Thumbnail : ChairThumbnail
  },
  {
    categoryName : 'Dresser',
    icon : <ViewComfyAltIcon />,
    link : '/dressers',
    Thumbnail : DresserThumbnail
  },
  {
    categoryName : 'Table',
    icon : <TableBarIcon />,
    link : '/tables',
    Thumbnail : TableThumbnail
  },
  {
    categoryName : 'Sofa',
    icon : <WeekendIcon />,
    link : '/sofas',
    Thumbnail : SofaThumbnail
  },
  // {
  //   categoryName : 'Lamp',
  //   icon : <LightIcon />,
  //   link : '/lamps',
  //   Thumbnail : LampThumbnail
  // },
  {
    categoryName : 'Accessories',
    icon : <DeckIcon style={{fontSize : '28px'}} />,
    link : '/accessories',
    Thumbnail : AccessoriesThumnail
  },
]