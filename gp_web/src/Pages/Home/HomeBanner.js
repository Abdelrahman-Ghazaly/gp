import React from "react";
import { CategoriesList , CategoriesListItem } from "../../Styles/home";


import { Navigation, Pagination, Scrollbar, A11y, Autoplay } from "swiper";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/scrollbar";

import banner1 from "../../assets/Banners/Banner1.png";
import banner2 from "../../assets/Banners/Banner2.png";
import banner3 from "../../assets/Banners/Banner3.jpg";
import banner4 from "../../assets/Banners/Banner4.png";

const images = [banner1, banner2, banner3, banner4];


const HomeBanner = ({match , Categories}) => {


  return (
      <>
        {!match && (
          <CategoriesList>
            {Categories.map((cat) => (
              <CategoriesListItem key={cat.categoryName}>{cat.icon}{cat.categoryName}</CategoriesListItem>
            ))}
          </CategoriesList>
        )}
        <Swiper
          modules={[Navigation, Pagination, Scrollbar, A11y, Autoplay]}
          spaceBetween={0}
          slidesPerView={1}
          autoplay={true}
          pagination={{ clickable: true }}
          style={{ width: "auto", height: "auto" }}
        >
          {images.map((img, imgIndex) => {
            return (
              <SwiperSlide className="" key={imgIndex}>
                <img
                  src={img}
                  className=""
                  alt={img}
                  style={{
                    width: "100%",
                    height: `${match ? "200px" : "500px"}`,
                    objectFit: "cover",
                    borderRadius: "15px",
                  }}
                />
              </SwiperSlide>
            );
          })}
        </Swiper>
      </>
  );
};

export default HomeBanner;
