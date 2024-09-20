Return-Path: <linux-kernel+bounces-334009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A6097D159
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841261F24EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0F433D0;
	Fri, 20 Sep 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m4BVCDkQ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555F22F1C;
	Fri, 20 Sep 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815197; cv=none; b=UueirRfW66f36/dYDK23S7RW61kTRbnfcKmXLF0JeUV0rA6VyBbvXooghg1LPuOUvSlmToGBYr6DDLztE3Pq+hwC9B4lDfrIFGnARNB+wLsuOn+mEpyADmXzTBJCWBXq/qz6dytTjia7LBNmXmt/QOsQVRuQMOmSV6dYtl50rY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815197; c=relaxed/simple;
	bh=3ovcTv20LCDTrIb8c2S7m6LN1wH3uAsh3y2SX1ZrkOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN6YYd3/V5TGSeNTnSmvdzrNor5zSzmaRemck0bh5j4HyDeOO1S6LuoV0pY6RgA4dpMzWO5l+L9lLOttptNepL+EXcjcGr/wuJXnFeHhYtFqpKa/yLV1rc9qnqTKlwX+zafZytzIj/DWimC087Bp6bmtZRMW1ofqtp5TgMVl1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m4BVCDkQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726815168; x=1727419968; i=markus.elfring@web.de;
	bh=F2ANZLY0Xfa8MVa7JzV2vgAyGcPR+WdYGalndNVH1F8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m4BVCDkQwpgQthMUHnAiyg3WR+GXt18MVugppHGnG4l9LLD8FUaw0l5wdhLJozOA
	 yWQ+X1r9TZzcIYmmB330OLeztzdjqMAJ/MTLvIQk8M9cA6dwPlwd4QEtHPedF/Jb9
	 H3RTddtyIzOwV+V9ufXUJcKt1ugrCJ69CRjgGuQHupPdPgfcQ3rCIQKd9lAWKXi4h
	 d+u4XyeETMyzvLv31N+whz5KBfuHBMTIbep/T6Cg7zeEj6rTBABOH/IMXl+/L+d2C
	 tr/XgJrGy8gVRGE9ItDdsWMVKI/cyAJZWgnWodc0CDQWyUrUMt0ovkcyubqgI37zE
	 c3C3Odujb0ZUnX2Q1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1saYaY1hEw-00YBSj; Fri, 20
 Sep 2024 08:52:48 +0200
Message-ID: <db53c8d1-2eef-48c9-9580-ba31bfb03e1f@web.de>
Date: Fri, 20 Sep 2024 08:52:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/perf: Use guard(irqsave)() in eight functions
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Anjali K <anjalik@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Kan Liang <kan.liang@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@inria.fr>
References: <096fc4ee-8ffe-4eb6-88f8-28dc944b079f@web.de>
 <871q1eoqya.fsf@mail.lhotse>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <871q1eoqya.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mBVC7eXHzXRpfcgQtsPCvDPM86WYM8vBt0vb6PTl/FXapSGK6/z
 KSwyswshsHxXmQBSr/B9gULVYLLQoDidbSjqOYZg10ySkx7MInFE/qID5tMyatTnjISgwGD
 ccxlQWoOUgQnAV/FyLxbF2Y+1be6ryvcjZM7vWfMlf7qRwqdQz/v2yFH58JCEs3dePq8JW0
 DiIPOYGVfBdRSX1eFbbsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MQ27wgbhhWE=;SEzQcigJBdT7ohf7FWq3xlQrEaq
 hy4TB+oDlwAEnIn52bitOqu0CKu6B/lyjZB8Qu8XAMRgZ421uwQflLkoHuqj9oh0MLI03ESKM
 JyIl6Ai4txIztyptuklbkdUppePGgWJNMS9OpuM8c7xNQrNtM47Gyu57DbV16l42ed0lUrp+c
 qbgDOiD3EFtqJWXbNPlkXCrC3mOonq395ImK8HxfL+qOiDPsfmd+VQZ+KnMm0gymJt/6u7NFX
 GSTYz/gzDu6OaZjGjJsBdOeg9R2Eh80hLjsPJohDY3Y+PO9asnKvrYDW70mOIUSTolo4+iPFa
 9eFVIVZ0gb3OU57cs73fudBg42UVqb3RtCRSe8STx8V5SvZs2GYSJ9XXgPLUYtg3Zv90eKPAu
 giB8HcSY7RqzpMF0VuYOjq9Uxz4EIZdUdzPVE5KX5fAWXF3HHAo2IBHA+jR2HKBMh5deUTsMr
 sqKaH0Qr9uRqtiiGMXpoHpbHLxEzhiVX1a6ctqQ7vZeAbt00XXhgIaGldka1x50o2qRCJefH3
 mUT1bAnC8OLKJNy5k2TJYF4lYhiHyFoRD9eMgOcDndqNi2v+4xdxvjc7gFG6HcWIVlcUqDwca
 MouELA1tLXoDLk+e2gU5yAtYAu+ch8RIxJEpMsczI+TpBk1L2odtsne9r1EcOKJMwZis+HKbU
 zS/sV8CDpatjyDVErm1rX2pu6fz+r9mz3PZ9rPzJ5m7tv4PFiYFig6RsmIfW4OdQUWcVkWj9N
 1JDhUQ6lHkGEX/m6bwzqFY9AEEN3rWxrDNycBgTj3RSNyvPKH/cgnilgjjLx/EKnsELsn8Mel
 9Wc/ImwwJZt4ZClMM3LjLcKw==

