Return-Path: <linux-kernel+bounces-355281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E2994F56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0474628439D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51D1DF985;
	Tue,  8 Oct 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eN+nz3cZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzGHFmqZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3001DF97A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393861; cv=none; b=hSR7tQw0SXVsEv+fAtwn0+XhI3yXsBet04F9+73PaQ4UIBXxAz2V61i4S129QOMSox29UjTNYTmw+UZ1TKp8bQ22ST6UY/BkPmmPGsyyJYjTH3oaTYLDLE56bvfOkP0aaoAXf3ysHNPF42IGAk9APEv0xOb55TiPGuOn2aL5Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393861; c=relaxed/simple;
	bh=mAWGVEP0Tff4m0qPzMENJwzWY5jd52I9IgyhRsmYiAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHWT1iTZOm8xEagCKLbTQWsD1DtNb+7b2HS01Q3rYMRX9J3kuKqRNlhHB+T2DkhhaIhBzsq/uAol4MuDL3h0+Zii2HJ8+R6UXM02lse/4Ey28gau6wu4c4crC6rX8+K6y4NdP3hOqX9oUCAVCIHnpNQZuctkpA5agLeqDTZ+tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eN+nz3cZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzGHFmqZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 15:24:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728393857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgGbsUtuLsNszLGe/2acSB1ElUiMRIBZM1C9nZ1HZkc=;
	b=eN+nz3cZjtoneQMBCbPV3bCAe5YSRiZ61tEsSLaT/UTvFSiXU9SIUw7SBfiWiBZygr9pKo
	TtsTdhi4CnF6/vnz0fQ+1/BwsSOC6HTxYd3e0b/7NBPDevJ6Tu0RuAcGiLyejNOvkyyVY5
	vZzErr18BmfdELmCIOZ7U1XhniG58alfKCkmL8XgeDrwbi1ToW+7tIfn7SUHzRZVuEFrNu
	hKX02TXMRVequltzpykVM7x6QxV08hSdeah0MCFI3iQbswI1NbrhxfSmEKzgELV1+J//yV
	iF2R88BK9lWY5TEl33Z6m/18zPU+kVqP+ZGijlTfnwlwJcw800FYDEeguk4IoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728393857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgGbsUtuLsNszLGe/2acSB1ElUiMRIBZM1C9nZ1HZkc=;
	b=AzGHFmqZz/TC/eca1cpQftyXcnHk1MEzN3X/lJO4aTE9UkVRedHorQ7TuEXeVvXbMLWXBR
	VQyd2egHeDqa5vDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/5] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
Message-ID: <20241008132416.9cVldCGG@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.441622332@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007075055.441622332@infradead.org>

On 2024-10-07 09:46:12 [+0200], Peter Zijlstra wrote:
> In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
> from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
> not a change in how preemption works, but rather it makes a ton more
> code preemptible.
> 
> Notably, take away NONE and VOLATILE options for PREEMPT_RT, they make
> no sense (but are techincally possible).

So this is what we do. Okay. This means we can enable the DYNAMIC mode
on PREEMPT_RT enabled kernels and switch between "full" and the "lazy"
mode(s).
On PREEMPT_RT enabled kernels with PREEMPT_DYNAMIC the UTS_VERSION
string is set to PREEMPT_RT and PREEMPT_DYNAMIC is not exposed. Is this
on purpose or just happened?

Clark was asking for a file to expose whether or not PREEMPT_RT is
enabled and I was pointing him to UTS_VERSION but then suggested that it
might be possible if we expose the current setting of the preemption
model and use this. 
But with this it won't work.
I am not sure if PREEMPT_DYNAMIC is needed to be exposed and if
everybody is happy parsing UTS_VERSION (we used to have a
/sys/kernel/realtime file in the RT queue).

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Sebastian

