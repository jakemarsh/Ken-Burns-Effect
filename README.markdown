Forked from [@jberlana](https://github.com/jberlana)'s [iOS KeyBurns effect](https://github.com/jberlana/iOSKeyBurns)
====================

I've renamed a few things to work better in my environements, but this project is 99.9% the work of [@jberlana](https://github.com/jberlana). 

The goal of this project is to create a `UIView` that can generate a Ken-Burns-style transition when given an array of `UIImage` objects.

To use it, you simply need to an an instance of `JMKenBurnsView` and call this method to start the action:

``` objc

[self.kenBurnsView animateWithImages:slideshowImages
			 transitionDuration:15.0 
						   loop:YES 
					inLandscape:YES];

```

### Documentation

``` objc

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)duration loop:(BOOL)shouldLoop inLandscape:(BOOL)isLandscape;

```

- `images` - NSArray of UIImages.
- `duration` - Time in seconds for the transition between each image.
- `shouldLoop` - The animation will start again when ended.
- `isLandscape` - If true optimized to show in Landscape mode.

### TODO

* Need to allow device rotation.
* Improvements on image transition effects.

--

###[SweetBits](http://www.sweetbits.es/ "SweetBits"), welcome to the candy factory.###