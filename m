Return-Path: <linux-kernel+bounces-419180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9569D6A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA7B21528
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1D14EC47;
	Sat, 23 Nov 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ntPQB099"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8913B2A8;
	Sat, 23 Nov 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381225; cv=none; b=Kdc6ze9ksjg7TjFzdY9183aVJUz88qxjNjjtid62qZMWsthdI6eFVIZt7Q0RAT0dnHf1OQFqFGiZ3fmuSsL29zkx9Up/+5pdPdgK8OgS0/v29OuRRhv1jJK+zQDlaBDu934ZXbi6wZ/txIWnhVC8LONDfIfbIXlxCB7xJoGM8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381225; c=relaxed/simple;
	bh=DM4//eNbZfyM12Q86uc6Jzb8gKZsqYiM1dGZdtheaPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d47ZbfEuqm1sdQUWTqtuMsWVsoFCUQzq7muFlTz+LYeGSn3+lur3xQBrfTebRvq2VsrsE6C2TPWH9/SiVU7wmbm/9MATJrMYvoM8n9kq88Ry0C+f/Vjy75U7eVVAxTqeQKbBSyNKozy6AdyiIVcsJ2oOyBFgnzrPD0FnY2XvS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ntPQB099; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732381216;
	bh=DM4//eNbZfyM12Q86uc6Jzb8gKZsqYiM1dGZdtheaPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntPQB099Xe19Nq1wv7qUNrHaeM30rWPpT/0tCTr7/2/I1VxyUxq4dzUB3X/Qx2+Pr
	 ssWMaXRb+iQ6kHWhEjHjuleGLSzpFBbUC+FqcjTQ7N/+8YPv/MwyCCkPBlHrSv/C8c
	 dcxMeVjxDntGglRfxBlg25WvG5lXuWkGpnqo5zvf2bRkr6nH+uZSDgtMEUmULmZzgK
	 p6nm3MDAnTgVKHJAMP3rpPvnY77VDQeP0VzNqgiVoXDjw1C+SWVhm5g878K8EGyqWe
	 n4Mb1x0NV9FbimSGm3PcNTJuw3AepCY0p1ydHcr8G8gnBrGPDON0nBZINGEDV3qJlk
	 NB7JO8wocAd/Q==
Received: from [192.168.1.90] (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3840417E376B;
	Sat, 23 Nov 2024 18:00:15 +0100 (CET)
Message-ID: <2c7fc07c-b431-4384-8dc6-3ae77b18367e@collabora.com>
Date: Sat, 23 Nov 2024 19:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v10,3/3] drm/rockchip: Add basic RK3588 HDMI output support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20241016-b4-rk3588-bridge-upstream-v10-3-87ef92a6d14e@collabora.com>
 <790091a1-00af-43bb-8cdf-814f4cc38d83@roeck-us.net>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <790091a1-00af-43bb-8cdf-814f4cc38d83@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/24 5:56 PM, Guenter Roeck wrote:
> On Wed, Oct 16, 2024 at 11:06:53PM +0300, Cristian Ciocaltea wrote:
>> The RK3588 SoC family integrates the newer Synopsys DesignWare HDMI 2.1
>> Quad-Pixel (QP) TX controller IP and a HDMI/eDP TX Combo PHY based on a
>> Samsung IP block.
>>
>> Add just the basic support for now, i.e. RGB output up to 4K@60Hz,
>> without audio, CEC or any of the HDMI 2.1 specific features.
>>
>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
> [ ... ]
> 
>> +static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
>> +{
>> +	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
>> +	struct drm_crtc *crtc = encoder->crtc;
>> +	unsigned long long rate;
>> +
>> +	/* Unconditionally switch to TMDS as FRL is not yet supported */
>> +	gpiod_set_value(hdmi->enable_gpio, 1);
>> +
>> +	if (crtc && crtc->state) {
>> +		rate = drm_hdmi_compute_mode_clock(&crtc->state->adjusted_mode,
>> +						   8, HDMI_COLORSPACE_RGB);
>> +		clk_set_rate(hdmi->ref_clk, rate);
>> +		/*
>> +		 * FIXME: Temporary workaround to pass pixel clock rate
>> +		 * to the PHY driver until phy_configure_opts_hdmi
>> +		 * becomes available in the PHY API. See also the related
>> +		 * comment in rk_hdptx_phy_power_on() from
>> +		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +		 */
>> +		phy_set_bus_width(hdmi->phy, rate / 100);
> 
> On 32-bit systems:
> 
> ERROR: modpost: "__udivdi3" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> 
> in the mainline kernel.

Yeah, that's a known issue and has been already fixed:

https://lore.kernel.org/lkml/20241018151016.3496613-1-arnd@kernel.org/

Thanks,
Cristian

