docker run -it --rm \
    --name govuk_form_product_page \
    --user root \
    -v $(pwd)/build:/app/build \
    govuk-form-product-page sh
