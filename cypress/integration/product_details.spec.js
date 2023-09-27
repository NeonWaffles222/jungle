describe("Navigation", () => {
  it("should visit root", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Navigates to the product page", () => {
    cy.get("article > a")
      .first()
      .click();
    cy.get(".product-detail")
      .should("be.visible");
  });
});