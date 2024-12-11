Return-Path: <linux-kernel+bounces-441109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684819EC9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8094C168A29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4D1E9B1F;
	Wed, 11 Dec 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pyixXY4y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6795236FA9;
	Wed, 11 Dec 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910731; cv=none; b=h/mhF9jlt6EoSU+hA/7TahIeqP8xtC9uLTJ1kgAT7B2NMOXH0rt4kC5I1OrgEoxhqOH7V0axRzJ8xIyXBqwQ2f9nylOzdXAm9G9xEPer3IZZK4clBWevAvT529tWA0ViMo06wRb3AcO3ESvIEvJS9PrXRLgbT0gJNTBLEeN8zfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910731; c=relaxed/simple;
	bh=KQa0YljSDyn4f2yMLEHD4sXJuIGsikdtCBRivJW4u+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4pmMX9RWN3hNebFhmbP1bVlAqYOP0e+OdcDr+6+dPdGcl5VWbZJJGI3PyQ5BOwMWknEWXtHVmYm5Q45YMd2r9cbEDQ8DWD+IND8lqYLyi5mIkgq1wuJtBOdY5Oe6H3awSQhv6gKUGMgIqW4j69yyGv794Np8VsAP+Sodke9TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pyixXY4y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733910727;
	bh=KQa0YljSDyn4f2yMLEHD4sXJuIGsikdtCBRivJW4u+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pyixXY4yVLNRRp7l8Dm2uhUoxDDMaLYCUO/5v86h/IyllVT8vjBOMCX7DXuOpUAUV
	 0DiTqMQFUF2iKae6huS8FOqPbSGjvqbXXSYXEpNoF74EpubmiSiAFF0tDOXL+Pzy64
	 hjPHIg8LQgSXNytwthlq5gegWpuD04K6LxjhrAm5xxN8VmSzXc3osGt3F9arUiVWXn
	 TDf7tlcvO/ehpOBt0tcB4n+szHA9ZC8FtmPBe5AbwafWyKSBz1SRmxSnsNfdWnzapp
	 nOqs6NXyz7v9TzFul8L1vc7qt8e+D/vNUXds0ggK1usjzDbbao1yzT1M9wJvU3Ogku
	 lMCUxeCWJYozA==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 228AB17E35EA;
	Wed, 11 Dec 2024 10:52:07 +0100 (CET)
Message-ID: <a0cf9b40-8ac2-4d6a-a26c-bafa85096440@collabora.com>
Date: Wed, 11 Dec 2024 11:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
To: Alexandre ARNOUD <aarnoud@me.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
 <BC29D61C-317D-4F82-AF42-EA3D705B0632@me.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <BC29D61C-317D-4F82-AF42-EA3D705B0632@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 12/11/24 11:42 AM, Alexandre ARNOUD wrote:
> Hello Cristian,
> 
>> On 11 Dec 2024, at 12:06 AM, Cristian Ciocaltea <cristian.ciocaltea@collabora.com> wrote:
>>
>> Changes in v2:
>> - Override hdmi1 pinctrl-0 on rock-5b as it requires hdmim0_tx1_cec
>>  instead of hdmim2_tx1_cec (fixes a pin conflict when enabling
>>  CONFIG_SPI_ROCKCHIP_SFC)
>> - Link to v1: https://lore.kernel.org/r/20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com
>>
>> ---
>> Cristian Ciocaltea (4):
>>      drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
>>      arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
>>      arm64: dts: rockchip: Add HDMI1 node on RK3588
>>      arm64: dts: rockchip: Enable HDMI1 on rock-5b
>>
>> arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi  |  62 ++++++++++++
>> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  44 ++++++++-
>> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 119 +++++++++++++++++++-----
>> 3 files changed, 200 insertions(+), 25 deletions(-)
>> ---
>> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
>> change-id: 20241207-rk3588-hdmi1-704cbb7cd75f
> 
> Tested-by: Alexandre ARNOUD <aarnoud@me.com>
> 
> Works perfectly on Rock-5B, thanks for your work.

Thanks for your quick test report on the series, which helped
identifying the pin conflict issue which I missed initially.

Regards,
Cristian

