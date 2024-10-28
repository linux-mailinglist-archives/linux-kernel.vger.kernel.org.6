Return-Path: <linux-kernel+bounces-384640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0579B2CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A6F1F21FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65B1D0F56;
	Mon, 28 Oct 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UrI9Y8a5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRjKHWna"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB9193091
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111056; cv=none; b=nliVlzfjw/3MqK8EGHOC3N7qx/ZVpj4QOJxEt8kmTv9WZ93aL/h0LRJu6utT5y1mFLrPKg2WwcTlQ8fpdTyxbcVgqRZP51fFUZz2U47csz4qkIrA7oFpM9tVVWXh4Hnfth7XPw3XxmhEfJmnateOYPT95X/e/koUAoztqHNiFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111056; c=relaxed/simple;
	bh=275+2h+htJx/GJOFq6L9NdfF7U3GYueybydXhCwSRZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy1zM54Us9NHW0Yv0fAQqqEp7YlpB9dzab3zuGo0QM4rt0pzilMPYISh6oAL8I/BmMyzzzItcqCfk0Z7S2IEWu5Z9EQ3dTkkXSQ1ConuVXqqF79QMZydCkXalhPgADu9VoIejW1pZElIeEZWmF2Hht/VkLtWxlea8Zmsnjxb/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UrI9Y8a5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRjKHWna; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 11:24:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730111052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=py4OMr2UnGe0jsATofcKzBedko+C/J2SAgL1NcAKMbQ=;
	b=UrI9Y8a505Cs83aJYWv/0UTzHcVCWgKfDuvbVktXdYPr21w5q15iuKVnFg+gfhN/wp0IVk
	CUvk99FkJCPWRehvxm0O6rFBwhQ3kJvO2heL66dmXle0rfAvPUnnE1+CClxhbUW4S41ZDH
	8T0sUptWfhyYoO3Ps1+fXoEMeT+1+LcdwFrIk0iXIt9dXAxIoysRWPA0BbrUlHuwLf3pZ2
	B8ckwbHX3b0z8paRgyZNCl6fACvJQE1CxFA16e46pzfyBzOG71r/53bi1rc6mVh5Cftp3w
	yQSxndkSE4NTnYXpQMxKkt8DRNuxamkW7Fz1s83+u48z0fR4zPf9dnRYFzo7OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730111052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=py4OMr2UnGe0jsATofcKzBedko+C/J2SAgL1NcAKMbQ=;
	b=DRjKHWnasznsrUGqQmhsfkTxzRW6r+Xf7pF57l92FLTzN2xyNlRe7WsdgQMkuUNGZvC9ea
	w+8XiYthgIGgXTAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241028102408.GbFgnLMF@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <20241028101633.GM9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028101633.GM9767@noisy.programming.kicks-ass.net>

On 2024-10-28 11:16:33 [+0100], Peter Zijlstra wrote:
> On Sun, Oct 27, 2024 at 12:34:51AM +0200, Sebastian Andrzej Siewior wrote:
> 
> > Introduce a task local hash map. The hashmap can be allocated via
> > 	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_ALLOCATE, 0)
> 
> Per process, per task is useless and will make things malfunction.
> 
> Things missing in this patch are CLONE_THREAD / CLONE_VM, and create
> must be absolutely forbidden once mm_users != 1.

I moved this to struct signal_struct and limited it for now to the
group leader.

Sebastian

