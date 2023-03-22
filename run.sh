docker run -it \
    --name govuk_form_product_page \
    --user root \
    -v $(PWD)/build:/app/build \
    govuk-form-product-page sh
