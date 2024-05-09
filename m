Return-Path: <linux-kernel+bounces-174377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FE8C0DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC981C21D29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA314AD2B;
	Thu,  9 May 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jaNb/HMB"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9C101E3;
	Thu,  9 May 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248518; cv=none; b=MQrAJ8/Im2JjQ1pImaOTOanynGnqXazJXrUDLOJgnEoPJY4tkx8DJt4ms4ZVjabv1gIn5AfJe96lAi7bo7VFGsnNlHiMWIW+Ex41wwdhq5nYUtFwdoTZQ+gCEJXgvCBKlw1FrmhkwfI/YmhFTCeQxS2AMU3njV27EP66p6ZjOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248518; c=relaxed/simple;
	bh=yrD/QtiUP7raTVg4YwCBZ7H+mXiDO6gGM1MH4II/Grs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfuIVNB8mAoJipHe+ZUwfxAdnNoWS0AZQI8T2kFqV4zKFsvb7t1pTxL35shJWeuizMgcVn6OIB++m67tEkR3UDNgoyKVrAYg6lFnpLk/obNiR1hYwlgGe1ke3dgcuHqrWuvUihtrEVlvXVQJ35joz41+VzorVNwDkAC4NRM+bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jaNb/HMB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715248509; x=1715853309; i=markus.elfring@web.de;
	bh=yrD/QtiUP7raTVg4YwCBZ7H+mXiDO6gGM1MH4II/Grs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jaNb/HMBNLDiJ0b8Dl6mr92ZZ0B0zDlSF7+nWkGvI8ZtKQnk16FAvCQNj3AdrIn9
	 RuGBMIE1ou5FP+NBIVt88QMevCscbvO3Ed1c20v7gBkNaDkxszQ4LqY5Rlk0AynY9
	 CoUtJN/O9COYLQg/+rnf6aDDfcEINoSZ5hq463dO1kUUixYTFuN0b0TtYbhYs9iAX
	 dJ/iqrYYdOzgZjE4KpVccE7iOKS7AkUnIYfKGXEeOU1OOJFc6/wHbozwy8CWlL9gg
	 d0pEiEeOeFWDZLcQhdeGzoJLFZDMCDlm5gnQdmIyQXW8NVt+T7XCeTb+TStKm1SgZ
	 OXXzRyK3MSPda1/0HQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1skD2J0L2U-00tG1W; Thu, 09
 May 2024 11:55:09 +0200
Message-ID: <336c0653-9876-4268-a798-3e316b3d7f26@web.de>
Date: Thu, 9 May 2024 11:55:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] time/tick-sched: idle load balancing when nohz_full cpu
 becomes idle.
To: Levi Yun <ppbuk5246@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240509092931.35209-2-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mRsGSphSdKcWayvWVJ8HzFyaVhXjvqms4KqJYG9jxLLE5kKokYt
 6XsL5ElLYFFMyvBNNDUJktAouATyTnhVZlgdpxQTSbVaYHbKzPfOuZkjXmpFuWggPsZ7QNk
 KkRtsaXW+OmHizladr4q2IgVsOflIyRshulQ/2f77PkwtBLmmzqx2pYfNo6A7iSsKuOINme
 gNsSZW+r8hUjMex0KUnkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0gNp7QchA8=;mkdnxuLzwbR+meQwfmi7wvbFJkF
 WjBo3X7sPLvGnyTzK90ALKbRw3erYTYuZSEUGzDd87W7vgSita2a/Spc2KzdrpT9Q5ISN9avy
 m6lqsKZ03fj5wLVVq0kqhSeAOEvYxsmvVbigRwOxEAums2W1nUJgEcHxXPGFQ45zxe87Ijjli
 ONVDsHVFAF3qpaPvSgtPHJUph668FGGiuNMV/UMcw/jgGHXDN/+p+84w8DTd2jbrewf3Zs1pj
 OPhqjFKC40iIbRZF0dEXigDPnEWPNTrNIyAH+nKpqrvCrbVunJyHwzamp+j4E/8L4S5MyIcAU
 /iboN7T7HlJKjXqjbL8oNvSr5KcCGTIJonTbv1Wi8DfeLIQ2W+moMJBzA/kgdbnW5KdOXniDY
 jXZ0l2kzTJ1NtM7o9Q4AY+YoKr5bAI28N6MWxqvMueVkM7g851rdzg+OgRDli1jpqtxXhMGWY
 BhdMDGyvy11edasnQGAs3OZQlmu7Z01cx7XDdyi3JOOw4KZEtuYP0541MeBim2pTYcus3NJmx
 9RiLQOXAQyMOKP9yuZfTj9V8KarA+pMOfx80SbznENVnfV3a6WTffxPwHgKcDFhs/M+qhZagA
 s3xMiZyi3c8GB7ftBw1j9h5ui7acchw7djLFGIU1s9v8aL4MfUDy4C9NC0FpNR/NaDeZu5gvb
 DG3fRh8yjOzUj95jXkMwLUvLH9+URCLM+Jyfkhnqk/GOp0qgTz4kAfTpyJVkqqZoLsWM2vBpC
 7kEscGIjRyRScq9gj2tad+chCQ6Z53LF9v6dGzSPqV1h7dE/zghpBEYpu0s5hclRsba05DVu8
 W+cKT9Y2qnnPiFUlHIu3DrbU9Mw9HgHVyfUpQ1UlXGFaw=

=E2=80=A6
> Currently, tick_nohz_idle_stop_tick() is only called in idle state and
> it calls nohz_balance_enter_idle(). this function tracks the CPU
> which is part of nohz.idle_cpus_mask with rq->nohz_tick_stopped properly=
.
=E2=80=A6

* How did you notice improvement possibilities for such data processing?

* I hope that a few remaining wording =E2=80=9Cweaknesses=E2=80=9D can be =
adjusted accordingly.

Regards,
Markus

