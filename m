Return-Path: <linux-kernel+bounces-408929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C699C8540
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DBB29D98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F51F7552;
	Thu, 14 Nov 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLFNcThA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bh8r5P+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE95198E84
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574232; cv=none; b=lbZEQY5fV+dCQBzkrlSay997wxNbysIbNPmzd3l9dFNOYcWiMo4/AL9a9biLQtK9JtXUKbb65nBa0tCY4fBowVcedzEOkq7BxsQUFX78+7Byn/4SPcYLWYSdFzGuC6zkt7pf84+/71fz80IG5BWFvag3TJLFozmdbVRQBcVpAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574232; c=relaxed/simple;
	bh=beVDURtEqRUXGJpgDZODbDaDPt6hEfZpGMTs+yVQVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV9mBs/mOvJr9fmLZhZqtHqFTSjxTe+segjrFutZQXsw+0iVpLy5Mx58tdwmqjkUzGN25HUpfVdG3IJX8efSU1oEJuRRMQro9QUTIvuGWh+pJVhtxI6lGQIi95EoNigQzQ9mOgyV0d07QSairuMU2GUuyloxe88CK/depBl7K5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLFNcThA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bh8r5P+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 09:50:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731574229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=km0gdVEicOr0yESQ3qDL0PlwSUZ5M/uDrYtUl5IbA4M=;
	b=KLFNcThAlNfilRM6ei38Gg+9ZQAOcd304vpJsIVbSZ0/7qA2MbgNoPe9NU/mBDLgDTVS1M
	ges0ttl5NA5LhhPhjI1Cv+j04pACLdZA8ujJEJfKoyv+WXpWKhDJvqTRr1o9h8WRcWD7Fk
	AlP32kJtBgFYKLLlpC2VAdHTZi99eVSwPD2TsSL/uoaCzCRpi58elK4MeimN7k3uJcgScf
	MWLeiCsbZBx6a3QqdFbHGgBBY3sSvCXzC9v5mUGKhQEraksvLq4rGKpNEq58YeHnfN3Pd5
	QSeWJRwzuCmVSQEwRlKxchaFY1lEgtZIzq6z0ca0cxSpZv3NuE0fbxVskW5nmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731574229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=km0gdVEicOr0yESQ3qDL0PlwSUZ5M/uDrYtUl5IbA4M=;
	b=bh8r5P+U44nnB3Trr61NCxCfpimTAEF5i632Yy3EbcRYun2zYjDWrBu5TGeoM4vCxQDTne
	bwyzUzBxrQn4iyBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 4/6] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <20241114085027.cH9ZY0OD@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-5-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:56 [-0800], Ankur Arora wrote:
> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was needed, was lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a read-side
> critical section or not.
> 
> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
> quiescent states via rcu_all_qs().

With PREEMPT_LAZY=y && PREEMPT_DYNAMIC=n we get PREEMPT_COUNT=y and
PREEMPT_RCU=n. In this configuration cond_resched() is an empty stub and
does not provide quiescent states via rcu_all_qs(). PREEMPT_RCU=y
provides this information via rcu_read_unlock() and its nesting counter.

> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().

Okay. You might also want to update the cond_resched() comment,
	s@In preemptible kernels, ->rcu_read_lock_nesting@
	  In PREEMPT_RCU kernels, ->rcu_read_lock_nesting@

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Sebastian

