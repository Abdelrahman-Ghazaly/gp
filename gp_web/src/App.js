import React , { useEffect } from 'react';
import { Suspense } from 'react';
import Home from './Pages/Home'
import LoginPage from './Pages/Login';
import SignupPage from './Pages/Signup';
import AddProductForm from './Pages/AddProductForm';
import ProductView from './Pages/ProductView';
import { Route , Routes  } from "react-router-dom";
import SearchResult from './Pages/Search/SearchResult';
import FavoritePage from './Pages/FavoritePage';
//import ViewProfile from './Pages/ViewProfile';
import CategoryPage from './Pages/CategoryPage';
import LoadingSpinner from './Components/UI/Common/LoadingSpinner';
import { useDispatch } from 'react-redux';
import { authSliceAction  } from './Store/authReducer';

const ViewProfile = React.lazy(() => import('./Pages/ViewProfile'))

function App() {
  const dispatch = useDispatch()

  useEffect(() => {
    const userData = JSON.parse(localStorage.getItem('userData'));
    //console.log(userData)
    if (userData) {
      dispatch(authSliceAction.login(userData));
    }
  }, [dispatch]);
  return (
    <>
      <Routes>
        <Route
          path="/"
          exact
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <Home />
            </Suspense>
          }
        />
        <Route
          path="/auth/login"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <LoginPage />
            </Suspense>
          }
        />
        <Route
          path="/auth/signup"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <SignupPage />
            </Suspense>
          }
        />
        <Route
          path="/upload"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <AddProductForm />
            </Suspense>
          }
        />
        <Route
          path="/product/:id"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <ProductView />
            </Suspense>
          }
        />
        <Route
          path="/searchPage"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <SearchResult />
            </Suspense>
          }
        />
        <Route
          path="/favorite"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <FavoritePage />
            </Suspense>
          }
        />
        <Route
          path="/viewprofile"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <ViewProfile />
            </Suspense>
          }
        />
        <Route
          path="/categorypage/:name"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <CategoryPage />
            </Suspense>
          }
        />
      </Routes>
    </>
  );
}

export default App;
