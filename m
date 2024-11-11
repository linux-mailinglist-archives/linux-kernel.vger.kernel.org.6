Return-Path: <linux-kernel+bounces-404175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC769C4048
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566B0B216E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AA156C52;
	Mon, 11 Nov 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bopGIKQV"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447415A85A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333822; cv=none; b=UGwZEZPdDvteV5j6LFH+MiKSpErXegrtESxlD+hr8IJA7lLj+CmxyQEsJq2Ks2A8MUvOameKpt5Pe1hdI43/fERqF/ry6SiB34t620v8pwN3oNdY0k0fC+6UsSIcfQI7mJZL3KwTvYx7b83yNQS/yw8r0osquBfv0XKNhj/9Ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333822; c=relaxed/simple;
	bh=Xccg7CjeXTkbb01cLmZikPRjYkQIA+EVFw6nvWs/LuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwWITkdcILmpVApaAqy+3SeTWdWAhNPlZ9VWSyivIoxyGIbmmNLmajevFwKVAN928KsHVtABj84uQJBCg9vF12n6/njNxmMyug57w5n+4MY2bz5JV9/qe2Wulv4wZIf2HIj6TxQCAEUrwl0zyXkeyhkd4d+L3gTQlkG22r3yYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bopGIKQV; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id AUzstDnhyjazzAUzstZGnD; Mon, 11 Nov 2024 15:02:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731333751;
	bh=GRAYVX32ssuALUcZpWdYH9UG/vZO1PcBSIlWazaToUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bopGIKQVe1KHbsRaWsBHWjDEU6kPo0mBTG+Zgy3NEIHvPSR5CtzPIzytGI0UO7knW
	 TRMrbDv8njmlu+NRT9gXJ3iBKs0PWftEO7qGTO5TnHkJUNuM36r+6/MdU65evPVXMO
	 lbWUHUGhNb9dmo56METU3izLIi1anS/UZ3hKP1OdLGHXuwjjMIK0NSn0sYuA1/rIn6
	 /sh+ezpB0b8koMSONuijFSCBDG1kVK2kV6xIF/kulMom4Q4EifM4DDHHC8okRyp6Pa
	 u1/BSYtflJT3BM/CVFRhwzpjVg18UbikxBY8hqvT3gNv8n6oPI/xsc6G577eV6Ev2G
	 S1/Au/cD3364g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 11 Nov 2024 15:02:31 +0100
X-ME-IP: 90.11.132.44
Message-ID: <2cc01a92-ce55-4b05-aa3a-09a610a8dab5@wanadoo.fr>
Date: Mon, 11 Nov 2024 15:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Apply upper limit for clock variable
To: Murad Masimov <m.masimov@maxima.ru>, Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20241111134644.1507-1-m.masimov@maxima.ru>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241111134644.1507-1-m.masimov@maxima.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/11/2024 à 14:46, Murad Masimov a écrit :
> If the value of the clock variable is higher than 800000, the value of the
> variable m, which is used as a divisor, will remain zero, because
> (clock * testp) will be higher than vcomax in every loop iteration, which
> leads to skipping every iteration and leaving variable m unmodified.
> 
> Clamp value of the clock variable to the upper limit, the same way it's done
> with the lower limit.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 877507bb954e ("drm/mgag200: Provide per-device callbacks for PIXPLLC")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
> ---
>   drivers/gpu/drm/mgag200/mgag200_g200se.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index 7a32d3b1d226..69402a591f59 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -218,6 +218,8 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
> 
>   	if (clock < 25000)
>   		clock = 25000;
> +	else if (clock > 800000)
> +		clock = 800000;

Maybe:
	clock = clamp(clock, 25000, 800000);

to be less verbose?

CJ

>   	clock = clock * 2;
> 
>   	/* Permited delta is 0.5% as VESA Specification */
> --
> 2.39.2
> 
> 
> 


