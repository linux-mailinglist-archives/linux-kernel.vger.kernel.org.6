Return-Path: <linux-kernel+bounces-224216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A35911EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63952832C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302316D4E8;
	Fri, 21 Jun 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ArddLuuA"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF916D30C;
	Fri, 21 Jun 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959254; cv=none; b=DbpCumtzlOFwr/GxUFZ6+/4wVCwcdvGOJy5m7imJI7O2PxMnyt12s9lJhxL1h3ytAVfGig+XyXJxH52gdWeNQl06PUXLPWP88XpzR0fzgPX8VKMJ3KMkLvlhcaGG/fcL4YgWjAZROJb9N2/6uKbJ1jt+74edw8KzYdEyewRXi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959254; c=relaxed/simple;
	bh=+fI3vQ8KpN7wmiBE1LqrWHp9LjNKEMFvI7bMQD6MuWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFH19SmQUctbiNOG0BgGHg9z4YbsrpmhAXone4bPi1z7bRt269/OnV8/sbuUj/d5NTzTA1hOgXZzIdarA2vjjccbgVRNMAZlkCe8IWt9KjOz0XAwpZzkFVaIBsUTVLX+MMRKchGXgssfCOoXKrYWmkSUtl1TufVp3fx3fWmttVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ArddLuuA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718959235; x=1719564035; i=markus.elfring@web.de;
	bh=+fI3vQ8KpN7wmiBE1LqrWHp9LjNKEMFvI7bMQD6MuWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ArddLuuAJqqcky4JYCvSEPvz/8sLzonwjlC+rvnoyJIvDj+XzoAU+pCv6TyxQClm
	 iSvzUnMBOfSF9tTMrI+RH5jbYt4CsXkhRhhwSsP31VvV3ShmiktDRdIASGL5+XtMy
	 sWAugTTbQV0aoh4WgIItom7SB8QZUovprFAFIYzzc15zDfTAM+21fDUP1t6yokSDN
	 i9pTPlKfP2tppboARnysqgNBoIhJKtiy9dyG3N/Z/MP4ZIj1sqUm+x0eHEUHjY4F1
	 XOW8y6+JM+W+nmRYcYm/K0GcuPV4q/VJFKOc9djyzrtpUTD12tp1WKWCnep0sYDn0
	 Vd2gD0gRUOWT3kG+pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjK2-1sahy43fYI-014PkM; Fri, 21
 Jun 2024 10:40:34 +0200
Message-ID: <5094e8bf-6eb6-43e4-80de-052e9c0c67c0@web.de>
Date: Fri, 21 Jun 2024 10:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dlm: use KMEM_CACHE() in dlm_memory_init()
To: Hongfu Li <lihongfu@kylinos.cn>, gfs2@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Alexander Aring
 <aahringo@redhat.com>, David Teigland <teigland@redhat.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <dec3e8d9-0a29-4e9b-afb5-888aaef4780d@web.de>
 <20240621075533.86674-1-lihongfu@kylinos.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240621075533.86674-1-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ZFqh+HXmFwLBDCFY6XraCDLjlpIhW/CsdvkEcBGUYRWrFl4yuS
 VqJAFwrB0GNyo7I9SVRI/igiaV7HsMgHGyLADp13eMqaNwv/Uv/HeR2d8CdSNjlUd1ESka6
 EIMLlL6o2rDU/mnLrUd8dGEui6nv57rqWcgEVvkds9ffn5m0NPDfJzjoAtwbQEzG2wGYSKh
 uccvKI5aPa7VYrUZXoB9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8UOxgFauSN4=;IOm/B3jtsx5RHs2e46xtB8JTSXT
 F3BoaBVrfPqOgW59E9UrxCjUIa+0CmeBH8axKCoUOhBUzW3zFNxbPjf5vFaAmtpK05FiLz2DP
 xKRYx7sqOxvV0Mv+/ODVqAzFj5ks7TjHg8iWzskHBWOBMwq9H+OVzEsFEMWgSVN6leuYu/pqI
 A80q0ddEdRNHg1Qi5ZSPkSbV+Qv0+Za3R/UhoBqrkIeO+eFGQqsHKcyXiTr09c5ta6lpdSZX3
 X9WSzzjZh5Axa5pz2YfJrBSFuLkB2bLWEz95okr2VsdRuHzuFhfFA+7IpnCreIHi86RnOdf2w
 7+FnEuS+sSCwiYDOtd11+gYcbqLaPGcXoLC7bMvxdsbI6lEBfMKPuyCBvxcEsOWxZsMJUs+Y8
 N28UQTYBm6ve1d12QKNcoBPNORs22Y14SxfQIli6IZppcdd9Rqp8IrKm9nnbLRlH0/FZfVyjs
 XctTV/if9d0y60kN54kr9mGQUPNh5NRDQDkK4ZZpSMJy8h6JGSVOyyuLFHQ+PyXEJWJ59cWAe
 oZvpNvKLYR7dmvU6Ca7JOG7CskjI8ANlnw+6yhplnhGFLt1/8jJp343fnW3of5EhE8jLRdKJa
 z9A2WcYGi9HHp4JIti1dvvbD7PdvBrJScZqIJkKJPrWJ2OLLQNf4oHZj7sVgpaa/c2QfqFRFf
 adDf9s+Clb3GXUDlqVzcqI8bylUbdHyIJPPLYGiIMTDZq8uLlCRv/ZOyv7W8qQWhTS/Q1rzoa
 FFMAPy1cAbYx/pQfq8HjE1QdZ4lEROKDfSYBz2DCvPVc8ABQP2de0fPV5OstHpqAv8YzAaZ9i
 3VizVeiQSD/p3wuzbEBI7HKRaI6o5eKKX+arqFokPXEiI=

>>>> https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
>>>> https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L3=
62
>>>
>>> probably only for "dlm_cb" that turns into "dlm_callback".
>> =E2=80=A6
>>
>> Will the development attention grow for deviations of passed name strin=
gs
>> from applied data structure identifiers?
>
> My initial purpose is to replace kmem_cache_create() with KMEM_CACHE().

Do you take any help from advanced analysis tools into account
for such transformation attempts?

Example for the semantic patch language (Coccinelle software):
[PATCH v2] Coccinelle: api: Add SmPL script =E2=80=9Cuse_KMEM_CACHE.cocci=
=E2=80=9D
https://lore.kernel.org/cocci/b08603d6-cac1-4876-a56c-30c680d5dc52@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-02/msg00000.html


> In my view=EF=BC=8Cthere is no problem in unifying passed name strings a=
nd
> structure identifiers.
> Maybe that's wrong=EF=BC=8C

I suggest to take another look also at feedback which other contributors
(from your Linux software distribution) got for similar change suggestions=
.


> I will resubmit a patch that does not change "dlm_cb" to "dlm_callback".

Do you see further opportunities to improve the change description accordi=
ngly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

Regards,
Markus

