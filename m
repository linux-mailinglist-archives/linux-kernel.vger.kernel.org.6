Return-Path: <linux-kernel+bounces-317182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2396DA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6A5B21606
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2F19D895;
	Thu,  5 Sep 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R89+ySB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntjYy1bk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDD19C56D;
	Thu,  5 Sep 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543679; cv=none; b=lmD7HxHCl2ZTPfpckz0K7KKBCNc3h8/SrxiW+jF7R41bBb22G4Fo/z4l0t0tq63YnoPm2PDpvnS7YueevSKtZHYQJj4yyzQxLD3GPYDMB6sX9GpC45ImGNwfBnqTacR1xdwdtOy9tKqJPxPZ3VmGoaMD1xrkJrozYLOAdt+M1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543679; c=relaxed/simple;
	bh=5P2OM2n+bCPQ2pZuFcpMTIhN9z+UlRaRb3D6hOdyXBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3X4y4gSbzLgm4Zv/aD6Vqa1xK2xoONeCK3JZz9pWqVn5bR+KliC8+lj8HnGLqByK3F+qNH99RYKrSD+mNppYa26Gvxfyfdh8OWzKLX4rhncE92uC9yP3FQanPC+eaby61tXEmzmmeTKmL1s4RYYSP1LuG/gkLYWyssTaaJZp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R89+ySB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntjYy1bk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 15:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725543676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVuPy5ibhq9HNeDwCgZS+Bfii/7ZPF86r5AeWFTRydE=;
	b=R89+ySB92OOV3NIcInoGxt27RH76uzDrg4SKSjk110Kj1CWBgPxn2phHYTN8kT0Ykc2Doh
	AmaR9rGlDqUEhbOrq82cMbZ+THbqSjoIg9T2Wem+R3zd7MJh4BxxfclkHV0ZoK0PuLSKA0
	r+peEJeFHGRc7IqAnzfa4ncoCC5pvJNM9ee5IPSMVh3hz5LfARvBulMzw1E3f/DY7AiahO
	z2/IIZYjACe/EZB4UODnl7OM/363mgdIrVF1aJeGXH3Z/0o2mkhV1ZmrTySRWthmpR0Eau
	0IyeHYIrXufXPOqzNrK7BSLPIAcBmKBs4Ob9pvBXXyHNzet/uwaI5efw+VC8zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725543676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVuPy5ibhq9HNeDwCgZS+Bfii/7ZPF86r5AeWFTRydE=;
	b=ntjYy1bk2ydt7/H1Uk4rxuXy4/XBspNQUn6xmeWYR/MyZJkKm8nyjkVf0nwSU9r1sjyhRF
	Goc3kgxF5+awyDBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] of: address: Report error on resource bounds overflow
Message-ID: <20240905153318-ef305b5f-7987-410b-8256-aa6d01574fc9@linutronix.de>
References: <20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de>
 <CAL_JsqJ=7kX6DL_HBJMrWuhjZEmPUL++BvJ9tg3BDD9-e+b6Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ=7kX6DL_HBJMrWuhjZEmPUL++BvJ9tg3BDD9-e+b6Xw@mail.gmail.com>

On Thu, Sep 05, 2024 at 08:15:40AM GMT, Rob Herring wrote:
> On Thu, Sep 5, 2024 at 2:46 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > The members "start" and "end" of struct resource are of type
> > "resource_size_t" which can be 32bit wide.
> > Values read from OF however are always 64bit wide.
> > Avoid silently truncating the value and instead return an error value.
> >
> > This can happen on real systems when the DT was created for a
> > PAE-enabled kernel and a non-PAE kernel is actually running.
> > For example with an arm defconfig and "qemu-system-arm -M virt".
> 
> A nice follow-up would be to make of_pci_range_to_resource() use
> overflows_type() as well instead of open coding it.

Good catch.

There are some differences though, it
* returns -EINVAL on overflow instead of -EOVERFLOW
* sets ->start and ->end to OF_BAD_ADDR on overflow
* does not check ->end for overflow

I don't have much experience with OF, so I'm not sure which of these are
important and if overflow checks on intermediate calculations are also
necessary.

