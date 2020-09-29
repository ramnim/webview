// Base
import Log from './base/Log.js';

// Game Levels
import RunnerLevel from './game/levels/RunnerLevel.js';
import CreditsLevel from './game/levels/CreditsLevel.js';
import HomeMenuLevel from './game/levels/HomeMenuLevel.js';

export default class Game {

    constructor(options = {}) {

        /**
         * Sets game options
         */
        this.options = options;

        /**
         * Keyboard pressed keys
         */
        this.keys = {};

        /**
         * Is game paused?
         */
        this.paused = false;

        /**
         * Can be used to log objects and debug the game
         */
        this.log = new Log();

        /**
         * Starts the BABYLON engine on the Canvas element
         */
        this.canvas = document.getElementById("renderCanvas");

        this.engine = new BABYLON.Engine(this.canvas, true);

        this.currentLevel = null;
        this.currentLevelName = 'HomeMenuLevel';

        this.levels = {
            'HomeMenuLevel': new HomeMenuLevel(),
            'CreditsLevel': new CreditsLevel(),
            'RunnerLevel': new RunnerLevel()
        };

    }

    start() {
        this.listenKeys();
        this.lintenTouchEvents();
        this.listenOtherEvents();
        this.startLevel();
    }

    pause() {
        this.paused = true;
    }

    isPaused() {
        return this.paused;
    }

    resume() {
        this.paused = false;
    }

    listenKeys() {
        
        document.addEventListener('keydown', keyDown.bind(this));
        document.addEventListener('keyup', keyUp.bind(this));
    
        this.keys.up = false;
        this.keys.down = false;
        this.keys.left = false;
        this.keys.right = false;

        function keyDown(e) {
            if (e.keyCode == 87 || e.keyCode == 38) {//Arrow Up
                this.keys.up = 1;
                
            }else if (e.keyCode == 83 || e.keyCode == 40) {//Arrow Down
                this.keys.down = 1;
                
            } else if (e.keyCode == 65 || e.keyCode == 37) {//Arrow Left
                this.keys.left = 1;
                
            } else if (e.keyCode == 68 || e.keyCode == 39) {//Arrow Right
                this.keys.right = 1;
            }
        }

        function keyUp(e) {
            if (e.keyCode == 87 || e.keyCode == 38) {//Arrow Up
                this.keys.up = 0;
            }else if (e.keyCode == 83 || e.keyCode == 40) {//Arrow Down
                this.keys.down = 0;
            } else if (e.keyCode == 65 || e.keyCode == 37) {//Arrow Left
                this.keys.left = 0;
            } else if (e.keyCode == 68 || e.keyCode == 39) {//Arrow Right
                this.keys.right = 0;
            }
        }
    }

    lintenTouchEvents() {
        var hammertime = new Hammer(document.body);
        hammertime.get('swipe').set({ direction: Hammer.DIRECTION_ALL });

        hammertime.on('swipeup', (ev) => {
            this.keys.up = 1;

            // Resets the key after some milleseconds
            setTimeout(() => {
                this.keys.up = 0;
            }, 150);
        });

        hammertime.on('swipedown', (ev) => {
            this.keys.down = 1;

            setTimeout(() => {
                this.keys.down = 0;
            }, 100);
        });

        hammertime.on('swipeleft', (ev) => {
            this.keys.left = 2;
            
            setTimeout(() => {
                this.keys.left = 0;
            }, 150);
        });

        hammertime.on('swiperight', (ev) => {
            this.keys.right = 2;

            setTimeout(() => {
                this.keys.right = 0;
            }, 150);
        });
    }

    listenOtherEvents() {
        window.addEventListener('blur', () => {
            this.pause();
        });

        window.addEventListener('focus', () => {
            this.resume();
        });
    }

    goToLevel(levelName) {

        if(!this.levels[levelName]) {
            console.error('A level with name ' + levelName + ' does not exists');
            return;
        }

        if(this.currentLevel) {
            this.currentLevel.exit();
        }

        this.currentLevelName = levelName;
        this.startLevel();
    }

    startLevel() {

        this.currentLevel = this.levels[this.currentLevelName];
        this.currentLevel.start();

    }

    render() {
        this.startRenderLoop();

        window.addEventListener("resize", () => { 
            this.engine.resize();
        });

    }

    startRenderLoop() {
        this.engine.runRenderLoop(() => {
            this.currentLevel.scene.render();
        });
    }

    stopRenderLoop() {
        this.engine.stopRenderLoop();
    }

    isMobile() {
        if( navigator.userAgent.match(/Android/i)
        || navigator.userAgent.match(/webOS/i)
        || navigator.userAgent.match(/iPhone/i)
        || navigator.userAgent.match(/iPad/i)
        || navigator.userAgent.match(/iPod/i)
        || navigator.userAgent.match(/BlackBerry/i)
        || navigator.userAgent.match(/Windows Phone/i)) {
            return true;
        }

        return false;
    }

}