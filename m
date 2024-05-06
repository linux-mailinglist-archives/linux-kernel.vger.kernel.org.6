Return-Path: <linux-kernel+bounces-169615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128E8BCB39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B501C2175E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBE142E9D;
	Mon,  6 May 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k5HVFWZ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6qKC8gg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FB1422D9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989011; cv=none; b=uAIN2XMDUp9qkisJjfXAoghKhOOCs9yycxBmLbq4MA+R16kEzFCi0ZR7onPhWXGCQb4diEhBq77e+cDCX/euNA3NKjc7/0gD26DiCKwv3LrmmZTMQtbigfhbz+aL7nJRiHpipOdEQDoQ0he2grfE/yDYuy7t/isZDLHyErp2C+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989011; c=relaxed/simple;
	bh=9+fA6x3W5sW7wIh5ABpMKfVB98eis5V3TMZpuCukAWs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRbctGXi3PRaSLaGe1TCyEwGRSQ/NHaggkzJ9f+oT3YRr2fq5BaUbmYp44RUp27X9QUFt4FZglWomVnc1OlvG47OOUw0vtwnYuj6ZNnAdW4WPbVD/k3vcjVeUJ3rqjUxXsF9inscbxBOo4afpVuJ+Nha7vmhXnn6HvAg+PehMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k5HVFWZ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z6qKC8gg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 6 May 2024 11:50:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714989008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYEcwncX0Z4LxyKRBooyxqYcoYW7DqL7oWZ6VIl81vU=;
	b=k5HVFWZ6mPRNpjqQ6zkWkw3UHkUjZNoDHgMwI9JLZwOQKa2HR5nSfCnbT8gzEOpuLrxBYz
	+LkPIL6BQXdJ+Krf4n06xjIdPdBRFSIEfv4G7gBHt8RiQj6I51jtMDBU8Q7xknJlntoyUV
	sgc84NEO4p0RUsZvkI8tf3jtOEajQuiqlMnKduBnE03sWtc62vAKNLJzAPzIa3SykrHLBw
	nSPIw5oNlxMuf32VhwJV5rEexOGWmKGF1ZyTOijjtpVgkFSsq/gy34NBnLvLjpYE0pRioG
	C1T44/2eFqRZYT9ynIe+TikVQSI3dagHvKpZfuakwCyyVUQjOra6yn2zMgqXVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714989008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYEcwncX0Z4LxyKRBooyxqYcoYW7DqL7oWZ6VIl81vU=;
	b=Z6qKC8gg4n8IC30BHxRgOlFqYg1qBj91w46K8OklO0vyYzwOQPTnkdT4YvrckefUn9+1ur
	VM/ivxmukLGL2iAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, kolyshkin@gmail.com,
	fuyuanli@didiglobal.com, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, frederic@kernel.org, oleg@redhat.com,
	hca@linux.ibm.com, paulmck@kernel.org, tj@kernel.org,
	kuba@kernel.org, CruzZhao@linux.alibaba.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Introduce task_struct::latency_sensi_flag.
Message-ID: <20240506095006.W6mrPsML@linutronix.de>
References: <20240505030615.GA5131@didi-ThinkCentre-M920t-N000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240505030615.GA5131@didi-ThinkCentre-M920t-N000>

On 2024-05-05 11:06:15 [+0800], fuyuanli wrote:
> In the path local_bh_enable()->__local_bh_enable_ip(), the softirq
> handlers will be executed in the context of current task. But for some
> tasks sensitive to running latency, we expect that they will not spend
> extra time executing softirq. So latency_sensi_flag is introduced in
> task_struct, when it is set to 1, task only wakes up softirq daemon in
> __local_bh_enable_ip().
> 
> A test has been made in two hosts named A and B. In A, several clients
> sent udp packets to a single server in B concurrently as fast as
> possible. In B, the IRQs of these flows were bound to CPU 0 by flow
> director, so there was always a triggered net_rx softirq on CPU 0. Then
> a test program was started in B, which was also bound to CPU 0, and
> keeped calling sendto() in a loop. Sampling with perf, results showed
> that about 25% of running time of test program was spent executing
> local_bh_enable() contained in syscall sendto(), but after setting
> latency_sensi_flag to 1, this proportion had been reduced to 0.5%.

Is this PREEMPT_RT related or not?
RT wise I worked hard to get rid of ksoftirqd usage because you use lose
context, priority and everything once this happens. Plus an innocent
thread can be forced to do the work instead.
Non-RT wise your performance can go rapidly down the hill if the wrong
task/ user is outsourcing the work to ksoftirqd.

And this is what you are doing: You are outsourcing work to a different
context and have 25% improvement here and 25% work somewhere else which
you don't measure. Not to mention that _another_ context could do this
softirq work if it happens to end up in the section before ksoftirqd had
a chance to run.

So, this does not sound good. If you want to have a low-latency task
which can send packets and not do the needed softirq part I would
suggest to have another thread where this is outsourced and the thread
does the work.

> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>

Sebastian

