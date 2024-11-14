Return-Path: <linux-kernel+bounces-408808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B859C83B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235C71F23829
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85E1F76C2;
	Thu, 14 Nov 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1Ltsnh1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BALTgwHY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8D1F76A7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568030; cv=none; b=FeU1A/b/5DNMIXJB8zkuQmuukea8LadHXBXzlXcgjB28/0TrIbFZZWZ7myh6er2GUKxpCCdbps5Co1fzjhr+GBHMj3FlKiAp8SktQ8irv9oE9Hna5A78Q53kSHwOuux1QZ/BXoJ1HuZ4pgECSFrm7bLsptpmcNxZz3aBKyZn93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568030; c=relaxed/simple;
	bh=EbuAVwoui6CniZhOmLWkmt4LB5SDlq4OGysLELSag74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY6ufF27ai98WCRs4oz0P2cYiVlx0DE7do2PZ6nuiGzH6Knu5FTXQLl0gi2zLOgxeZZRrVlVsKXOi/yvRdzGlDEQ4x5gqK5EfUahDh/wF6e0vX6MY4v+EgH8MW1TLhUS7b10w5O3keVhFSRj4ORiO0RHtnPOb+RrlZjPMpx0ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1Ltsnh1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BALTgwHY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 08:07:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731568027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtNL2mjEKEjg4lPIuRQMVTqvTjA1uNP6e8KlhFWBwgQ=;
	b=V1Ltsnh16QBFC2HNuXEgNsuw9TefuGH+JUIb6uiki2QPJcH8i1mTlwJf4HY+q8KkPIBjlX
	vS644qSGqD5V89UvlvzD4WQGGAIdb/rbYN6VGLVjLoN4/FfPuPjG18NZcry0sVTvIdPdmF
	5zVIOvuDhGJdvBaBKcRuWjc+Zi+nPXUNbg3v9UblTXh4rjifIyxE5aye4H1DrcRT7fVPhh
	4X+rvZyAjSd3Wtn4IRlU4QOPedLzXwo99ts2aXp/kM75eqAprAyD/k5u5A5TJyruoxmera
	ugF47HEzzC1dzxdkVvGr+XYAFH7LJcSOwhQhSwiLCNtInL/vl0RBJctateWNaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731568027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtNL2mjEKEjg4lPIuRQMVTqvTjA1uNP6e8KlhFWBwgQ=;
	b=BALTgwHY9sn/DxF5NBaf2rILD3Dfi6j5TpyNu3uKIE4uzeMxpn1jHewBHigaCegi8IJDm6
	MiWHaW+HvZd/g9Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 2/6] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Message-ID: <20241114070705.fuGqqmZv@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-3-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:54 [-0800], Ankur Arora wrote:
> Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.
> 
> Also, since PREMPT_LAZY implies PREEMPTION, we can just reduce the
> TASKS_RCU selection criteria from:
> 
>   NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> to:
>   NEED_TASKS_RCU && PREEMPTION
> 
> CC: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

