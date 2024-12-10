Return-Path: <linux-kernel+bounces-439557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88A9EB102
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8461882003
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542E1A4F2D;
	Tue, 10 Dec 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="niqjIXMu"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56F1CD15
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834376; cv=none; b=E7tGD9lsyT9z9uBQvE7DwSKzJNd3KbnGHHa1favHqNSp3zX/cO/xCLSekH8QaDTb1ZOaKf/AjxYE8SA6M/RSK5xKKf5wV/NEd8v287jYmGqD7bSzk7vpuLvH3KAGiemNKHsYl61Bqu2mwRq8PlKCEKoBIkUtVzPvJqIL2z6tQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834376; c=relaxed/simple;
	bh=IHSBE5NoPon8WtLpqsQUcg/k3bQc76aigQCxVnqAJW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxET3FTksPJh83rrB2shrZj3a+6fgQjoXq8ko6pGAiUGXeTCuy8xbTjRYK1J7eFjF9IYxIHDnVgynFqLr+D9k0bUG/J+w3ZhGR4xCxAbRr0k3abKdjPhd4YAJN4RI6SYMD1uxHNIQcBGliQ/q2uLov5D16auxhoHsrDX88PKCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=niqjIXMu; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733834374;
	bh=FY67r2LchSE3dywlGIQ6Oub8wkKLXxvVT38Tz1bV7aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=niqjIXMu5m9q2TA38ZVCvcExh5pAMwIaTJio+v57v979MoHboFSW8YeQE+rS0sn9B
	 GhURbPl3ExuXa/EN4jX41PQ9iXZOoeA5qDaFP8/ilYfMx7opLb7/5GQzShVLu8eBfj
	 c3BaEgtNwRJ/qJsF7UpVkzfeVetCd+nPnAFM+9SgqDsDceXqCwHSKqpkjHBPKBm8fz
	 t1j0VcGgZ/xhWtotmhBue6/b9VJ4gYbDHVQ6zUsgkF+sSsJN32DZgwLno7k9gxQJAx
	 Su9XtWlX44XkMcXoys/E6c1IzYdjMORzz/PMpNXvtUsw0XNRTiGcvPDDPiD030S20B
	 6b3/pp12YmLIw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 70BB5680306;
	Tue, 10 Dec 2024 12:39:30 +0000 (UTC)
Message-ID: <14fe473e-5f56-4a61-899c-bbb79e2aed3b@icloud.com>
Date: Tue, 10 Dec 2024 20:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Grant Likely
 <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com>
 <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0rbpkwe6xnr7Og7Egqq40JWTy71iyZxm
X-Proofpoint-GUID: 0rbpkwe6xnr7Og7Egqq40JWTy71iyZxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100094

On 2024/12/10 04:34, Rob Herring wrote:
> On Thu, Dec 5, 2024 at 6:53 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> of_device_uevent_modalias() saves MODALIAS value from offset
>> (@env->buflen - 1), so the available buffer size should be
>> (sizeof(@env->buf) - @env->buflen + 1), but it uses the wrong
>> size (sizeof(@env->buf) - @env->buflen).
>>
>> Fix by using right size (sizeof(@env->buf) - @env->buflen + 1).
> 
> Just writing what the diff says already is not that useful. The key
> part you need to know is why we back up by 1 character to begin with.
> 

will correct commit message in v2.

>>
>> Fixes: dd27dcda37f0 ("of/device: merge of_device_uevent")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/of/device.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index edf3be1972658f6dc165f577da53b10c7eebc116..ee29c07c83b9e6abd9b1c7747dd341026bc79eb0 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -266,10 +266,10 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
>>                 return -ENOMEM;
>>
>>         sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
> 
> This could use a comment why we back up by 1. Better to put it in a
> variable than add/subtract 1 everywhere:
> 
> /* After add_uevent_event(), buflen is at character after the nul char
> which needs to be overwritten */
> buflen = env->buflen - 1;
> 
> And then use 'buflen' throughout.
> 

good proposal. may use it for v2 after discussion done.

>> -                        sizeof(env->buf) - env->buflen);
>> +                        sizeof(env->buf) - env->buflen + 1);
>>         if (sl < 0)
>>                 return sl;
>> -       if (sl >= (sizeof(env->buf) - env->buflen))
>> +       if (sl >= (sizeof(env->buf) - env->buflen + 1))
>>                 return -ENOMEM;
> 
> There's another potential problem. If we return before here, we end up
> with "OF_MODALIAS=\0" or "OF_MODALIAS=some-non-nul-terminated-str".
> Maybe that doesn't matter? I haven't looked at the caller.
> 

that does not matter since current logic follows below 2 rules

1) all strings in @env->buf always terminated with '\0'.
2) both env->buflen and env->envp_idx are not updated once @env->buf
does not enough spaces then failed.

current logic has no difference with normal add_uevent_var() usage.

> I think a better solution to all this would be making add_uevent_var
> work to construct the full value. We could add "%pOFm" format that
> calls of_mod_alias(). Then this function becomes just:
> 
of_modalias() ?

agree with you.
for good practice, users should only use uevent APIs and should not
depend on  uevent's internal implementation.

> return add_uevent_var(env, "MODALIAS=%pOFm");
> 
> And of_device_modalias() can be:
> 
> sl = snprintf(str, len, "%pOFm\n", dev->of_node);
> if (sl >= len)
>   return -ENOMEM;
> return sl;
> 

looks good.

of_request_module() provides another solution.

> Rob


