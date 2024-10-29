Return-Path: <linux-kernel+bounces-386822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33589B4846
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EAC1C21735
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72F205157;
	Tue, 29 Oct 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgLupant"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C063204F7B;
	Tue, 29 Oct 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201446; cv=none; b=lx0tzwUKc7mjeR9Dqs2Tv4tIi2EpCvP8x2qc09vE5hE7mhVzoyOOAhi7sfblESHzwytuSChppC29tVlJH5P2wxK72InDZOB5ANl4P7fs2C2vA7XdFyEMJtHdcRsnEPSS1Mx2HWFDK3Wup9UYbIroYgyY6yJfpzmMCvHoLzLIvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201446; c=relaxed/simple;
	bh=77m1YSmH24wJ5zs07ke8laKYHLNvnG6xHGMz/sdPTeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZdszOi8JmJTkUPmfCgT22SbJzLHXhSp8pQE0wa0gFGHNQjmBXY15NaSJhYC01QABvkUisjRXdulPWUBdx9DV/+SOefR1A+VpQ8x8EB5NHke+4s7PXbGk+dSnHNkonFdN5EJs6TIfR/Ti/PMOB9ypjc/XlVrNSFAKU/r0egfTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgLupant; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7919C4CEE6;
	Tue, 29 Oct 2024 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730201446;
	bh=77m1YSmH24wJ5zs07ke8laKYHLNvnG6xHGMz/sdPTeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgLupantRxk6YH1hkM5vN76VmCzVflgIqxvJU+D0hyYiqOnhxrjyZqLOGkiQSq2D5
	 6bcKZ+WbtBYcKwOCB2yVr0pVWefGpM+0V+O1yfdceiHtntIahRCSAU92lZG8+dVi2H
	 lBWDiExB3ffieTYEN8yAzVb3JTTGCoHs5xGRH45gCSSm5WRN1VUTXi1pr8og+vlAtq
	 muY4FrcAkUDCzQz6KK617yU0cgVpk13U8F6UAh/V1ybATdJzXTnHtrqBUjwE7+VDjn
	 26fZO2TerknnvDBPiMEeFWhpZFE/h4IpYFth2h6p6faadA/5Hz/To19w+Clpyroe52
	 e4waKKHNWdcvw==
Date: Tue, 29 Oct 2024 07:30:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZyDHZHjxwmK1Ow9e@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
 <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>

On Tue, Oct 29, 2024 at 09:10:25AM +0100, Thorsten Leemhuis wrote:
>On 28.10.24 23:46, Sasha Levin wrote:
>> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>>> On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>>>> For example, for a given PR, the bot can report:
>>>>
>>>> - Were the patches CCed to a mailing list?
>>>> - A histogram of how long the patches were in next (to show bake times)
>>>> - Are any patches associated with test failures? (0day and many other
>>>> CIs are already running tests against -next; parse those reports)
>>>>
>>>> We could have a real pre-submit checker! :)
>>>
>>> That would be very useful.  Items 1 and 2 should be trivial, 3 would
>>> require a bit of work but would still be very useful.
>>
>> If you've been following so far, there is a bot that is capable of doing
>> most of the above
>> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-
>> analysis.git/).
>>
>> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
>> long commits spent in -next:
>
>I took a quick look at that tree and histo.sh that lead to a few
>questions here the code had no obvious answers to (or I missed them due
>to the "quick" aspect):
>
>* How does histo.sh handle changes where the commit-id changed between
>the first time in -next and their merge into Linus' tree (while the
>patch itself did not change)? For example due to a rebase or workflows
>where the commit-id changes regularly, such as those used by the
>bluetooth tree (for -fixes, as it queues them in their -next branch
>first) or the -mm tree (for most of it iirc -- this made things hard in
>a script of mine that looks up the arrival in -next)?

The "database" the scripts use stores 3 things:

  - commit ID
  - git patch-id
  - subject line

We try to match by either of the three. It means that maintainers can
rebase, change the subject, or even change the patch slightly, but as
long as one of the above stays the same we treat the commit the same.

>* Do those lore scripts detect if a committer adjusted the subject of a
>patch that has been on lore?

Yes, they also look up by patch-id, so if only the subject was adjusted
then we will still find the commit.

>* How do the scripts handle patches that changed a lot while they were
>in -next? I know of one subsystem that regularly drops whole patch-sets
>from their trees included in -next to replace them with newer versions
>of said patch-sets -- and then the timer maybe should restart.

The timer should just restart, right? If we uploaded patches that look
different from older ones, then their timer starts from 0 again.

>> This is where I think the value of linus-next comes during the -rc
>> cycles: the (89 + 21) commits that haven't gone through the -next
>> workflow before being pulled.
>>
>> I'm not looking to delay the process and
>> add latency, I'm looking to plug a hole where code would flow directly
>> to Linus's tree bypassing -next.
>
>Overall after all the discussions in this thread I still fail to see why
>we need a new tree for that. Why not make pending-fixes a bit more
>prominent while motivating maintainers to have proper -fixes branches
>included there?

Because that will add latency: my understanding that we don't want to
necessarily add another day or two between when fixes are ready and the
time it would take to get them through linux-next.

-- 
Thanks,
Sasha