>> Scope-based resource management became supported for some
>> programming interfaces by contributions of Peter Zijlstra on 2023-05-26=
.
>> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
>> Introduce __cleanup() based infrastructure").
>>
>> * Thus replace local_irq_save() and local_irq_restore() calls by calls
>>   of the macro =E2=80=9Cguard(irqsave)=E2=80=9D.
=E2=80=A6
>> ---
>>  arch/powerpc/perf/core-book3s.c | 102 +++++++++++++-------------------
>>  1 file changed, 42 insertions(+), 60 deletions(-)
>
> These mostly look good.

Thanks for this positive feedback.


> I don't think the change to power_pmu_event_init() is an improvement.

I presented an other development opinion.


> I'll drop that hunk when applying,

I guess that there are further opportunities to clarify remaining change r=
esistance.


> or you can send a v2 without that change if you prefer.

Not yet.

=E2=80=A6
>> @@ -1996,7 +1980,7 @@ static bool is_event_blacklisted(u64 ev)
>>  static int power_pmu_event_init(struct perf_event *event)
>>  {
>>  	u64 ev;
>> -	unsigned long flags, irq_flags;
>> +	unsigned long flags;
>>  	struct perf_event *ctrs[MAX_HWEVENTS];
>>  	u64 events[MAX_HWEVENTS];
>>  	unsigned int cflags[MAX_HWEVENTS];
>> @@ -2115,43 +2099,41 @@ static int power_pmu_event_init(struct perf_eve=
nt *event)
>>  	if (check_excludes(ctrs, cflags, n, 1))
>>  		return -EINVAL;
>>
>> -	local_irq_save(irq_flags);
>> -	cpuhw =3D this_cpu_ptr(&cpu_hw_events);
>> +	{
>> +		guard(irqsave)();
>> +		cpuhw =3D this_cpu_ptr(&cpu_hw_events);
>>
>> -	err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);
>> +		err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);
>>
>> -	if (has_branch_stack(event)) {
>> -		u64 bhrb_filter =3D -1;
>> +		if (has_branch_stack(event)) {
>> +			u64 bhrb_filter =3D -1;
>>
>> -		/*
>> -		 * Currently no PMU supports having multiple branch filters
>> -		 * at the same time. Branch filters are set via MMCRA IFM[32:33]
>> -		 * bits for Power8 and above. Return EOPNOTSUPP when multiple
>> -		 * branch filters are requested in the event attr.
>> -		 *
>> -		 * When opening event via perf_event_open(), branch_sample_type
>> -		 * gets adjusted in perf_copy_attr(). Kernel will automatically
>> -		 * adjust the branch_sample_type based on the event modifier
>> -		 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
>> -		 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
>> -		 */
>> -		if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_P=
LM_ALL) > 1) {
>> -			local_irq_restore(irq_flags);
>> -			return -EOPNOTSUPP;
>> -		}
>> +			/*
>> +			 * Currently no PMU supports having multiple branch filters
>> +			 * at the same time. Branch filters are set via MMCRA IFM[32:33]
>> +			 * bits for Power8 and above. Return EOPNOTSUPP when multiple
>> +			 * branch filters are requested in the event attr.
>> +			 *
>> +			 * When opening event via perf_event_open(), branch_sample_type
>> +			 * gets adjusted in perf_copy_attr(). Kernel will automatically
>> +			 * adjust the branch_sample_type based on the event modifier
>> +			 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
>> +			 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
>> +			 */
>> +			if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_=
PLM_ALL)
>> +			    > 1)
>> +				return -EOPNOTSUPP;
>>
>> -		if (ppmu->bhrb_filter_map)
>> -			bhrb_filter =3D ppmu->bhrb_filter_map(
>> -					event->attr.branch_sample_type);
>> +			if (ppmu->bhrb_filter_map)
>> +				bhrb_filter =3D ppmu->bhrb_filter_map(event->attr.branch_sample_ty=
pe);
>>
>> -		if (bhrb_filter =3D=3D -1) {
>> -			local_irq_restore(irq_flags);
>> -			return -EOPNOTSUPP;
>> +			if (bhrb_filter =3D=3D -1)
>> +				return -EOPNOTSUPP;
>> +
>> +			cpuhw->bhrb_filter =3D bhrb_filter;
>>  		}
>> -		cpuhw->bhrb_filter =3D bhrb_filter;
>>  	}
>>
>> -	local_irq_restore(irq_flags);
>>  	if (err)
>>  		return -EINVAL;
>>
>> --
>> 2.46.0

* Under which circumstances would you find it acceptable to use
  the proposed compound statement?

* Would you eventually prefer to apply a macro like =E2=80=9Cscoped_guard=
=E2=80=9D here?
  https://elixir.bootlin.com/linux/v6.11/source/include/linux/cleanup.h#L1=
40


Regards,
Markus

