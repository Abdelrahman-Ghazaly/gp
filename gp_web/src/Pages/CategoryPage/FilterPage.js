import { Box, Button, InputAdornment, MenuItem, TextField } from '@mui/material'
import React , {useEffect, useState} from 'react'
import AttachMoneyIcon from '@mui/icons-material/AttachMoney';
import { Categories } from '../../Utilities/CommonVariables/categoriesVariableList';
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { useSelector , useDispatch } from 'react-redux';
import { filterByCategory } from '../../Store/filterReducer';

const FilterPage = () => {
    const [minValue , setMinValue] = useState(0)
    const [maxValue , setMaxValue] = useState(0)
    const [selectValue , setSelectValue] = useState('')
    const dispatch = useDispatch()

    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));
    // const handleSubmit = (e) => {
    //     e.preventDefault()
    //     const minValue = minInput.current.value
    //     const maxValue = maxInput.current.value
    //     const selectValue = selectInput.current.value
    //     console.log(minValue , maxValue , selectValue);
    // }
    useEffect(() => {
        dispatch(filterByCategory(selectValue))
    } , [dispatch , selectValue])

  return (
    <div>
        {/* <form onSubmit={handleSubmit}> */}
        <Box style={{display : 'flex' , alignItems : 'center' , justifyContent: 'center' , border : '2px solid black' , borderRadius : '15px' , padding : '20px' , margin : '15px' , flexWrap : 'wrap'}}>
        <TextField
        id="outlined-select-currency"
        select
        label="Select Category"
        defaultValue=""
        style={{width : '30%', flexGrow : `${match ? '1' : '0'}` }}
        // inputRef = {selectInput}
        onChange = {e => setSelectValue(e.target.value)}
      >
        {Categories.map((option) => (
          <MenuItem key={option.categoryName} value={option.categoryName}>
            {option.categoryName}
          </MenuItem>
        ))}
      </TextField>
      <TextField
        placeholder="Min"
        variant="outlined"
        type="number"
        style={{ width: "120px", marginLeft: "20px" }}
        InputProps={{
          endAdornment: (
            <InputAdornment position="end">
              <AttachMoneyIcon />
            </InputAdornment>
          ),
          inputProps: { min: 0 }
        }}
        onChange = {e => setMinValue(e.target.value)}
      />
      <TextField
        placeholder="Max"
        variant="outlined"
        type="number"
        style={{ width: "120px", margin: "20px" }}
        InputProps={{
          endAdornment: (
            <InputAdornment position="end">
              <AttachMoneyIcon />
            </InputAdornment>
          ),
          inputProps: { min: 0 }
        }}
        // inputRef = {maxInput}
        onChange = {e => setMaxValue(e.target.value)}
      />
        </Box>
        {/* </form> */}
    </div>
  );
}

export default FilterPage