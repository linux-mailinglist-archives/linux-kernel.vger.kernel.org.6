Return-Path: <linux-kernel+bounces-408981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D69C860D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA13B2DAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC61E04BE;
	Thu, 14 Nov 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJjKbuDX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Grk+Uh31"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E524C85
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576150; cv=none; b=CLCAO1XyZPyW1Ll6LUbVD6pfaSuZccF+XsAn3EJXiUkEyNudghGCkL4O4vgyDUCvay/ijs6jEjUSPuS2FM2iJB9a37wJ9vuft/73UhyfH+KTKPStWfnq2gzIUAOJHm6aKgAK/nw5bW6QQmSgkg3JTj0QTY3PkUY6XYzmXG/hm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576150; c=relaxed/simple;
	bh=FtMvVrIkVgS87aYeDGnaRwQsqdUP2fDxVqVQT3zYK2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL1s+AHJlhD35XuSIWkrKwlnDOGs9taUUhNjqtqkmc+Ucq9cU92Yfgwi5Wykblmq7ey+REJ+NQouhqrk4opy3OXCDsvA912KIejIqmSEcPkcsHp3ODUtp8vrsezBeAh3MgQRhdV2rPeQL8LfK56XGXINtLvMwzmcPxAHVyZ2gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJjKbuDX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Grk+Uh31; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:22:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731576147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jU6QogdISgLdskSA0MGg4nE5fmBcyP9GNCznhYTpfNw=;
	b=rJjKbuDX2afhl77Zty7d/BMMQOZukZZzxuX98WUcv3q7xJqcZVqSXQTp6aLYjFWfgh6mAN
	pe37wIDQPsn3TqyjbjYsTB0s7KizfdP2FqhhkkWiO+M1Z4B65oGZ3NTACOBY8ywO8XrvqY
	V4F8GNg07VCeUJcwsdOZLSKsTdo0mkGt4mDpAcuH3/S56Y4RwkMO28Hb+RA+Pz9aoiCSvG
	qDToo1ubr2gpZ4YezakycBl0oyG5eVPm+TGJ6hcW2qoX94PVr7GyAy4Tbi46Jc3KBcFtcz
	TGeYuTLgWxmfKEYrqX7Q5q5j4VhTtl71wg54mwGsBW01uLyeZdkvC0wNd5/90A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731576147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jU6QogdISgLdskSA0MGg4nE5fmBcyP9GNCznhYTpfNw=;
	b=Grk+Uh31urIJRtSCMGkvxDRjqxWV2fXWZMmXkLwwv/r393IhH3jklR0FoXSQiA+ZHNg9j+
	QBx8JTszDmdKktAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
Message-ID: <20241114092225.lVdeX1wG@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-6-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:57 [-0800], Ankur Arora wrote:
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. And, for PREEMPT_RCU=y configurations does this
> by directly calling rcu_momentary_eqs().
> 
> With PREEMPT_LAZY=y, however, we can have configurations with
> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
> can help.

The problem is as you say CONFIG_PREEMPT_RCU=n + CONFIG_PREEMPTION=y.
You can't select any of those two directly but get here via
 PREEMPT_LAZY=y + PREEMPT_DYNAMIC=n.

Please spell it out to make it obvious. It is not a large group of
configurations, it is exactly this combo.

 With PREEMPT_LAZY=y + PREEMPT_DYNAMIC=n however we get PREEMPT_RCU=n
 which means no direct rcu_momentary_eqs() invocations and
 cond_resched() is an empty stub.

> Handle that by fallback to the explicit quiescent states via
> rcu_momentary_eqs().

> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Sebastian

