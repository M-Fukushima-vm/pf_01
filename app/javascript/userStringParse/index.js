import store from '@/store'

const created = () => {
  const userString = localStorage.getItem("currentUser");
  if (userString) {
    const userData = JSON.parse(userString);
    store.commit("auth/SET_CURRENT_USER", userData);
  }
};
const userStringParse = created();

export default { userStringParse };