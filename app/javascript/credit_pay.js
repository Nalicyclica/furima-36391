window.addEventListener("load", () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_address[card_number]"),
      exp_month: formData.get("order_address[exp_month]"),
      exp_year: `20${formData.get("order_address[exp_year]")}`,
      cvc: formData.get("order_address[cvc]"),
    };

    Payjp.createToken(card, (status, response) => {
      const sendToken = document.getElementById("charge-form");
      if (status == 200){
        const token = response.id;
        const tokenHTML = `<input value=${token} name='token' type='hidden'>`;
        sendToken.insertAdjacentHTML("beforeend", tokenHTML);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      sendToken.submit();
    });
  });
});