Return-Path: <linux-kernel+bounces-532592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA0A44FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7D3B1867
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A016211486;
	Tue, 25 Feb 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qJwTKFMt"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F115539D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521860; cv=none; b=cPo5rWEOaVwJWrs6HOUaL6lSxeQSaNUItpYAFQUHeyjDpjYkzuxKXy3Vo86GYGLGxhsXySetM5vEGE3FxkhjpPldyuI6zPJIxjTfZ0kGM9YXtenu0WLUnY46xHHqS9tdngrJ8bZlLzk4r23XDhjy/xWLIu0HkAZOBoFuvH3Rjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521860; c=relaxed/simple;
	bh=2xAg+xR9isAxludX2aUTlS5HqVo83GXFqkd+I9LuITo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2NgrrAWFLOgbDTMFjSdFyzgbKzIqd0zzwgrXggRuJDrUxyDw9pvvAw5pjX+o3nXQcYcgh0ngsN0jRWc2pA2zWsXyeF58TMtaH78cnLrOPrWeW+ZD8US6Xjm40a+01ER8JqBwmzWetugFZ+TPoIGPQmFjUTsSOdzhq8JE0sVz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qJwTKFMt; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n3DytzpBQbR3dn3E1tCdOf; Tue, 25 Feb 2025 23:16:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740521786;
	bh=d9A0JlJ4dz6HSjR6M0xdjKOHwvXf88YPRD+thZxM7BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qJwTKFMt9rHvzotJVhTQaLoATYLyaH4afQchZJZ2G6INFBu7WIu6ctwB/qZAQJdzJ
	 nNq2HZfbTX8gRF9cWzr2rQWPHKh81W7Cuq0IGp7NDz2+In+8vzUsysBkYBWqnf1G7i
	 lj/HZXkTSSL4ttQsLHmjf0weaoQrD60zfO9hCxRYe8aFZ2kj/G3bFtMB4uAN2cQ5f0
	 Iu4w7vdeRYAQ9Eb35bv/oJyS2suxR5jhVjskWYUxQawqVUHbDQkYnXVkNRFU3pUDX5
	 lheOj9JKUaT5GfbVa/9AUJfRnELdVTUjkKf5w5L5/q9o8dllm3pe4dk0DCgCwLyymB
	 G4SG4vtKJDBfQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 23:16:26 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7a8e6b9f-2fa2-4794-bb4f-3abdb784fbc3@wanadoo.fr>
