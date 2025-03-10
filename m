Return-Path: <linux-kernel+bounces-554611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069DA59A71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E963A6997
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C44D22DFB6;
	Mon, 10 Mar 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU8rIuID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041981DFF0;
	Mon, 10 Mar 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622209; cv=none; b=IgYIOueYo3NxJRA6FrnE9SnjP6M5qhezTZCMmVFtxjRmXHTxbC/Z5CGNcRciZ4Q0K3XkU5rf93J4UkXdJAFBFfUj6E7AprgauOTN/hqdQMCwvmF2zGq7hE8IrX6A7nBs2G/Mcb6RKWUKuRoPp4IcSqi4PjSjcPj/8BG+DXQoBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622209; c=relaxed/simple;
	bh=kamb/0x1RtibBi69Oi3ZHY8EijG20URTJpwtA9UanIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxN4AtxZKRQdvxzMoCbnJOYJZDU4KEi1nDd5ncPmbA/PJ5+5xOJLPyjyc8Rpd+TxVr9KBFlyB876NlhwjM6zTBrc/UzspYyKtleSM1t1WnK3U3NdI0N117TJhC5Gs0p8keaEa7V/ycJLgg+N94zDvaBUmEgw1vTC/Lb8LkGKCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU8rIuID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1991C4CEED;
	Mon, 10 Mar 2025 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741622208;
	bh=kamb/0x1RtibBi69Oi3ZHY8EijG20URTJpwtA9UanIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YU8rIuID2ZcjzyRs4+lMKU6IIcOYPchsQLG8WBKpT5Ha/xw9e66suP6XzGUBAQby9
	 LZNpEwOWo/AwkdScXHw/AY5olaZVgQxfmNbXMS6bFKhx2IHVw3oEAENbFZuyl3IbBg
	 VEyJmVpHuIvXn115vcAYqS3Epp0L3rx4dio4v6OQwcJIAgZtLzahLeP92RMArsPWxZ
	 r9HAPUaA7yFQVKJw6NloVzlTuNamWAz7rK5RXLP2NoR6ugt2fqYdJIwRy5jkuPhNzr
	 FiNRf1yHuRscImO5S74kZYlaxutGB4x34xsxS1ivBx5u0Up3mrSgkq36dG+chDqE/V
	 gMoO7+RVJHeFQ==
Date: Mon, 10 Mar 2025 16:56:38 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yury Norov
 <yury.norov@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250310165638.7b001393@sal.lan>
In-Reply-To: <bcce7d39-f142-4838-ba23-4fa2dda69fd0@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
	<f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
	<20250310155301.6db5033c@foz.lan>
	<bcce7d39-f142-4838-ba23-4fa2dda69fd0@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 11 Mar 2025 00:27:47 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi,
> 
> Mauro Carvalho Chehab wrote:
> > Em Fri,  7 Mar 2025 13:04:51 +0530  
> [...]
> >>  /**
> >> - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> >> + * cpumask_first_and - return the first cpu from *@srcp1 & *@srcp2  
> > 
> > I don't think this would produce the right output. See my other comment.
> > 
> > See, if I add this there:
> > 
> > 	 * cpumask_first_and - return the first cpu from ``*srcp1`` & @srcp2 & *@srp3
> > 
> > The kernel-doc output is:
> > 
> > 	.. c:function:: unsigned int cpumask_first_and (const struct cpumask *srcp1, const struct cpumask *srcp2)
> > 
> > 	   return the first cpu from ``*srcp1`` & **srcp2** & ***srp3**
> > 
> > e.g.:
> > 
> > - srcp1: will not be bold, but it will use a monospaced font and will have 
> > 	 an asterisk;
> > 
> > - srcp2: will be bold, without asterisk;
> > 
> > - srcp3: violates ReST spec: different versions may show it different
> >          and warnings may be issued.  
> 
> This third pattern is available since commit 69fc23efc7e5 ("kernel-doc:
> Add unary operator * to $type_param_ref") and I haven't heard of any
> regression report.
> 
> Sphinx parses ***srp3** in the following way:
> 
>   - It sees the first ** and start strong emphasis.
>   - It continues that mode until it sees next **.
> 
> In the end, Sphinx will produce strongly emphasized "*srp3".

Yes, I got it. But, as "*" is a reserved symbol, used already as
*italic* and **bold**, nothing prevents some day to have a ***something***.

Also, other ReST tools may misinterpret that,as, IMO, this has
undefined behavior. So, better avoid that.

> It would be much better to convert *@srp3 into "\*\ **srp3", which will
> result in normal "*" followed by emphasized "srp3", but I didn't go that
> far at that time.  

Yeah, either that or **\*srp3** to keep the asterisk bold
(assuming it works properly) [1].

[1] I remember I had some troubles with escape codes on
bold before, but can't rename exactly on what version.

> This looked sufficient to me as a band-aid workaround.
> 
> Or you are aware of any Sphinx version who doesn't work in this way?

Didn't check this specific issue.

> 
>         Thanks, Akira
> 

