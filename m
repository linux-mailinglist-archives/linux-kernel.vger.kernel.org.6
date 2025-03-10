Return-Path: <linux-kernel+bounces-554459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FEA597F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A69188739A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A47522B8D9;
	Mon, 10 Mar 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmRKqNw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFF22A819;
	Mon, 10 Mar 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617833; cv=none; b=HVLmJl++JuEo26uRF2+XMYrqeQwcCFjBtaOCXClbDJXc9QrRft4pyBNcVYPpi0pKAGkmuM5Ui64Givy3ud55EYe7SdtvPxstXROoWeh2Mw7O9kEBGcAlrY8h2fz4kYgr0wsnMuGnq0s5MUBbqZc0ntRrrMcXxL1q0BEyy9h/LoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617833; c=relaxed/simple;
	bh=Thmf/y0SSN2KxoHs69gHv4bIXG0MkEkZ0xp/2eIKgyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8kkTcWCyx+EbL00ozTpKzKV8UKwfVFsE/PK5gJxxbYo15+tSaYwUITy3V+KR6i2K015Sv47X5xVgCX/9CR/EYgHJqx0HFiNXHlceyeCz3NdGeJTz4dEHkixHWhav39ffvzfaI2/m0EHgFdIKtAtDYIPdnP09bZxgZHcPkllzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmRKqNw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE42C4CEE5;
	Mon, 10 Mar 2025 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741617832;
	bh=Thmf/y0SSN2KxoHs69gHv4bIXG0MkEkZ0xp/2eIKgyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmRKqNw3RmVNpihAQHh4Za0Xr8n7sPBD6ToaLiEGZX/stHbWAx89DPyMVds4F6NqB
	 J53XYul+cBynJ1eLEqAS82wGxBPCRzCo3f+svEji2E0q6AnLzDzFD2TylKDO63KejC
	 mCs4DuIEi56Gb7AS7upjmjScAEPLumnC+udg+soflkeQj8Qx2GLIcijFYD4XpZJiJK
	 VIAWbBrdoEYDrVre70jLY+nE7CxKlHBJ3vKFajS9p90vXy8mrsUSpM1ggAelvw89di
	 NfRqEp6NuVZARByx489DbVdzv1O/sjsiAB3+mGyNxnZ/D1Jyz4HgaB8QdOL6MglfCa
	 FNWH38HH/7AsQ==
Date: Mon, 10 Mar 2025 15:43:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yury Norov <yury.norov@gmail.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Vincent Guittot <vincent.guittot@linaro.org>, Akira Yokosawa
 <akiyks@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250310154344.0facb4f7@foz.lan>
In-Reply-To: <87r0350yk5.fsf@trenco.lwn.net>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
	<f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
	<Z8snakYmzhaavkKN@thinkpad>
	<87r0350yk5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 10 Mar 2025 08:07:06 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Yury Norov <yury.norov@gmail.com> writes:
> 
> > On Fri, Mar 07, 2025 at 01:04:51PM +0530, Viresh Kumar wrote:  
> >>  /**
> >> - * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> >> + * cpumask_first_and_and - return the first cpu from *@srcp1 & *@srcp2 & *@srcp3
> >>   * @srcp1: the first input
> >>   * @srcp2: the second input
> >>   * @srcp3: the third input
> >> @@ -266,7 +266,7 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
> >>  #endif /* NR_CPUS */
> >>  
> >>  /**
> >> - * cpumask_next_and - get the next cpu in *src1p & *src2p
> >> + * cpumask_next_and - get the next cpu in *@src1p & *@src2p
> >>   * @n: the cpu prior to the place to search (i.e. return will be > @n)
> >>   * @src1p: the first cpumask pointer
> >>   * @src2p: the second cpumask pointer  

IMO, the better would be to use:

	cpumask_next_and - get the next cpu in @src1p and @src2p

e. g. I would avoid the asterisk and the "&" symbol at the comment - the
less symbols we have there, the better for people reading the C code.

> > So the question: if some word in this particular comment block is
> > prefixed with @ symbol, can we teach kernel-doc to consider every
> > occurrence of this word as a variable?
> >
> > Why I'm asking: before the "*src1p & *src2p" was a line of C code.
> > And because we are all C programmers here, it's really simple to ident
> > it and decode. After it looks like something weird, and I think many
> > of us will just mentally skip it.
> >
> > I like kernel-docs and everything, but again, kernel sources should
> > stay readable, and particularly comments should stay human-readable.  
> 
> I'm sure it *can* be done, yes.  In truth, given that we're dealing with
> named parameters in a prototype that we are decoding, we might be able,
> with enough clever programming, to do away with that markup entirely.

Please notice that, if we use:

	/**
	 * cpumask_first_and - return the first cpu from *srcp1 & @srcp2
	 */

The ReST output from kernel-doc is:

	.. c:function:: unsigned int cpumask_first_and (const struct cpumask *srcp1, const struct cpumask *srcp2)

	   return the first cpu from *srcp1 & **srcp2**

Placing an asterisk before "@" won't work, as, in order to produce a 
valid ReST syntax, the output for srcp2 would need to be be: 

	**\*srcp2**

Please notice that I didn't test if the above would work on Sphinx. 
I remember we had some issues with things similar to that in the past,
with older versions of the toolchain. So, we need first to test it
against minimal and current versions of toolchain to be sure that this
would work.

Assuming that the above works, we'll need to define how this
will be represented at the source code. IMO, neither @*var nor *@var
would be great. Perhaps we could stick with *var, but then we would
need to ensure that this won't cause any regressions with already
existing kernel-doc macros.

Thanks,
Mauro

