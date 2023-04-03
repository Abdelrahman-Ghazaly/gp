import { Suspense, useEffect } from 'react';
import Home from './Pages/Home'
import LoginPage from './Pages/Login';
import SignupPage from './Pages/Signup';
import AddProductForm from './Pages/AddProductForm';
import ProductView from './Pages/ProductView';
import { Route , Routes  } from "react-router-dom";
import SearchResult from './Pages/Search/SearchResult';
import FavoritePage from './Pages/FavoritePage';
import ViewProfile from './Pages/ViewProfile';
import CategoryPage from './Pages/CategoryPage';
import LoadingSpinner from './Components/UI/Common/LoadingSpinner';

function App() {
  // Hi From Other Side
  return (
   <>
     <Routes>
       <Route path="/" exact element={<Home />} />
       <Route path="/auth/login" element={<LoginPage />} />
       <Route path="/auth/signup" element={<SignupPage />} />
       <Route path="/upload" element={<AddProductForm />} />
       <Route path="/product/:id" element={<ProductView />} />
       <Route path="/searchPage" element={<SearchResult />}/>
       <Route path="/favorite" element={<FavoritePage />}/>
       <Route path="/viewprofile" element={<ViewProfile />}/>
       <Route path="/categorypage/:name" element={<CategoryPage />}/>
     </Routes>
   </>
  );
}

export default App;
