import React, { useRef } from "react";
import ProductSlider from "../../Components/UI/ProductSlider";
import useFetch from "../../CustomHooks/api/useFetch";
import { dataFilter } from "../../Utilities/HelperFun";
import { Box } from "@mui/material";
import { motion } from "framer-motion";

const arrayOfCategories = [
  {
    id : 1,
    name : "bed",
  },
  {
    id : 2,
    name : "sofa",
  },
  {
    id : 3,
    name : "lamp",
  },
  {
    id : 4,
    name : "chair",
  },
  {
    id : 5,
    name : "table",
  },
  {
    id : 6,
    name : "dresser",
  }
];

const HomeProductsSlider = ({ match }) => {
  const { data , loading , error} = useFetch("http://localhost:5000/product/view");
  const scrollRef = useRef(null);
  const getAllObjestInOneArray = Object.values(data)
  const mixedData = [].concat(...getAllObjestInOneArray)


  const CategoryTitleStyle = {
    color: "#20284f",
    padding: "18px 5px",
    fontSize: `${!match ? "35px" : "30px"}`,
  };

  return (
    <div>
      <h1
        style={{
          color: "#20284f",
          padding: "18px 5px",
          fontSize: `${!match ? "50px" : "25px"}`,
          marginTop: "40px",
        }}
      >
        Shop By Item
      </h1>
      <Box sx={{ flexGrow: 1, marginTop: "25px" }}>
        {arrayOfCategories.map((item) => (

            <motion.div
              key={item.id}
              initial={{ opacity: 0, scale: 0.5, y: -150 }}
              whileInView={{
                opacity: 1,
                scale: 1,
                transition: {
                  duration: 1,
                  delay: 0.3,
                  ease: [0, 0.71, 0.2, 1.01],
                },
                y: 0,
              }}
              viewport={{ root: scrollRef }}
              animate={{ scale: 1 }}
            >
              <h1 style={CategoryTitleStyle} >{item.name}</h1>
              <ProductSlider
                match={match}
                productsArray={dataFilter(mixedData , item.name)}
                //productsArray={data}
              />
            </motion.div>

        ))}
      </Box>
    </div>
  );
};

export default HomeProductsSlider;
