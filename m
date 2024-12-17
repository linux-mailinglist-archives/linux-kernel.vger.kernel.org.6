Return-Path: <linux-kernel+bounces-449614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232799F517B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554337A1939
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B41F76B3;
	Tue, 17 Dec 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pj3RxCaV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042E1F5420;
	Tue, 17 Dec 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454804; cv=none; b=TYfC6/FCk9oVP9iw8fK6E1RS1fmBPExCbJVkP2h33/3mKef8S6q1Ff6/5tIZF60ml1aQOqxgmnWn+/J/tzSxx9wjU9Zv2ugiBKOVSfCODnjvk5cr/SZ0CdITFpqkSLiqeVZ8Q051Gd0DFYBOdy1T+F8YOw5kyyIN5pYqHRhqrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454804; c=relaxed/simple;
	bh=uuSw8aKFWxqFiQ4Pleowz22gxsmtmaYoLcqkORPkNzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASibgGlf7OQYmcZpNeXGQ/BspuuXH9v3jG29Q0b8CE/qH9DDXnscZPKKdVXnlZd21TRxZ9MUcJy1fpt74UcqSltCHt+r1rB2rAEDFSmQY4ZNmjGUJEpKBGBoObFLmc1LcbQh1F+gIuqD89DY9amVIMBIVYK6uiFiaaD5A6pK/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pj3RxCaV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734454800;
	bh=uuSw8aKFWxqFiQ4Pleowz22gxsmtmaYoLcqkORPkNzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pj3RxCaVg96G3ZKZ8XbKBInT9EL3zwrj0kTU17n4DShb5kITQRoUB/3aGkKTcZMjN
	 v8nmEtfGKNzaq5+ToRCpKwgZcXLnyxSXyyXNyFbdFlRnVVecof2tTh3VypPTLLLEME
	 Jb5iBAt1p3eDvdXkaMQb3N6OhkSmYnlWMAy1s9rK1H7FmjqdQf+zb29M+oeFgNT3A2
	 yYCgO1cy7vD8tWht72XtDXCRri1l/wJXYwvETuUysrVtO6eEKpVLT5oiQln8jedKe5
	 DtiVf3PLjiS1ikZXScPb1ehfBg8TfqIejK/ZfGmsOWvMjSc+JTKsiPzclL+QZmFd6n
	 AQv0Bn4XVEDbA==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 809C617E37C0;
	Tue, 17 Dec 2024 17:59:59 +0100 (CET)
Message-ID: <2ba24dc6-b6e7-4964-af84-a5374903ce36@collabora.com>
Date: Tue, 17 Dec 2024 18:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes handling
 on RK3588 HDMI0
To: Maxime Ripard <mripard@kernel.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
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
 <c45ff74a-c9a4-4cf1-8530-04087e06b07a@collabora.com>
 <20241217-zealous-boisterous-llama-52bfcc@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20241217-zealous-boisterous-llama-52bfcc@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 6:53 PM, Maxime Ripard wrote:
