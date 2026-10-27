*** Settings ***
Resource          ../resources/common.resource
Test Setup        Open BStackDemo
Test Teardown     Close Browser

*** Test Cases ***
BStackDemo Test Checkout Flow
    [Documentation]    Signs in, adds two items, completes the address form, and proceeds through checkout.

    # sign in
    Wait For Elements State    id=signin    visible    timeout=15s
    Click    id=signin

    Wait For Elements State    css=#username svg    visible    timeout=15s
    Click    css=#username svg
    Wait For Elements State    id=react-select-2-option-0-0    visible    timeout=15s
    Click    id=react-select-2-option-0-0

    Wait For Elements State    css=#password svg    visible    timeout=15s
    Click    css=#password svg
    Wait For Elements State    id=react-select-3-option-0-0    visible    timeout=15s
    Click    id=react-select-3-option-0-0

    Click    id=login-btn

    # add two items to cart
    Wait For Elements State    css=[id="1"] > .shelf-item__buy-btn    visible    timeout=15s
    Click    css=[id="1"] > .shelf-item__buy-btn
    Wait For Elements State    css=div.float-cart__close-btn    visible    timeout=15s
    Click    css=div.float-cart__close-btn
    Wait For Elements State    css=[id="2"] > .shelf-item__buy-btn    visible    timeout=15s
    Click    css=[id="2"] > .shelf-item__buy-btn
    Wait For Elements State    css=.buy-btn    visible    timeout=15s
    Click    css=.buy-btn

    # add address details
    Wait For Elements State    id=firstNameInput    visible    timeout=15s
    Fill Text    id=firstNameInput      first
    Fill Text    id=lastNameInput       last
    Fill Text    id=addressLine1Input   address
    Fill Text    id=provinceInput       province
    Fill Text    id=postCodeInput       pincode

    # checkout
    Click    id=checkout-shipping-continue
    Wait For Elements State    id=confirmation-message    visible    timeout=15s
    Get Text    id=confirmation-message    ==    Your Order has been successfully placed.
    Wait For Elements State    xpath=//*[normalize-space()='Continue']    visible    timeout=15s
    Click    xpath=//*[normalize-space()='Continue']
    Wait For Elements State    xpath=//*[normalize-space()='Orders']    visible    timeout=15s
    Click    xpath=//*[normalize-space()='Orders']
