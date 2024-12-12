Return-Path: <linux-kernel+bounces-442811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F19EE24A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A991883B40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C420E31C;
	Thu, 12 Dec 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bm2MQOWk"
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com [101.71.155.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9913E40F;
	Thu, 12 Dec 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994649; cv=none; b=c8Kj/U/zDyh/Vo7nWnYAmnrADtBfPAZsqAWDaJaJDRqMACFCSL/Hry8OPXo3pAOyCEUMRpUZWu5/qyGHzK99siD+BTEqFOzNInP88wsHDUouqE9Ak/aBDrtc9II1tm4GCEypaYbK63S4xmbNyu/UtFKJCAH+1DmZlP6nsrKHjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994649; c=relaxed/simple;
	bh=jwYrXDddRG3PR4qyYG5gwWlBh42QqTd8zTyJJlniWlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZgNrnpoydXEoM/szrOVcG7DkRiPMbgsbJXWsfehaPx9tsNcR9dJ6ptw4fP2aZNxbZkyj5cTEmVxpkNT6lvRy9BWfHjqqt9EttgTWUp/NxFP9Kcm6oKYFlj+LRhaV4KGeN8gsx1AOlYx8SGc3n0Nf8Ek8dF3PRmNFZn7JRZU2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Bm2MQOWk; arc=none smtp.client-ip=101.71.155.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 587970be;
	Thu, 12 Dec 2024 16:55:19 +0800 (GMT+08:00)
Message-ID: <f6fd6efe-73bb-4aa2-a075-9a03c39951df@rock-chips.com>
Date: Thu, 12 Dec 2024 16:55:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] drm/bridge: analogix_dp: Add support for phy
 configuration.
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heiko@sntech.de, robh@kernel.org, conor+dt@kernel.org,
 algea.cao@rock-chips.com, rfoss@kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, kever.yang@rock-chips.com,
 linux-rockchip@lists.infradead.org, vkoul@kernel.org,
 andy.yan@rock-chips.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-7-damon.ding@rock-chips.com>
 <twhosvpoyafo472gqsblpvxmuewe2lkqufxabp2q7o636uinfm@unzyfv2pchqn>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <twhosvpoyafo472gqsblpvxmuewe2lkqufxabp2q7o636uinfm@unzyfv2pchqn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1DT1YYHk1DQkkaHUtOGUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93ba14685803a3kunm587970be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Qjo4FTIPOjQOCTcYCB0h
	DS8wCT9VSlVKTEhIQkJITElKQ09MVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTE1JNwY+
DKIM-Signature:a=rsa-sha256;
	b=Bm2MQOWkXjx8Pf9F3W4LsD7hTW78m7eB7oq2XDcJbwtsVGle3yaMemLVAEN+zVoWZx1sSiKi07Y1Rcxs8X+7lH/hi9FsqJO5eqOVWzogYs3zRK3doeb9Kv0vTMPvpyP88zoti2YuAe7NHqy+LN/uRRr11+USss2pTU7MU1cFiqk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=FoVNNZh4L/GMNtlxTr6ggp+PnIEfUziJ14W8Sk9sycA=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 2024/11/30 16:53, Dmitry Baryshkov wrote:
