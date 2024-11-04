Return-Path: <linux-kernel+bounces-394401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A119BAE83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E643FB210E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0F1AB531;
	Mon,  4 Nov 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUtB+P8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99591AA7BE;
	Mon,  4 Nov 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710160; cv=none; b=lR3zBHuQMhfQNqHNu1E8G+ifoZbgX+WCk7PTiRyRLBZ52zvfjq8Fdr8p0kWgAZ1aGabcn5+iOzWmJtkf4pVIGwgJ2V0M9Yns7dNinmqh4G+Lgne+j5SL6x/GoHnou0xQlpw5i0CJcyIfcc/2+8Xj6U7VFU42qAlQ+ZrBx/7qAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710160; c=relaxed/simple;
	bh=1W+aHVELLPkleC4uw2SzmYEmjTKAOffe9qKQM3Ly0Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akl1qOoLpKaQmKykUrVjUBgNSpTFBhThG0Q22NXlY5xbFxS2kUKkc/CLeZwZdg39r2muGeJKxeHVdjGiyTGHyr8KfoUxqgo3cVGM8CBzadMDPrk4rD6scWU3Dk2PwLZ5y0Me2GywYV0s27d97bPOGoWeouTg4S1Wwc0FqNgk1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUtB+P8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F48C4CECE;
	Mon,  4 Nov 2024 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730710160;
	bh=1W+aHVELLPkleC4uw2SzmYEmjTKAOffe9qKQM3Ly0Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUtB+P8oMMe1gKg7RVajCD1uLYeIgbixISIoCSIUdGuxzKD9VM3zEpZ1Wx53lpRcH
	 KH4HiBVW/nl/NPnQDtQ7bSILoCWtZyxcqDjsNkL5A7ltet3xrEP3QXNSHWmrGHXjC/
	 rrFlMZC3WFvG8+y+um8y/fS7k2UxGXhiuTcGo1GDeE7A7EWZ7xk7fsU2TjbOcX9wc1
	 3QOSrVOCEdivpDLrEdUPybxMZl7ThFfO4vJkSh0TlYtOS24nd1EfKGwUiZedMDWBEx
	 34Ij3c/v0UgayzI856Pex96F7na4Os9Sti1HNN7tBYVRyFCfBe84OxtpEIMl/DF9i4
	 +70rudjdQWoKg==
Date: Mon, 4 Nov 2024 09:49:15 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: linus-next: improving functional testing for to-be-merged
 pull requests
Message-ID: <z2zehszaude6q2jicvdkjz7bgr22zxxayw5vgbjrhgoghqxhia@ngjos2ihibjo>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyAUO0b3z_f_kVnj@sashalap>

On Mon, Oct 28, 2024 at 06:46:19PM -0400, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
> >On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> >> For example, for a given PR, the bot can report:
> >>
> >> - Were the patches CCed to a mailing list?
> >> - A histogram of how long the patches were in next (to show bake times)
> >> - Are any patches associated with test failures? (0day and many other
> >> CIs are already running tests against -next; parse those reports)
> >>
> >> We could have a real pre-submit checker! :)
> >
> >That would be very useful.  Items 1 and 2 should be trivial, 3 would
> >require a bit of work but would still be very useful.
> 
> If you've been following so far, there is a bot that is capable of doing
> most of the above
> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).
> 
> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
> long commits spent in -next:
> 
> Days in linux-next:
> ----------------------------------------
>   0 | +++++++++++++++++++++++++++++++++++++++++++++++++ (89)
> <1 | +++++++++++ (21)
>   1 | +++++++++++ (21)
>   2 | +++++++++++++++++++++++++ (45)
>   3 | ++++++++++++++ (25)
>   4 | +++++ (10)
>   5 |
>   6 | + (2)
>   7 |
>   8 | + (3)
>   9 | ++ (4)
> 10 |
> 11 | +++ (6)
> 12 |
> 13 |
> 14+| ++++++++ (15)
This looks super nice. Sometimes I need to answer how long a
commit/series has been in next to either take it out of the PR or to at
least have a comment to Linus.
I see that I can use the script like `histo.sh /PATH/TO/DB COMMIT-ID`,
which is exactly what I would expect.

Is the idea to run the scripts from
https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git
or to populate ones own DB in linux-next and then run histo?

thx

Best

-- 

Joel Granados

