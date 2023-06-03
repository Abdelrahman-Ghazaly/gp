import React, { useEffect } from "react";
import { Suspense } from "react";
import { Route, Routes } from "react-router-dom";
import LoadingSpinner from "./Components/UI/Common/LoadingSpinner";
import { useDispatch, useSelector } from "react-redux";
import { authSliceAction } from "./Store/authReducer";

const ViewProfile = React.lazy(() => import("./Pages/Ecommerce/ViewProfile"));
const CategoryPage = React.lazy(() => import("./Pages/Ecommerce/CategoryPage"));
const FavoritePage = React.lazy(() => import("./Pages/Ecommerce/FavoritePage"));
const SearchResult = React.lazy(() => import("./Pages/Ecommerce/Search/SearchResult"));
const ProductView = React.lazy(() => import("./Pages/Ecommerce/ProductView"));
const AddProductForm = React.lazy(() => import("./Pages/Ecommerce/AddProductForm"));
const SignupPage = React.lazy(() => import("./Pages/Ecommerce/Signup"));
const LoginPage = React.lazy(() => import("./Pages/Ecommerce/Login"));
const Home = React.lazy(() => import("./Pages/Ecommerce/Home"));
const Chat = React.lazy(() => import("./Pages/Chat"));

function App() {
  const dispatch = useDispatch();

  useEffect(() => {
    const userData = JSON.parse(localStorage.getItem("userData"));

    if (userData) {
      dispatch(authSliceAction.login(userData));
    }
  }, [dispatch]);

  const userData = useSelector((state) => state.auth.userData);
  console.log(userData);
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
          path="/categorypage/:name"
          element={
            <Suspense fallback={<LoadingSpinner />}>
              <CategoryPage />
            </Suspense>
          }
        />
        {/* if User Has Logged In */}
        {userData && (
          <>
            <Route
              path="/upload"
              element={
                <Suspense fallback={<LoadingSpinner />}>
                  <AddProductForm />
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
              path="/chat"
              element={
                <Suspense fallback={<LoadingSpinner />}>
                  <Chat />
                </Suspense>
              }
            />
          </>
        )}

        <Route
          path="*"
          // element={<h1 style={{ textAlign: "center" }}>NOT Found 404</h1>}
          element = {<div style={{width : "50%" , margin : '0 auto'}}>
            <img style={{width : '100%'}} src="https://i0.wp.com/creative-sofa.com/wp-content/uploads/2018/01/404-page-inspiration-creative-sofa-8.gif?resize=800%2C600" alt="FEW"/>
          </div>}
        />

      </Routes>
    </>
  );
}

export default App;
