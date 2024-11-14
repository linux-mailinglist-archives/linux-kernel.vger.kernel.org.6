Return-Path: <linux-kernel+bounces-408800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13849C83A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1DB25EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676741F26DB;
	Thu, 14 Nov 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKiGo7yn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uWZUzhOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDE1EABBB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567972; cv=none; b=a0y+JVALeOojSRLsQzI837F5QuVhTDSuO360jJg4vVHXj2hNE0lYctqVHV/qwgTAnmc+ngxElBbREq26Z4S0UgvwiFwFUc2xLM1lvRrQzCkAq9brV3NMiaB/cehGaODQC2sDrW5gkhkYHNINtHImFsc+2hVSosQIhwGGesA6UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567972; c=relaxed/simple;
	bh=/sVtScjrpr1UZS0qwxchiQRHZPE2lDgMN4OWGBbpvv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax+qbqDVto+BmZrxjGiDkVH47bafXB/ROZwdySTRp/y3/kWHmM1szz82R4TNyCQXKEK1bO++DTMoGiC9LM1jaZBACOKtcbWC93UaYe6lc7OQ6mMK+3E2OgR6M5FiNQBxZ9n4i0DvRtn2IWlbrtXD3TBU818AjkRtmeHm5X4sjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKiGo7yn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uWZUzhOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 08:06:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731567967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpeob0AONlOdcFu0G8A8bpHT3I+GRaKf2EmgU2rAoUQ=;
	b=HKiGo7ynAcBCKdtCJUocdaReI0X4rSeBvomDu6kLDHjS2RVvjK37L3l2WAPDYXixOw1VxN
	P0Mqc7Ro9nJqu3BPze/F+C6vVT4nSAEIAY4qgRIEDReuYYQIPxdIznd+i+89q0Edsr3V5G
	+pCyM4K1ODBcUh0+8WEcXZvq+ppeT9k2/ec1dTOpFZR0DcfDPRou9OsVOh+Z+ccKRFoP4g
	O+PHeWmxdvTsGxUVHy6R09U0b7m0ga4djpCHohgG4KxqoHARHwtI20pUKY44CF+Wi8ANbW
	rJB6x9/vqTxRn3XAHtAQ0ODvrFsvQOOYMYtm/GFrUFlLPSTo4DIUzXvQMdQIkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731567967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpeob0AONlOdcFu0G8A8bpHT3I+GRaKf2EmgU2rAoUQ=;
	b=uWZUzhOkDYLa4LytLjIu2lmNxZwexxC7y69NzP9vkwyPScysggJn+jzLuZd7o9t4/KTdWx
	vjIVaV6eWmK0FMCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 1/6] rcu: fix header guard for rcu_all_qs()
Message-ID: <20241114070605.bZFvKJ-r@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-2-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:53 [-0800], Ankur Arora wrote:
> rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
> is conditioned on CONFIG_PREEMPTION.
> 
> With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
> CONFIG_PREEMPT_RCU=y.
> 
> Decouple the two.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

