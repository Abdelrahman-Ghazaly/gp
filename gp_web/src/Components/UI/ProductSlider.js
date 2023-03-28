import React from "react";
import ProductCard from "./ProductCard";
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
// Import Swiper.js
import { Navigation, Pagination, Scrollbar, A11y, Autoplay } from "swiper";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/scrollbar";

const ProductSlider = ({match , productsArray}) => {
  const theme = useTheme();
  const tabletMatch = useMediaQuery(theme.breakpoints.down("md"));
  return (
    <Swiper
      modules={[Navigation, Pagination, Scrollbar, A11y, Autoplay]}
      spaceBetween={30}
      slidesPerView={match ? 1 : tabletMatch ? 2 : 3}
      pagination={{ clickable: true }}
      style={{ width: "auto", height: "auto" , marginBottom : '35px' , padding : "10px 5px 50px 5px"}}
    >
      {productsArray.map((item, imgIndex) => {
        return (
          <SwiperSlide  key={imgIndex}>
              <ProductCard match={match} item={item} />
          </SwiperSlide>
        );
      })}
    </Swiper>
  );
};

export default ProductSlider;
