Return-Path: <linux-kernel+bounces-449416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3B9F4EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D843E161F28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBF1F6674;
	Tue, 17 Dec 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hdLIQrZs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDI1rS+f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6911F63E8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447502; cv=none; b=p86bN+sE+Ebm4BH1/WTnbju+m/TNAUmrSi/pscMWdon+x3e2xFpKGatuoUIGQkVpG0ioh2VGAWCaVJk93+RES7K6rwuYy2zwf6ZR2YqDlj0//FYdXSTrvCF/sUNbROhLf7YQIs+2RLehvwSZoH/vgKfck00s2w9GuKYOR/l+adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447502; c=relaxed/simple;
	bh=RrFrT81NXNarfEyD9+e9+QlKEN3HnKOgqjkoMO237GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKkYbescs4CgYwlmu3s+r9LT5a0NTW652ZsY4y27VhRgdr7XJFgg4CcIhW6b92tfEnjdQOPuIzeEyq4vpdvGoO3U3QpjvMMGdcuPF25y//OIDdPJyHV7QhUE6Nu+lIOG2/VogY2I5UaFK7yEJnl4Nb381r76ZiTGgUDl2lYEXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hdLIQrZs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDI1rS+f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Dec 2024 15:58:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734447495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sIIygnIcqxKtlEfOZFumwcF+6lF+hsGXHKJryMU8bJI=;
	b=hdLIQrZsY4/sOQ5PTC3ts5qz5CeEL/m2Ll1GTeyW4XPnGX64IRzHq33F/pIbBFZwlFLHtP
	YkFiH2d4uBfTzNWHt98Q1ZXCo8DdXLSyQzKv625C4FHE5RTL1B+yl1Oi09Au6ENOANy2Je
	7qdBNsuPCHyMrHb3/FN76IJfVfMDMkRI7BWXyQALK1ihI1nUMePoPxBF5hsSUE2ZzD7XmT
	sb2N93TktowgJSMoeCLWbSA+ISkHYf8X6pI+fZ5Bv31UdQjlSqS54z/ALDK3HDwgZ4HBaK
	V+2epO79yFDUIZPCdwdoEeP3wdEBAiYM2ST5hIkjM0SPQ1vnNbkcB1G+JY2Y4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734447495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sIIygnIcqxKtlEfOZFumwcF+6lF+hsGXHKJryMU8bJI=;
	b=iDI1rS+fBzXIzx+XMvuRLypzXso7xtDJTaqPtFZWDL6iH87Dtlkk3YJtBg25tWYAWkWcWk
	RvEoxSmwx3aZnnBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 09/14] futex: Allow to re-allocate the private hash
 bucket.
Message-ID: <20241217145814.euTL-GEf@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
 <20241215230642.104118-10-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241215230642.104118-10-bigeasy@linutronix.de>

On 2024-12-16 00:00:13 [+0100], To linux-kernel@vger.kernel.org wrote:
> @@ -154,6 +303,17 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
>  
>  void futex_hash_put(struct futex_hash_bucket *hb)
>  {
> +	struct futex_hash_bucket_private *hb_p;
> +
> +	if (hb->hb_slot == 0)
> +		return;
> +	hb_p = container_of(hb, struct futex_hash_bucket_private,
> +			    queues[hb->hb_slot - 1]);
> +
> +	if (!rcuref_put(&hb_p->users))
> +		return;
> +
> +	futex_assign_new_hb(NULL);

I have reworked two things:
- I have to remove futex_assign_new_hb() here and let the next
  rcuref_get() perform the assignment instead. The reason is that the
  caller can change its task state (futex_wait_queue()) and blocking on
  the mutex will reset it. Instead of delaying it after the schedule()
  it looks simpler to delay it to the next rcuref_get() where it has to
  be handled anyway.

- The logic in __futex_assign_new_hb() didn't deal properly with delayed
  assigns.

>  }

Sebastian

