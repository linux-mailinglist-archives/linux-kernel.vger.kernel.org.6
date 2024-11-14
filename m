Return-Path: <linux-kernel+bounces-408970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E589C85E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD82BB2BDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A329CFB;
	Thu, 14 Nov 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BiH3C02a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rK8swdz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097361632F2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575781; cv=none; b=roSfxHeuaD85InB/IiosZY10tc0PGfuAoUB76HRZrtIizNMrpDtfxO1am/tTcSrvZNgWen1WRmJnEsMiT/HUCduPp4J5JDRrGWKvNRfpOENm99e6vr6mWeTiyMYx0nNZUrq+zwMHRa6yu7BVylCaUgumF60ryQZbvWUKgHkfGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575781; c=relaxed/simple;
	bh=3IlxANAnuFAQJPKpRYOXxLSDlXSqNtW7LiVOTZMygUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSkmPzMsVbC/CMCXtzhOh9SKWw+1KuozZPFj0ckFJEKnd2XRAslWONK12AR70LiFKtGbKkWobzzrwkrf8vKDG25UReX4RIvtR7mZGJ4K/bsCcCXbr8Gr7ymQXPLMoBnDjXpZUeF4Pm1gsop+LtrMPF+VDN8gOZInNMkOuoSzqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BiH3C02a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rK8swdz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:16:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731575776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IlxANAnuFAQJPKpRYOXxLSDlXSqNtW7LiVOTZMygUs=;
	b=BiH3C02aG/1p9MVzbuVoqhLc3bi8qR+/vx/kDr0EtTqDdOFVKZ4/gBfta825yoiWSr6N/k
	zWFZOKNw4Fhhpew4BeUAYkZ5MeMmv6XNmujoB5ZCbpT1GJlhZe+R27QZR7clCXRibUuRqb
	ttcKAxZoo2P+n071NeoEX2erkEyJzDCJJUUc7KrrRPUKc69OFKhBxsehyh8XX4czUzlX8q
	Zq7lU/shg5D6GxU1UtL7Eaz4BN2xQu3hKt13N3eln2Hh2JtfUQ9GMLj2QlYS+LySRjVbNx
	DtlqUogK13Zjlirmb40JOku0VBw9inmdzE5oaZ57/KRTAXZ0QtT4ei/L6ojFnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731575776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IlxANAnuFAQJPKpRYOXxLSDlXSqNtW7LiVOTZMygUs=;
	b=6rK8swdz9Q2ueCuq0GmDjxz9ZpnzX/92mbUDuWakuG5bJcudo1m/rquUVPniARh3i/oasQ
	k4E+6mcryEhb8wAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 6/6] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
Message-ID: <20241114091614.jSmSI78r@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-7-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-7-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:58 [-0800], Ankur Arora wrote:
> Add support for warning if the TIF_NEED_RESCHED_LAZY bit is set
> without rescheduling for more than the latency_warn_ms period.

You fail to explain _why_ it is required to also check
TIF_NEED_RESCHED_LAZY to not be set.

The problem with NEED_RESCHED set but no scheduling in 100ms is a long
preempt-off or IRQ-off region .
The problem with NEED_RESCHED_LAZY set but no scheduling in 100ms is a
missing timer tick in that time. Also the previous mentioned things
might have happen.
And the code acting on NEED_RESCHED_LAZY is invoked before this check
is.

Sebastian

