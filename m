Return-Path: <linux-kernel+bounces-416365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726279D43DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF48A1F22A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03661BC097;
	Wed, 20 Nov 2024 22:17:18 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623C2F2A;
	Wed, 20 Nov 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141038; cv=none; b=d5WkQ8vW0SvuAblQ5CGqWvDG+q8BDlXe5mUOryeJKxG5byrjm4qUvLlJRQ13v7mKaog+3SybO3Jx2kVsmySU3o9fOG4xV+jU8Rq34Ff6MfCbj22neDQ9tz7sAruPGVxbuMLyjWWgbpQXpCSuEk6jJuEligFdGS2tcngLN8Go7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141038; c=relaxed/simple;
	bh=16DmVH9TsiygaaxczMaAcb5KsfLDoPR9ZqxXW8ea9+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsEVe4VHQeG65jdRMelpbrAC1PC+fT04QCy+QmJeVuZ1eJgHKVVYQMegzvuMd4pvILoZrwLnqdym00zYl+hMkXfKpC0xVxEGP9NbJTflmiP0ZXFjf2mo33BsPYU8lQfbgoPlLXMRbro9ceu1zbSvJhNw/DCc+ES9z138F+f/tKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip2t1732140984tymev5i
X-QQ-Originating-IP: VFS7TXKFCL86VDvZbg+yeZ74TOGFmsQaL+ekJyN6cIk=
Received: from [IPV6:240f:10b:7440:1:c3e4:b91c ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Nov 2024 06:16:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8514301682738835123
Message-ID: <2664D23C9E354B20+5fb967f9-348d-4508-8e3e-b979e4e44b15@radxa.com>
Date: Thu, 21 Nov 2024 07:16:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improve Rockchip VOP2 display modes handling on
 RK3588 HDMI0
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NTznjAszAYlzZCkTA1LBjxVmPSqCfhy9wWIoOTAUAwRVwzgwNmFb0/PC
	2to8mUOPqu+T6Cqii5rMgHmPlzB1+Z9kJLUH0y3BKP7TYuit2XIxF4tNLxkiuYZmNnjvJqS
	0TPMA1llGaRbGTdx0SVupSLY/TlSgILI80Au/jstu1s/AvtMbs8LrTAjG0ydzYR73CZWPUK
	r3y/xQwnOfSu5wgMBrLZ3nQJ9M8pbpPHsZ71sVrxToFyt9QpCA7U8exQ2x8fv+EKXDZCXPu
	jEUSCkAvKjNs6zWWGhJx7cZchH734cZv4hGH5wi7dWb2W6+aCZUlWgdIOIse0VcIIVu+O0K
	U19GfRk5ME+ycbEvfRmkx7AwKUVYUxhlU+3+3tdvgkbxh6UGxwHdhE7FQO5Vzy0cwBNK6Pd
	yJ5hfBa4bzA4jIQj2rGMkaCyFfrazDQpQY/AZ3iLj9qJbfUnX4/SaVj5jJ8yzxEIPAXPbTG
	qo/l0aNag/oLaR2M3qebVPEWv9yeDgsp2CBavcvaw2xllfGkhONgDTb9RsmTnW+iicUHHMK
	6QeaLbpAaLl8NqC+0n3/v+hW8jwwKtClmBFD1ur8tB6nTjTN5k65mYCi/Zq8oF0Cfmkb4K7
	RTrP+Kbq77fpOm+2DDaCj7xY/X1GMmFaBDmOjnVgKYLkou0rBIyEsUHOgEyOZvHoV8S/4co
	T87Kl2FrQoBFlh/o5HMNPhDrFhepOTMQL/Bvaq2Ypjrp7QevzZKPqgp8Vjeyn3jVhR3h3PC
	33EzMHmQ5hevAOdeBskNYBz8zFx4O6jD6Voz2XJ8aF5BJqx0F/66C5zuxfB+b3ZL/RqRbB0
	wIF//IIKiZIVa7gjrQgNR3pHII6WuEe3ZqMssA2lHSOoyvaYeD+VKNOQ7JuQ7R69pfBgVWS
	b0dIyFO3WHdzpWKkuvtuG8cCltvVUF1FPUIHvY3fPE0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi,

On 11/17/24 03:22, Cristian Ciocaltea wrote:
> VOP2 support for RK3588 SoC is currently not capable to handle the full
> range of display modes advertised by the connected screens, e.g. it
> doesn't cope well with non-integer refresh rates like 59.94, 29.97,
> 23.98, etc.
> 
> There are two HDMI PHYs available on RK3588, each providing a PLL that
> can be used by three out of the four VOP2 video ports as an alternative
> and more accurate pixel clock source. This is able to correctly handle
> all display modes up to 4K@60Hz.
> 
> As for the moment HDMI1 output is not supported upstream, the patch
> series targets HDMI0 only.
> 
> Additionally, note that testing any HDMI 2.0 specific modes, e.g.
> 4K@60Hz, requires high TMDS clock ratio and scrambling support [1]. The
> patch is usable but not yet ready to be submitted - I will handle this
> soon.
> 
> Thanks,
> Cristian
> 
> [1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-next-20241115
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

for whole series

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Diginnos DG-NP09D 8.9inch 1920x1200 display works with your patch!

Name: HSE
EISA ID: ___0001
EDID version: 1.3
EDID extension blocks: 1
Screen size: 120.0 cm x 68.0 cm (54.30 inches, aspect ratio 16/9 = 1.76)
Gamma: 2.2
Digital signal
Max video bandwidth: 160 MHz

	HorizSync 14-91
	VertRefresh 22-80

	# Monitor preferred modeline (59.9 Hz vsync, 74.6 kHz hsync, ratio 
16/10, 40x44 dpi)
	ModeLine "1920x1200" 193.25 1920 2008 2052 2592 1200 1204 1209 1245 
+hsync +vsync

	# Monitor supported modeline (59.9 Hz vsync, 33.7 kHz hsync, 
interlaced, ratio 16/9, 40 dpi)
	ModeLine "1920x1080" 74.18 1920 2008 2052 2200 1080 1084 1094 1125 
