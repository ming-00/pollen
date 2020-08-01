// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require turbolinks
//= require jquery
//= require rails-ujs
//= require bootstrap.min
//= require bootstrap
//= require_tree .
//= require notifications

$(document).on('turbolinks:load', function() {

    new Notifications().constructor();

    $("#journal-button").click(function(){
        $("#journal-form").toggle();
    });
    $("#correction-button").click(function(){
        $("#load-correction").toggle();
        $("#no-correction").hide();
    });
    $("#perfection-button").click(function(){
        $("#no-correction").toggle();
        $("#load-correction").hide();
    });
    $("#generator-field").hide();
    $("#inspiration-pop").click(function(){
        $("#generator-field").toggle();
    });

    $('[data-toggle="tooltip"]').tooltip(); 

    var btn = document.getElementById('generator');
    var text = document.getElementById('change-prompt');

    var generate = function() {
        const prompts = ["your favourite movie.", 
            "the best day you have ever had.", 
            "your best friend.", 
            "your favourite TV show.",
            "the scariest thing that has ever happened to you.",
            "your favourite place in the world.",
            "your experience with language learning.",
            "your experience in NUS.",
            "your favourite food in NUS.",
            "your favourite food.",
            "how you week went.",
            "the country you wish to visit the most.",
            "your favourite game.",
            "a superpower you wish you had.",
            "a story that begins and ends with someone falling down the stairs.",
            "the best decision you ever made.",
            "two strangers chatting about anything while waiting in a queue.",
            "your favourite place in Singapore.",
            "something you wish you had the opportunity to do.",
            "the most interesting class you enrolled in.",
            "your favourite artist.",
            "your favourite time period.",
            "an animal that doesn't exist.",
            "your favourite memory.",
            "your biggest fear.",
            "who you look up to most, and why.",
            "what a perfect day would be like to you.",
            "the favourite thing that you own.",
            "the strangest dream you had.",
            "something in your bucket list.",
            "the only thing you would eat if you have to eat it for the rest of your life, and why.",
            "the book that has impacted you the most.",
            "the best present you ever received.",
            "whether you believe aliens exist, and why.",
            "your major.",
            "something you would change about the world.",
            "your favourite place in NUS.",
            "your earliest childhood memory.",
            "the time period you would like to live in.",
            "why you want to learn the language you are learning.",
            "the luckiest thing to ever happen to you.",
            "your favourite day of the year.",
            "what animal you would want to be.",
            "3 pet peeves that you have.",
            "the last movie you watched.",
            "the last book you read.",
            "when you would want to time travel to.",
            "the person you would want to have a dinner with, dead or alive.",
            "a conspiracy theory that you actually believe in.",
            "your favourite joke, and whether it translates well into the language you are learning.",
            "the scariest movie you watched.",
            "the scariest book you ever read.",
            "your favourite movie genre.",
            "where you would like to live.",
            "your dream lifestyle.",
            "whether you would like to change the world, and why or why not.",
            "some advice you would like to give everyone.",
            "where you are and what is around you.",
            "your favourite character in a movie or book.",
            "what you recommend everyone should do in Singapore.",
            "a historical figure whom you think is overrated.",
            "your hobbies.",
            "the laziest thing you have ever done/ not done.",
            "your thoughts on climate change and global warming.",
            "your thoughts on the most pressing issue the world is facing now.",
            "a misconception you had when you were a child.",
            "a habit you wish you could get rid of.",
            "a habit you wish you could cultivate, and why you haven't done so.",
            "a useless talent that you have.",
            "the favourite thing about your culture.",
            "your hobby, but make it as cryptic as possible without telling us what it is.",
            "the funniest thing that has happened to you.",
            "your thoughts on the meaning of life.",
            "the worst injury you ever had.",
            "a phobia you have.",
            "the best trip you ever had.",
            "what you would tell an alien if you met one.",
            "40 eagles vs 5 lions: who you think would win in a fight?",
            "your pet, or a pet you wish you had.",
            "your thoughts on being immortal.",
            "a button you are given, which does something when pressed. What does your button do?",
            "a question you really want to know the answer to, and why.",
            "whether you think a taco is a sandwich or a hotdog, or neither.",
            "an invention you wish existed.",
            "an invention you wish never existed.",
            "how deep you think a pan has to be before it becomes a pot?",
            "your favourite childhood show.",
            "the most expensive thing you ever bought.",
            "your role model.",
            "whether you think billionaires should exist.",
            "how you deal with stress.",
            "the most stressful time in your life.",
            "your favourite relative.",
            "something you cannot live without.",
            "the craziest thing you ever did.",
            "your favourite animal, but describe it without telling us what it is.",
            "whether you would rather have the ability to talk to animals, or speak every language."
        ];
        newPrompt = prompts[Math.floor(Math.random() * prompts.length)];
        console.log(newPrompt);
    }

    function WordShuffler(holder,opt){
        var that = this;
        var time = 0;
        this.now;
        this.then = Date.now();
        
        this.delta;
        this.currentTimeOffset = 0;
        
        this.word = null;
        this.currentWord = null;
        this.currentCharacter = 0;
        this.currentWordLength = 0;
      
      
        var options = {
          fps : 20,
          timeOffset : 0,
          textColor : '#000',
          fontSize : "50px",
          useCanvas : false,
          mixCapital : false,
          mixSpecialCharacters : false,
          needUpdate : true,
          colors : [
            '#AA6976','#82A78D','#004D80',
            '#E1AF90','#D67272','#850941'
          ]
        }
      
        if(typeof opt != "undefined"){
          for(key in opt){
            options[key] = opt[key];
          }
        }
      
        this.needUpdate = true;
        this.fps = options.fps;
        this.interval = 1000/this.fps;
        this.timeOffset = options.timeOffset;
        this.textColor = options.textColor;
        this.fontSize = options.fontSize;
        this.mixCapital = options.mixCapital;
        this.mixSpecialCharacters = options.mixSpecialCharacters;
        this.colors = options.colors;
      
         this.useCanvas = options.useCanvas;
        
        this.chars = [
          'A','B','C','D',
          'E','F','G','H',
          'I','J','K','L',
          'M','N','O','P',
          'Q','R','S','T',
          'U','V','W','X',
          'Y','Z'
        ];
        this.specialCharacters = [
          '!','§','$','%',
          '&','/','(',')',
          '=','?','_','<',
          '>','^','°','*',
          '#','-',':',';','~'
        ]
      
        if(this.mixSpecialCharacters){
          this.chars = this.chars.concat(this.specialCharacters);
        }
      
        this.getRandomColor = function () {
          var randNum = Math.floor( Math.random() * this.colors.length );
          return this.colors[randNum];
        }
      
        //if Canvas
       
        this.position = {
          x : 0,
          y : 50
        }
      
        //if DOM
        if(typeof holder != "undefined"){
          this.holder = holder;
        }
      
        if(!this.useCanvas && typeof this.holder == "undefined"){
          console.warn('Holder must be defined in DOM Mode. Use Canvas or define Holder');
        }
      
      
        this.getRandCharacter = function(characterToReplace){    
          if(characterToReplace == " "){
            return ' ';
          }
          var randNum = Math.floor(Math.random() * this.chars.length);
          var lowChoice =  -.5 + Math.random();
          var picketCharacter = this.chars[randNum];
          var choosen = picketCharacter.toLowerCase();
          if(this.mixCapital){
            choosen = lowChoice < 0 ? picketCharacter.toLowerCase() : picketCharacter;
          }
          return choosen;
          
        }
      
        this.writeWord = function(word){
          this.word = word;
          this.currentWord = word.split('');
          this.currentWordLength = this.currentWord.length;
      
        }
      
        this.generateSingleCharacter = function (color,character) {
          var span = document.createElement('span');
          span.style.color = color;
          span.innerHTML = character;
          return span;
        }
      
        this.updateCharacter = function (time) {
          
            this.now = Date.now();
            this.delta = this.now - this.then;
      
             
      
            if (this.delta > this.interval) {
              this.currentTimeOffset++;
            
              var word = [];
      
              if(this.currentTimeOffset === this.timeOffset && this.currentCharacter !== this.currentWordLength){
                this.currentCharacter++;
                this.currentTimeOffset = 0;
              }
              for(var k=0;k<this.currentCharacter;k++){
                word.push(this.currentWord[k]);
              }
      
              for(var i=0;i<this.currentWordLength - this.currentCharacter;i++){
                word.push(this.getRandCharacter(this.currentWord[this.currentCharacter+i]));
              }
      
      
              if(that.useCanvas){
                c.clearRect(0,0,stage.x * stage.dpr , stage.y * stage.dpr);
                c.font = that.fontSize + " sans-serif";
                var spacing = 0;
                word.forEach(function (w,index) {
                  if(index > that.currentCharacter){
                    c.fillStyle = that.getRandomColor();
                  }else{
                    c.fillStyle = that.textColor;
                  }
                  c.fillText(w, that.position.x + spacing, that.position.y);
                  spacing += c.measureText(w).width;
                });
              }else{
      
                if(that.currentCharacter === that.currentWordLength){
                  that.needUpdate = false;
                }
                this.holder.innerHTML = '';
                word.forEach(function (w,index) {
                  var color = null
                  if(index > that.currentCharacter){
                    color = that.getRandomColor();
                  }else{
                    color = that.textColor;
                  }
                  that.holder.appendChild(that.generateSingleCharacter(color, w));
                }); 
              }
              this.then = this.now - (this.delta % this.interval);
            }
        }
      
        this.restart = function () {
          this.currentCharacter = 0;
          this.needUpdate = true;
        }
      
        function update(time) {
          time++;
          if(that.needUpdate){
            that.updateCharacter(time);
          }
          requestAnimationFrame(update);
        }
      
        this.writeWord(this.holder.innerHTML);
      
      
        console.log(this.currentWord);
        update(time);
    }

    

    btn.addEventListener('click', function() {
        generate();
        text.innerText = newPrompt;
        var pText = new WordShuffler(text,{
            textColor : '#000',
            timeOffset : 1
        });
        pText.restart();
    });
});
  
  


  
