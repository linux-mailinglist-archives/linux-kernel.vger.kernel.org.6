Return-Path: <linux-kernel+bounces-197339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAC8D6982
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB6283E57
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A717CA03;
	Fri, 31 May 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="w+5RfYmC"
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476117C7D4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182762; cv=none; b=OlI3fGhM6U7a8qJ1dAG+0LAMM8IcWVT7bZrmhj6cwre86ntKLSjooKEw2ugZyaBKxR69eAvkrHEIFGEVjia6gC47M1j9qikZ8XzNOBOFYoOr+7cm5/5WJbfp73/EXjfiDtRA9BmTloVBBW8fE6Nid2hs+NxVW4WU/+XRyxy3Jf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182762; c=relaxed/simple;
	bh=l6Noy5qDuga5ddzS3uhFndxB/qs8GrX99aTIdEU4qGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDIbX74sU2q3H+91eR8YhEv4Qyyd4ySuQN/koBLzGKx2zWN0+Fs7r8v4iutKFwObFRPCfNKHZcTxghzIM0I6p1BMjS05R1ZYXxzKYz+cewFZTDMnXVZvVYmssF2+CNJFqXcjh7yzwuRmmpBjw5lSnu3j295rN/XrE1W+6+/J3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=w+5RfYmC; arc=none smtp.client-ip=129.70.45.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
Received: from [192.168.0.100] (dslb-088-074-203-220.088.074.pools.vodafone-ip.de [88.74.203.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id C27B56015A;
	Fri, 31 May 2024 21:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1717182249;
	bh=l6Noy5qDuga5ddzS3uhFndxB/qs8GrX99aTIdEU4qGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w+5RfYmCDLL39Us+JDOzdHqgmRGlqo8OWHhr7mWY2eJVoyJXFo93+GRnBB/dx/rav
	 z33rrAesPCMaPGXP5CFXthePyVYRhxhAmlLqC5gBlzqzGFQnkwhA+FrjDVZFwl8HSc
	 BMF1UWHrVR4IJPvoiEEnJcu/UCuU79MGCN6UeLRItizp7vfN68qnNSy5K/zjVhqJHZ
	 6vyxOSsUki4qNll8xlw4Xv/hBGOReZcin50XjiV3qAW41P5Qxn/4tc40kwCOfvfYDe
	 zgT8D96tzaNmwKu0rHTdN6FFHM6LBe9c6vDtvKA2BajuknkaLhHkslmshDahNpEowZ
	 eEtT7dZb0q3Gg==
Message-ID: <a4069a85-b990-42b4-8cde-8906a740ec27@math.uni-bielefeld.de>
Date: Fri, 31 May 2024 21:04:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm: panel-orientation-quirks: Add quirk for Aya
 Neo KUN
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Hans de Goede <hdegoede@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>
Content-Language: en-US
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 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
 JRHWPGCL3BhOxQ==
In-Reply-To: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/24 23:04, tjakobi@math.uni-bielefeld.de wrote:

> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Similar to the other Aya Neo devices this one features
> again a portrait screen, here with a native resolution
> of 1600x2560.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3d92f66e550c..5d3fb11fd45f 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
>   		},
>   		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* AYA NEO KUN */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_rightside_up,
>   	}, {	/* Chuwi HiBook (CWI514) */
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),

Trying yet another ping! Also adding Hans to the list of recipients, as 
he committed the last quirk for an Ayaneo device. Someone pick this up, 
pretty please! :-)

- Tobias


