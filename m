Return-Path: <linux-kernel+bounces-213605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F6907789
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AC4284C13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2912EBC2;
	Thu, 13 Jun 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzOEq1nJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vOHzYtM8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C5A23
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293925; cv=none; b=Vgp1A/ahmZbdnhnWLvDWEb9hHMCw45WvlugbNos9r960EjvRj7Xq4z/4Rr1QJUcdOKvoEQMgIJ6uMlYZZ5Mq7aZdPoebGHQ/ettqF4h+5l0iYfNVGvtmS5Vr+18w2HrTMP2KeqPCTl6+GJgzK2EDIKXrUezGd3gY5KeLSQsBpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293925; c=relaxed/simple;
	bh=6HyqqFFQPXoJVDX9A6TXXxRLT6kcrO50b/yW6RiC7GI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejKqsxvcCKZzp4bOCClNgVuGefYSyKPmaxtBuI9kJTs01RSE2hIPJ7YkmVgFGoWBvPaOJiz2yzKVWTRjJysqzU0VnGxQAJ/j9COLtaO1SnBn6Qg/wHD30qozhULaZKZphAZI25AqYUU1ZOfyzGLoVr3bzF7gNdSNAAUZaDUC1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzOEq1nJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vOHzYtM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718293922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPdE+csVR4SMwRqqNkaq+RBS1C3dGw4oeouxbAPm6Vc=;
	b=HzOEq1nJpaKlvtpzhae76zIJnQpETrRmeSrAZBNcsWl7CoXGztXuB09ICu7UBZ6JvBfU1j
	94yrmS8IPS6zlP2qcbdCcRjnsv6N3Cc1EM5HY1rebO46/1/PpUeVvpzmUbR2bT6d6zUqEv
	CVz8kbeDuvOfZArlBCFuuuhgqYuzd8CMu7VNggvboHPVQWAblP0+zPmAlXvXphYatm+6KY
	labSe7hjkY7HuqgM+uYKSC0kpnHVwBnjs+y0wwIURtHY6MajCJoX5/3hvjbZBSalcGbt0E
	11huLu0CdWVqgzoPOjR7jcZ4H8EJvoeF9F2rYsmeeeHCaV6P753IkSLLo/jmnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718293922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPdE+csVR4SMwRqqNkaq+RBS1C3dGw4oeouxbAPm6Vc=;
	b=vOHzYtM8rA8nyHS/CaCF+lAbMCfvekLsJRS9V0UWiX5HyBsZErSKEhp2RrX2GOu1So8LMQ
	iaSRIBXYW9rI5cBw==
To: Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 7 PID: 0 at kernel/time/timer_migration.c:1332
 tmigr_inactive_up+0xd2/0x190
In-Reply-To: <20240613150142.GHZmsJ1haFMVkHHjEE@fat_crate.local>
References: <20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local>
 <87h6dwzz1a.fsf@somnus>
 <20240613150142.GHZmsJ1haFMVkHHjEE@fat_crate.local>
Date: Thu, 13 Jun 2024 17:52:01 +0200
Message-ID: <87bk44zvq6.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Narasimhan,

Borislav Petkov <bp@alien8.de> writes:

> Hi Anna-Maria,
>
> On Thu, Jun 13, 2024 at 04:40:33PM +0200, Anna-Maria Behnsen wrote:
>> thanks for the report. Is it reproducible?
>
> Narasimhan just tells me that he was NOT able to reproduce it in today's run.
> I guess we can wait and see.
>
>> If yes, might it be possible to enable the timer_migration tracepoints and
>> provide the trace?
>
> Can you pls give Narasimhan exact instructions what to do the next time it
> happens?

Please add the following to the kernel command line before boot:

    traceoff_on_warning trace_event=timer_migration:*

And then everything I would need should be part of the trace
file. Please extract it after the warning occurs with

    cat /sys/kernel/debug/tracing/trace > trace.txt

and provide me this file.

Thanks a lot for your help!

	Anna-Maria


