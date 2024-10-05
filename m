Return-Path: <linux-kernel+bounces-352067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BA9919BD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E43B1F23669
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2515EFA0;
	Sat,  5 Oct 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="S9uxUOVb"
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFA15AAD7
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154411; cv=none; b=RZmOD+g/tRA0eUesSVXYdOlGVqeTQa3ZQ+eFy66TTLgGsRcnUGYXUbcxt+ZXUwfH3U3KjkfeUtJLy82cfOwXJMaYlWhu2OcUsvrajI4nsKmns7oXLRjqHyQApVgktNMSQe4pAwBLhgjrpuQ/Q3YpeHcDD9LgImMnmZePeMAUAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154411; c=relaxed/simple;
	bh=baXiw2+ViVqhOgHCFNI23bNYZZWj+v2kx0T+cfRy9Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONKXV63TYUJOASxrMtNQOKYlhd8+Iwl+lDC/K0HdVpzaPWxACv8bvOLxzY2hMa192Sv1FeXw0YmAosfp+am2/L6uv7WOMLBAIJgU01wGO2Tq2HVsMOGez2cktOEljgKtKZ7I1Zug6GdA5iK9i9DAEV3/YP9sIqgTGG28z/g7YdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=S9uxUOVb; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id x9susHYYBzmbmx9susOfhZ; Sat, 05 Oct 2024 20:52:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728154333;
	bh=wrAs3u3w8srHTYG+yCL1fRY9noATZoGiSiPoQyKbzSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=S9uxUOVbSoA3SV9KVT983YS7MuDwRFcb4TuXhlbclCpG1q9plY4Ii9hTY/R2SjrsJ
	 bbZKPkpzZc4hVCzzw0Cg/znag0Hnb3c5AnzQf140jbGPdrLtX3nofk69v8zAOluQX1
	 kJ4CdxcGKZB5ALbBcB3xX+auActwkcYWC0QhEP7WwwdYcfTxlm99TyhsWr8Z19vUfZ
	 EVj8kFuqcZrhzMtnSX+o2JUnTM1YJPPA/mBQnJW/mxuPB4+xlmYo3a565C2Yc/DHmy
	 u6ox9j0bEEC2GhEkNpVVVyCge4g1JHiUQO/aMGDz2MEMHuUngpuErbE0wMGbHcn4Jk
	 KJOynKYcJ0dOQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 05 Oct 2024 20:52:13 +0200
X-ME-IP: 90.11.132.44
Message-ID: <00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr>
Date: Sat, 5 Oct 2024 20:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/psi: fix memory barrier without comment warnings
To: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org,
 surenb@google.com, peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: joe@perches.com, skhan@linuxfoundation.org, pintu.ping@gmail.com
References: <20241005174535.2152-1-quic_pintu@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241005174535.2152-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/10/2024 à 19:45, Pintu Kumar a écrit :
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
> index 020d58967d4e..4e4ff12fdeae 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>   	if (static_branch_likely(&psi_disabled))
>   		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>   
> +	/* Pairs with the smp_store_release in psi_write */
>   	t = smp_load_acquire(trigger_ptr);
>   	if (!t)
>   		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>   		return PTR_ERR(new);
>   	}
>   
> +	/* Pairs with the smp_store_acquire in psi_trigger_poll */

smp_load_acquire()?
I would also add some () after the functions name, here and above.

CJ

>   	smp_store_release(&seq->private, new);
>   	mutex_unlock(&seq->lock);
>   


