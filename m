Return-Path: <linux-kernel+bounces-358352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7B997D84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB11C23117
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB51A08B1;
	Thu, 10 Oct 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXy6X5+S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flRLz/Ka"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8013D6B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542488; cv=none; b=fTgi9OvBGV0fl8xlp4/X7OX2kue52qUttv6Awjj+75F7aVp6iTLlo5TaL+CorA03J2wc1zjLwcWSgyR3Yeu93TF1tuc3wm+jQ2jGK6VulU8rCkWH9LLlIGrObGs6PFLyI5jybQMGRTHxdKooeqTCLlHwLGpiT3UMhSQWZYtkLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542488; c=relaxed/simple;
	bh=vCNpzH9/Bpf0rY1sEm5I0l+DDrpbv5dkEGS42I4baWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IusBAHR67OaViJsfRpPssOJxP76SnuB9/EBRoe4ldTNPscuU1dY1YUZweGqAS5wR/EXwFbO3/6eatMWW24qiNYItSX89p6027dVoM8R3RPDFZ6jsMw7DOVWkVJ8JKvgpvVVnvmH3yYPDiF4Lah7Rh7WTDlVw7nMr/BSENhiW+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXy6X5+S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flRLz/Ka; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 08:41:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728542485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTUz+9n0BCU3HeggnsXQjdtGxyJjrgCP39ImYZ/hBsE=;
	b=tXy6X5+SNm0F64+JhvSk0UKzi4GtUGewvS+3KuA9U2sbX8WrIUoEPgy5f7tlWx5mu8VnX1
	TuWUij3Z9YIB7M9BXH5KsfsNRq8NmmaMc9JhXz2vNT4iTrA4gvjUEeq9TV+DiNLhNr52rV
	Zm9s96idIyz1w0ZByCkhB3+I4T/DRkznCrePL96Qnwho0r0/G66PMJROBMom8jZR4mHVRD
	+0G0OusD/i+7uO0cPWW0pGNk9Qn5UjbAmj68maHGxae2e1+Ln2UrjxdGF7PM5dUuCtXcRi
	Wjy+DTYqZT/VAFH7nhMS5HK+gRQx5crr9U/G4n/9GEpuImCCiFjd5TlkgqTCiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728542485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTUz+9n0BCU3HeggnsXQjdtGxyJjrgCP39ImYZ/hBsE=;
	b=flRLz/Kalfab1+dS+VvcAyJ1QsWCaYh9GS91/tiNNygXPTh8OJz0nLl/kxVtYHcY9TWpp2
	byT+JdhNe11IPvDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 3/7] rcu: fix header guard for rcu_all_qs()
Message-ID: <20241010064123.WJjDYegr@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-4-ankur.a.arora@oracle.com>

On 2024-10-09 09:54:07 [-0700], Ankur Arora wrote:
> rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
> is conditioned on CONFIG_PREEMPTION.
> 
> With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
> CONFIG_PREEMPT_RCU=y.

From kernel/rcu/Kconfig:
| config PREEMPT_RCU
|         bool
|         default y if PREEMPTION

this looks like PREEMPT_RCU implies PREEMPTION.

> Decouple the two.

Sebastian

