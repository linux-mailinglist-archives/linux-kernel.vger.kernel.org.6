Return-Path: <linux-kernel+bounces-534411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E98A46667
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F000D3A6406
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED421C9FE;
	Wed, 26 Feb 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVcdN4cU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6/Sb2yQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413A21D58C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586732; cv=none; b=mTeFYGtOUHUXjmMVCc+W79N7Gv0pBpWI3T3wAVg/nRocDO5sNCDs+koyZunRaanh58BdYzoc2twu+BT62tlVQ84huI9N62AUIcHJO1hYekBt5N6odkqazxKBUXubInquEtDVlVTKz8JqAh7nHfldT6BDcuebPJuTk9GZH18NTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586732; c=relaxed/simple;
	bh=ihff/4I114zmlq2rerVgXVzRtRbXazjckeOZ3R2piFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdz9uEEURG0dSow+QvorXjx8liQT76bhCWEjByia0EZOztlSSbRsdJt2U2vZNH1g22+owFMRlVvT2fU6Y4Q8ukV9dCD655NOuqS6SUXUrcqF+Kx/w4b+YvA5EE43Zqj2yxl3vnUS9viA76pR1HxP/ZVYeFF7dd26hW5wOoOtbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVcdN4cU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6/Sb2yQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 17:18:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740586728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkNenM+yKDUaHBy3c3ZJgUQZ1lxQ7VuCx5GrvAyocnE=;
	b=oVcdN4cUEvI4Wg6URhwtMZf3ufDVwWaLkwAQl+0MpUZ/7QZ7CJcRiinJ4m4r6cFPqdo6Je
	ukgTK0kBDQs1lJX3NMijk/G+df+NlvrWyxtIVC3VM+C7OUun+ILrgfOu0zPnZe++3RXkFK
	OoDN8QZF1X2CgTltQixGn2JuP3L5Xoo4qRyV/BRYtvP0irlQpLjRuzwSNwxjBc3m0xTC+w
	e8Quqru//HfCIqpJDBNM4u982aO0JOyT6Ku7WMPsA+OFOHPm0xmSXtILgLTj0Jcx9gN5tp
	HzAptuOts1QUzn1zSfzvXWJYsqwEw5Og+16AAqFqU/k7nq54ZoAA4zafk9DcjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740586728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkNenM+yKDUaHBy3c3ZJgUQZ1lxQ7VuCx5GrvAyocnE=;
	b=u6/Sb2yQ71oHgzAOdMElkLcJUxQpGhk/dHPZE4ejIPciElUZIgA1sx3LBgzdCBoXjHK+Kb
	MgEXefNK1J0qOaCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <20250226161847.eYrJFpIg@linutronix.de>
References: <20250221112003.1dSuoGyc@linutronix.de>
 <Z7iSboU-05uMJ7-e@localhost.localdomain>
 <Z7iuUObJGgZtsaJe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z7iuUObJGgZtsaJe@slm.duckdns.org>

On 2025-02-21 06:48:16 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> > I'm tempted to just assume that none of its users depend on the
> > work locality?
>=20
> That's API guarantee and there are plenty of users who depend on
> queue_work() and schedule_work() on per-cpu workqueues to be actually
> per-cpu.=20

You mean queue_work(), not queue_work_on()?
Even with the latter you need to ensure the CPU does not go away and
hardly someone does this.

>          I don't think we can pull the rug from under them. If we want to=
 do
> this, which I think is a good idea, we should:
>
> 1. Convert per-cpu workqueue users to unbound workqueues. Most users don't
>    care whether work item is executed locally or not. However, historical=
ly,
>    we've been preferring per-cpu workqueues because unbound workqueues ha=
d a
>    lot worse locality properties. Unbound workqueue's topology awareness =
is
>    a lot better now, so this should be less of a problem and we should be
>    able to move a lot of users over to unbound workqueues.

you mean convert each schedule_work() to schedule_unbound_work() which
uses system_unbound_wq instead?

I would really like to make it default because otherwise most people
will stick to the old function and the "convert" is never ending.

Maybe I misunderstood you.

> 2. There still are cases where local execution isn't required for
>    correctness but local & concurrency controlled executions yield
>    performance gains. Workqueue API currently doesn't distinguish these t=
wo
>    cases. We should add a new API which prefers local execution but doesn=
't
>    require it, which can then do what's suggested in this patch.

I see. So we get rid of the old naming and have them something like
	schedule_bound_work()
	schedule_unbound_work()
	schedule_hopefully_local_work()

? The last one would attempt the local CPU for performance reasons
unless the CPU is not part the workqueue' cpumask. So the difference is
that the middle one would be queued on WQ_UNBOUND while the latter might
be queued on a different CPU but on WQ without WQ_UNBOUND. Both would
respect workqueue' cpumask.

> Unfortunately, I don't see a way forward without auditing and converting =
the
> users.

So tried to pull the "in WORK_CPU_UNBOUND the has unbound" card and
comment where it says "prefer local CPU" card.
We have already different behaviour with queue_delayed_work(,,0) vs
queue_delayed_work(,,!0) but this does not count here?
I don't insist in doing this always, just if the CPU is "isolated" as in
not part of the workmask. But then, this path gets probably less testing
so it might be not a good idea if something relies on but does not know=E2=
=80=A6

> Thanks.

Sebastian

