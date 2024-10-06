Return-Path: <linux-kernel+bounces-352283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F80991CE8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 09:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C201F2452F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E23166F34;
	Sun,  6 Oct 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="M6FnWs92"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559D158DB9
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728198207; cv=none; b=hTdHCNZILBxKTSvyiOeovmebHR7owy2mXzx0M/EMLSaioNMqQv4zmke6TMJ4P9dsFc6GOOPm5+WBO1IEJRVPtpHjX7zlUIQeylEwBjBaYswVIIj8mKncTgHt1/Sm19kTg6u/xMydqoiMGcNsYkzZhCJ/B6LoC2jFDG14HGcFxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728198207; c=relaxed/simple;
	bh=A3jv2+JkMoCpLWPPu4FFiwqbcd/QNqiJhAqXPzOONsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7CzZ2ksGzOENdoWN7FNbnkO6tlFjT6fZHcT7BbQFywGuufXkMeRm8QmPLfkbazn4DlKiV5d2ou+bVaX2axDZWOF4DQ8j7dMBjOEUHnNz70ppIHslYzWVjAfatI0NBXXbzkaot4eQtNaHYA11DU6HKxlPko5xpqKq+zJGAEUsTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=M6FnWs92; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id xLIKskLtwtQe6xLIKsnJwW; Sun, 06 Oct 2024 09:03:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728198195;
	bh=EKs8elQaZOtggBnymL5w5OvfAy7AfNP6UeXaPvTC6yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=M6FnWs92bno1SYWLoFU+38rGCmldkKAWXfBJFGd3Gj9/NM03KnZbY14m5VH0M9c1e
	 mEG79JqLezogtUzTAsl4u+1//biJNovSdMwVn1pSXGvNNIn4U6eX/gzx7YCEI48X0H
	 V4yHsu0LRFvA95Ky2XUsRH1brRhOm9y5hbWO+wvUPI2M7jdF4cPbDm9XlvERIUDkuV
	 3F373y2WhPnBBuJu31VukUN0R+tCS5f09oIpzD4V0cdjwduVsxEzj4G6Ef36yd88N2
	 jMg9FOGtnQJaBU0Sj+R8DJheon8HK4WdPNoJI7xZ/qXF2L6XVbr3usMNIdzq0y+MPB
	 DX/B6Mjr7IOxg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 06 Oct 2024 09:03:15 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a8393bc0-6f56-4e40-b971-4a837cf28323@wanadoo.fr>
Date: Sun, 6 Oct 2024 09:03:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/psi: fix memory barrier without comment warnings
To: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org,
 surenb@google.com, peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: joe@perches.com, skhan@linuxfoundation.org, pintu.ping@gmail.com
References: <20241006060042.17613-1-quic_pintu@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241006060042.17613-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/10/2024 à 08:00, Pintu Kumar a écrit :
> These warnings were reported by checkpatch.
> Fix them with minor changes.
> No functional changes.
> 
> WARNING: memory barrier without comment
> +       t = smp_load_acquire(trigger_ptr);
> 
> WARNING: memory barrier without comment
> +       smp_store_release(&seq->private, new);
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> 
> ---
> Changes in V4:
> Added () in comment as well suggested by Christophe JAILLET.
> V3: https://lore.kernel.org/all/00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr/
> Changes in V3:
> Removed signature of Joe as requested. No other change.
> V2: https://lore.kernel.org/all/CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bWv6Qj9A8ofX1g@mail.gmail.com/
> Changes in V2:
> Retain printk_deferred warnings as suggested by Joe Perches.
> V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com/
> ---
>   kernel/sched/psi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e..175423716e4c 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>   	if (static_branch_likely(&psi_disabled))
>   		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>   
> +	/* Pairs with the smp_store_release() in psi_write */
>   	t = smp_load_acquire(trigger_ptr);
>   	if (!t)
>   		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>   		return PTR_ERR(new);
>   	}
>   
> +	/* Pairs with the smp_store_acquire() in psi_trigger_poll */

Sorry if I was unclear in my previous comment, but my main point is that 
I think that it should be smp_load_acquire() and not smp_store_acquire().

(Also, if you add some (), you could also add them for psi_trigger_poll 
and psi_write)

CJ

>   	smp_store_release(&seq->private, new);
>   	mutex_unlock(&seq->lock);
>   


