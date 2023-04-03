import React , {useRef } from 'react'
import {SearchContainer , SearchIconWrapper , StyledInputBase} from '../../../Styles/Search'
import SearchIcon from '@mui/icons-material/Search';
import { useNavigate } from 'react-router-dom';
import {useDispatch } from 'react-redux'
import { fetchDataByTitle } from '../../../Store/searchReducer';

const Search = () => {
  const inputRef = useRef('')
  const dispatch = useDispatch()
  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault();
    const inputValue = inputRef.current.value
    await dispatch(fetchDataByTitle(inputValue))
    navigate("/searchPage")
  }

  return (
    <>
      <SearchContainer>
        <SearchIconWrapper>
          <SearchIcon />
        </SearchIconWrapper>
        <form onSubmit={handleSubmit}>
          <StyledInputBase
            placeholder="Search…"
            inputProps={{ "aria-label": "search" }}
            inputRef={inputRef}
          />
        </form>
      </SearchContainer>
    </>
  );
}

export default Search
