# Noodall Articles

Noodall Articles adds simple blog functionality to Noodall.

## Install

Add to your `Gemfile`

    gem 'noodall-articles', :git => 'git@github.com:noodall/noodall-articles.git'

Run `bundle install`

    bundle install

## Configuration

Noodall Articles adds an `Article` and `ArticleList` Node to Noodall.

`ArticleList` is the classic blog listing page. `Article` is an individual blog post.

In `config/initializers/noodall.rb`

Add the `ArticleList` as a root template

    Noodall::Node.root_templates ArticleList, ContentPage

Noodall Articles also adds a `LatestArticles` component which you can to your slots if required.

    Noodall::Node.slot :large, LatestArticles
    Noodall::Node.slot :small, LatestArticles

You can now create an `ArticleList` as your blog listing page and `Article` Nodes beneath it.

