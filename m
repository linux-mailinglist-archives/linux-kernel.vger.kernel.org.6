Return-Path: <linux-kernel+bounces-409724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6F9C908E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55EF1F22DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027C433D2;
	Thu, 14 Nov 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exg5+tYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF936F307
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604353; cv=none; b=lTMz5a6pbArFRZTCum3GASXhpDSFoWu4lAgW5qAVKDlFWP/BwYP2OD2UUsRpj63+uxOAop9DuAgVKZGkciWdEraqPqdv3okrJN0pFNXw4VdPU+I9Ci/ZuO8f3TJnnwN6r7tWA0CjofybtU8kSPam1UV8Dqcwo6nrG4Tkh2Ezo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604353; c=relaxed/simple;
	bh=n3xE733z5jputSl8VVs0fOKd2DLeSer73+VDtwPfqqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUX7HZ4KXzxiV4o10vGGaqWpJOQpGTkiWczBT87uMDL2wSeNbozn1xgR4g0UC+NdnZVHlPAQRwzA5bMu2Ztl1aciPMwDvLZSdiKgyfrid9f8D+0ujBFZf1a/lh2jts+BXD4GIR+OAksiLVz9Hfyn5Te9VYddtVyv/EWWfG3aW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exg5+tYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE26C4CECD;
	Thu, 14 Nov 2024 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731604352;
	bh=n3xE733z5jputSl8VVs0fOKd2DLeSer73+VDtwPfqqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exg5+tYX8cBBTcWvKLiix77gUwR6JySws+FQeOYIhWHXYxB3zim03rHob8MZs04oy
	 bTkvTC/B8DTQkddXfTxAIe6g5xGgVztHEoAX5zAswqL/bClBfKqcCqv1POr8u5haWW
	 ++qV+QgeZm5HYeABZOEVEr0U6PaNNUEUuuWFwp4d0XjEVMjgX61WpcMDHs5jWquVfx
	 lW5F9JJKTcuwRQdFcG0IqwBJlEKK1TgQuYru8s5U6GEzpZ5ks98Mt6H4QaEVT6X1eZ
	 woVdPPTz6fEYyl7N+mdFLzut6YQaIv2ZcvtnZKd+D1PeVbDTbfNp92e3wr8hVYrls4
	 0uugi43GlcPqQ==
Date: Thu, 14 Nov 2024 07:12:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Replace hardcoding with macro and minor
 typo fix
Message-ID: <ZzYvf2L3rlmjuKzh@slm.duckdns.org>
References: <20241113025908.306936-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113025908.306936-1-zhaomzhao@126.com>

Hello,

On Wed, Nov 13, 2024 at 10:59:08AM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> 1. replace hardcoding with SCX_KF_UNLOCKED.
> 2. scx_next_task_picked() has been replaced with siwtch_class().
> 3. minor typo fixes.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  kernel/sched/ext.c             | 6 +++---
>  tools/sched_ext/scx_qmap.bpf.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1b1c33f12dd7..832f77d1d318 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2759,10 +2759,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  		 * If the previous sched_class for the current CPU was not SCX,
>  		 * notify the BPF scheduler that it again has control of the
>  		 * core. This callback complements ->cpu_release(), which is
> -		 * emitted in scx_next_task_picked().
> +		 * emitted in switch_class().
>  		 */
>  		if (SCX_HAS_OP(cpu_acquire))
> -			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
> +			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq), NULL);

I think this is actually a bug. David, shouldn't this be SCX_KF_REST?

>  		rq->scx.cpu_released = false;
>  	}
>  
> @@ -6096,7 +6096,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  		if (cpu != cpu_of(this_rq)) {
>  			/*
>  			 * Pairs with smp_store_release() issued by this CPU in
> -			 * scx_next_task_picked() on the resched path.
> +			 * switch_class() on the resched path.
>  			 *
>  			 * We busy-wait here to guarantee that no other task can
>  			 * be scheduled on our core before the target CPU has
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index ee264947e0c3..f230641929ec 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -5,7 +5,7 @@
>   * There are five FIFOs implemented using BPF_MAP_TYPE_QUEUE. A task gets
>   * assigned to one depending on its compound weight. Each CPU round robins
>   * through the FIFOs and dispatches more from FIFOs with higher indices - 1 from
> - * queue0, 2 from queue1, 4 from queue2 and so on.
> + * queue0, 2 from queue1, 3 from queue2 and so on.

The number to dispatch is determined by:

  cpuc->dsp_cnt = 1 << cpuc->dsp_idx;

I think the existing comment is correct.

Thasnks.

-- 
tejun

