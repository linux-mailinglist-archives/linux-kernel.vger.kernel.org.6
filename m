Return-Path: <linux-kernel+bounces-358100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9B997A28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF2B2113C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E82B9D2;
	Thu, 10 Oct 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WypiXq4L"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF422094
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523628; cv=none; b=J+verW2/VD8+yrH2ScTe7h9539Jw90JlwqIlKvorZ3Kpe7GWt7QSAQbzNPX5aKgcPrzzys/Uo5xdSeCXxiJau91su65nKPp9m5bGXdvVIXFhou5hSwzVeQTJyN80oFxXOu531YbDntd+3q1nyx1Tqd5KYEdXlJBlbf3dDPZKNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523628; c=relaxed/simple;
	bh=toemyvmYqqP72eea5HcvNuQW8tOXh8PfEcnDDu15tqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KekXAxdM+HYWgm+HZIc/eDrjiP99YrjQ9TMf4ql1K5E0ZiyMa+66vegjZgQohp/nQGs+nEvRmtjRyuDzSsHCkq7xrlT1AAwkeyLwbMFU1sKA9aoAjWCylJKw9HYcA5ZqwlNPeBYHROEcdLhhrmqaZktbKGP4N1/DkWMBhfmWKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WypiXq4L; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=DkdWd7CsWZJtpQE7T+Wl5I5+WVHwXfRHMDBTlB5olI4=;
	b=WypiXq4Li4ey2O3+hbmXZk+RuilKXPlxg7/MNJ5u1qmQRrSpOaMZspKLVT5Q6q
	wkkYaWF9bBCQi+QUOzuzazT5SMSkJqQnA6Xyt/S0deII55AY09ATfMMCoaJ1b2O5
	tG8eDFu9f8LbCvN5mhwE76rgsJb5A1q++gRCTINp2z3i8=
Received: from [172.24.140.7] (unknown [111.204.182.99])
	by gzsmtp3 (Coremail) with SMTP id pykvCgAX7983LQdn3zrYAw--.44124S2;
	Thu, 10 Oct 2024 09:26:17 +0800 (CST)
Message-ID: <e0ada5bd-d2aa-47bf-9a81-89fc3907f149@126.com>
Date: Thu, 10 Oct 2024 09:26:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: use correct function name in pick_task_scx()
 warning message
To: David Vernet <void@manifault.com>
Cc: tj@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20241009030602.91216-1-jameshongleiwang@126.com>
 <20241009170147.GB11867@maniforge>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20241009170147.GB11867@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:pykvCgAX7983LQdn3zrYAw--.44124S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr17Ar4fJry8Kr4DCw18uFg_yoW8Cryrpa
	nxZ3WFka1Yyay7Kan7Xrn2y3W5uwsxA347WF1qyw4SkF1rK3Wxtw15K3W3Kr15Kry2kw42
	yF40g343WF4IgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtpnQUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbi2xZ0rWcHKS0sGAAAsE



On 2024/10/10 01:01, David Vernet wrote:
> On Wed, Oct 09, 2024 at 11:06:02AM +0800, Honglei Wang wrote:
>> pick_next_task_scx() was turned into pick_task_scx() since
>> commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
>> task paths"). Update the outdated message.
>>
>> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
>> ---
>>  kernel/sched/ext.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 410a4df8a121..22e18aec4ee1 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2958,7 +2958,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
>>  
>>  		if (unlikely(!p->scx.slice)) {
>>  			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
>> -				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
>> +				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_task_scx()\n",
> 
> Doesn't really matter much, but if we ever decide to touch this line again then
> something like this will be a bit more robust:
> 

Indeed, I'll send a v2 patch later.

Thanks,
Honglei

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fe8acae35166..9fde2d3f8df5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3020,8 +3020,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
> 
>                 if (unlikely(!p->scx.slice)) {
>                         if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
> -                           printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
> -                                           p->comm, p->pid);
> +                         printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
> +                                         p->comm, p->pid, __func__);
>                                 scx_warned_zero_slice = true;
>                         }
>                         p->scx.slice = SCX_SLICE_DFL;


