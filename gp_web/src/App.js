import Home from './Pages/Home'
import LoginPage from './Pages/Login';
import SignupPage from './Pages/Signup';
import AddProductForm from './Pages/AddProductForm';
import ProductView from './Pages/ProductView';
import { Route , Routes  } from "react-router-dom";

function App() {
  return (
   <>
     <Routes>
       <Route path="/" exact element={<Home />} />
       <Route path="/auth/login" element={<LoginPage />} />
       <Route path="/auth/signup" element={<SignupPage />} />
       <Route path="/upload" element={<AddProductForm />} />
       <Route path="/product/:id" element={<ProductView />} />
     </Routes>
   </>
  );
}

export default App;
