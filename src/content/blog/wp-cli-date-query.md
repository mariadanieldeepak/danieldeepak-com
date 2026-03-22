---
title: How To Use Date Query With WP CLI?
date: 2022-05-08T05:30:00+05:30
excerpt: Learn to make WP CLI and date query go hand-in-hand.
category: Web Programming
tags: ["wp-cli", "wordpress"]
---

If you're reading this post, I'm sure you don't need an introduction on WP CLI.

Inclined to use some stats in my monthly review post, I wanted to find out the total number of spam comments my blog received for the month of April.

Thinking that WP CLI would make my task easier, I started looking at the documentation to find out the appropriate syntax to be used with the wp comment list command.

To my surprise I found out that date query isn't possible with WP CLI. I realized that I could leverage RESTful WP CLI and apply the date query.

RESTful WP CLI query looks like the following.

```bash
wp rest comment list
```

Using the help command, I figured out the options to be passed.

```bash
wp help rest comment list
```

In order to get the list of spam comments for the month of April, I arrived at the following command.

```bash
wp rest comment list --after='2022-03-31T23:59:59' --before='2022-05-01T00:00:00' --status='spam'
```

## Problems

However, there were a couple of problems.

- **Authorization**: In order to use the status option, authorization is must. Otherwise only the default value approve will be taken in to account.
- **Readability**: The output contains all the comment table fields cluttering the entire console.
- **Getting the total count**: A tabular display of data doesn't output the total number of records.

#### Authorization

I solved the authorization problem using the `user` option in the command like shown below.

```bash
wp rest comment list --after='2022-04-27T23:59:59' --before='2022-05-01T00:00:00' --status='spam' --user='admin'
```

#### Readability

I solved the readability problem using the `field` option in the command like shown below.

```bash
wp rest comment list --after='2022-04-27T23:59:59' --before='2022-05-01T00:00:00' \
  --status='spam' --user='admin' --field='id'
```

#### Total Count

You can obtain the count by using the `--format=headers` option.

```bash
wp rest comment list --after='2022-04-27T23:59:59' --before='2022-05-01T00:00:00' \
  --status='spam' --user='admin' --field='id' --format='headers'
```

## References

- [WP REST API - Getting Started](http://wp-api.org/guides/getting-started.html#before-we-start)
