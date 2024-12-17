Return-Path: <linux-kernel+bounces-449592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E879F512A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39577A1E22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD05156F20;
	Tue, 17 Dec 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j4RLQUW7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314213D891;
	Tue, 17 Dec 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453408; cv=none; b=ia7FKQZ6lBhSmwbxLi5wVNI7YNNR0jbl8yNL4b5XXK33L8uZSiY9z9CR9KmxkJiAQRUo5lj3u30DM2mN8DINnekyOojoa6h6sT7cN+0RY8wHEz2kXJu4UZRHkJOhZpA54G0R2SfDLfn4P7QXf5l6WRFR3Vw0lXB7KfXVmsX2+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453408; c=relaxed/simple;
	bh=PAu25BTtqRIZ7TehGqU+OEInbWitHM7ErDsbsrjdeLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHtXo62Bsa2ekmBwM0gK9URuyQa9xg6YUT9Mr8wHlQ6x7DIBRGat2/heARKzT3OB78wk6cO7q5XpskOzJQnUk2JBnMVsFML0bCgS0oRgGp0p90pE6pnxE72PoRRjYNmUGpgdnlYeZC4Iy2SYJjHieqnLrHnxNSBivf47UQCz2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j4RLQUW7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734453404;
	bh=PAu25BTtqRIZ7TehGqU+OEInbWitHM7ErDsbsrjdeLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j4RLQUW7ucEUCYXiyDkUlnsBvM/2UW3XQ+tXe5QtFGmabPBx/LEHLzuToIckoi5IE
	 zM3iHNiqHKT2QFXip3jfVJFifsncvj5ApK2DQ8dmGHB2+qwUWZuwSJViEwPrcvnuer
	 PLuBaW2XhQIz6BhRQ31wDM23mjlyMMaumPdvrxi/WoUJFI7K8eMCjGeo0lFTRFmM8Y
	 LV4D6WbdcnnnNMoy95UFIYJQDoJ90kDeP2ZeWPKamvyUqUiF/rEHfsCsCwluXgJ2Z5
	 SSJ4atgRy08XXAkbddJdCVc5VcANcz0QUfFFLV+5HqC0DMbUsC0+ZSS3iKYSN0wGTS
	 3hJ6hpWYhdifA==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF34517E37B2;
	Tue, 17 Dec 2024 17:36:43 +0100 (CET)
Message-ID: <c45ff74a-c9a4-4cf1-8530-04087e06b07a@collabora.com>
Date: Tue, 17 Dec 2024 18:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes handling
 on RK3588 HDMI0
To: Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
References: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
 <1820767.5KxKD5qtyk@diego>
 <a4ex3s23r4k6wehyoaw3aylpcexfrclrxxykjpabhdfne2jgmu@ii6riiiga2zj>
 <1756448.izSxrag8PF@diego>
 <20241217-ubiquitous-refreshing-finch-aceade@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20241217-ubiquitous-refreshing-finch-aceade@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 5:00 PM, Maxime Ripard wrote:
