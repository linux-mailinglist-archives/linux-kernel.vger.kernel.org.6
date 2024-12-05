Return-Path: <linux-kernel+bounces-434014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A169E6025
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3480128212A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4C1BC9EE;
	Thu,  5 Dec 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VbqrfznH"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB43A1BF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434364; cv=none; b=Udh+f+Vl1JSsSsMo3tAgloZ7TbmBeJ6GNCXg65qizmPdLJfEUzLmN2H9SsnoMiQCnKnLYgNIPytcVX449I1HdFz6CkpNkulKWl4aKG3W7+xaokjDoId1CA03pwkzC+tQTJ1LXAaZlT/6PJrEFsUDOgdNx6ruYt17FfnNxRaO3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434364; c=relaxed/simple;
	bh=d245TM7TRoeflKb+grbpzAdlrdczq38xHHhrgWegxRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdmdppccaj4i8UZGrCUL3fp1v08C2DoO8e2r2qyzlSUyRJV/O6h7ahPz4sqVmjAYeiZg9lpuiAhIgMsImnl/nXhZqBelayCFOWrdwZ90sSCTKNut7Y2CSPVqli+HrijjQ31HYY59Q0gXOiRSoE+mm1QzWXczsJJmKAPFh5nmDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VbqrfznH; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JJJetXoMbFm7WJJJetb1oA; Thu, 05 Dec 2024 22:23:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733433802;
	bh=/s7qSsvVwXKTD5NcierhUMHk9Z7LUK/W6kfD1GFPHkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VbqrfznHLybwoaJWgefxc+/Ay6+ylIWRi3EgXKEqaZVDkq+HxuBBeyh0noqk3tJ5F
	 PAGi+9tbe4hmUwaQXcEWWxxN434ReUdWxB4/RlFqi8t0ON6Ew4SGpE7VucoNRPp4UO
	 7EGekxoRFcAJrfzJdAHITNy766uKnF/jbHMLkVC+AZjIIXd+OXVe7ttE39PSLM6CM+
	 tc4ryqcUlP5VgveCGMcPtWu5VOPGufKjguYQ88IZbTZHkIVBTPHHPvZxUOsaPTsIyt
	 s2sS3IfjzWEfV1yAHRsR4U4u0+iQ2kSvEJ1IqARR0QO2kMAoLBX56VEMUXoar1C0dm
	 RPcTu/drD4QGA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 05 Dec 2024 22:23:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <06444675-136e-442f-918b-e7887d2c535b@wanadoo.fr>
Date: Thu, 5 Dec 2024 22:23:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched: deadline: Remove unnecessary goto label in
 pick_earliest_pushable_dl_task
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Wanpeng Li <wanpeng.li@linux.intel.com>, Todd Kjos <tkjos@google.com>,
 kernel-team@android.com
Newsgroups: gmane.linux.kernel
References: <20241205211632.1181715-1-jstultz@google.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241205211632.1181715-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/12/2024 à 22:16, John Stultz a écrit :
> Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> added an odd goto label that seems to be unnecssary, given its

s/unnecssary/unnecessary/

> called unconditionally from the bottom of a while loop and the
> label is at the top.

Except that it is not a while loop, but only an if.

Maybe, changing this if into a while would save a few lines of code and 
be more readable as-well.

CJ

> 
> Thus, clean it up and remove the label/goto.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: kernel-team@android.com
> Fixes: 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> Reported-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/deadline.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a61..566a05efa4e57 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2501,8 +2501,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   		return NULL;
>   
>   	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
> -
> -next_node:
>   	if (next_node) {
>   		p = __node_2_pdl(next_node);
>   
> @@ -2510,7 +2508,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   			return p;
>   
>   		next_node = rb_next(next_node);
> -		goto next_node;
>   	}
>   
>   	return NULL;