> On Wed, Nov 27, 2024 at 03:51:53PM +0800, Damon Ding wrote:
>> Add support to configurate link rate, lane count, voltage swing and
>> pre-emphasis with phy_configure(). It is helpful in application scenarios
>> where analogix controller is mixed with the phy of other vendors.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   .../drm/bridge/analogix/analogix_dp_core.c    |  4 +-
>>   .../drm/bridge/analogix/analogix_dp_core.h    |  2 +
>>   .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 90 +++++++++++++++++++
>>   3 files changed, 94 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 6f10d88a34c5..7624ed13cdbf 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1672,7 +1672,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_probe);
>>   
>>   int analogix_dp_suspend(struct analogix_dp_device *dp)
>>   {
>> -	phy_power_off(dp->phy);
>> +	analogix_dp_phy_power_off(dp);
> 
> Why?
> 
>>   
>>   	if (dp->plat_data->power_off)
>>   		dp->plat_data->power_off(dp->plat_data);
>> @@ -1696,7 +1696,7 @@ int analogix_dp_resume(struct analogix_dp_device *dp)
>>   	if (dp->plat_data->power_on)
>>   		dp->plat_data->power_on(dp->plat_data);
>>   
>> -	phy_power_on(dp->phy);
>> +	analogix_dp_phy_power_on(dp);
> 
> Why?
> 

These changes for phy_power_on()/phy_power_off() may be unnecessary. I 
will just put the phy_set_mode() before phy_power_on() in next version.

>>   
>>   	analogix_dp_init_dp(dp);
>>   
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> index 774d11574b09..a76079d61768 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> @@ -232,5 +232,7 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
>>   			     struct dp_sdp *vsc, bool blocking);
>>   ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>>   			     struct drm_dp_aux_msg *msg);
>> +void analogix_dp_phy_power_on(struct analogix_dp_device *dp);
>> +void analogix_dp_phy_power_off(struct analogix_dp_device *dp);
>>   
>>   #endif /* _ANALOGIX_DP_CORE_H */
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> index 3afc73c858c4..809bb0c72d18 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>> +#include <linux/phy/phy.h>
>>   
>>   #include <drm/bridge/analogix_dp.h>
>>   
>> @@ -513,10 +514,27 @@ void analogix_dp_enable_sw_function(struct analogix_dp_device *dp)
>>   void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype)
>>   {
>>   	u32 reg;
>> +	int ret;
>>   
>>   	reg = bwtype;
>>   	if ((bwtype == DP_LINK_BW_2_7) || (bwtype == DP_LINK_BW_1_62))
>>   		writel(reg, dp->reg_base + ANALOGIX_DP_LINK_BW_SET);
>> +
>> +	if (dp->phy) {
>> +		union phy_configure_opts phy_cfg = {0};
>> +
>> +		phy_cfg.dp.lanes = dp->link_train.lane_count;
> 
> You can drop this, .set_lanes is false.
> 
>> +		phy_cfg.dp.link_rate =
>> +			drm_dp_bw_code_to_link_rate(dp->link_train.link_rate) / 100;
>> +		phy_cfg.dp.set_lanes = false;
>> +		phy_cfg.dp.set_rate = true;
>> +		phy_cfg.dp.set_voltages = false;
> 
> You don't need to set those to false, it's cleared by = {0};
> 
>> +		ret = phy_configure(dp->phy, &phy_cfg);
>> +		if (ret && ret != -EOPNOTSUPP) {
>> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
>> +			return;
>> +		}
>> +	}
>>   }
>>   
>>   void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype)
>> @@ -530,9 +548,24 @@ void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype)
>>   void analogix_dp_set_lane_count(struct analogix_dp_device *dp, u32 count)
>>   {
>>   	u32 reg;
>> +	int ret;
>>   
>>   	reg = count;
>>   	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_COUNT_SET);
>> +
>> +	if (dp->phy) {
>> +		union phy_configure_opts phy_cfg = {0};
>> +
>> +		phy_cfg.dp.lanes = dp->link_train.lane_count;
>> +		phy_cfg.dp.set_lanes = true;
>> +		phy_cfg.dp.set_rate = false;
>> +		phy_cfg.dp.set_voltages = false;
> 
> Likewise
> 
>> +		ret = phy_configure(dp->phy, &phy_cfg);
>> +		if (ret && ret != -EOPNOTSUPP) {
>> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
>> +			return;
>> +		}
>> +	}
>>   }
>>   
>>   void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
>> @@ -546,10 +579,39 @@ void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
>>   void analogix_dp_set_lane_link_training(struct analogix_dp_device *dp)
>>   {
>>   	u8 lane;
>> +	int ret;
>>   
>>   	for (lane = 0; lane < dp->link_train.lane_count; lane++)
>>   		writel(dp->link_train.training_lane[lane],
>>   		       dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL + 4 * lane);
>> +
>> +	if (dp->phy) {
>> +		union phy_configure_opts phy_cfg = {0};
>> +
>> +		for (lane = 0; lane < dp->link_train.lane_count; lane++) {
>> +			u8 training_lane = dp->link_train.training_lane[lane];
>> +			u8 vs, pe;
>> +
>> +			vs = (training_lane & DP_TRAIN_VOLTAGE_SWING_MASK) >>
>> +			     DP_TRAIN_VOLTAGE_SWING_SHIFT;
>> +			pe = (training_lane & DP_TRAIN_PRE_EMPHASIS_MASK) >>
>> +			     DP_TRAIN_PRE_EMPHASIS_SHIFT;
>> +			phy_cfg.dp.voltage[lane] = vs;
>> +			phy_cfg.dp.pre[lane] = pe;
>> +		}
>> +
>> +		phy_cfg.dp.lanes = dp->link_train.lane_count;
>> +		phy_cfg.dp.link_rate =
>> +			drm_dp_bw_code_to_link_rate(dp->link_train.link_rate) / 100;
> 
> You can drop these two.

Indeed, all the needless assignments for phy_configure() will be deleted 
in next version.

> 
>> +		phy_cfg.dp.set_lanes = false;
>> +		phy_cfg.dp.set_rate = false;
>> +		phy_cfg.dp.set_voltages = true;
>> +		ret = phy_configure(dp->phy, &phy_cfg);
>> +		if (ret && ret != -EOPNOTSUPP) {
>> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
>> +			return;
>> +		}
>> +	}
>>   }
>>   
>>   u32 analogix_dp_get_lane_link_training(struct analogix_dp_device *dp, u8 lane)
>> @@ -1053,3 +1115,31 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>>   
>>   	return -EREMOTEIO;
>>   }
>> +
>> +void analogix_dp_phy_power_on(struct analogix_dp_device *dp)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_set_mode(dp->phy, PHY_MODE_DP);
>> +	if (ret) {
>> +		dev_err(dp->dev, "%s: phy_set_mode() failed: %d\n", __func__, ret);
>> +		return;
>> +	}
>> +
>> +	ret = phy_power_on(dp->phy);
>> +	if (ret) {
>> +		dev_err(dp->dev, "%s: phy_power_on() failed: %d\n", __func__, ret);
> 
> There is already a dev_err() call in phy_power_on().
> 
>> +		return;
>> +	}
>> +}
>> +
>> +void analogix_dp_phy_power_off(struct analogix_dp_device *dp)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_power_off(dp->phy);
>> +	if (ret) {
>> +		dev_err(dp->dev, "%s: phy_power_off() failed: %d\n", __func__, ret);
> 
> There is already a dev_err() call in phy_power_off().
> 
>> +		return;
>> +	}
>> +}
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

Best regards,
Damon


