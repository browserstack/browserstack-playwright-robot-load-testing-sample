*** Settings ***
Resource          ../resources/common.resource
Test Setup        Open BStackDemo
Test Teardown     Close Browser

*** Test Cases ***
BStackDemo Test Add To Cart
    [Documentation]    Adds a product to the cart and asserts the cart shows the same product name.
    Wait For Elements State    css=[id="3"] > p    visible    timeout=10s
    ${product_to_add}=    Get Text    css=[id="3"] > p
    Click    css=[id="3"] > .shelf-item__buy-btn
    Wait For Elements State    css=.float-cart--open .shelf-item__details p.title    visible    timeout=10s
    ${product_in_cart}=    Get Text    css=.float-cart--open .shelf-item__details p.title
    Should Be Equal    ${product_in_cart}    ${product_to_add}
