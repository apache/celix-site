---
title: Submitting patches
---

# Submitting patches

{{% tableofcontents %}}

## Contributing with GitHub

Using the GitHub mirror is the simplest way to contribute to Apache Celix if you are not a member
of the Celix Committers group.

First you must have an account created at GitHub to be able perform the next step. If you don't,
go ahead and create one just right now! Please remember to setup
[SSH keys](https://help.github.com/articles/generating-ssh-keys) and test them! You don't have to use SSH Keys 
if you are using the HTTPS url. In this case git simply uses user/password authentication.

When ready go to [https://github.com/apache/celix](https://github.com/apache/celix) and click `Fork` button
in top right corner. This will fork the Apache Celix' repository and will create your private (but public) repository
with the source code.

Next step is to clone the original repo locally

    git clone https://github.com/apache/celix.git
    
This will be an `origin`, you cannot push changes to the `origin` but don't worry, you will use your fork.

Now is time to add your fork as a remote

    git remote add fork https://github.com/my-username/celix.git 

Right now you should have two remotes defined for the repo, `origin` and `fork`, use below command to confirm that

    git remote -v 

Now you are ready to work with the Apache Celix' code base. Start with switching to `develop` branch

    git checkout develop
    
now is time to fetch any changes from remote repository

    git fetch
    git pull
    
you should create a branch to keep your changes and it must be done off the `develop` branch

    git checkout -b my-branch

Do your changes and commit them to `my-branch`, when you're done you can push the changes to GitHub, to your fork.

    git push -u fork my-branch
    
If you still need to change something, please remember to commit and push changes, but this time you can use just

    git push
    
as `my-branch` was already connected with the remote branch.

The final step is to open a Pull Request (short: PR) against the original Apache Celix repo. Go to the 
[Apache Celix mirror](https://github.com/apache/celix), then to [Pull request](https://github.com/apache/celix/pulls)
and hit [New Pull Request](https://github.com/apache/celix/compare/) button.

If not already selected, click on `compare across forks.` Right now you must select from the dropdowns on right
your fork and branch to compare the differences with the Apache Celix' `develop` branch.

Finally hit `Create Pull Request` button and you are done!

After your PR got accepted and merged you must clean up your local repo, please switch your current branch to `develop`

    git checkout develop
    
and fetch updates from remote

    git fetch -p
    git pull
    
and now you can delete your local branch

    git branch -d my-branch
    
and you are ready to start working on another feature/issue.

## Committers

Celix uses Git so you must install a git client locally and then you can clone the Celix repository:

either using Apache GitBox

    git clone https://gitbox.apache.org/repos/asf/celix.git    
    
or GitHub
   
    git clone https://github.com/apache/celix.git

and done!

<p class="alert alert-primary">Note: Remember that Apache Celix is following the <a href="https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow">GitFlow Workflow</a>
and the most recent work is on the `develop` branch.</p>

## Non-committers 

If you are not a committer you can still clone the Gitbox repo but you won't be able push to any changes to it.
At that moment, it's easier to use GitHub, as GitHub provides the functionality to handle Pull Requests.

    git clone https://github.com/apache/celix.git

For more info, read [Contributing with GitHub](#contributing-with-github) on this page.

## Further reading

 * [Git at Apache](http://wiki.apache.org/general/GitAtApache)
