Return-Path: <linux-kernel+bounces-188364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79C8CE11C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14162B20D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62598128382;
	Fri, 24 May 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V3ENFQBG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="79zbjKzi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646984D23
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532992; cv=none; b=gG6O+N+UReQ1uoul5jM6SBey+EZU/RsUxqurfgUgPoogpG8SeTUX+MWFGt5Nt2R7bSKdtXrWIkL3Bj43f2md8r2KfwjdlsWsdLhipFFp2ug0H0qMHgBBLcgQ+tNCpdTGWmrekWdn+mVpq7ns0hmaHJIvptUlxMyfuXvxIB8QOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532992; c=relaxed/simple;
	bh=wEp7i5jwsZ84dHnzXTDUybMukSNpwTvEfoSfQnplscY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GreTK8dntc5mDlNTZO/R9sd82Klsp2W9qwI+iox45H+v2q6FFYU41dprLJKVKT2qqkBNHfhhtPP61QaY6bzlL+1AL5FV4ee863b53E41RW9N95FzPOalAcoMn8yg9Q4aGuXXIp2iWwFPuEJqGbCLI7uvjtmJtHb8NZe+ZPb6VWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V3ENFQBG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=79zbjKzi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 May 2024 08:43:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716532988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpRyuuJJeXMepCuk4dxVJkRfLtOIeOpXAxCVzCQEjRo=;
	b=V3ENFQBGOdFQEaBx8Zl/xtMFcug3VA8Hc66H4GDlrAWGh9SLu1eMKzb+/avBgI2pzB0Erc
	9ogjb2lJrvyDSsC3Qr5znDmfNNYG+1Vuiu1JuC3O/FoNG+aqnYZFlfE/FxjWAaUY+93pzW
	Ou6zF1VBQEU7RnpQ89rQuUzp02EXNHiUQFoBr9410wK2cu3xZIH7jA9i0enxRXkKYjyy46
	Lo6JOWOxkH9KUChbf3p7jce8aKPagO4Rj4abKynFXKNoJKhftL4UPU7T7JGvw+I4jNJoSD
	F5b7f3hSap9XTZ+KcVrmndko5hzPdqWpEf2Ul5N+uBCJBP2NA5p7lYGm13ekfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716532988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpRyuuJJeXMepCuk4dxVJkRfLtOIeOpXAxCVzCQEjRo=;
	b=79zbjKzijYSkmmeKFFiga6ihntljixAbKVzEYcXHAgJQcL50JnXhzAUvWfOyZAGb6zz7Oc
	rmes18ee96w6L5Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, x86@kernel.org, linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in flush_cpu_slab
Message-ID: <20240524064306.b98TP1nU@linutronix.de>
References: <0000000000008c9d27061915ca9c@google.com>
 <87v834g6hn.ffs@tglx>
 <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz>

On 2024-05-23 23:03:52 [+0200], Vlastimil Babka wrote:
> I'm puzzled by this. We use local_lock_irqsave() on !PREEMPT_RT everywhere.
> IIUC this warning says we did the irqsave() and then found out somebody else
> already set the owner? But that means they also did that irqsave() and set
> themselves as l->owner. Does that mey there would be a spurious irq enable
> that didn't go through local_unlock_irqrestore()?

correct.

> 
> Also this particular stack is from the work, which is scheduled by
> queue_work_on() in flush_all_cpus_locked(), which also has a
> lockdep_assert_cpus_held() so it should fullfill the "the caller must ensure
> the cpu doesn't go away" property. But I think even if this ended up on the
> wrong cpu (for the full duration or migrated while processing the work item)
> somehow, it wouldn't be able to cause such warning, but rather corrupt
> something else

Based on

> >> CPU: 3 PID: 5221 Comm: kworker/3:3 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0

the code was invoked on CPU3 and the kworker was made for CPU3. This is
all fine. All access for the lock in question is within a few lines so
there is no unbalance lock/ unlock or IRQ-unlock which could explain it.

Sebastian