> On Tue, Dec 17, 2024 at 06:36:41PM +0200, Cristian Ciocaltea wrote:
>> On 12/17/24 5:00 PM, Maxime Ripard wrote:
>>> On Wed, Dec 11, 2024 at 07:01:15PM +0100, Heiko Stübner wrote:
>>>> Am Mittwoch, 11. Dezember 2024, 18:47:44 CET schrieb Maxime Ripard:
>>>>> On Wed, Dec 11, 2024 at 06:23:03PM +0100, Heiko Stübner wrote:
>>>>>> Am Mittwoch, 11. Dezember 2024, 18:07:57 CET schrieb Maxime Ripard:
>>>>>>> On Wed, Dec 11, 2024 at 12:15:07PM +0200, Cristian Ciocaltea wrote:
>>>>>>>> The RK3588 specific implementation is currently quite limited in terms
>>>>>>>> of handling the full range of display modes supported by the connected
>>>>>>>> screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
>>>>>>>> few of them.
>>>>>>>>
>>>>>>>> Additionally, it doesn't cope well with non-integer refresh rates like
>>>>>>>> 59.94, 29.97, 23.98, etc.
>>>>>>>>
>>>>>>>> Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
>>>>>>>> all display modes up to 4K@60Hz.
>>>>>>>>
>>>>>>>> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
>>>>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>>>>> ---
>>>>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 34 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>>>> index 8b2f53ffefdbf1cc8737b3a86e630a03a7fd9348..393fe6aa170aaee9663c4a6d98c1cd6a5ef79392 100644
>>>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>>>>>> @@ -158,6 +158,7 @@ struct vop2_video_port {
>>>>>>>>  	struct drm_crtc crtc;
>>>>>>>>  	struct vop2 *vop2;
>>>>>>>>  	struct clk *dclk;
>>>>>>>> +	struct clk *dclk_src;
>>>>>>>>  	unsigned int id;
>>>>>>>>  	const struct vop2_video_port_data *data;
>>>>>>>>  
>>>>>>>> @@ -212,6 +213,7 @@ struct vop2 {
>>>>>>>>  	struct clk *hclk;
>>>>>>>>  	struct clk *aclk;
>>>>>>>>  	struct clk *pclk;
>>>>>>>> +	struct clk *pll_hdmiphy0;
>>>>>>>>  
>>>>>>>>  	/* optional internal rgb encoder */
>>>>>>>>  	struct rockchip_rgb *rgb;
>>>>>>>> @@ -220,6 +222,8 @@ struct vop2 {
>>>>>>>>  	struct vop2_win win[];
>>>>>>>>  };
>>>>>>>>  
>>>>>>>> +#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
>>>>>>>> +
>>>>>>>>  #define vop2_output_if_is_hdmi(x)	((x) == ROCKCHIP_VOP2_EP_HDMI0 || \
>>>>>>>>  					 (x) == ROCKCHIP_VOP2_EP_HDMI1)
>>>>>>>>  
>>>>>>>> @@ -1033,6 +1037,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>>>>>>>>  
>>>>>>>>  	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
>>>>>>>>  
>>>>>>>> +	if (vp->dclk_src)
>>>>>>>> +		clk_set_parent(vp->dclk, vp->dclk_src);
>>>>>>>> +
>>>>>>>>  	clk_disable_unprepare(vp->dclk);
>>>>>>>>  
>>>>>>>>  	vop2->enable_count--;
>>>>>>>> @@ -2049,6 +2056,27 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>>>>>>>>  
>>>>>>>>  	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
>>>>>>>>  
>>>>>>>> +	/*
>>>>>>>> +	 * Switch to HDMI PHY PLL as DCLK source for display modes up
>>>>>>>> +	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
>>>>>>>> +	 */
>>>>>>>> +	if (vop2->pll_hdmiphy0 && mode->crtc_clock <= VOP2_MAX_DCLK_RATE) {
>>>>>>>> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
>>>>>>>> +			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
>>>>>>>> +
>>>>>>>> +			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
>>>>>>>> +				if (!vp->dclk_src)
>>>>>>>> +					vp->dclk_src = clk_get_parent(vp->dclk);
>>>>>>>> +
>>>>>>>> +				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
>>>>>>>> +				if (ret < 0)
>>>>>>>> +					drm_warn(vop2->drm,
>>>>>>>> +						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
>>>>>>>> +				break;
>>>>>>>> +			}
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>
>>>>>>> It seems pretty fragile to do it at atomic_enable time, even more so
>>>>>>> since you don't lock the parent either.
>>>>>>>
>>>>>>> Any reason not to do it in the DRM or clock driver probe, and make sure
>>>>>>> you never change the parent somehow?
>>>>>>
>>>>>> On rk3588 we have 3 dclk_s and 2 hdmi controllers. Each video-port can
>>>>>> use the clock generated from either the hdmi0phy or hdmi1phy, depending
>>>>>> on which hdmi-controller it uses.
>>>>>>
>>>>>> So you actually need to know which vpX will output to which hdmiY to then
>>>>>> reparent that dclk to the hdmiphy output.
>>>>>
>>>>> The Rockchip nomenclature isn't super obvious to me, sorry. Is there a
>>>>> datasheet for this somewhere? Also, does this vpX -> HDMI-Y mapping need
>>>>> to be dynamic?
>>>>
>>>> VPs are CRTCs in drm-language and each of them can drive a differing
>>>> number of output encoders. Those video-ports also have differing output
>>>> characteristics in terms of supported resolution and other properties.
>>>>
>>>> The rk3588 TRM has leaked in a number of places, and if you find a
>>>> TRM-part2, there is a section labeled "Display Output Interface Description"
>>>> that has a nice graphic for that.
>>>>
>>>> Or in short:
>>>> - CRTC(VP)0 supports 8K resolution and can drive DP0+1, HDMI0+1, eDP0+1
>>>>   [if I'm reading things correctly, 8K together with CRTC1 somehow)
>>>> - CRTC(VP)1 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP0+1
>>>> - CRTC(VP)2 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP01, DSI0+1
>>>> - CRTC(VP)3 supports 2K resolution and can drive DSI0+1 and some BT1120,BT656
>>>>
>>>> so for the 3 higher resolution CRTCs there are essentially 6 or 8 output options
>>>> depending on the board design
>>>
>>> That's much clearer, thanks. I'm not entirely sure how that links to the
>>> need for the PLL to change its parent depending on the ouput. Do you
>>> need to always have all the outputs on the same PLL?
>>
>> One of the problems is that the PHY PLLs cannot be used as clock sources
>> for resolutions above 4K@60Hz, while VOP2 on RK3588 supports up to 8K@60Hz,
>> which is supposed to be handled by the system CRU.
> 
> But can that system CRU drive resolutions lower than 4k@60? If so, why
> do we bother with PHYs?

It can, but it's not accurate enough to support all modes, e.g. those
having fractional refresh rates, among others.  That's actually the
reason we'd want to make use of the PHY PLLs.

>> Moreover, the 2 PLLs are shared between 3 out of the 4 video ports already
>> mentioned by Heiko.  There is quite a bit of complexity in downstream
>> driver to handle all possible usecases - see [1] for a brief description on
>> how was that designed to work.
> 
> That's a generic allocation issue. Multiple drivers (vc4 for example)
> has this issue for other components. It can be fairly easily dealt with
> at atomic_check time.
> 
> Maxime


