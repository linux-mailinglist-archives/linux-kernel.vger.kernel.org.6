Return-Path: <linux-kernel+bounces-386004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E09B3DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898D81F2234D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98BF1EE00D;
	Mon, 28 Oct 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ20A2/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D11547CA;
	Mon, 28 Oct 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155581; cv=none; b=aQxpVm7vcVa6Yu7WIwzuK71hyByEKw/VEiX3dzhXEGP3c0/dmgqVf5FXDyS9zuuQ1AdFWocynWS/GKWamGTYJiu/02wdivcUWsHES5WCl/Y8BKJHfr+oDq6OSvWN/Dj8oaogh8EzU/3SIzNb/GVj3Wk8xVtdg+0n6yQF8rSWnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155581; c=relaxed/simple;
	bh=dx37CcAfhAOSr47qe9jy3n62PlhDk3xN8vfHVtLHSC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5RnyBscYrlhGQGmoRemBPNey5vVDhNszLVVzvyBZrs//gMZiWjRibbz5+w68+XtQdppUqjGTaeg2I7NkcH8p+KOg8GoHyXPTGoPGuGC9KNmhZYGE24eKZuoTIu0ws5VuKiKbswtdb6y7DGrsfkMn/pGuM8gcvr9Ak9QZKKlB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ20A2/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D0BC4CEC3;
	Mon, 28 Oct 2024 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730155580;
	bh=dx37CcAfhAOSr47qe9jy3n62PlhDk3xN8vfHVtLHSC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQ20A2/C7cpP0YGUXKZLbXpCT4TVIYkVCvV202dRuHfoCqz3SKBzaZiRvJhEDFSdH
	 Ulrq8g4DaBvXKkI+v6dubvo34StGHzwA0R8X6Cw+w7r6ERk+Hhu01JbPKUXwpzeoo0
	 nBbD+VhGj4TfjHCFNbaTlD7liUsdcClbuUqpwW2CmU4FLeUyGOkBs2PC06Jzf4z4oJ
	 bFr1I+MLQjVqGaUUFCjqOb4UVJqRLbdP1V2vx0DVCFkMy7P9zQrR/yUhg1UkWfeNl5
	 dl2OVgUrP5KKHmpMSDiYiao4WO18M0YQED0HRlcujlDS/Zgt77EqFwpBd+3dUXUcYU
	 2WQn9qE6k8V3g==
Date: Mon, 28 Oct 2024 18:46:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZyAUO0b3z_f_kVnj@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZxdKwtTd7LvpieLK@infradead.org>

On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>> For example, for a given PR, the bot can report:
>>
>> - Were the patches CCed to a mailing list?
>> - A histogram of how long the patches were in next (to show bake times)
>> - Are any patches associated with test failures? (0day and many other
>> CIs are already running tests against -next; parse those reports)
>>
>> We could have a real pre-submit checker! :)
>
>That would be very useful.  Items 1 and 2 should be trivial, 3 would
>require a bit of work but would still be very useful.

If you've been following so far, there is a bot that is capable of doing
most of the above
(https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).

Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
long commits spent in -next:

Days in linux-next:
----------------------------------------
  0 | +++++++++++++++++++++++++++++++++++++++++++++++++ (89)
<1 | +++++++++++ (21)
  1 | +++++++++++ (21)
  2 | +++++++++++++++++++++++++ (45)
  3 | ++++++++++++++ (25)
  4 | +++++ (10)
  5 |
  6 | + (2)
  7 |
  8 | + (3)
  9 | ++ (4)
10 |
11 | +++ (6)
12 |
13 |
14+| ++++++++ (15)

This is where I think the value of linus-next comes during the -rc
cycles: the (89 + 21) commits that haven't gone through the -next
workflow before being pulled. I'm not looking to delay the process and
add latency, I'm looking to plug a hole where code would flow directly
to Linus's tree bypassing -next.

With linus-next, we can at least squeeze in build tests as well as some
rudimentary testing if we get a few hours before Linus pulls (and we
usually do).

-- 
Thanks,
Sasha

