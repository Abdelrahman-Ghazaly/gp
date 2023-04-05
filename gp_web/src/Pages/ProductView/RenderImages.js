import React , {useState} from 'react'

// Swiper Imports
import { Swiper, SwiperSlide } from "swiper/react";

// Import Swiper styles
import "swiper/css";
import "swiper/css/free-mode";
import "swiper/css/navigation";
import "swiper/css/thumbs";

// import required modules
import { FreeMode, Navigation, Thumbs } from "swiper";

const imgStyle = {
    aspectRatio: "3/3",
    width: "100%",
    objectFit: "contain",
    borderRadius: "15px",
}

const RenderImages = ({data}) => {
    const [thumbsSwiper, setThumbsSwiper] = useState(null);

    const renderImages = () => {
        if (typeof data.imgURL !== "string") {
          return (
            <>
              <Swiper
                loop={true}
                spaceBetween={10}
                thumbs={{ swiper: thumbsSwiper }}
                modules={[FreeMode, Navigation, Thumbs]}
              >
                {data.imgURL.map((img, idx) => {
                  return (
                    <SwiperSlide key={idx}>
                      <img
                        style={imgStyle}
                        src={img}
                        alt="product_image"
                      />
                    </SwiperSlide>
                  );
                })}
              </Swiper>
              <Swiper
                onSwiper={setThumbsSwiper}
                loop={true}
                spaceBetween={10}
                slidesPerView={4}
                freeMode={true}
                watchSlidesProgress={true}
                modules={[FreeMode, Navigation, Thumbs]}
              >
                {data.imgURL.map((img, idx) => {
                  return (
                    <SwiperSlide key={idx}>
                      <img
                        style={imgStyle}
                        src={img}
                        alt="product_image"
                      />
                    </SwiperSlide>
                  );
                })}
              </Swiper>
            </>
          );
        } else {
          return (
            <img
              style={imgStyle}
              src={data.imgURL}
              alt="product_image"
            />
          );
        }
      };

  return (
    <>
        {renderImages()}
    </>
  )
}

export default RenderImages