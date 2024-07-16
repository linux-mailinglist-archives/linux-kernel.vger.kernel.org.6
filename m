Return-Path: <linux-kernel+bounces-253813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDA93275C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CF228370F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827619AD6C;
	Tue, 16 Jul 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U13Kb87g"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2217CA05;
	Tue, 16 Jul 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136240; cv=none; b=lUqUjOYx3spcUIfA3RW5hrI1alshMVbhM/Coi2EzWYXWzRNf8Dfo64UMuWtYDjRb4C/ZpzcoJvKXq/4XJWsLccT68912CxrhqzFMbQROTGyG/iIdtfe4rCFuurE7v6coUBKnveYNyHhlArjPGY/Uz+5On2sMPLp1ta7VBkYlc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136240; c=relaxed/simple;
	bh=CaJASSV1ka7Bj5NyM8UKeKZUos0RTwMlBmpSxl6lGyo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q4a/i5VjbdYsbgDZx15rOga8iHvInxixm+iw2w2puvS5j9wj2IMrxfo7vhlFgheGbOPcWOFtoGwMRKYSe8S+jbNnDc1Aa9LvymPDVFdH4jEGRW6QELYmQR9Wp9IN1NgOFwU/XkQOKlVed1Udd81a7832Ma8yn7zOH+z2V1RFISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U13Kb87g; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721136185; x=1721740985; i=markus.elfring@web.de;
	bh=7bRGzv8Y9/jye8elVbQZuYfnhOqWdiGOQotYz8+ZuWA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U13Kb87gd53Tp5IrR7ajhybnxH3UyWXxGEve4Eq3Wt+H/4q/Ci8CmWpiFjK4hySa
	 aFM67qk7yqijpoTNo2gTxmjtvsonwutvMEUH9th8IgN/mUxmCJNrXnORc314XdHq9
	 WSudyEVE784Um1CAxSR2aJcFe0cNkeQN8afAo8FYvkJRTuQ3W8LMJtZ27Rof9Zkfa
	 WFeVQTJD/K8GhXf95u70rwO+bNbsRLx+litOnqKMxg9AktVSf42dVdKIp4V7WhZst
	 UbYBxZX7PbITq5ZUUgIzER2pAkJFxjrkXX9/EIkSFaTCE1z0F++mkRyVVJqhqSONl
	 6u9d0koan7UpMnHGMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1sPIID2qga-000P3c; Tue, 16
 Jul 2024 15:23:05 +0200
Message-ID: <17ac3b59-b189-41d9-b88d-268d7202dde2@web.de>
Date: Tue, 16 Jul 2024 15:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yang Yingliang <yangyingliang@huawei.com>, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Chen Yu <yu.c.chen@intel.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Wei Li <liwei391@huawei.com>
References: <20240703031610.587047-4-yangyingliang@huaweicloud.com>
Subject: Re: [PATCH 3/4] sched/core: Introduce sched_set_rq_on/offline()
 helper
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240703031610.587047-4-yangyingliang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lb3PFhy4QoVrF9aQMRQMyTD51u46Uv/eEbs99RnY3+8og40DpS6
 hWv6RepkX5JgaTk+yeClWNyyu7QVwNPYrI0zhjfAu5FXbGqyfK+IPpXEKrCzwKiDqsdvoFg
 rNbkG2iKK3fXbKDk8Mm2qkCFJuVO6vig+RndJojVaqGXbfABnjlwpAOXO6Ra6Qedl4Rx49X
 Fg+DctmnlVchu+Eru/c2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MrfjKyHyf7M=;hpyO1/IVf2lLY3T45v3wAUmX/oR
 Y15LTHxtmzJnFa8m8v6EVLURLSkem6juPXkgT31aGZZH4z6nM7HQpcQpNeuBZDDWp9MSTDpCT
 CUyVg2ysp1LWOBAfOUxEuKNYudMYLzHZWQFWljcHJtSo80FuJ7inxyHRK6vCBlaRFlxvwBOA3
 XD7ei3Q9n8HcYzcpIcetubBQD6GJaTiD/SDVRFeBACbAOc3dugZMDjWx8Npif0rjrFN9kPizM
 4NdXi+NOdaem0Y7dhSNAIxlCJt2YWfVOA1UIBAJR7NNNNj8oghJr/5hKP4QWY3iuVaGQu7TEB
 tDLPJdEOCCqiPTMEqeRpH/BpqH0zq5JUlx0JFacKC3PBsbztKn/5NX0c8wRlsd+AtWnfdVgim
 VSWxcvsjTtLbDF4vKtA5WoZTrG9X3yX/wjK5qHANBMFiUywXMeeDwSalmNtJTHXla/KC+AuWw
 VFzddEXBWg5CnuO1JJ9vlb728JYoETS75LNbrAxZNH7ReA20BUgfr7pXxpcFw/whiXvwH5HAO
 /EdErjnKfTMJFk4QeYdjSxoLNeyRE0nsh9cvrEw6It4mtpH0Obgob2bcTwerEBBIFI+XGq1WD
 +11TiuXrV5cwa/YNU9AQZdyCDzYuFGwYtMXQQfFTgAtY91Cxzzg7Q55y2TQsQ5n53vqqmg4Nb
 +MDKmtpER3yEaaxg8RrlgKLk0nU9K5Q+c99kBaPZu6u2heI8w4Go8Ah8MrClsznsykZqg1Mm7
 jMh7jFaGM07lGWEd9HeWcYYOdbHoa4V58d1PAugCCemJwg77Z1a5d51RSM5zTKhKcHNqdlLoY
 DIGG8oYdtd8YhJBVFVL6W8UQ==

> Introduce sched_set_rq_on/offline() helper, so it can be called
> in normal or error path simply. No functional changed.

Would you like to improve such a change description another bit?


=E2=80=A6
> +++ b/kernel/sched/core.c
> @@ -9604,6 +9604,30 @@ void set_rq_offline(struct rq *rq)
=E2=80=A6
> +static inline void sched_set_rq_online(struct rq *rq, int cpu)
> +{
=E2=80=A6
> +	rq_lock_irqsave(rq, &rf);
> +	if (rq->rd) {
=E2=80=A6
> +	}
> +	rq_unlock_irqrestore(rq, &rf);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(rq_lock_irqsave)(rq);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10/source/kernel/sched/sched.h#L1741

Regards,
Markusbsegall@google.com

