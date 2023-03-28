import { Box } from '@mui/material'
import React from 'react'
import { Link } from 'react-router-dom'

const ProductList = ({item}) => {

  return (
    <>
        <Box>
            <Link to={`/product/${item.id}`}>
                <h3 className="SearchResultTitle">{item.title}</h3>
            </Link>
        </Box>
    </>
  )
}

export default ProductList