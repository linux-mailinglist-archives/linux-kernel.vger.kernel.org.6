Return-Path: <linux-kernel+bounces-443447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BE9EF165
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E83C188CE85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9A22C37B;
	Thu, 12 Dec 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WNwSBVpg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BywmcS0N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FC215764
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020212; cv=none; b=eHmyq4GU1Db8TP8pQ5qNHC1irjIxZYWqNp7YB4uwZiv9ROjI2oGPrzPlYzyM0FEPYWgs4QVKW0DiOok4QfjmAUF8mxctDyGQKRaCYBXamDQn9G5Q1LElqZoy3NXAuwJuQat2yQx7qRZL8HwttDPRqqtLocspvWS+jez3x79wyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020212; c=relaxed/simple;
	bh=7hNn7jsNox1lFgKagbGf7VI9/di+xBYjxR3qn+QQIJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl3zMduJ7iNuLUsjBLbcWocLkoEEKJBbS495Yu110Hqduexo7FfmztWrMd21lAW+Up6ALqsxEIB21adrsCUM05/Fo9uV+YdKW1eX1zHbZPQhawMbPKO7KBeul7gRY/Za2G7HTmzP07rwZ62RPlMVj2K4+dv2C79HIJsKwjnuBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WNwSBVpg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BywmcS0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 17:16:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734020209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsSzR0g1eP3SQqwrKDUeiAkzyQHkvWkas71Yt/ytVJo=;
	b=WNwSBVpgKRGkpB3EsafyurBDzodZEwAJFSHr23R6U2QEjr5bdQf97IM07FbDMfsnIZwYtX
	wITmwtxB15Ku117J6gRfiKEqmgdQgggvcXS1rMieLwJlBa2nsv7+Y1Kbg6ZafXlmwARBfr
	MsHaXGVmZEbfvPMDiJFZBuZeBsCHdgY77Jxb5Of0uEX6gvEnkur2taWBq6WHRF1naZ49x1
	HvbK2Qo+0E7Ej6owtk7+y9CN0MGHpaqogjwJljyvGbAf4FC4dzEcYKuqYPEvyNls9lUkgr
	Y6C0cgyHKWHs6uO9eYPjfUchcV7mxlyXqVZcPRbKTB9GgD7kWIxR1UUeOu42JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734020209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsSzR0g1eP3SQqwrKDUeiAkzyQHkvWkas71Yt/ytVJo=;
	b=BywmcS0Nj3hHawH8wVZcBFS9cekQDl69EMyAI6zLMZ3L/pv12QNkvI+8/Pau13O4kqqjrQ
	weHjxhBuk0YiiHDQ==
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
Subject: Re: [PATCH v4 06/11] futex: Allow to re-allocate the private hash
 bucket.
Message-ID: <20241212161648.W97qL77l@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-7-bigeasy@linutronix.de>
 <8734ivcgx7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734ivcgx7.ffs@tglx>

On 2024-12-10 23:27:32 [+0100], Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> > +static void futex_put_old_hb_p(struct futex_hash_bucket_private *hb_p)
> > +{
> > +	unsigned int slots = hb_p->hash_mask + 1;
> > +	struct futex_hash_bucket *hb;
> > +	DEFINE_WAKE_Q(wake_q);
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < slots; i++) {
> > +		struct futex_q *this;
> > +
> > +		hb = &hb_p->queues[i];
> > +
> > +		spin_lock(&hb->lock);
> > +		plist_for_each_entry(this, &hb->chain, list)
> > +			wake_q_add(&wake_q, this->task);
> > +		spin_unlock(&hb->lock);
> > +	}
> > +	futex_hash_priv_put(hb_p);
> > +
> > +	wake_up_q(&wake_q);
> 
> So you wake up all queued waiters and let themself requeue on the new
> hash.
> 
> How is that safe against the following situation:
> 
>     CPU 0                               CPU 1
>     hb_p_old = mm->futex_hash_bucket;   hbp = mm->futex_hash_bucket;
>     mm->futex_hash_bucket = new;
>                                         // Referrence count succeeds!
>                                         rcuref_get(&hpb->refcnt);
>     futex_put_old_hb_p();
>                                         // Queues on old hash and
>                                         // is lost forever
>                                         queue(hbp);

This does not happen. futex_q_lock() check if the hb is valid after
locking the HB it obtained. So if the HB is still valid then
futex_put_old_hb_p() will see/ wake it. If it is not then it will drop
the lock and try again.

However looking at your proposal below, it has some benefits. Let me
implement this instead.

Sebastian

