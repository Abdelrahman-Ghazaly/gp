import { Box, Button, InputAdornment, MenuItem, TextField } from '@mui/material'
import React , { useRef } from 'react'
import AttachMoneyIcon from '@mui/icons-material/AttachMoney';
import { Categories } from '../../../Utilities/CommonVariables/categoriesVariableList';
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import {  useDispatch } from 'react-redux';
import { filterAction , filterProducts} from '../../../Store/Ecommerce/filterReducer';

const FilterPage = () => {
    // const [minValue , setMinValue] = useState(0)
    // const [maxValue , setMaxValue] = useState(0)
    const minInput = useRef(0)
    const maxInput = useRef(0)
    const selectInput = useRef('')
    // const [selectValue , setSelectValue] = useState('')
    const dispatch = useDispatch()

    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));

    const handleSubmit = async (e) => {
        e.preventDefault()
        let minValue = minInput.current.value
        let maxValue = maxInput.current.value
        let selectedValue = selectInput.current.value

        dispatch(filterAction.setMinPrice(minValue))
        dispatch(filterAction.setMaxPrice(maxValue))
        dispatch(filterProducts(selectedValue))
        minInput.current.value = ''
        maxInput.current.value = ''

    }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <Box
          style={{
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            borderRadius: "15px",
            padding: "20px",
            margin: "25px",
            flexWrap: "wrap",
            boxShadow : `rgba(100, 100, 111, 0.2) 0px 7px 29px 0px`
          }}
        >
          <TextField
            id="outlined-select-currency"
            select
            label="Select Category"
            defaultValue=''
            style={{ width: "30%", flexGrow: `${match ? "1" : "0"}`}}
            inputRef={selectInput}
            // onChange = {e => setSelectValue(e.target.value)}
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
              inputProps: { min: 0 },
            }}
            inputRef={minInput}
            // onChange = {e => setMinValue(e.target.value)}
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
              inputProps: { min: 0 },
            }}
            inputRef={maxInput}
            // onChange = {e => setMaxValue(e.target.value)}
          />
          <Button style={{padding : '12px'}} type="submit" variant="contained">
            GO
          </Button>
        </Box>
      </form>
    </div>
  );
}

export default FilterPage