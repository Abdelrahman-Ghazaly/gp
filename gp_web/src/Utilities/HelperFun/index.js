export const dataFilter = (data , type) => {
    const arrOfType = []
    data.forEach(item => {
        if(item.category === type)
            arrOfType.push(item)
    });
    return arrOfType
}