//Alex Pilafian (sikanrong@gmail.com) / Aleksandra Gabka (rivvel@gmail.com) / 2015
//https://fullstackmofo.wordpress.com/2015/07/26/exercise-06-the-luhn-algorithm/

//Luhn class; calculates validity of Credit Card and Bank Account numbers.
var Luhn = function(cardNumber) {
    this.cardNumber = cardNumber;
    this.valid = false;
    this.validate = function(cardNumber) {
        
        var cardSequence = cardNumber.split('');
        for (var i=0; i < cardSequence.length; i++) { 
            cardSequence[i] = parseInt(cardSequence[i]); // convert card number string into array of numbers 
        };

        var checkDigit = cardSequence.pop(); // Take the last digit = check digit
        for (i=1; i <= cardSequence.length; i+=2) { 
                    cardSequence[cardSequence.length - i] *= 2; // Double every other digit starting from the right
        };

        var allDigitsSum = 0; 
        for (var i=0; i < cardSequence.length; i++) { 
            if (cardSequence[i] >= 10) { 
                cardSequence[i] = (cardSequence[i] % 10) + 1; // Sum the digits of the products 
            };
            allDigitsSum += cardSequence[i]; // Add all the digits together
        };

        allDigitsSum *= 9; 

        var lastDigit = allDigitsSum % 10;
        if (lastDigit == checkDigit) {
                this.valid = true;
        };
    };

    this.validate(this.cardNumber);
};

$(document).ready(function() {
    var form = $("form");
    
    var reset = function(){
        form.removeClass();
        $(".validMessage").hide();
    };

    $( "input" ).keyup(function() {
        var user_input = $( this ).val();

        reset();

        if (user_input.length == 16) {
            
            var test = new Luhn(user_input);
            form.addClass(test.valid? "valid" : "invalid");
            
            if (test.valid == true) {
                $(".validMessage.valid").show();
            } else {
                $("#errorInvalid").show();
            }
            
        }else {
            form.addClass("invalid");
            $("#errorCardLength").show();
        };	
    });

    reset();
})
