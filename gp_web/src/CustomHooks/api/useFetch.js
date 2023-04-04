import  {useState , useCallback, useEffect} from 'react'

const useFetch = (url) => {
    const [data, setData] = useState([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    const fetchData = useCallback(async (url , tokenId) => {
        try{
            const response = await fetch(url)
            const urlData = await response.json()
            setData(urlData)
            setLoading(false)
        }catch(error){
            setLoading(false)
            setError(error)
        }
    } , [url])

    useEffect(() => {
        fetchData(url)
    },[fetchData , url])

    return {data , loading , error}
}

export default useFetch