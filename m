Return-Path: <linux-kernel+bounces-577070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF39A71800
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D34F1899809
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFA1E5B7D;
	Wed, 26 Mar 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUuJGsRn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnAUhGJC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4B1DBB03
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997681; cv=none; b=gl6B9TvNC/l6id5rSRJlKustAkKsH6lDBM29NwV6WzAH/oBwRSm0rh6CYbHsqnJpCMy77+SxnHWKi/Pux7NhNeVMOnFRn7+nR1a6Pi/1KtQSWsD5NSo1cMIpRNM47zOo+BpTnZWX3hK5ifhWgl0tff/K3VyZ19i3FocVkuSsOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997681; c=relaxed/simple;
	bh=Igrxll/xy+jJfLMZQ+C3GykA3exQ7yATUS4lASMKXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/3YduXUi8kcXTHmuVD6wsJtGm6yGx/0YUOyvoWeq9h1MNLSCuUzeznwsjatspQ44qbIZPk4UDHO5wormPmzDwV/CiJ+JW/xmYTBkbKWBxS5Rn74FPERR0GyfqPuGSwxds6p2mI7iuc4iRc+2D/6Ll4jao91zeLquT1tsBpPxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUuJGsRn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lnAUhGJC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 15:01:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742997676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDpJi3HJJuF39B2sjxncAYZsGzMf2Cy9EDTvWaL5HU8=;
	b=DUuJGsRnWTfDQpM45hgh2Wjr7OWaV5TrRj0qf0OAodEoE68uSkeXVyFkCrlMJf4dt2zr6b
	EocSGwvRTqL94gcQs9ALfGe3vJXy9pnyJo/S/FbQzoG2/Wg00DSE5f7JzxFhzuH0yjD9TE
	ewoLLnUGckjVS/opXeRTTXzoU9QwluIeZYioCQkT7idVSvW7BgiyYMDjRI0zwMHxaMaTRb
	G8oUk5sOiJcI6EsrxR+ju9+38nJL8fJTL4xI0gLMCW2Il612H2EBqxgqRqeB6VAcI1oezc
	Yx+5kiyc6wn+hV1Tgxi08Wm6sAnH3nl2x9UECFib9+Kcwu6PF1cvi8IlZryBcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742997676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDpJi3HJJuF39B2sjxncAYZsGzMf2Cy9EDTvWaL5HU8=;
	b=lnAUhGJCeXUp/j+Asl0Xi4utCKPB46KlMiF3YuH4N78B8iVp1VWceNvTZ2iVqpAQKZ1+VL
	zVrVN48O6/SXUvAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	"Nysal Jan K.A." <nysal@linux.ibm.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250326140115.F2qcoyMa@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
 <587d45c3-2098-4914-9dfc-275b5d0b9bb7@linux.ibm.com>
 <20250326093153.Ib5b2p6M@linutronix.de>
 <7c660d7a-6c70-4307-895f-70d4aa274886@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c660d7a-6c70-4307-895f-70d4aa274886@linux.ibm.com>

On 2025-03-26 18:24:37 [+0530], Shrikanth Hegde wrote:
> > Anyway. To avoid the atomic part we would need to have a per-CPU counter
> > instead of a global one and a more expensive slow path for the resize
> > since you have to sum up all the per-CPU counters and so on. Not sure it
> > is worth it.
> > 
> 
> resize would happen when one does prctl right? or
> it can happen automatically too?

If prctl is used once then only then. Without prctl it will start with
16 buckets once the first thread is created (so you have two threads in
total).
After that it will only increase the buckets if 4 * threads < buckets.
See futex_hash_allocate_default(). 

> fph is going to be on thread leader's CPU and using atomics to do
> fph->users would likely cause cacheline bouncing no?

Yes, this can happen. And since the user can even resize after using
prctl we can't avoid the inc/ dec even if we switch to custom mode.

> Not sure if this happens only due to this benchmark which doesn't actually block.
> Maybe the real life use-case this doesn't matter.

That is what I assume. You go into the kernel if the futex is occupied.
If multiple threads do this at once then the cacheline bouncing is
unfortunate.

Sebastian

