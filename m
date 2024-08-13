Return-Path: <linux-kernel+bounces-284177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A072E94FDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A021C20C68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088B3BBF1;
	Tue, 13 Aug 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FCl1yb+h"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80944C61;
	Tue, 13 Aug 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531049; cv=none; b=gAXLkTpdeRU7pqycfHGvHx5emfVrNuFIMDZRHtL7UvtgVcc3ELwadxQUdR1hC6gAlYrfi+FhCbAcYqV21Y10lP+4DasUOb02jOpBf5YUtG0HMP8h8TiLzaggXziuC3/GsWMQauviGwelSVEqggtz74OibbAuO+/F+4JH0y7yaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531049; c=relaxed/simple;
	bh=yGbgSEHCrIz2erNpKhwaQq4EhnfOudXLb8OuIS3FX60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fX2HCpuwfZjGxZ5kK1BS3+hGiilVSMTsBAmal6eCGt/7PNiGEjWguXAbeXVklVpMwNbkWS1niTkkh3QxcgBZ52BwvatourM7l+rvgdfFlWrNVnK+yW4LCiFiUlhW2oKkg3UYWH2I3C6gHigEV1hWpyaKROG9s540n/HL7sXWSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FCl1yb+h; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=bLExkehxxzVL2qWW0ujXcl5qXzz4AU7QWmuItPbBY0g=; t=1723531046;
	x=1723963046; b=FCl1yb+hrGk4SITYkempdurHNhQ+bFAqK3n4ox69ryN1/Wn9r0zr5Ht/1SPQo
	111CcnZQqGaBp0HZIhtimW86M2KD8w6JWR76yX+50eDdL22oi/QNyi/vI9g+T+U9/SDhPlsVfR/GZ
	qcqW4tCfPLrucuOh3ClxRpS+xjuMcGz6ABFMgDAykCowFL0eo278NAZINm3dfRSYcXcMLPE+OIkAq
	fMgIUpvwh0hrLfZoozrpH5CNBxNZbHvmCcyQCC1B9ijc0Uv20MTj06Z7ndRnkFSdcsunSEZjmaGvH
	9ECj62fRrsD2TfSWeHDk667yhhazB45SttCS2/qv4gui+4Kt0Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sdl9f-0006OE-Bq; Tue, 13 Aug 2024 08:37:15 +0200
Message-ID: <fc9b6d33-572a-4e36-8575-84eca897709b@leemhuis.info>
Date: Tue, 13 Aug 2024 08:37:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: bug-bisect: rewrite to better match the other
 bisecting text
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info>
 <87ttfwrxfz.fsf@trenco.lwn.net>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <87ttfwrxfz.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1723531046;422c5323;
X-HE-SMSGID: 1sdl9f-0006OE-Bq

On 07.08.24 20:37, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Rewrite the short document on bisecting kernel bugs. The new text
>> improves .config handling, brings a mention of 'git skip', and explains
>> what to do after the bisection finished -- including trying a revert to
>> verify the result. The rewrite at the same time removes the unrelated
>> and outdated section on 'Devices not appearing' and replaces some
>> sentences about bug reporting with a pointer to the document covering
>> that topic in detail.
>>
>> This overall brings the approach close to the one in the recently added
>> text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
>> As those two texts serve a similar purpose for different audiences,
>> mention that document in the head of this one and outline when the
>> other might be the better one to follow.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>  Documentation/admin-guide/bug-bisect.rst | 205 +++++++++++++++--------
>>  MAINTAINERS                              |   1 +
>>  2 files changed, 135 insertions(+), 71 deletions(-)
> 
> So overall this seems like a good thing to do.

Nice to hear that. :-D

>  I wouldn't be me if I didn't have some comments though...:)

And I think that is right, as some of the feedback made me go "what did
I do there, Jonathan is right there". Guess that happens to all of us. :-D

>> diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
>> index 325c5d0ed34a0a..f4a9acab65d0f5 100644
>> --- a/Documentation/admin-guide/bug-bisect.rst
>> +++ b/Documentation/admin-guide/bug-bisect.rst
>> @@ -1,76 +1,139 @@
>
> [...]
>
>> +===============
>> +Bisecting a bug

Side note: While revisiting this I concluded that I most likely will do
a s/bug/regression/ in the title, as that seems more appropriate. But I
will leave the file name as it is to not break existing links.

>> +===============
>>  
>> +This document describes how to find a change causing a kernel regression using
>> +``git bisect``.
> 
> This seems a bit terse.  A bit of information on when doing a bisection
> makes sense would not go amiss - when somebody has observed that a
> previously working feature broke with an update.

Changed that to "This document describes how to use a Git bisection to
find the source code change that broke something -- for example when
some functionality stopped working after upgrading from Linux 6.0 to 6.1."

>> -.. [#f1] You can, optionally, provide both good and bad arguments at git
>> -	 start with ``git bisect start [BAD] [GOOD]``
>> +The text focuses on the gist of the process. If you are new to bisecting the
>> +kernel, better follow Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> +instead: it depicts everything from start to finish while covering multiple
>> +aspects even kernel developers occasionally forget. This includes:
>>  
>> -For further references, please read:
>> +- Detecting situations where a bisections would be a waste of time, as nobody
>> +  would care about the result -- for example, because the problem is triggered
>> +  by a .config change, was already fixed, is caused by something your Linux
>> +  distributor changed, occurs in an abandoned version, or happens after the
>> +  kernel marked itself as 'tainted'.
>> +- Preparing the .config file using an appropriate kernel while enabling or
>> +  disabling debug symbols depending on the situation's needs -- while optionally
>> +  trimming the .config to tremendously reduce the build time per bisection step.
>> +- For regressions in stable or longterm kernels: checking mainline as well, as
>> +  the result determines to whom the regression must be reported to.
> 
> This instead seems a bit verbose; I'd be tempted to take out the
> itemized list and leave just the paragraph above.

Hmmm. You have a point, but I'd like to have some warning sign along the
lines of "if you are not careful, you will waste your time with this"
indicator somewhere. That's why I for now settled with this:

"""The text focuses on the gist of the process. If you are new to
bisecting the kernel, better follow
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
instead: it depicts everything from start to finish while covering
multiple aspects even kernel developers occasionally forget. This
includes detecting situations beforehand where a bisection would be a
waste of time, as nobody would care about the result -- for example,
because the problem happens after the kernel marked itself as 'tainted',
occurs in an abandoned version, was already fixed, or is caused by a
.config change you or your Linux distributor performed."""

>> -- The man page for ``git-bisect``
>> -- `Fighting regressions with git bisect <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
>> -- `Fully automated bisecting with "git bisect run" <https://lwn.net/Articles/317154>`_
>> -- `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_
>> +Neither document describes how to report a regression, as that is covered by
>> +Documentation/admin-guide/reporting-issues.rst.
> 
> This could maybe go at the end - "once you've found the regression, see
> this document on how to report it" ?

Done, this is now this at the end:

"""With that the process is complete. Now report the regression as
described by Documentation/admin-guide/reporting-issues.rst."""

>> +Finding the change causing a kernel issue using a bisection
>> +===========================================================
>> +
>> +*Note: the following process assumes you prepared everything for a bisection;
>> +this includes having a Git clone with the appropriate sources, installing the
>> +software required to build and install kernels, as well as a .config file stored
>> +in a safe place (the following example assumes '~/prepared_kernel_.config') to
>> +use as pristine base at each bisection step.*
>> +
>> +* Preparation: start the bisection and tell Git about the points in the history
>> +  you consider to be working and broken, which Git calls 'good' and 'bad'::
>> +
>> +    git bisect start
>> +    git bisect good v6.0
>> +    git bisect bad v6.1
>> +
>> +  Instead of Git tags like 'v6.0' and 'v6.1' you can specify commit-ids, too.
>> +
>> +1. Copy your prepared .config into the build directory and adjust it to the
>> +   needs of the codebase Git checked out for testing::
>> +
>> +     cp ~/prepared_kernel_.config .config
>> +     make olddefconfig
>> +
>> +2. Now build, install, and boot a kernel; if any of this fails for unrelated
>> +   reasons, run ``git bisect skip`` and go back to step 1.
> 
> Spell out "unrelated reasons" a bit more thoroughly?  I'd mention that
> things can go wrong (despite our best efforts) when bisect lands in the
> middle of a patch series, and to recognize a failure that is not the bug
> in question.

This now looks like this in my current draft:

"""2. Now build, install, and boot a kernel. This might fail for
unrelated reasons, for example, when a compile error happens at the
current stage of the bisection a later change resolves. In such cases
run ``git bisect skip`` and go back to step 1."""

>> +3. Check if the feature that regressed works in the kernel you just built.
>> +
>> +   If it does, execute::
>> +
>> +     git bisect good
>> +
>> +   If it does not, run::
>> +
>> +     git bisect bad
>> +
>> +   Be sure what you tell Git is correct, as getting this wrong just once will
>> +   send the rest of the bisection totally off course.
> 
> Something about hard-to-trigger bugs and putting in the effort to be
> sure that a good kernel is really good?  Along those lines, maybe
> something at the top about having a well-defined reproducer for the
> problem would be good.

Added a """You ideally want to have worked out a straight-forward and
fully reliable way to reproduce the regression, too.""" to the note at
the start and changed this area to:

"""Note, getting this wrong just once will send the rest of the
bisection totally off course. To prevent having to start anew later you
thus want to ensure what you tell Git is correct -- it is thus often
wise to spend a few minutes more on testing when your reproducer is
somewhat unreliable."""


>> +   Go back to back to step 1, if Git after issuing one of those commands checks
>> +   out another bisection point while printing something like 'Bisecting:
>> +   675 revisions left to test after this (roughly 10 steps)'.
>> +
>> +   You finished the bisection and move to the next point below, if Git instead
>> +   prints something like 'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first
>> +   bad commit'; right afterwards it will show some details about the culprit
>> +   including its patch description.
> 
> That's a big and hard-to-parse sentence.  I'd start with the "if"
> condition - this isn't perl :)

I really wanted to have the "where to go next" aspect in that sentence.
But yes, I guess I tried to hard. Changed this to:

"""You have finished the bisection, if Git instead prints something like
'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first bad commit'. In
that case move to the next point below. Note, right after displaying
that line Git will show some details about the culprit including its
patch description; this can easily fill your terminal, so you might need
to scroll up to see the message mentioning the culprit's commit-id.

   In case you are missed Git's output, you at any time of the bisection
can run ``git bisect log`` to print the status: it will show how many
steps remains or mention the result of the bisection."""

>> +* Recommended complementary task: put the bisection log and the current
>> +  .config file aside for the bug report; furthermore tell Git to reset the
>> +  sources to the state before the bisection::
>> +
>> +     git bisect log > ~/bisection-log
>> +     cp .config ~/bisection-config-culprit
>> +     git bisect reset
>> +
>> +* Recommended optional task: try reverting the culprit on top of the latest
>> +  codebase; if successful, this will validate your bisection and enable
>> +  developers to resolve the regression through a revert.
> 
> "successful" could be misinterpreted as referring to the revert itself
> here.  An explicit "if that fixes the bug..." would be more clear.

Now reads """Recommended optional task: try reverting the culprit on top
of the latest codebase and check if that fixes your bug; if that is the
case, it validates the bisection and enables developers to resolve the
regression through a revert."""

> [...]
> 
> Thanks for doing this.

Many thx for the feedback, much appreciated.

Ciao, Thorsten

