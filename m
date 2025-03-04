Return-Path: <linux-kernel+bounces-544107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8CA4DD70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE13A4205
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322BB202C23;
	Tue,  4 Mar 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AjVbo8kd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE41FDA78
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089863; cv=none; b=fR+X/1BKLcVcJnV3kByCY/+pxz544TxY5weRQgfr1fSAfpZi71wTKs6GdpUsQVTgeFz8z9U0aacFkmh45OwgPia/jitJn59BlgiBrqnNz9wM6ZhxXAp2C4zazG71cI0nouiL8Dmr9pLV/EGPTmxTaQF5zhb0f5jJun75E/m11/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089863; c=relaxed/simple;
	bh=7VUHnquwE/QdFs1qoBO1l/34onrJ8q7S6w5kpFpcMcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iva6DaKLOE+2RxUZreqYIgDXhw+RCO/XRzdckAyXZ2N5mnqhQNBH9x1P+MavOo93++sjtZ1RQnkCcRpOLgFNoaIlBVJhhywN8bJxHT1dMlCDI8XpDvHskNvWDez1jlQNafLIGHjslQcqMnmGQb0C9uyPjk5TsrktwcLbp/NeY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AjVbo8kd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741089859;
	bh=7VUHnquwE/QdFs1qoBO1l/34onrJ8q7S6w5kpFpcMcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AjVbo8kdonHW6j6x9ddScTYnIJPHdmtbEdjH1VWVWapBKzQgU2yynW2nq7HtcWffb
	 Td5IvOxQBuDOgt0xFmEIXEl2EknaG5wnlkB/2cFHQ7Q6ghm+qMSxBPE270+dX+DpKt
	 UizZbUXAs9QmKoMY8S4ju5GHl4GnNhSg3IsxI6Ll/QmeFHwZ2euB128jYledwU3gTR
	 xTNm+ghilHPByK7Jyh1bOp4NtD7TOfuLOSRrcrj5x4oz6RjTiVkUBWlK1A4V58mUGT
	 v+1vjUTxrlU3ySKguUjwUPT4Z1BkO1Acf5xesQ2V2mtkeywwfCiN7SWvAcEP+OASpV
	 NVFz6VQR3IWJw==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 325F217E0A4E;
	Tue,  4 Mar 2025 13:04:19 +0100 (CET)
Message-ID: <155f609f-994f-4140-8453-7e38a5e6deef@collabora.com>
Date: Tue, 4 Mar 2025 14:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
To: Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-3-8657847c13f7@collabora.com>
 <20250304-small-mindful-mongrel-bd6f8b@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-small-mindful-mongrel-bd6f8b@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 3/4/25 10:13 AM, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Mar 04, 2025 at 03:44:02AM +0200, Cristian Ciocaltea wrote:
>> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
>> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
>> and not before.
>>
>> While at it, introduce a define for this rate limit constant.
>>
>> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> index f88369864c50e4563834ccbb26f1f9f440e99271..cf2c3a46604cb9d8c26fe5ec8346904e0b62848f 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> @@ -320,6 +320,7 @@
>>  #define LN3_TX_SER_RATE_SEL_HBR2_MASK	BIT(3)
>>  #define LN3_TX_SER_RATE_SEL_HBR3_MASK	BIT(2)
>>  
>> +#define HDMI14_MAX_RATE			340000000
>>  #define HDMI20_MAX_RATE			600000000
>>  
>>  enum dp_link_rate {
>> @@ -1072,7 +1073,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
>>  
>>  	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
>>  
>> -	if (rate >= 3400000) {
>> +	if (rate > HDMI14_MAX_RATE / 100) {
> 
> The rate seems to come from rk_hdptx_phy_power_on and eventually from
> tmds_char_rate in the PHY config options, so its rate is in Hertz.

The rate coming from rk_hdptx_phy_power_on() is in hHz, since it passed
via dw_hdmi_qp_rockchip_encoder_enable() as

  phy_set_bus_width(hdmi->phy, div_u64(rate, 100));

> HDMI14_MAX_RATE and HDMI20_MAX_RATE are both defined in Hertz as well.
> It seems super odd to mee that you then convert HDMI14_MAX_RATE to hHz?

This stems from the ropll_tmds_cfg table containing the configuration
params for the supported rates which requires the search keys to be
provided in hHz rather than Hz.

I agree this is nothing but confusing, that's why I fixed this up in
"phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead"

Thanks for reviewing!

Regards,
Cristian