> On Wed, Dec 11, 2024 at 07:01:15PM +0100, Heiko Stübner wrote:
>> Am Mittwoch, 11. Dezember 2024, 18:47:44 CET schrieb Maxime Ripard:
>>> On Wed, Dec 11, 2024 at 06:23:03PM +0100, Heiko Stübner wrote:
>>>> Am Mittwoch, 11. Dezember 2024, 18:07:57 CET schrieb Maxime Ripard:
>>>>> On Wed, Dec 11, 2024 at 12:15:07PM +0200, Cristian Ciocaltea wrote:
>>>>>> The RK3588 specific implementation is currently quite limited in terms
>>>>>> of handling the full range of display modes supported by the connected
>>>>>> screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
>>>>>> few of them.
>>>>>>
>>>>>> Additionally, it doesn't cope well with non-integer refresh rates like
>>>>>> 59.94, 29.97, 23.98, etc.
>>>>>>
>>>>>> Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
>>>>>> all display modes up to 4K@60Hz.
>>>>>>
>>>>>> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
>>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++++++++++++
>>>>>>  1 file changed, 34 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>> index 8b2f53ffefdbf1cc8737b3a86e630a03a7fd9348..393fe6aa170aaee9663c4a6d98c1cd6a5ef79392 100644
>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>> @@ -158,6 +158,7 @@ struct vop2_video_port {
>>>>>>  	struct drm_crtc crtc;
>>>>>>  	struct vop2 *vop2;
>>>>>>  	struct clk *dclk;
>>>>>> +	struct clk *dclk_src;
>>>>>>  	unsigned int id;
>>>>>>  	const struct vop2_video_port_data *data;
>>>>>>  
>>>>>> @@ -212,6 +213,7 @@ struct vop2 {
>>>>>>  	struct clk *hclk;
>>>>>>  	struct clk *aclk;
>>>>>>  	struct clk *pclk;
>>>>>> +	struct clk *pll_hdmiphy0;
>>>>>>  
>>>>>>  	/* optional internal rgb encoder */
>>>>>>  	struct rockchip_rgb *rgb;
>>>>>> @@ -220,6 +222,8 @@ struct vop2 {
>>>>>>  	struct vop2_win win[];
>>>>>>  };
>>>>>>  
>>>>>> +#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
>>>>>> +
>>>>>>  #define vop2_output_if_is_hdmi(x)	((x) == ROCKCHIP_VOP2_EP_HDMI0 || \
>>>>>>  					 (x) == ROCKCHIP_VOP2_EP_HDMI1)
>>>>>>  
>>>>>> @@ -1033,6 +1037,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>>>>>>  
>>>>>>  	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
>>>>>>  
>>>>>> +	if (vp->dclk_src)
>>>>>> +		clk_set_parent(vp->dclk, vp->dclk_src);
>>>>>> +
>>>>>>  	clk_disable_unprepare(vp->dclk);
>>>>>>  
>>>>>>  	vop2->enable_count--;
>>>>>> @@ -2049,6 +2056,27 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>>>>>>  
>>>>>>  	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * Switch to HDMI PHY PLL as DCLK source for display modes up
>>>>>> +	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
>>>>>> +	 */
>>>>>> +	if (vop2->pll_hdmiphy0 && mode->crtc_clock <= VOP2_MAX_DCLK_RATE) {
>>>>>> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
>>>>>> +			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
>>>>>> +
>>>>>> +			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
>>>>>> +				if (!vp->dclk_src)
>>>>>> +					vp->dclk_src = clk_get_parent(vp->dclk);
>>>>>> +
>>>>>> +				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
>>>>>> +				if (ret < 0)
>>>>>> +					drm_warn(vop2->drm,
>>>>>> +						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
>>>>>> +				break;
>>>>>> +			}
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>
>>>>> It seems pretty fragile to do it at atomic_enable time, even more so
>>>>> since you don't lock the parent either.
>>>>>
>>>>> Any reason not to do it in the DRM or clock driver probe, and make sure
>>>>> you never change the parent somehow?
>>>>
>>>> On rk3588 we have 3 dclk_s and 2 hdmi controllers. Each video-port can
>>>> use the clock generated from either the hdmi0phy or hdmi1phy, depending
>>>> on which hdmi-controller it uses.
>>>>
>>>> So you actually need to know which vpX will output to which hdmiY to then
>>>> reparent that dclk to the hdmiphy output.
>>>
>>> The Rockchip nomenclature isn't super obvious to me, sorry. Is there a
>>> datasheet for this somewhere? Also, does this vpX -> HDMI-Y mapping need
>>> to be dynamic?
>>
>> VPs are CRTCs in drm-language and each of them can drive a differing
>> number of output encoders. Those video-ports also have differing output
>> characteristics in terms of supported resolution and other properties.
>>
>> The rk3588 TRM has leaked in a number of places, and if you find a
>> TRM-part2, there is a section labeled "Display Output Interface Description"
>> that has a nice graphic for that.
>>
>> Or in short:
>> - CRTC(VP)0 supports 8K resolution and can drive DP0+1, HDMI0+1, eDP0+1
>>   [if I'm reading things correctly, 8K together with CRTC1 somehow)
>> - CRTC(VP)1 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP0+1
>> - CRTC(VP)2 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP01, DSI0+1
>> - CRTC(VP)3 supports 2K resolution and can drive DSI0+1 and some BT1120,BT656
>>
>> so for the 3 higher resolution CRTCs there are essentially 6 or 8 output options
>> depending on the board design
> 
> That's much clearer, thanks. I'm not entirely sure how that links to the
> need for the PLL to change its parent depending on the ouput. Do you
> need to always have all the outputs on the same PLL?

One of the problems is that the PHY PLLs cannot be used as clock sources
for resolutions above 4K@60Hz, while VOP2 on RK3588 supports up to 8K@60Hz,
which is supposed to be handled by the system CRU.

Moreover, the 2 PLLs are shared between 3 out of the 4 video ports already
mentioned by Heiko.  There is quite a bit of complexity in downstream
driver to handle all possible usecases - see [1] for a brief description on
how was that designed to work.

Regards,
Cristian

[1] https://github.com/radxa/kernel/blob/linux-6.1-stan-rkr4.1/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c#L4742

