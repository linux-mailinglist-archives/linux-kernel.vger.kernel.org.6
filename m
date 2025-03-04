Return-Path: <linux-kernel+bounces-544118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64190A4DD96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A918975FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53817201110;
	Tue,  4 Mar 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W+6OkqBw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A71FC7E5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090343; cv=none; b=YQ2EWjE0ggpocrsaJcvsjqO4vlsAiQbO0mabnMXCZN7cRzRsDDVUsLGUqv1xczsaiHNiLnZEa91rNSYVh0mvstz7bYoBz5uLmxVYLCb/1HRusg8orvcr0ZQitXEBpe3Dnk8lfQfUFUwvQQT46T7GdFOw7WmGFF778HfxemGmv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090343; c=relaxed/simple;
	bh=2EWvYx/k/x8mpI0CYKajuJPigLOs0dmymMDl3QAd2hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYQUPjBhXEA0E+5P6XZO4lxdbCumuW0iCre1baw9OtUcFa8/C/7hmXsHWEGkFLnp8dp55/po/S2eewuyI70uKSFAOCB6qA3tMLNrci7p0v+KLfJQFG+FoAYQs0Io3CMxQywX3sYb/tjly1B4x4WbN/zuVqfMaJ98wrU3JZgBHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W+6OkqBw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741090339;
	bh=2EWvYx/k/x8mpI0CYKajuJPigLOs0dmymMDl3QAd2hI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W+6OkqBwc1A2NIjP3nnNr7SLiC2ThlRzqbIbKrsXKeVfwlMZkAVMHWVarX/ftESaD
	 azit1IA/HORWSZH+Go4Otd0cdd2BMMaD8OqDHUjep7Hm4HwqaNUTscOPG81+0wqwAr
	 ZK5LqjpUDxo7mfQQhJXbVQURC5TtNjv9kLQDkLSAcdYS51LXhmmniVV0r9z0yjN8RL
	 ICGBkOJuBBvjtijxGyre0v16L0um9ChpIIOOhJXFPIElpeRC58f5NUXZhEJXg7sjm4
	 /aDMPAC5SQl8N7TC6NuW9f3WTH0ZyBwYpNd/sMQbeOpLO648CItB42rFi1QGHSwQip
	 YrWkTlxCGJTOQ==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B9DC17E088C;
	Tue,  4 Mar 2025 13:12:19 +0100 (CET)
Message-ID: <ddf4c3c9-849c-4d96-a073-966bb19a6047@collabora.com>
Date: Tue, 4 Mar 2025 14:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
To: Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-7-8657847c13f7@collabora.com>
 <20250304-turtle-of-serious-aurora-2b0bae@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-turtle-of-serious-aurora-2b0bae@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 10:15 AM, Maxime Ripard wrote:
> On Tue, Mar 04, 2025 at 03:44:06AM +0200, Cristian Ciocaltea wrote:
>> The current workaround to setup the TMDS character rate relies on the
>> unconventional usage of phy_set_bus_width().
>>
>> Make use of the recently introduced HDMI PHY configuration API to
>> properly handle the setup.  The workaround will be dropped as soon as
>> the switch has been completed on both ends.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 54 ++++++++++++++++-------
>>  1 file changed, 38 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> index 2bf525514c1991a1299265d12e1e85f66333c604..7e1d1c10758249aa5bbddbdaae0108bba04f30df 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> @@ -394,6 +394,7 @@ struct rk_hdptx_phy {
>>  
>>  	int phy_id;
>>  	struct phy *phy;
>> +	struct phy_configure_opts_hdmi hdmi_cfg;
>>  	struct clk_bulk_data *clks;
>>  	int nr_clks;
>>  	struct reset_control_bulk_data rsts[RST_MAX];
>> @@ -1409,19 +1410,25 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
>>  static int rk_hdptx_phy_power_on(struct phy *phy)
>>  {
>>  	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
>> -	int bus_width = phy_get_bus_width(hdptx->phy);
>>  	enum phy_mode mode = phy_get_mode(phy);
>> +	unsigned int rate = 0;
>>  	int ret, lane;
>>  
>> -	/*
>> -	 * FIXME: Temporary workaround to pass pixel_clk_rate
>> -	 * from the HDMI bridge driver until phy_configure_opts_hdmi
>> -	 * becomes available in the PHY API.
>> -	 */
>> -	unsigned int rate = bus_width & 0xfffffff;
>> -
>> -	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
>> -		__func__, bus_width, rate);
>> +	if (mode != PHY_MODE_DP) {
>> +		if (!hdptx->hdmi_cfg.tmds_char_rate) {
>> +			/*
>> +			 * FIXME: Temporary workaround to setup TMDS char rate
>> +			 * from the RK DW HDMI QP bridge driver.
>> +			 * Will be removed as soon the switch to the HDMI PHY
>> +			 * configuration API has been completed on both ends.
>> +			 */
>> +			rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
>> +			hdptx->hdmi_cfg.tmds_char_rate = rate * 100;
>> +		} else {
>> +			rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
>> +		}
>> +		dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
>> +	}
> 
> Some story here, I can't make sense of a variable in hHz. If it's
> actually needed and not a bug, this should be very explictly documented.

Not a bug - as explained earlier, phy_set_bus_width() on the other end
passes this in hHz.  I agree it should have been properly documented,
but eventually we got this cleaned up in the last patch of the series.

Thanks,
Cristian

