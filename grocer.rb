def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  row_index = 0 
  while row_index < collection.length
    if collection[row_index][:item] == name
      return collection[row_index]
    end
  row_index += 1 
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
new_cart = []
  row_index = 0

  while row_index < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[row_index][:item], new_cart)
    if new_cart_item
      new_cart_item[:count] +=1
    else 
      new_cart_item = {
        :item => cart[row_index][:item],
        :price => cart[row_index][:price],
        :clearance => cart[row_index][:clearance],
        :count => 1 
      }
      new_cart << new_cart_item
    end
    row_index += 1 
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  row_index = 0 
 while row_index < coupons.length
 cart_item = find_item_by_name_in_collection(coupons[row_index][:item], cart)
 couponed_item_name = "#{coupons[row_index][:item]} W/COUPON"
 cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
 if cart_item && cart_item[:count] >= coupons[row_index][:num]
   if cart_item_with_coupon
     cart_item_with_coupon[:count] += coupons[row_index][:num]
     cart_item[:count] -= coupons[row_index][:num]
   else
     cart_item_with_coupon = {
       :item => couponed_item_name,
       :price => coupons[row_index][:cost] / coupons[row_index][:num],
       :count => coupons[row_index][:num],
       :clearance => cart_item[:clearance]
     }
     cart << cart_item_with_coupon
     cart_item[:count] -= coupons[row_index][:num]
      end
    end
  row_index += 1 
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
    i = 0 
  while i < cart.length do 
    if cart[i][:clearance] == true 
      new_price = cart[i][:price]*0.8
      cart[i][:price] = new_price.round(2)
    end
    i += 1
  end
    cart
end


def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0 
  i = 0 
  while i < cart.length do 
    price_per_type = cart[i][:price]*cart[i][:count]
    total += price_per_type
    i += 1 
  end
  if total > 100
    with_discount = total * 0.9
    total = with_discount.round(2)
  end
  total
end
