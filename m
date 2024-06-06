Return-Path: <linux-kernel+bounces-204062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121D8FE37D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642021C25EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240173444;
	Thu,  6 Jun 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qncj7IYy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB317E8FB;
	Thu,  6 Jun 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667609; cv=none; b=cmn7EDvkNWYckkbNJIYh0Cig3jPgldw9BNnoCi95i7emEEF6hQhXht8WYL+CAiyP1qibfO6TJU3hhauhs8eo2offx16BW6QK57reGBIAEAJTWM4iQHBh52ZKVE/+jGp8DtYaLYaMmmO58uMrp6X+L+fAUcJyXtyIAQgWGbq9RyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667609; c=relaxed/simple;
	bh=CKTgow/rXEHMO5WjfhlWa4EqAX2k6le6hA30B/0Rkug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4mQnLfHvdpfVt7z1PyugGFoOjBECEHhm9GLWKx6+/vCTdBXzGJFJAK1lQ/OHtio3rU4/LjTS6wE/UHOu4scPYA5ox95hz2kawo7AVl6tJZvc5YvBWiFSwVuetQvnMiZFqB2eXBrkJf2hfGNv0snuIMgDpSYNHp1GIc2MspMRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qncj7IYy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717667605;
	bh=CKTgow/rXEHMO5WjfhlWa4EqAX2k6le6hA30B/0Rkug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qncj7IYyv4cPm7O8mmmeYAsqXX2wIMRYjy47ZisSwnTzuBapQHru2SfHHT5snuLzU
	 NyJ/WPRp/6MGqP+ZMMhBM4jFWOLG5/qddVlFH5dKcZP1qRN2m4xOQPv74qFQfH8/rp
	 HRvkqkGUS91XBUdJFpJZXiT3vRq4FPOvfZVb8E1/oIsOHdhO7Z1761xudvFgPbsq0r
	 l7XGNa3vch39wRWsYD7c/tVCqEAyk/84VVKlCpUI6/mlItPi497RrIQuHRENY/R79h
	 8efYUvpHPwgqh8nQpKJOxnRvThALy2bP83BmgTfnm2bmRiHLGOhyWq7dtWHacQdkar
	 HgukqBYuuih7w==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CC0683781182;
	Thu,  6 Jun 2024 09:53:23 +0000 (UTC)
Message-ID: <25ba8753-b7e9-4f6f-a9ad-c5266540939a@collabora.com>
Date: Thu, 6 Jun 2024 12:53:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
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
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
 <2554679.TLnPLrj5Ze@diego>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2554679.TLnPLrj5Ze@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/24 5:48 PM, Heiko Stübner wrote:
> Am Samstag, 1. Juni 2024, 15:12:35 CEST schrieb Cristian Ciocaltea:
>> The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX controller supports
>> the following features, among others:
>>
>> * Fixed Rate Link (FRL)
>> * 4K@120Hz and 8K@60Hz video modes
>> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS), aka
>>   Cinema VRR
>> * Fast Vactive (FVA), aka Quick Frame Transport (QFT)
>> * SCDC I2C DDC access
>> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
>> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
>> * Multi-stream audio
>> * Enhanced Audio Return Channel (EARC)
>>
>> Add driver to enable basic support, i.e. RGB output up to 4K@60Hz,
>> without audio, CEC or any HDMI 2.1 specific features.
>>
>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/Makefile     |   2 +-
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 787 +++++++++++++++++++++++++
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h | 831 +++++++++++++++++++++++++++
>>  include/drm/bridge/dw_hdmi.h                 |   8 +
>>  4 files changed, 1627 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
>> index ce715562e9e5..8354e4879f70 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
>> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
> 
>> +static int dw_hdmi_qp_i2c_read(struct dw_hdmi *hdmi,
>> +			       unsigned char *buf, unsigned int length)
>> +{
>> +	struct dw_hdmi_i2c *i2c = hdmi->i2c;
>> +	int stat;
>> +
>> +	if (!i2c->is_regaddr) {
>> +		dev_dbg(hdmi->dev, "set read register address to 0\n");
>> +		i2c->slave_reg = 0x00;
>> +		i2c->is_regaddr = true;
>> +	}
>> +
>> +	while (length--) {
>> +		reinit_completion(&i2c->cmp);
>> +
>> +		dw_hdmi_qp_mod(hdmi, i2c->slave_reg++ << 12, I2CM_ADDR,
>> +			       I2CM_INTERFACE_CONTROL0);
>> +
>> +		dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
>> +			       I2CM_INTERFACE_CONTROL0);
> 
> Somehow the segment handling is present in the rest of the i2c code here, but
> not the actual handling for reads.
> 
> The vendor-kernel does:
> 
> -               dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
> -                              I2CM_INTERFACE_CONTROL0);
> +               if (i2c->is_segment)
> +                       dw_hdmi_qp_mod(hdmi, I2CM_EXT_READ, I2CM_WR_MASK,
> +                                      I2CM_INTERFACE_CONTROL0);
> +               else
> +                       dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
> +                                      I2CM_INTERFACE_CONTROL0);

Hmm, for some reason this is not present in the stable-5.10-rock5 branch 
I've been using as an implementation reference:

https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c#L760

Is there an updated fork?

> Without this change, connecting to a DVI display does not work, and
> reading the EDID ends in the "i2c read error" below.
> 
> Adding the segment handling as above makes the DVI connection
> work (as it does in the vendor-kernel).
> 
> So it would be nice if you could maybe incorporate this in the next version?

Sure, thanks for pointing this out!

Cristian

