Return-Path: <linux-kernel+bounces-561369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F1A61085
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6084B170F41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4C1FCFE9;
	Fri, 14 Mar 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mmc8hC8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbdsxSIK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBED1A83F8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953662; cv=none; b=cv+8Ezs765FD5HTbGRQ+/DeUv8iC7hu8ZcKwB2KU4xWuMEflRki2c1xFMN55Uk09a1+MR9XJY+JzDy3mC0kQhCLtDPWw4zINHN2M7K1j0XATuH5u9B7XDE5H/WaRRd6Z13/2LK02b+gWI9uOqaZ+TjByyJgbr7M0njf4J+RquEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953662; c=relaxed/simple;
	bh=PZ/TGt845hR/ZW06wr8QYJBGMskx/fnw9fKInqfDlJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB00Br3zZUApybNpL67bD+88+SvPTZQVPSpOiSmP1nbZA7UVv90he2pa7Wn5BHQrB7TEZcPh5+ZEBZ+29bbwheHFjf3iQorUDsA8xRdo24Ur7hErwmauIuxDi1ziMgPCCkJB0+WLmaQtVi0bb04EQpQ/ahe7QXnK04zSAV59PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mmc8hC8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbdsxSIK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 13:00:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741953659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dE7BFelqkjVV5FXF6c3TOSPVc0u66puMADltrlZkU1k=;
	b=Mmc8hC8iqhvQ0RbqrI+ye4OkxOO/igOiykP7OiEmL2zmvMAJZ7Sy7/2S1PdmS/ix4QoGfQ
	9oErLh43cMiur3O6NXgmwoPah5o483Wwylv4vXYpknbmdwS2usafsAKTyfiJBLYbnEgN1W
	mVCyxqwxd3XaqvdjmjRDWn6MKSNmCC3WYsMIklq83jLFkW7Jwnv+HETOHNuwboLe924BG2
	3RC8kNVVaMMAT0K0JmwmxS5QYV/OEe7eaRSt3QtmPoCJ9t05dBOoaWmVldGmWyWM6AhmOJ
	XHEoJriX2dvL7dUgEWQYyFZPCz/7LOJxeh8hrdahsOv1NQ4Yg6hEGINunsHJzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741953659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dE7BFelqkjVV5FXF6c3TOSPVc0u66puMADltrlZkU1k=;
	b=CbdsxSIKFbflRqHHf8PeS105npsx+qEjmTQEvLINCSekLt5UjPovitZJUzt5qC8cbijNGn
	4y31JvOu+W4H0JBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314120057.NcjcFp3K@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
 <20250314114102.GY5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314114102.GY5880@noisy.programming.kicks-ass.net>

On 2025-03-14 12:41:02 [+0100], Peter Zijlstra wrote:
> On Fri, Mar 14, 2025 at 12:28:08PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-03-14 11:58:56 [+0100], Peter Zijlstra wrote:
> > > On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:
> > > 
> > > > @@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
> > > >  		struct futex_private_hash *free __free(kvfree) = NULL;
> > > >  		struct futex_private_hash *cur, *new;
> > > >  
> > > > -		cur = mm->futex_phash;
> > > > +		cur = rcu_dereference_protected(mm->futex_phash,
> > > > +						lockdep_is_held(&mm->futex_hash_lock));
> > > >  		new = mm->futex_phash_new;
> > > >  		mm->futex_phash_new = NULL;
> > > >  
> > > 
> > > Same thing again, this makes no sense.
> > 
> > With "mm->futex_phash" sparse complains about direct RCU access.
> 
> Yeah, but sparse is stupid.

I though we like sparse.

> > This makes it obvious that you can access it, it won't change as long
> > as you have the lock.
> 
> It's just plain confusing. rcu_dereference() says you care about the
> load being single copy atomic and the data dependency, we don't.
> 
> If we just want to shut up sparse; can't we write it like:
> 
> 	cur = unrcu_pointer(mm->futex_phash);
> 
> ?

But isn't rcu_dereference_protected() doing exactly this? It only
verifies that lockdep_is_held() thingy and it performs a plain read, no
READ_ONCE() or anything. And the reader understands why it is safe to
access the pointer as-is.

Sebastian

