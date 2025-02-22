Return-Path: <linux-kernel+bounces-527228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29987A408B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FCF19C1074
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1F20AF8E;
	Sat, 22 Feb 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMR3ydvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536F27453
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230870; cv=none; b=tXg6bhyEykjjUonOCuATwtNc40z0CDdn6ssYBngOcHGf0xAE1F/DViV/C7k1FAF1A4wK++BcKMltc+PMpN5sdGA0nhtsuEZ3O/qZZBFNr+/BSDnNh594Qt44OvGwUUxBNEcuweIl6TisLQNnhFxEBXXhUi45RWONABKQxlXLuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230870; c=relaxed/simple;
	bh=g1EkSPNBdQaXE2bP1ALnptlXMK4qiILz19aCXql5pSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa7g1ynzrLqWbeGp4OcM5Q68EC/sxT+DtO2CjWr+Rsw2R+KhsYK8AFQGXS/StGMHflEZND9Pt0blOxgjh65OGpooqJV7y08Sp3oUNc1jq45DruorvO7blZS7rvD5RSvhUjDo2OOS/a27oos6TBQ+0BwduOflP993DscHkGeyN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMR3ydvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0D0C4CED1;
	Sat, 22 Feb 2025 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740230869;
	bh=g1EkSPNBdQaXE2bP1ALnptlXMK4qiILz19aCXql5pSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMR3ydvDgqWjbXS92N9v4aphTAfQqAUqPEpno/o0S7elMP2n1MrF/F6g1pC94QNYi
	 uK/FuoY2nHW/3Qv/A4Br4liL0yNx3eIhOcfdl6gC9xoDQOEy9/+0XaEYXd8pg3r057
	 oTVES3CIgwi/N+Rrf61HdBE+zvwmf/3BpIIzkJy0dlanh2DhgNm4HmTRdXl8tlVbHz
	 ENNSmYLbAe2QAJcujfrevEidQKdRqDZl1gVJNEay2Il+swA/KtN4T1bPG1stVBn4Dc
	 icrISTTLo9OyqfwO75BeInJczc5fyZw/rGOaoJmXXDBMzccR3t7AKnvD9ZcePjolYw
	 YyQjw/Q7BQeZg==
Date: Sat, 22 Feb 2025 14:27:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
Message-ID: <Z7nQzOQT_-9-Rbr5@gmail.com>
References: <20250221191401.464648-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191401.464648-1-mjeanson@efficios.com>


* Michael Jeanson <mjeanson@efficios.com> wrote:

> With CONFIG_DEBUG_RSEQ an in-kernel copy of the read-only fields is
> kept synchronized with the user-space fields. Ensure the updates
> are done in lockstep in case we error out on a write to user-space.
> 
> Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rseq.c | 85 +++++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0a..5bdb96944e1f 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -26,6 +26,11 @@
>  				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>  				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>  
> +static struct rseq __user *rseq_user_fields(struct task_struct *t)
> +{
> +	return (struct rseq __user *) t->rseq;
> +}
> +
>  #ifdef CONFIG_DEBUG_RSEQ
>  static struct rseq *rseq_kernel_fields(struct task_struct *t)
>  {
> @@ -78,24 +83,24 @@ static int rseq_validate_ro_fields(struct task_struct *t)
>  	return -EFAULT;
>  }
>  
> -static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
> -			       u32 node_id, u32 mm_cid)
> -{
> -	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
> -	rseq_kernel_fields(t)->cpu_id = cpu_id;
> -	rseq_kernel_fields(t)->node_id = node_id;
> -	rseq_kernel_fields(t)->mm_cid = mm_cid;
> -}
> +/*
> + * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
> + * state.
> + */
> +#define unsafe_rseq_set_field(t, field, value, error_label)		\
> +	do {								\
> +		unsafe_put_user(value, &rseq_user_fields(t)->field, error_label);	\
> +		rseq_kernel_fields(t)->field = value;			\
> +	} while (0)
> +
>  #else
>  static int rseq_validate_ro_fields(struct task_struct *t)
>  {
>  	return 0;
>  }
>  
> -static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
> -			       u32 node_id, u32 mm_cid)
> -{
> -}
> +#define unsafe_rseq_set_field(t, field, value, error_label)		\
> +	unsafe_put_user(value, &rseq_user_fields(t)->field, error_label)
>  #endif
>  
>  /*
> @@ -173,17 +178,18 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
>  	WARN_ON_ONCE((int) mm_cid < 0);
>  	if (!user_write_access_begin(rseq, t->rseq_len))
>  		goto efault;
> -	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
> -	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
> -	unsafe_put_user(node_id, &rseq->node_id, efault_end);
> -	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
> +
> +	unsafe_rseq_set_field(t, cpu_id_start, cpu_id, efault_end);
> +	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
> +	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
> +	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);

Could we please name the new wrapper rseq_unsafe_put_user(), to make it 
clear it's a wrapper around unsafe_put_user()?

Thanks,

	Ingo

