describe("Navigation", () => {
  it("should visit root", () => {
    cy.visit("/");
  });

  it("Adds an item to the cart", () => {
    cy.contains("Add")
      .first()
      .click({ force: true });
  });

  it("check if the cart count is 1", () => {
    cy.contains("My Cart (1)");
  });
});