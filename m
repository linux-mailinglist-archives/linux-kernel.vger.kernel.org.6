Return-Path: <linux-kernel+bounces-434585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E3E9E68A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF46D1620B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA761DF274;
	Fri,  6 Dec 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmCbf1/Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXW+boal"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B81D935A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473146; cv=none; b=kxxovAwQ8CB3vq8AnpKS64wCvqfO5ooMqoXoJmJadiYSwQc61p2i2Wf40ymRGlK1+BwhsrhNAwrrQoFlxuS6cpSrplVNNLfEp6xv0wwzcB0nMgz0kmkLjJdQTww/lft8QZdHjWvHEa1C3tfeMp0DY1u9F2ZghRtB5dlTTOzRga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473146; c=relaxed/simple;
	bh=KRIYyavnKYu+t3bWkla4nojjnl6N/DqSm7gf2hp1BsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew2IcFSURgMFhXtOvDgJXR1dfGaPRaqVHGyod+RaM4G/S4OLvzgAIsvtN4qBKSrW3VGbpiZTpJFoIKQE96QRkPqnXC3SBYieZIjUCy1T9KaCAacjkJx2PKx9yuBuRyJ8sf0mMoNuXoIpfbuYwTwQcCjh6qrMimldJK1QNItB7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmCbf1/Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXW+boal; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 6 Dec 2024 09:19:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733473143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjIntSzuffv2x+joxRCuwKm7MC9U7l2H1EecTvX/5LU=;
	b=cmCbf1/Q7wsxJr7BBd20azJqdkR5vTKXUpSDnCmGJc5YungkovsdM+emYa79kee/jvu1Js
	4+M89m0k9dKTNBfw0vckkPX66KSS6GNA1vRf9VY76qie4Dpcj4bA0OK/cdMcxRCGMCdSmW
	C3Q+Aomt41tkBgdL64tWPflVfAiE3fmWd3SSkNQuNAqgVX+xSOn3wRZmdyqBnJpTr1tRbk
	ZKHeKmslHUTTmf+qpFVFQDayHdzbr6y18FpsmQNwbYjTfrso3SFe1O36gPgWbkhjzVFjpJ
	Iud3dE/ZvI7x6r4mLaBoHudEwM9AYrjdCvKD1En27wbWOeUd8tlQNEvWObIu9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733473143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjIntSzuffv2x+joxRCuwKm7MC9U7l2H1EecTvX/5LU=;
	b=bXW+boalyYXYP0HB7J/GXMMGB6Em4bbbXOchsRuGdkGQ0g9MEKSp1OCfRZ+HltSrj+dCbt
	jhbwMXXwHsPiXcBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v4 07/11] futex: Allow to make the number of slots
 invariant.
Message-ID: <20241206081901.cPNVptQi@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241203164335.1125381-8-bigeasy@linutronix.de>

On 2024-12-03 17:42:15 [+0100], To linux-kernel@vger.kernel.org wrote:
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 0dd7100e36419..1abea8f9abd22 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1323,6 +1335,36 @@ static int futex_hash_get_slots(void)
=E2=80=A6
> +bool futex_hash_is_invariant(void)
> +{
> +	struct futex_hash_bucket_private *hb_p;
> +	struct mm_struct *mm;
> +
> +	mm =3D current->mm;
> +	guard(rcu)();
> +	hb_p =3D rcu_dereference(mm->futex_hash_bucket);
> +	if (!hb_p)
> +		return -EINVAL;

Dan spotted that this should be false.

> +	return hb_p->slots_invariant;
> +}

Sebastian

