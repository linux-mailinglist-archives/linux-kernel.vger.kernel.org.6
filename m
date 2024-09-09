Return-Path: <linux-kernel+bounces-321662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F534971DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078B2B2352B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB03A1AC;
	Mon,  9 Sep 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqTZ92NI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5391CD23;
	Mon,  9 Sep 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894917; cv=none; b=Uul2Kw4saNpSbllB2diOTQvadtjteCRBlLzcHMdjfPTiQQTG/4ugNrvIKG2vXBB3Z05LEmeZjgA39agI3lx6wsZtkCEaqWR3ZUIlpK4Ak1z/y7MYf5EQvLNtLTCjVxBKn7L6ZOZRqi93+kYWJ2rtVZlDEK5N8f/HOVMIih4O97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894917; c=relaxed/simple;
	bh=2c4IFcMrbT8s2LSV2B0iAdU87SghNG8m8i2iTklh678=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZYW+aHSS1Hfwjp/59OzLRN+hWfYrGi1g1ayLLEHM3JcoA7bmwSC3SV4u6oSSuuynewWGvtcqdmlBtMafQmV+MPwnKTT9exWO1fiEsA7C4SwTupe3yHSe2GqCIFU5UsJuJivyfmLaEUY2m1Cjdalx6NBtV71uA9a9FSSwqam1lEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqTZ92NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD02C4CEC5;
	Mon,  9 Sep 2024 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894917;
	bh=2c4IFcMrbT8s2LSV2B0iAdU87SghNG8m8i2iTklh678=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AqTZ92NIu1O8pIQbQdKGj9VYgoE4k0n/0wJECDKpe5q++992zlyQ5ulDt2sjWvr3F
	 Qq18nOaCu4fW/cxYKgABI4xSCNYuh7YXeq3ZH4fK11X0ZQZB7Bl6tCqp2H0tdvCBR7
	 0Z0mKGzn+/z3YPQ/dCGRhUes1MYkNo/PxB1im8CC/6ZoZBpUGw4F4QjMn1uyyYls0y
	 9nDwqBv0FMl1RPfUO/L28Cb3J3ZWGWAKsN9i10sGDFUBHH4GqUCrBoUjtu44llNVTA
	 ylCHZh7UYXbnAoORXZ5IzuQPkL90BymUhI8QpJwRU5jx55MFFb3QWdD/P6uKeRs2xe
	 jpZCmM2rt/f5w==
Date: Tue, 10 Sep 2024 00:15:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: syzbot <syzbot+list692d096cfc0c03673c30@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly trace report (Sep 2024)
Message-Id: <20240910001512.f604fd970f2be1ef6e7f9189@kernel.org>
In-Reply-To: <000000000000e69f460621ab50f4@google.com>
References: <000000000000e69f460621ab50f4@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 01:12:20 -0700
syzbot <syzbot+list692d096cfc0c03673c30@syzkaller.appspotmail.com> wrote:

> Hello trace maintainers/developers,
> 
> This is a 31-day syzbot report for the trace subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/trace
> 
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 8 issues are still open and 37 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 2278    Yes   possible deadlock in console_flush_all (3)
>                   https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df

This is artifically injected circuler lock dependency about the combination
of eBPF + fault injection.

 - BPF test program traces sched_switch event. (under rq->lock)
 - fault inject injects a fault in BPF's strncpy_from_user.
 - this fault printk dump to the console.(to lock console_owner)

To avoid this issue, use another event to test fault injection.

> <2> 1023    Yes   WARNING in format_decode (3)
>                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c

This seems also be caused by bpf test program.

> <3> 31      Yes   INFO: task hung in blk_trace_ioctl (4)
>                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c

This is a bug in blk_trace.

> <4> 15      Yes   WARNING in bpf_get_stack_raw_tp
>                   https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652

This may be a bpf issue.

> <5> 11      Yes   WARNING in get_probe_ref
>                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

This is a bug in blk_trace.

It seems blk_trace does not check input parameters of ioctl correctly.

Thank you,

> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
> 
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
> 
> You may send multiple commands in a single email message.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

