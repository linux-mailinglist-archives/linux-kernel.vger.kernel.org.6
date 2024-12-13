Return-Path: <linux-kernel+bounces-444345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CA9F051C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55091687FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6018EFD4;
	Fri, 13 Dec 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="VS5Q/Gm/"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B517AE1C;
	Fri, 13 Dec 2024 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073058; cv=none; b=geJA0kQZN8cDoqfaswYcAOC5/J30DeA2+iKfk9a3cVrmAfbbFivStQfK2We6Yt750B+MmlAhtCN6W3qbH18bOAbt3+xgTiMZJexwG5SUIbEpOwePXEuDzJyCZUi8wh1l0MPuiSkTSZ8HKz3bAdDVtqGG9sBJN0cj3NuIHYI1rOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073058; c=relaxed/simple;
	bh=5qyiSpmKIAbZ4WXcWu0Ly4A3/IZ/K4R/lUgA3raXBV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYIcNFYnHDHHbeXUcj/aoD4u629nDVfca69I4ffUArv0RYRbeJ2CfrEK9rHQC6onJcPyIIaEyfx8YvcRz83FUe0oCnP6zdLfJk9bINyACPM533qfFBRm2bOA2G34+izomXYCQLCLUzjx0fKAvjm81nfPXoHLDjaT116u5PwXxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=VS5Q/Gm/; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mz5+fDTTej/xbzEM2PzYBBnHKsi8dVYTYuT376akQF0=; b=VS5Q/Gm/ZPIbUPXpceSul9RGfV
	Dk+Uk/S5gS1pkNAkyBkDXwiAoYLSTJ49vMuUJuuvfUGGlp5/gpJGrMw5xkZLXZBue1owd2BKnKuw2
	4VBGQ65S6bXec9oIgISbrUlhiUvI/iSbkt0SsiwcbZRVsOE6ie93/sAUht67RDfe2LZewRuKrE0iY
	ifTfDm14KLr3UjYUeOEdwv62QPYuTPtS0dohb2sa3wkHO7L1Jiqwvamdp3M+E9wpa+68NwaLC6vUp
	dMhRLtUBX8630QTz0xT8tvte3n7JbNm4lsTDeeCBFjpLdI7gkHdc8HOyXE5sWbYekZYtYHCVXrVGF
	jPusKcfQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:44300 helo=[192.168.69.52])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tLzcE-00CtFs-2s;
	Fri, 13 Dec 2024 07:57:34 +0100
Message-ID: <cdf8cff7-543c-4a28-bf2e-bc7f331d0db5@norik.com>
Date: Fri, 13 Dec 2024 07:57:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] drm/bridge: ti-sn65dsi83: Add ti,lvds-vod-swing
 optional properties
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, marex@denx.de
References: <20241212121712.214639-1-andrej.picej@norik.com>
 <20241212121712.214639-3-andrej.picej@norik.com>
 <45f90007-3136-4b59-a3fc-6fc0147b8ad8@wanadoo.fr>
Content-Language: en-US
From: Andrej Picej <andrej.picej@norik.com>
Autocrypt: addr=andrej.picej@norik.com; keydata=
 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
 xtT/8OxBOVSHvA==
In-Reply-To: <45f90007-3136-4b59-a3fc-6fc0147b8ad8@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Christophe,

