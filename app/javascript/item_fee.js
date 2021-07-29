function item_fee() {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  itemPrice.addEventListener('keyup', ()=>{
    let inputPrice = parseInt(itemPrice.value, 10);
    let taxPrice = Math.floor(itemPrice.value / 10);
    if(isNaN(inputPrice) || !inputPrice){
      addTaxPrice.innerHTML = 0;
      profit.innerHTML = 0;
    }else{
      addTaxPrice.innerHTML = taxPrice;
      profit.innerHTML = inputPrice - taxPrice;
    };
  });
};
window.addEventListener("load", item_fee );