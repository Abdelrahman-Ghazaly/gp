import React , {useEffect} from 'react'
import { useParams } from 'react-router-dom'
import SearchImage from '../../../assets/searchImage.jpg'
import ProductCard from '../../../Components/UI/ProductCard'
import AppBar from '../../../Components/Layout/AppBar'
import Footer from '../../../Components/Layout/Footer'
import { Container, Grid } from '@mui/material'
import LoadingSpinner from '../../../Components/UI/Common/LoadingSpinner'
import FilterPage from './FilterPage'
import { useSelector , useDispatch } from 'react-redux';
import { filterProducts } from '../../../Store/Ecommerce/filterReducer'


const CategoryPage = () => {
    const {name} = useParams();
    const dispatch = useDispatch()
    const {filteredData , loading } = useSelector(state => state.filter)
     //const {data , loading} = useFetch(`http://localhost:5000/product/search/product/?category=${name}`)
    let filteredDataLength = filteredData.length

    useEffect(() => {
        dispatch(filterProducts(name))
    } , [dispatch , name])


    
  return (
    <>
      <AppBar />
      <Container>
        <FilterPage />
        {loading ? (
          <LoadingSpinner />
        ) : (
          <
          >
            {filteredDataLength === 0 ? (
              <div style={{display : 'flex' , justifyContent : 'center' , alignItems : 'center' , flexDirection : 'column'}}>
                <h1>Please Select Category</h1>
              <img style={{width : '50%'}} src={SearchImage} alt="img"/>
            </div>
            ) : (
            <Grid
            container
            spacing={{ xs: 2, md: 1 }}
            columns={{ xs: 12, sm: 12, md: 12 }}>
            {filteredData.map((item) => {
              return (
                <Grid item xs={12} sm={6} md={4} key={item._id}>
                  <ProductCard item={item} />
                </Grid>
              );
            })
          }
            </Grid>
            )
            }
          </>
        )}
      </Container>
      <Footer />
    </>
  );
}

export default CategoryPage