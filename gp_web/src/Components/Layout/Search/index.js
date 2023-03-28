import React , {useRef , useState , use , useCallback, useEffect} from 'react'
import { createPortal } from 'react-dom';
import {SearchContainer , SearchIconWrapper , StyledInputBase} from '../../../Styles/Search'
import SearchIcon from '@mui/icons-material/Search';
import ProductList from '../../UI/ProductList';
import useFetch from '../../../CustomHooks/api/useFetch';
import { Box } from '@mui/material';

const Search = ({getTerm}) => {
  const [term , setTerm] = useState('')

  useEffect(() => {
    getTerm(term)
  },[term])
  return (
    <>
    <SearchContainer >
    <SearchIconWrapper>
      <SearchIcon />
    </SearchIconWrapper>
      <StyledInputBase
        placeholder="Search…"
        inputProps={{ "aria-label": "search" }}
        onChange={e => setTerm(e.target.value)}
      />
  </SearchContainer>
    </>
);
}

export default Search
