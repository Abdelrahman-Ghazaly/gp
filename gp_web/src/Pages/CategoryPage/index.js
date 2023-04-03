import React , {useEffect} from 'react'
import { useParams } from 'react-router-dom'
import useFetch from '../../CustomHooks/api/useFetch'
import ProductCard from '../../Components/UI/ProductCard'
import AppBar from '../../Components/Layout/AppBar'
import Footer from '../../Components/Layout/Footer'
import { Container, Grid } from '@mui/material'
import LoadingSpinner from '../../Components/UI/Common/LoadingSpinner'
import FilterPage from './FilterPage'
import { useSelector , useDispatch } from 'react-redux';
import { filterByCategory } from '../../Store/filterReducer'

const CategoryPage = () => {
    const {name} = useParams();
    const dispatch = useDispatch()
    const {filteredData , loading } = useSelector(state => state.filter)
    // const {data , loading} = useFetch(`http://localhost:8000/Products?category=${name}`)
    useEffect(() => {
        dispatch(filterByCategory(name))
    } , [dispatch , name])
    console.log(filteredData);
  return (
    <>
      <AppBar />
      <Container>
        <FilterPage />
        {loading ? (
          <LoadingSpinner />
        ) : (
          <Grid
            container
            spacing={{ xs: 2, md: 1 }}
            columns={{ xs: 12, sm: 12, md: 12 }}
          >
            {filteredData.map((item) => {
              return (
                <Grid item xs={12} sm={6} md={4} key={item.id}>
                  <ProductCard item={item} />
                </Grid>
              );
            })}
          </Grid>
        )}
      </Container>
      <Footer />
    </>
  );
}

export default CategoryPage