+hsync +vsync Interlace

	# Monitor supported CEA modeline (59.9 Hz vsync, 31.5 kHz hsync, ratio 
4/3, 13x17 dpi) (bad ratio)
	ModeLine "640x480" 25.175 640 656 752 800 480 490 492 525 -hsync -vsync

	# Monitor supported CEA modeline (59.9 Hz vsync, 31.5 kHz hsync, ratio 
3/2, 15x17 dpi) (bad ratio)
	ModeLine "720x480" 27 720 736 798 858 480 489 495 525 -hsync -vsync

	# Monitor supported CEA modeline (59.9 Hz vsync, 31.5 kHz hsync, ratio 
3/2, 15x17 dpi) (bad ratio)
	ModeLine "720x480" 27 720 736 798 858 480 489 495 525 -hsync -vsync

	# Monitor supported CEA modeline (60.0 Hz vsync, 45.0 kHz hsync, ratio 
16/9, 27 dpi)
	ModeLine "1280x720" 74.25 1280 1390 1430 1650 720 725 730 750 +hsync +vsync

	# Monitor supported CEA modeline (60.0 Hz vsync, 33.8 kHz hsync, 
interlaced, ratio 16/9, 40 dpi)
	ModeLine "1920x1080" 74.25 1920 2008 2052 2200 1080 1084 1094 1125 
+hsync +vsync Interlace

	# Monitor supported CEA modeline (60.0 Hz vsync, 67.5 kHz hsync, ratio 
16/9, 40 dpi)
	ModeLine "1920x1080" 148.5 1920 2008 2052 2200 1080 1084 1089 1125 
+hsync +vsync

	# Monitor supported CEA modeline (50.0 Hz vsync, 31.2 kHz hsync, ratio 
5/4, 15x21 dpi) (bad ratio)
	ModeLine "720x576" 27 720 732 796 864 576 581 586 625 -hsync -vsync

	# Monitor supported CEA modeline (50.0 Hz vsync, 37.5 kHz hsync, ratio 
16/9, 27 dpi)
	ModeLine "1280x720" 74.25 1280 1720 1760 1980 720 725 730 750 +hsync +vsync

	# Monitor supported CEA modeline (50.0 Hz vsync, 28.1 kHz hsync, 
interlaced, ratio 16/9, 40 dpi)
	ModeLine "1920x1080" 74.25 1920 2448 2492 2640 1080 1084 1094 1125 
+hsync +vsync Interlace

	# Monitor supported CEA modeline (50.0 Hz vsync, 56.2 kHz hsync, ratio 
16/9, 40 dpi)
	ModeLine "1920x1080" 148.5 1920 2448 2492 2640 1080 1084 1089 1125 
+hsync +vsync

	# Monitor supported modeline (85.4 Hz vsync, 44.9 kHz hsync, ratio 
0.97, 9x17 dpi) (bad ratio)
	ModeLine "464x480" 27 464 480 542 602 480 489 495 525 -hsync -vsync

	# Monitor supported modeline (50.0 Hz vsync, 37.5 kHz hsync, ratio 
16/9, 27 dpi)
	ModeLine "1280x720" 74.25 1280 1720 1760 1980 720 725 730 750 +hsync +vsync

	# Monitor supported modeline (50.0 Hz vsync, 28.1 kHz hsync, 
interlaced, ratio 16/9, 40 dpi)
	ModeLine "1920x1080" 74.25 1920 2448 2492 2640 1080 1084 1094 1125 
+hsync +vsync Interlace

	# Monitor supported modeline (59.9 Hz vsync, 31.5 kHz hsync, ratio 3/2, 
15x17 dpi) (bad ratio)
	ModeLine "720x480" 27 720 736 798 858 480 489 495 525 -hsync -vsync

	# Monitor supported modeline (50.0 Hz vsync, 31.2 kHz hsync, ratio 5/4, 
15x21 dpi) (bad ratio)
	ModeLine "720x576" 27 720 732 796 864 576 581 586 625 -hsync -vsync


Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
> Cristian Ciocaltea (5):
>        dt-bindings: display: vop2: Add optional PLL clock properties
>        drm/rockchip: vop2: Drop unnecessary if_pixclk_rate computation
>        drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI0
>        arm64: dts: rockchip: Enable HDMI0 PHY clk provider on RK3588
>        arm64: dts: rockchip: Add HDMI0 PHY PLL clock source to VOP2 on RK3588
> 
>   .../bindings/display/rockchip/rockchip-vop2.yaml   |  4 +++
>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  7 +++--
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 36 +++++++++++++++++++++-
>   3 files changed, 44 insertions(+), 3 deletions(-)
> ---
> base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
> change-id: 20241116-vop2-hdmi0-disp-modes-b39e3619768f


