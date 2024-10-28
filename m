Return-Path: <linux-kernel+bounces-384633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766059B2CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3411F215D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF01D4342;
	Mon, 28 Oct 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="S6L8GoTX"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2461D3573
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110830; cv=none; b=FFWZBp/VZMNLCi/4y9JzA7TGd5GdIVQb7FgBl4Bv51JyTMGmz9S8PX1H8kFV0Ju/WUn6/TvxaArnoADgo6MN2+MPbQmpLA9t2JW2yHFZyqnfRSgwb0P9Pg74psENkxDgEs9nu9JRbx9Yq0yzvxzUljZnYlBPO97tifZorH+VlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110830; c=relaxed/simple;
	bh=A0GqmnuqlPptcNZg6+u3k/n30Pb95tM6ybSTJvsR02o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EM8xrencLBFcaMimi7jfZ7Y4OUCeOeXP9XlahFnq7hsJNoozKQMH45W9M0BmnzdzeRMRSLIWtsaQENRSFiydww88kxvTi8lq8ViWsbqk5j0G/VkLnIDQDiWxLPOdvcdatCrUTvbhDCo2PNJYKRiMW7oCrWFOwiIL+bpLwNPRgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=S6L8GoTX; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XcTt266QQz9vMZ;
	Mon, 28 Oct 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1730110827; bh=A0GqmnuqlPptcNZg6+u3k/n30Pb95tM6ybSTJvsR02o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=S6L8GoTXankcL+IvSHq8MOnQa5WqCJaXAc0yVgOHfGrRgTdWoc44M/614Uj58dFID
	 SyBYkeELX8WLpC5JLd9c3qFRPrKQDlbVH2HsTr+IeHPWKXu6ClkPDLA0jpdVtG8BG9
	 9FVY/znxPwWr6em0YSmKE/YOZ30ZPUVobKkm62Ms=
X-Riseup-User-ID: ACFA0EC763EE17DF39ECF7ABA89DF4B9B67CC05D073A779B1DFAE844FC37A2DF
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XcTsx13NzzFtfv;
	Mon, 28 Oct 2024 10:20:20 +0000 (UTC)
Message-ID: <3b497dee-9371-4d21-a4a6-e75a6e61e364@riseup.net>
Date: Mon, 28 Oct 2024 07:20:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 2/8] drm/vkms: Add support for ARGB8888 formats
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com, 20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
 <20241007-b4-new-color-formats-v2-2-d47da50d4674@bootlin.com>
 <40c85513-6c57-4b9c-87f6-2ca56c556462@riseup.net> <Zx9eateq0ylJGvS_@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <Zx9eateq0ylJGvS_@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 28/10/24 06:50, Louis Chauvet wrote:
> On 26/10/24 - 11:11, Maíra Canal wrote:
>> Hi Louis,
>>
>> On 07/10/24 13:46, Louis Chauvet wrote:
>>> The formats XRGB8888 and ARGB8888 were already supported.
>>> Add the support for:
>>> - XBGR8888
>>> - RGBX8888
>>> - BGRX8888
>>> - ABGR8888
>>> - RGBA8888
>>> - BGRA8888
>>>
>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>> ---
>>>    drivers/gpu/drm/vkms/vkms_formats.c | 18 ++++++++++++++++++
>>>    drivers/gpu/drm/vkms/vkms_plane.c   |  6 ++++++
>>>    2 files changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
>>> index 8f1bcca38148..b5a38f70c62b 100644
>>> --- a/drivers/gpu/drm/vkms/vkms_formats.c
>>> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
>>> @@ -432,8 +432,14 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
>>>    READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
>>> +READ_LINE_ARGB8888(XBGR8888_read_line, px, 255, px[0], px[1], px[2]) > +READ_LINE_ARGB8888(RGBX8888_read_line, px, 255, px[3], px[2], px[1])
>>
>> I'm not expert in colors, but is this correct? From what I understand,
>> it should be:
> 
> Yes, this is correct, READ_LINE_ARGB8888 take the parameters as A, R, G,
> B, so here 0xFF, px[2], px[1], px[0]

Now I wonder if

READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])

is correct.

Best Regards,
- Maíra

>   
>> READ_LINE_ARGB8888(RGBX8888_read_line, px, px[2], px[1], px[0], 255)
>>                                             ^R     ^G     ^B     ^X
>>
>>> +READ_LINE_ARGB8888(BGRX8888_read_line, px, 255, px[1], px[2], px[3])
>>
>> Again, is this correct?
>>
>> Best Regards,
>> - Maíra
>>
>>>    READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
>>> +READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
>>> +READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
>>> +READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
>>>    READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
>>> @@ -637,8 +643,20 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>>>    	switch (format) {
>>>    	case DRM_FORMAT_ARGB8888:
>>>    		return &ARGB8888_read_line;
>>> +	case DRM_FORMAT_ABGR8888:
>>> +		return &ABGR8888_read_line;
>>> +	case DRM_FORMAT_BGRA8888:
>>> +		return &BGRA8888_read_line;
>>> +	case DRM_FORMAT_RGBA8888:
>>> +		return &RGBA8888_read_line;
>>>    	case DRM_FORMAT_XRGB8888:
>>>    		return &XRGB8888_read_line;
>>> +	case DRM_FORMAT_XBGR8888:
>>> +		return &XBGR8888_read_line;
>>> +	case DRM_FORMAT_RGBX8888:
>>> +		return &RGBX8888_read_line;
>>> +	case DRM_FORMAT_BGRX8888:
>>> +		return &BGRX8888_read_line;
>>>    	case DRM_FORMAT_ARGB16161616:
>>>    		return &ARGB16161616_read_line;
>>>    	case DRM_FORMAT_XRGB16161616:
>>> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
>>> index 67f891e7ac58..941a6e92a040 100644
>>> --- a/drivers/gpu/drm/vkms/vkms_plane.c
>>> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
>>> @@ -14,7 +14,13 @@
>>>    static const u32 vkms_formats[] = {
>>>    	DRM_FORMAT_ARGB8888,
>>> +	DRM_FORMAT_ABGR8888,
>>> +	DRM_FORMAT_BGRA8888,
>>> +	DRM_FORMAT_RGBA8888,
>>>    	DRM_FORMAT_XRGB8888,
>>> +	DRM_FORMAT_XBGR8888,
>>> +	DRM_FORMAT_RGBX8888,
>>> +	DRM_FORMAT_BGRX8888,
>>>    	DRM_FORMAT_XRGB16161616,
>>>    	DRM_FORMAT_ARGB16161616,
>>>    	DRM_FORMAT_RGB565,
>>>


