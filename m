Return-Path: <linux-kernel+bounces-375918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D79A9D36
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190351C21901
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5C189905;
	Tue, 22 Oct 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUDhP4A5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639018C325;
	Tue, 22 Oct 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586493; cv=none; b=ZL71zhkAT5oYTBn+YZocsn8ERG3+QVDHW8hc7fW2F5oueeTcrgsX3zzl01/Whm/mN7GmYjZnD2YWxZ+ijp8TVGVxB/OBT1kLJck0RNiq0PL5jvSMc16fwKCE+GIRQiZeY8XvmgLxskuWHbh/wFf1Yz4hUXOvUYUTke0hLyNnLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586493; c=relaxed/simple;
	bh=MP3D4NEWwnNkeEnf8yI9OHhF+zzjeUfIKTthqL9P3V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1ZU6U2IKYVNeHv+T4WzOA1jv8dTDir3ZmiTOBzfiOT5rsQyCqaLsyswPALd17Sxstqf4Vg576xfU2zQbpTVtEhP81UrEWw50/IE0Yf7eTwpdxan+Rrh9iIdQYUOgXaGBFp663ReP8wDpI5sJHMclYlBaVMl7fIqUjExLa6yqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUDhP4A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39021C4CEE4;
	Tue, 22 Oct 2024 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729586492;
	bh=MP3D4NEWwnNkeEnf8yI9OHhF+zzjeUfIKTthqL9P3V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUDhP4A5F7tbL/OMnzOVYhN2Hpl7TryFUcVp9OlMAhK694EYHadarVcdJ1gZShOsg
	 cuI8MHB+8WT8s9W2ix7VWsqUzyHYAV6/WUdyZIdKxiTc+fNWcr30uEebWAnX5YFpnu
	 jepgzJ8mA8CVSXtYSuqlYon9/N29BFapplVh9f/QqgaVL7KrqpwHgHYQMz6lZDrdSB
	 OeuKRpNzfnx7P2UgIocdhAJXoYWIry4WuK9QQgbyxqjouCND5AfeUrNI0/fe0Iyb5z
	 di6NDmdhV885a0gu9sfZigreUJqR2Y7h4GZFtT82cQWIqv6Cd6Kqmp8E0N0YUGvpLH
	 6Z2A/vJc1JtaA==
Date: Tue, 22 Oct 2024 10:41:28 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ylfkxl3pxysnev6ll2byyzjbq5a6khwhzai5f3yupxc6fpiz5d@fv75pqj3gu5q>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>

On Oct 21 2024, Kees Cook wrote:
> 
> 
> On October 21, 2024 9:07:13 AM PDT, Sasha Levin <sashal@kernel.org> wrote:
> >In an attempt to address the concerns, we're trying out a new "linus-next"
> >tree is being created and maintained with the following characteristics:
> >
> >	1. Composed of pull requests sent directly to Linus
> >
> >	2. Contains branches destined for imminent inclusion by Linus
> 
> But this means hours or a day or 2 at most.

Yeah :/

> 
> >	3. Higher code quality expectation (these are pull requests that
> >	maintainers expect Linus to pull)
> 
> Are people putting things in linux-next that they don't expect to send to Linus? That seems like the greater problem.
> 
> >	4. Continuous tree (not daily tags like in linux-next),
> >	facilitating easier bisection
> 
> I'm not sure how useful that is given the very small time window to find bugs.

I think there is some value for this tree, but the target is not what
Sasha explained (or what I understood at least). The linus-next (or
whatever linus-pr) is seems to me to be solely targetting Linus, for
running pre-merge checks.

And that is *very* interesting for him, so yes, I'd vote for a plus one
on this.

IMO this new tree shouldn't be advertised as a:
"please run as many possible tests on this before Linus pulls it",
but as a:
"we are gathering all PR, run a dedicated sets of tests on it, and if
they passes, Linus will look at your PR. If not, your PR will be
automatically put on hold".

Think of it as a pre-merge testing, and if a PR fails, the maintainer
has to sort it out instead of having Linus to sort it out.

> 
> >The linus-next tree aims to provide a more stable and testable
> >integration point compared to linux-next,
> 
> Why not just use linux-next? I don't understand how this is any different except that it provides very little time to do testing and will need manual conflict resolutions that have already been done in linux-next.

Agree. Gathering general tests should not come *after* the PR has been
sent, but before.

It could be interesting IMO to have a linux-current-fixes tree which
gather trees that are meant to be sent to this current cycle (fixes only
basically).

In my small subsystem we sometime gather fixes that are not urgent but
could go into the current cycle but are not send them right away. They
could be integrated in such a tree, but OTOH, they are tested in
linux-next already, so it's more of a matter for testers to decide if
they want to have a "current tree + upcoming fixes" or not.

> 
> How about this, instead: no one sends -rc1 PRs to Linus that didn't go through -next. Just have a bot that replies to all PRs with a health check, and Linus can pull it if he thinks it looks good. 
> 
> For example, for a given PR, the bot can report:
> 
> - Were the patches CCed to a mailing list?
> - A histogram of how long the patches were in next (to show bake times)
> - Are any patches associated with test failures? (0day and many other CIs are already running tests against -next; parse those reports)
> 
> We could have a real pre-submit checker! :)

As long as it only helps making an educated guess (or catch obvious
failures) I'm all for it.
In the same way stable receives emails from testers before Greg tags the
new tree.

Cheers,
Benjamin

