---
title: Breaking WordPress with a simple plugin
date: 2024-02-13T15:01:28.430503-06:00
tags:
- reclaim
- wordpress
cover:
  relative: true
  image: 
---

I am prepping for [next week's Workshop for DoOO and WordPress Multisite Admins](https://events.reclaimhosting.com/event/2024-winter-admin-workshop/), and I wanted to create a plugin that could display an error page for the purposes of showing how to troubleshoot a broken WordPress site caused by a problematic plugin. In the past I've asked folks to "imagine" a site was broken, but its a little more fun to break stuff for real.


```php
<?php
/**
 * Plugin Name: Really cool neato plugin
 * Description: I am gud programmer.
 * Version: 1.0
 * Author: Taylor Jadin
 */

add_action('wp', 'error_demo');
add_action('admin_init', 'error_demo');

function error_demo() {
    $result = 10 / 0;
}
```

Ultimately it wasn't too tricky to figure out. The code above runs on every page and the admin dashboard, and it tries to divide by zero!

From here I just needed to put this code in a file in `wp-content/plugins/really-neat/really-neat.php` and activate the plugin in WordPress, and we've got a broken site 💥!

![a screenshot of a broken wordpress site with a error of the type DivideByZero](<Capture 2024-02-13 15.11.26@2x.png>)