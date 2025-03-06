Return-Path: <linux-kernel+bounces-549349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12944A5519E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1CF3A6DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94575212B0D;
	Thu,  6 Mar 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LVdJ9bO6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CF440C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279140; cv=none; b=iTdACuWSW6/DWp/eTTvmcrTAtHp8fTMi0Ay30lu5KZMMH1rTvJSrW6sgsxrVHL6W50YN8cv9OdnZtUCHyuzbMRZhAtmtoOIX55fpklazys8e5xfbk6tGNzpuaX4bGlpOvceF1P4RLUPPtnMXxcIz0OOSVwGRHiz/DxumlBtGsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279140; c=relaxed/simple;
	bh=pf36QmNJXVaZuz3s0mehd9lTyDeLXhfnvdrEPGA0Fj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHA/4dmI1DLH2m9kNj6JOxS4lFiCbKfMmOvsorscpThITIgErCR4tZg+yTzAtGUKKWIpcR2bHZwnKUNhPPd1omUiC/QYgAiWPHpYhEXz4qeVkWxi8qblI7FiXsXUxZwlLV1U25cXbV/IMjWMOjqnEQnAFWhL5d8Z05jLxGUrxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LVdJ9bO6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741279135;
	bh=pf36QmNJXVaZuz3s0mehd9lTyDeLXhfnvdrEPGA0Fj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LVdJ9bO6yHENnaiGBkjkHB6ID9jroBGW+832lD2QHbp1MoPDOdOrLAFh5PK67eH3B
	 J8hW+/HhpWumL0HgRcfXj2n1b964Dgd8IrMCFuVesFqGfwbOHN7DRsMd9U3Y9bJGLq
	 /1SKMpO2qRhSrh5oztFLL3if988MSDBQxXrnXsaogjwuLH0UpNhEFzfHgjpU4SGLaO
	 vFlF264y7A44/zYXFotkTS6KgYN/PsL23H8Hw7ZwxYICU3/sySmMCbfoNNICpYPIUu
	 J087mlZc7AmqD2XPxjTg1d3O7lmHAf3H074JopdaaJYcuvc8+QEn/vrnRaaAV1bdiS
	 WylyrhmOK71AQ==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3232D17E086B;
	Thu,  6 Mar 2025 17:38:55 +0100 (CET)
Message-ID: <0600430d-12c1-4af7-9082-76448943b02a@collabora.com>
Date: Thu, 6 Mar 2025 18:38:53 +0200
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
 <155f609f-994f-4140-8453-7e38a5e6deef@collabora.com>
 <20250306-masked-voracious-octopus-be05b8@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250306-masked-voracious-octopus-be05b8@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:35 PM, Maxime Ripard wrote:
> On Tue, Mar 04, 2025 at 02:04:18PM +0200, Cristian Ciocaltea wrote:
>> Hi Maxime,
>>
>> On 3/4/25 10:13 AM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Tue, Mar 04, 2025 at 03:44:02AM +0200, Cristian Ciocaltea wrote:
>>>> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
>>>> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
>>>> and not before.
>>>>
>>>> While at it, introduce a define for this rate limit constant.
>>>>
>>>> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> index f88369864c50e4563834ccbb26f1f9f440e99271..cf2c3a46604cb9d8c26fe5ec8346904e0b62848f 100644
>>>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> @@ -320,6 +320,7 @@
>>>>  #define LN3_TX_SER_RATE_SEL_HBR2_MASK	BIT(3)
>>>>  #define LN3_TX_SER_RATE_SEL_HBR3_MASK	BIT(2)
>>>>  
>>>> +#define HDMI14_MAX_RATE			340000000
>>>>  #define HDMI20_MAX_RATE			600000000
>>>>  
>>>>  enum dp_link_rate {
>>>> @@ -1072,7 +1073,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
>>>>  
>>>>  	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
>>>>  
>>>> -	if (rate >= 3400000) {
>>>> +	if (rate > HDMI14_MAX_RATE / 100) {
>>>
>>> The rate seems to come from rk_hdptx_phy_power_on and eventually from
>>> tmds_char_rate in the PHY config options, so its rate is in Hertz.
>>
>> The rate coming from rk_hdptx_phy_power_on() is in hHz, since it passed
>> via dw_hdmi_qp_rockchip_encoder_enable() as
>>
>>   phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
>>
>>> HDMI14_MAX_RATE and HDMI20_MAX_RATE are both defined in Hertz as well.
>>> It seems super odd to mee that you then convert HDMI14_MAX_RATE to hHz?
>>
>> This stems from the ropll_tmds_cfg table containing the configuration
>> params for the supported rates which requires the search keys to be
>> provided in hHz rather than Hz.
>>
>> I agree this is nothing but confusing, that's why I fixed this up in
>> "phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead"
> 
> Yeah, sorry, I noticed it after sending the review. Still, I'd advise to
> put that patch first, it's a bit weird to add more patch we're going to
> rework later on.

No worries and yes, I've already planned to move the patch before all
the others adding more stuff.  I'd still keep this patch as is, to make
it easier for backporting, as well as the next three patches dropping
stuff, before continuing with the unit conversion.

