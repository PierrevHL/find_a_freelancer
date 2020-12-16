const initInstagramFeed = () => {
  const container = document.querySelector("#ig-pictures")
  console.log(334)
  if (container){
    const username = container.dataset.username
    if (username === "") return
    fetch(`https://www.instagram.com/${username}/?__a=1`)
    .then(response => response.json())
    .then((data) =>{
      const pics = data.graphql.user.edge_owner_to_timeline_media.edges
      const urls = pics.map(pic => pic.node.display_url)
      const row = container.querySelector(".row")
      urls.slice(0, 6).forEach((url) => {
        row.insertAdjacentHTML("beforeend",  `<div class="col-sm-4 justify-content-around"><img src="${url}" class="instafeed"/></div>`)
      })

    })
  }
}


export { initInstagramFeed }
