Return-Path: <linux-kernel+bounces-174193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88758C0B82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB431F23829
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3B149C51;
	Thu,  9 May 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qXwiv2Qh"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A0147C6C;
	Thu,  9 May 2024 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236142; cv=none; b=OU9kWjH81BcamILvBv4SdlD4g5Nh5bf/UJ1v8whg9o4ljFFus3JKhOJ1nsuPwAHj/Zydvi/DqTxQ9IJgU8ek897eDEi0mW/EZVItQB+H6MKNVXWbM0AknoBzlfQ1SeDnRXpuzTodkj5U0HPIpItLPH+Kw+YKEchWc+Z/q+GZ+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236142; c=relaxed/simple;
	bh=6ez9Lqfhbd340o4y9vgQktizgcEqn2zc2QMhtm6j9Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuBvBK1OQuh/xfh2L4/rMY58n84e3gl9D7CeKYe72BZqQqRMI79ksplxL9nkTuY1LYyR2+N4XcMoEGWdy9i5CBNvskHPT/GyBnU4PM7To5WwBeqOCCwBbunrWZN/BJ+MkZMP+9rRrL6sSjgH2T77IzsqpmA9ULjL5T4QDhqpaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qXwiv2Qh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715236122; x=1715840922; i=markus.elfring@web.de;
	bh=qI8eEoxlnq/rtJxkh/NHiyGK6SIHgwqdPIuCrkX4CoQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qXwiv2Qhg5/TJ4AAAjT5N1MKgf9mFaEG+C14/pgVfisSI2hwSX05+UjTah4vnLiq
	 4NpJgN+ORlNXsSolT9ymxW5TL9hr5BRjCJT+sAKPwtNiBNFID4RUhc7hl4TWUgT4I
	 P+2HopVLTX7NTocrdJrXhB7WN/nQ7bq4kKU8WW+SspO5KeyvLSm8lpNEyWHD+oDXI
	 Pkb5c24nhjdqeR8Il1hDHvTwjdBTWydacXzpJz3ZE9a/a9/JGOPqJLt39wS4eHjiX
	 4ck8D6fCXUPZrXLeB9aKQ/0fXb6UVlJOq7lnaIXBP6ovtYr5wgOhjDq9hdQIqItwz
	 +UaZh/R+p5ij3kIaEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpuw-1seqJk2QXi-00ZlrX; Thu, 09
 May 2024 08:28:42 +0200
Message-ID: <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de>
Date: Thu, 9 May 2024 08:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Levi Yun <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240508192213.31050-1-ppbuk5246@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508192213.31050-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1INbcY5FfjRWXmY7EYIG9fWe0ZA28urskb0AEX0UuqmQknXemwo
 6aL7b5TTk9/I0Gq8p1gIcWoAUP/G3niPjwib9Sig0BWttoixFQvRLxbKjNV9dBk7zKIYhJi
 v+W7P/vWbDs+x/PrUgA29lskoAaW2PGNURzk1DufKAc86pSEZ/IGtv2E8rX0BhEW3POx9vu
 PXdA5mvm+X5m+vXhK5DmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VQqKqKPXP9Q=;Sy19RzSEH5REP179ojt6y9bn5Af
 BTmggMFcoXwYL8dH2hFzuVMCMnDbn7MLLkAn4AEh7But3T+25jYFixSfMhySXKAvhDXx6LSsi
 tz727qrk10Yh9SrZlk4Ogy1IzfZX/fbnkW7aNIefNUWyJEF9icPkrLVTv0Ik3cjIHJR0vRN8P
 1YWrekTjWsTp2b4VxXqZkqn/OFnyhsyL1Ecm/F5kazpWcI0r5AD4gaTr1xX9VHwmMmUw1iUeg
 qv5eNYpLM12MNeIhuBaoqlS/72ODEsQO0QVONndEmide0XlBDA7Mmx3X+6UCgRQol/B+uwBZb
 2Ln/r4kYnS8aVPDBCzqd32xWVdnf6PJFQObMeh0BSF61X2Kuu8HyObfoPGdoD6042UG1+GlOw
 Xn7LyaZSUHjLAmx4s9Dn4tthOrFfe7b9CUJaxKjz1l8yW9H8D84zm/EdmY79kr4BuSQvXnZ8n
 4faw5yO0DQ8C0lUjdjAby+B4lzSwGJth1KSSk6nWcO/jb79o6T/IYkj0Syr9W3NvgAbypVIhg
 KVt+FYIWQpr3uUZDUNLQSSRWhtY0phzS2eF57fyu64pS7xb1sjVqGRO4QBx8IOoY/8Pkg1aA4
 5rH3MbucpnyH0ywlSWu7QZDTJvfF/ITJbsViZwrMhyiMfvkh3FM/SnCJV2GR2MRI3dpVBuKDP
 Xtjf+mHdMH3rHC1ZoN8LzWDdzpX87WUjz/LIsNetEcuZOh9uO8GS1RGtmRQDHSDvN7E9kQ3Zh
 ghlYDellhGOpEss9Ivp/7IdqTcIghO/KlkVROU19jgNf9Q7yM/+zggEAgQ29anYCfXpm0UDmo
 aJx6axTv+tU4PomGjVrRJeTBbseOSV7DJ/4nwILB3+cFg=

> When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> It wouldn't be chosen to perform idle load balancing because it doesn't
> call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
> becomes idle.
>
> tick_nohz_idle_stop_tick() is only called in idle state and
> nohz_balance_enter_idle() tracks the CPU which is part of nohz.idle_cpus=
_mask
> with rq->nohz_tick_stopped.
>
> Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_idle()
> without checking !was_stopped so that nohz_full cpu can be chosen to
> perform idle load balancing when it enters idle state.

Would you eventually like to add the tag =E2=80=9CFixes=E2=80=9D once more=
?


=E2=80=A6
> +++ b/kernel/time/tick-sched.c
> @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
>  		ts->idle_sleeps++;
>  		ts->idle_expires =3D expires;
>
> -		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> -			ts->idle_jiffies =3D ts->last_jiffies;
> +		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> +			if (!was_stopped)
> +				ts->idle_jiffies =3D ts->last_jiffies;
> +
>  			nohz_balance_enter_idle(cpu);
>  		}
=E2=80=A6

I interpret these diff data in the way that you propose to reorder
two condition checks.

But I wonder still how =E2=80=9Cgood=E2=80=9D the presented change descrip=
tion fits to
the suggested source code adjustment.

Regards,
Markus