Date: Tue, 25 Feb 2025 23:16:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: rockchip: usbdp: move type-orientation-switch
 further down
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-2-heiko@sntech.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225184519.3586926-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/02/2025 à 19:45, Heiko Stuebner a écrit :
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Move the typec-orientation-switch functionality further down, next to
> the typec-mux code. Not only brings this the typec-related functionality
> closer together, but also the following change needs access to other
> driver functions, that are below the current position.
> 
> No functional change.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 166 +++++++++++-----------
>   1 file changed, 83 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 5b1e8a3806ed..7b17c82ebcfc 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -616,89 +616,6 @@ static void rk_udphy_dp_hpd_event_trigger(struct rk_udphy *udphy, bool hpd)
>   	rk_udphy_grfreg_write(udphy->vogrf, &cfg->vogrfcfg[udphy->id].hpd_trigger, hpd);
>   }
>   
> -static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
> -{
> -	if (udphy->flip) {
> -		udphy->dp_lane_sel[0] = 0;
> -		udphy->dp_lane_sel[1] = 1;
> -		udphy->dp_lane_sel[2] = 3;
> -		udphy->dp_lane_sel[3] = 2;
> -		udphy->lane_mux_sel[0] = PHY_LANE_MUX_DP;
> -		udphy->lane_mux_sel[1] = PHY_LANE_MUX_DP;
> -		udphy->lane_mux_sel[2] = PHY_LANE_MUX_USB;
> -		udphy->lane_mux_sel[3] = PHY_LANE_MUX_USB;
> -		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_INVERT;
> -		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_INVERT;
> -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
> -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> -	} else {
> -		udphy->dp_lane_sel[0] = 2;
> -		udphy->dp_lane_sel[1] = 3;
> -		udphy->dp_lane_sel[2] = 1;
> -		udphy->dp_lane_sel[3] = 0;
> -		udphy->lane_mux_sel[0] = PHY_LANE_MUX_USB;
> -		udphy->lane_mux_sel[1] = PHY_LANE_MUX_USB;
> -		udphy->lane_mux_sel[2] = PHY_LANE_MUX_DP;
> -		udphy->lane_mux_sel[3] = PHY_LANE_MUX_DP;
> -		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_NORMAL;
> -		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_NORMAL;
> -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
> -	}
> -
> -	udphy->mode = UDPHY_MODE_DP_USB;
> -}
> -
> -static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
> -				 enum typec_orientation orien)
> -{
> -	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
> -
> -	mutex_lock(&udphy->mutex);
> -
> -	if (orien == TYPEC_ORIENTATION_NONE) {
> -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> -		/* unattached */
> -		rk_udphy_usb_bvalid_enable(udphy, false);
> -		goto unlock_ret;
> -	}
> -
> -	udphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
> -	rk_udphy_set_typec_default_mapping(udphy);
> -	rk_udphy_usb_bvalid_enable(udphy, true);
> -
> -unlock_ret:
> -	mutex_unlock(&udphy->mutex);
> -	return 0;
> -}
> -
> -static void rk_udphy_orien_switch_unregister(void *data)
> -{
> -	struct rk_udphy *udphy = data;
> -
> -	typec_switch_unregister(udphy->sw);
> -}
> -
> -static int rk_udphy_setup_orien_switch(struct rk_udphy *udphy)
> -{
> -	struct typec_switch_desc sw_desc = { };
> -
> -	sw_desc.drvdata = udphy;
> -	sw_desc.fwnode = dev_fwnode(udphy->dev);
> -	sw_desc.set = rk_udphy_orien_sw_set;
> -
> -	udphy->sw = typec_switch_register(udphy->dev, &sw_desc);
> -	if (IS_ERR(udphy->sw)) {
> -		dev_err(udphy->dev, "Error register typec orientation switch: %ld\n",
> -			PTR_ERR(udphy->sw));
> -		return PTR_ERR(udphy->sw);
> -	}
> -
> -	return devm_add_action_or_reset(udphy->dev,
> -					rk_udphy_orien_switch_unregister, udphy);
> -}
> -
>   static int rk_udphy_refclk_set(struct rk_udphy *udphy)
>   {
>   	unsigned long rate;
> @@ -1323,6 +1240,89 @@ static const struct phy_ops rk_udphy_usb3_phy_ops = {
>   	.owner		= THIS_MODULE,
>   };
>   
> +static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
> +{
> +	if (udphy->flip) {
> +		udphy->dp_lane_sel[0] = 0;
> +		udphy->dp_lane_sel[1] = 1;
> +		udphy->dp_lane_sel[2] = 3;
> +		udphy->dp_lane_sel[3] = 2;
> +		udphy->lane_mux_sel[0] = PHY_LANE_MUX_DP;
> +		udphy->lane_mux_sel[1] = PHY_LANE_MUX_DP;
> +		udphy->lane_mux_sel[2] = PHY_LANE_MUX_USB;
> +		udphy->lane_mux_sel[3] = PHY_LANE_MUX_USB;
> +		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_INVERT;
> +		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_INVERT;
> +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
> +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> +	} else {
> +		udphy->dp_lane_sel[0] = 2;
> +		udphy->dp_lane_sel[1] = 3;
> +		udphy->dp_lane_sel[2] = 1;
> +		udphy->dp_lane_sel[3] = 0;
> +		udphy->lane_mux_sel[0] = PHY_LANE_MUX_USB;
> +		udphy->lane_mux_sel[1] = PHY_LANE_MUX_USB;
> +		udphy->lane_mux_sel[2] = PHY_LANE_MUX_DP;
> +		udphy->lane_mux_sel[3] = PHY_LANE_MUX_DP;
> +		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_NORMAL;
> +		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_NORMAL;
> +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
> +	}
> +
> +	udphy->mode = UDPHY_MODE_DP_USB;
> +}
> +
> +static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
> +				 enum typec_orientation orien)
> +{
> +	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
> +
> +	mutex_lock(&udphy->mutex);
> +
> +	if (orien == TYPEC_ORIENTATION_NONE) {
> +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> +		/* unattached */
> +		rk_udphy_usb_bvalid_enable(udphy, false);
> +		goto unlock_ret;
> +	}
> +
> +	udphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
> +	rk_udphy_set_typec_default_mapping(udphy);
> +	rk_udphy_usb_bvalid_enable(udphy, true);
> +
> +unlock_ret:
> +	mutex_unlock(&udphy->mutex);
> +	return ret;

This will break built.

It was return 0 preivously.
This change should be aprt of 2/2 where "int ret;" is introduced.

CJ


> +}
> +
> +static void rk_udphy_orien_switch_unregister(void *data)
> +{
> +	struct rk_udphy *udphy = data;
> +
> +	typec_switch_unregister(udphy->sw);
> +}
> +
> +static int rk_udphy_setup_orien_switch(struct rk_udphy *udphy)
> +{
> +	struct typec_switch_desc sw_desc = { };
> +
> +	sw_desc.drvdata = udphy;
> +	sw_desc.fwnode = dev_fwnode(udphy->dev);
> +	sw_desc.set = rk_udphy_orien_sw_set;
> +
> +	udphy->sw = typec_switch_register(udphy->dev, &sw_desc);
> +	if (IS_ERR(udphy->sw)) {
> +		dev_err(udphy->dev, "Error register typec orientation switch: %ld\n",
> +			PTR_ERR(udphy->sw));
> +		return PTR_ERR(udphy->sw);
> +	}
> +
> +	return devm_add_action_or_reset(udphy->dev,
> +					rk_udphy_orien_switch_unregister, udphy);
> +}
> +
>   static int rk_udphy_typec_mux_set(struct typec_mux_dev *mux,
>   				  struct typec_mux_state *state)
>   {


