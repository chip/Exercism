# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  SCARY_MOVIE_MINIMUM_AGE = 18
  SENIOR_DISCOUNT_MINIMUM_AGE = 60
  SENIOR_TICKET_PRICE = 10
  REGULAR_TICKET_PRICE = 15

  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    @age >= SENIOR_DISCOUNT_MINIMUM_AGE ? SENIOR_TICKET_PRICE : REGULAR_TICKET_PRICE
  end

  def watch_scary_movie?
    @age >= SCARY_MOVIE_MINIMUM_AGE
  end

  # Popcorn is 🍿
  def claim_free_popcorn!
    raise NotMovieClubMemberError, 'Exception was raised!' unless @member

    '🍿'
  end
end
