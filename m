Return-Path: <linux-kernel+bounces-323034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4359736D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FF11C24BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74FA18E77F;
	Tue, 10 Sep 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GJZyv6xw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922913E02D;
	Tue, 10 Sep 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969993; cv=none; b=U8Jp9ACvG+APtUeGxyro0CsJ5x6fePbmpxw3O3TnwtWVcne4gH7BCSUZZKeuk8POd0IQj7op+nSgT8KDVAVTgZHkMB6TgwZ2wB3eYb8+vHMlJgZeDBYrqk4foE9nVnhySCT28rt/CfWTZdGFai9Bo5UZCswZ98QiuRMYpQdem/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969993; c=relaxed/simple;
	bh=5G2bEKkJcecYb9XE+wS/gPtywdeG0cO3XP6VeQpEfNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IROJAcdjtjY56Y/ZRiljejoC2sWltrjb6UmD4KX0R1sGE6W6syS5gPWpn86BvA3Sh4Hv7wZ8l9ez3JAaHSOwKjzb0IfeXbJ0itpsI5OJaF2EXxxvzjePV5JCmC/sO11wsvVLwf6I3SVEUWbWdhCDA+Hy0sy5jU5JaOvyOw4axW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GJZyv6xw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725969983;
	bh=5G2bEKkJcecYb9XE+wS/gPtywdeG0cO3XP6VeQpEfNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GJZyv6xw5Qm7FPXTcKy0CZ7+P31lxGKdzJcpjFJPgTbvz4ctuZi6LXPv6hzyvKg4n
	 Jb5Nc4KywTamuEiuyQHqZYOQ7Ur7YsmP/0SKqPvJF5jigNlEUtSOaVZFH0/YY4IUJK
	 0kXFU9420xXNqGVh68ycI581XIbrILDmOuHtxMRPvF/Nq3Ng35GRisJy+TK9/Pqn4n
	 lWFYhNEufGVSZg0SdrZms6Q5TL8bnpbfXIRjARj/fhS73YZlkDpWEoBKvfZfzb2aDj
	 PbaTMBPUfJWI2gKCZatxzuLykuSc7Ac+8yieHYvGc4rejfHxRMXRYSb3fWDl3EqjOS
	 PUZuVZIyCcPRw==
Received: from [192.168.1.90] (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D6EC017E10C7;
	Tue, 10 Sep 2024 14:06:22 +0200 (CEST)
Message-ID: <de3a907a-bafe-4cd0-a0e4-264015151e86@collabora.com>
Date: Tue, 10 Sep 2024 15:06:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>
 <2241188.nHSHbJBgIm@diego>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <2241188.nHSHbJBgIm@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 2:27 PM, Heiko Stübner wrote:
> Am Freitag, 6. September 2024, 03:17:42 CEST schrieb Cristian Ciocaltea:
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
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/rockchip/Kconfig               |   8 +
>>  drivers/gpu/drm/rockchip/Makefile              |   1 +
>>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 437 +++++++++++++++++++++++++
>>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c    |   2 +
>>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h    |   1 +
>>  5 files changed, 449 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
>> index 7df875e38517..4da7cef24f57 100644
>> --- a/drivers/gpu/drm/rockchip/Kconfig
>> +++ b/drivers/gpu/drm/rockchip/Kconfig
>> @@ -8,6 +8,7 @@ config DRM_ROCKCHIP
>>  	select VIDEOMODE_HELPERS
>>  	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
>>  	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
>> +	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
>>  	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
>>  	select GENERIC_PHY if ROCKCHIP_DW_MIPI_DSI
>>  	select GENERIC_PHY_MIPI_DPHY if ROCKCHIP_DW_MIPI_DSI
>> @@ -63,6 +64,13 @@ config ROCKCHIP_DW_HDMI
>>  	  enable HDMI on RK3288 or RK3399 based SoC, you should select
>>  	  this option.
>>  
>> +config ROCKCHIP_DW_HDMI_QP
>> +	bool "Rockchip specific extensions for Synopsys DW HDMI QP"
> 
> this needs a
> +       select DRM_BRIDGE_CONNECTOR
> 
> now, otherwise it can't link the drm_bridge_connector_init function

That's because of a recent change [1] which I was aware of, but didn't
actually follow when that got merged.  This series is still based on
v6.11-rc1, hence we should probably switch to linux-next starting with the
next revision.

Thanks,
Cristian

[1] https://lore.kernel.org/dri-devel/20240715-drm-bridge-connector-fix-hdmi-reset-v4-4-61e6417cfd99@linaro.org/


