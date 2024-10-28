Return-Path: <linux-kernel+bounces-384659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020119B2CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9575281674
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F61B6547;
	Mon, 28 Oct 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFM03vSI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbM1Jfwm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154E52F9B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111469; cv=none; b=jHIADg7oz6xVNxTCJ+aisuG2MZ13Za9ByaxLwO2tQq0JGPneT43CwOhiNIgUwqX+uaBSZo+Jfoe+dQi6clJ8cmUfXMoj5SP6TiwbFFYrk2qxfCO+mjuMfhVar5Ep2BSDARPq0uTzRDABCu1NE0qGY3BoZDa5kIsUqlOwkb2M7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111469; c=relaxed/simple;
	bh=B16yNVHsF455Z3NP9srk93PxljgEo+gTcMnE+liuAUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxgQ+6O9Mw/sR7j3QPt1nGsOfxIyfnQSPuLAv/KdcHInwNZJzSJWXZTW7WHEyzyM1dIhpwj5tmCLO/FesdPQYDnaSnYyvkCXN6TwDcfhuA9xGufxTxtsJ1Wk3MIOL66Rga4rYE34vC/dYNO2FHWxIVEegbpUwvQTlWVg+xdiTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFM03vSI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbM1Jfwm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 11:30:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730111461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+TdBRRgwCH6TTFIW8XyqYwtFftLwj6CYwNGS/bjOuI=;
	b=AFM03vSIxDhR42hv7+tbPR95RP1b989+qHqAnh+mf28LfAhlasaZbv161iKrh8BIIN8ar4
	e68DlQaXyILeZtrsH9PNpWvInNKzrtNqT+xRpbDIi6CGOmUdjniiP3PgieKSma6NdsOdXd
	C9N1k+gx6BwJjCFTOAPgH9Mn2Qgpa3OCGPEekxpM6Lr/zezahfAV8x1MsKIVUGvfcvV+Ht
	+EMT5aYZfHMYD4WeBO13brXEbtQBP44nXbNWypnfyVtFMj/4O4lEkk4qbPqXsO1at0vKgS
	ihfShFdhHrRztCRmcBj8hEY4y/maUzdEnTOO0hJg9i+/t8CXNqtr5f3GqcVD7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730111461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+TdBRRgwCH6TTFIW8XyqYwtFftLwj6CYwNGS/bjOuI=;
	b=mbM1Jfwm8e/KM+tQDsbG+VLUITUqBV1mgODMiqey9P5CeNJWL39qNRsgpn7eGQuJ3BUXlA
	29ZWIZufmFTkL8Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241028103058.tERYBWZu@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <87cyjl4u1h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyjl4u1h.ffs@tglx>

On 2024-10-27 13:19:54 [+0100], Thomas Gleixner wrote:
> > +	if (current->futex_hash_table)
> > +		return -EALREADY;
> 
> You also need to check whether a hash table exists already in the
> process. The table must be process shared to make sense. So it should
> live in current->signal, which is a valid pointer in the context of
> current.
> 
> So this needs some more thoughts especially vs. automatic creation and
> sharing.
> 
> The first question is whether the hash table might have been already
> created when the application reaches main(). If so then this call will
> fail.
> 
> To make this work correctly, this needs proper serialization as well.
> 
> Assume a situation where the application does not allocate a table
> upfront and the first futex use happens late when threads are running
> already.
> 
> CPU0                            CPU1
> T1                              T2        
> sys_futex()                     sys_futex()
>   create_hash()                   create_hash()
> 
> So T1 and T2 create their local hash and the subsequent usage will fail
> because they operate on different hashs. You have the same problem
> vs. your allocation scheme when two threads do prctl(ALLOC). We really
> want to make this as simple as possible.

So I moved this to struct signal_struct and limited allocation to the
group leader.

You want automated creation of this? For everyone or with a hint? This
is 64 bytes per slot due to the cache alignment but event without this
struct takes 56 bytes on PREEMPT_RT and 24 bytes on non-RT. So the four
slots are 256 bytes. Assuming 2.5k tasks it takes 625 KiB. Maybe not
that much.

Let me post v2 the signal_struct and then think about auto ON.

> 
> Thanks,
> 
>         tglx

Sebastian