On 12. 12. 24 13:33, Christophe JAILLET wrote:
> Le 12/12/2024 à 13:17, Andrej Picej a écrit :
>> Add a optional properties to change LVDS output voltage. This should not
>> be static as this depends mainly on the connected display voltage
>> requirement. We have three properties:
>> - "ti,lvds-termination-ohms", which sets near end termination,
>> - "ti,lvds-vod-swing-data-microvolt" and
>> - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
>> output voltage for data and clock lanes. They are defined as an array
>> with min and max values. The appropriate bitfield will be set if
>> selected constraints can be met.
>>
>> If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
>> end termination will be used. Selecting only one:
>> "ti,lvds-vod-swing-data-microvolt" or
>> "ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
>> constraint for only data/clock lanes will be met. Setting both is
>> recommended.
> 
> ...
> 
>> +static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
>> +    u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i <= 3; i++) {
>> +        if (lvds_vod_swing_data_table[lvds_term][i][0] >= 
>> lvds_vod_swing_data[0] &&
>> +        lvds_vod_swing_data_table[lvds_term][i][1] <= 
>> lvds_vod_swing_data[1] &&
>> +        lvds_vod_swing_clock_table[lvds_term][i][0] >= 
>> lvds_vod_swing_clk[0] &&
>> +        lvds_vod_swing_clock_table[lvds_term][i][1] <= 
>> lvds_vod_swing_clk[1])
> 
> Adding a few spaces to align things would help reading.

Ok, that makes sense, will fix.

> 
>> +            return i;
>> +    }
>> +
>> +    dev_err(dev, "failed to find appropriate LVDS_VOD_SWING 
>> configuration\n");
>> +    return -EINVAL;
>> +}
>> +
>> +static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int 
>> channel)
>> +{
>> +    struct device *dev = ctx->dev;
>> +    struct device_node *endpoint;
>> +    int endpoint_reg;
>> +    /* Set so the property can be freely selected if not defined */
>> +    u32 lvds_vod_swing_data[2] = { 0, 1000000 };
>> +    u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
>> +    /* Set default near end terminataion to 200 Ohm */
>> +    u32 lvds_term = 200;
>> +    int lvds_vod_swing_conf;
>> +    int ret = 0;
>> +    int ret_data;
>> +    int ret_clock;
>> +
>> +    if (channel == CHANNEL_A)
>> +        endpoint_reg = 2;
>> +    else
>> +        endpoint_reg = 3;
>> +
>> +    endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 
>> endpoint_reg, -1);
>> +
>> +    of_property_read_u32(endpoint, "ti,lvds-termination-ohms", 
>> &lvds_term);
>> +    if (lvds_term == 100)
>> +        ctx->lvds_term_conf[channel] = OHM_100;
>> +    else if (lvds_term == 200)
>> +        ctx->lvds_term_conf[channel] = OHM_200;
>> +    else
>> +        return -EINVAL;
> 
> Should it be:
>      else {
>          ret = -EINVAL;
>          goto exit;
>      }
> ?

Of course, good catch. Thanks.

Best regards,
Andrej.

> 
>> +
>> +    ret_data = of_property_read_u32_array(endpoint, 
>> "ti,lvds-vod-swing-data-microvolt",
>> +                    lvds_vod_swing_data, 
>> ARRAY_SIZE(lvds_vod_swing_data));
>> +    if (ret_data != 0 && ret_data != -EINVAL) {
>> +        ret = ret_data;
>> +        goto exit;
>> +    }
>> +
>> +    ret_clock = of_property_read_u32_array(endpoint, 
>> "ti,lvds-vod-swing-clock-microvolt",
>> +                    lvds_vod_swing_clk, ARRAY_SIZE(lvds_vod_swing_clk));
>> +    if (ret_clock != 0 && ret_clock != -EINVAL) {
>> +        ret = ret_clock;
>> +        goto exit;
>> +    }
>> +
>> +    /* Use default value if both properties are NOT defined. */
>> +    if (ret_data == -EINVAL && ret_clock == -EINVAL)
>> +        lvds_vod_swing_conf = 0x1;
>> +
>> +    /* Use lookup table if any of the two properties is defined. */
>> +    if (!ret_data || !ret_clock) {
>> +        lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev, 
>> lvds_vod_swing_data,
>> +                        lvds_vod_swing_clk, 
>> ctx->lvds_term_conf[channel]);
>> +        if (lvds_vod_swing_conf < 0) {
>> +            ret = lvds_vod_swing_conf;
>> +            goto exit;
>> +        }
>> +    }
>> +
>> +    ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
>> +    ret = 0;
>> +exit:
>> +    of_node_put(endpoint);
>> +    return ret;
>> +}
> 
> ...
> 
> CJ

