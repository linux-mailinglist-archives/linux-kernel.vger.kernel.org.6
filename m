Return-Path: <linux-kernel+bounces-219137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4B90CA51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AFE1C23132
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213712D743;
	Tue, 18 Jun 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AACNMWpJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA36BFAA;
	Tue, 18 Jun 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709920; cv=none; b=ken1O9m6sDEtLjh4EdO3uivu6fzmh6aygcw5j5kuAs74/oPyh9akmyUd62GHHhze5AdA9OTT6P83G0V97euYCnEAPl76/gnBKlAVaQBAGCUjPwkhGQqTLz0fIBXjAwgcnCTead5lFDfnmom5JX/PjQlYqDER87jDZ9ZX8lgqdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709920; c=relaxed/simple;
	bh=laBbGW8u+C3wkt52DJVoyFfKIQuH6xetOZoiKmaKf20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK+60FguZjwjhZNd5nOjvAsh1LM1tqeO6x0p5/qp5Z6Sk5sCmf3kVg/Y5Bc92g1mwnlYz20AUzvVaMQW6xeuwBXKEtOFokusTa7qriqdXxxFJMg53+F9AmQUQYtOaRJdfpVAehWZujvqpNM8rOwgezZmY3W6KDRwbBRNZdA2cK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AACNMWpJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718709917;
	bh=laBbGW8u+C3wkt52DJVoyFfKIQuH6xetOZoiKmaKf20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AACNMWpJM4WRVJIsfDww72SFiSALFZZ5AdyZm+2NGuGCfsy5fYf8cOVvYQ3wAU3Qo
	 L/xCpy6rAKSFMNimFaCXcfttYFR++8IRzmk6NE8jtBPMosoFk4JF5bRUfqXY0HOXW8
	 NdDfVGxF5nqJ1KCkNhJSnvCdvIO6pHRlByaVagXDs8ARYVIj7RQmUwCBFM1arQYMsy
	 9hRlIUexe4XcwuG6oSlkBaP97yTc4ZoETNJAumFMvo/wAKAQH3Rn7c7oidVyR+TLAq
	 NLJQB5k1XXrl2cORp7Bfkedr+OdLGe+iSqVYH/oyLZNV9ijARWvO4iz+JHc5VnszGr
	 YCefW+0Mj5opQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D33A5378217B;
	Tue, 18 Jun 2024 11:25:16 +0000 (UTC)
Message-ID: <af51905f-f249-4f4e-8aae-82ff5b585c87@collabora.com>
Date: Tue, 18 Jun 2024 14:25:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: phy-rockchip-samsung-hdptx: Add clock provider
 support
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
 <20240618-rk3588-hdmiphy-clkprov-v1-4-80e4aa12177e@collabora.com>
 <2910644.FA0FI3ke8A@diego>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2910644.FA0FI3ke8A@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/24 10:55 AM, Heiko Stübner wrote:
> Am Montag, 17. Juni 2024, 23:48:12 CEST schrieb Cristian Ciocaltea:
>> The HDMI PHY PLL can be used as an alternative dclk source to RK3588 SoC
>> CRU. It provides more accurate clock rates required by VOP2 to improve
>> existing support for display modes handling, which is known to be
>> problematic when dealing with non-integer refresh rates, among others.
>>
>> It is worth noting this only works for HDMI 2.0 or below, e.g. cannot be
>> used to support HDMI 2.1 4K@120Hz mode.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 189 +++++++++++++++++++---
>>  1 file changed, 167 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> index 72de287282eb..ad3fd4084377 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> 
>>  static int rk_hdptx_phy_power_on(struct phy *phy)
>>  {
>>  	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
>>  	int bus_width = phy_get_bus_width(hdptx->phy);
>> +	int ret;
>> +
>>  	/*
>>  	 * FIXME: Temporary workaround to pass pixel_clk_rate
>>  	 * from the HDMI bridge driver until phy_configure_opts_hdmi
>> @@ -871,20 +925,18 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
>>  	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
>>  		__func__, bus_width, rate);
>>  
>> -	return rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
>> +	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
>> +	if (!ret)
>> +		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
> 
> I think this will need a put if _mode_config fails?

Indeed, a forced put variant would be required to ignore any
regmap_read() errors and keep usage_count decremented.  This should be
also used in rk_hdptx_phy_clk_unprepare(), since ->unprepare() callback
cannot fail.

Will get this fixed in v2.

Thanks for reviewing!

Cristian

