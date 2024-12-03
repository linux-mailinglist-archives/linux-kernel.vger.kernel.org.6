Return-Path: <linux-kernel+bounces-429160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C449E1807
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14B92854F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142351E25EB;
	Tue,  3 Dec 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="fEoWVV5u"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C371E1335;
	Tue,  3 Dec 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218850; cv=none; b=hE4c9qttlFU/R0l/GO2bNTRlnhHWroruc3pc2fUe0YkgusK2Q8xHhUB8qaUmoJwfN0KCMp9kKHyf2AAGRlcS/VVS35cKtg6pLkRrEQAWDJ264UcdCqPdCbIxeYMznqyWWTBVsBluBHXXmOvME7vSp3P2RDE11DLWDA8YOI9Y3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218850; c=relaxed/simple;
	bh=iytTdnjzgJ3zi93wfbEfqHtH6CCHtA5tI/Jiub/ZTI8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p4C3ZegQv+nAM06pD5d+Pn2HoztSLxfb0pRxe1KaEQ1H2UtHl7FeWcw80Hj3btJu+LEZjZO+ZAohPuU9ObxXyRl682xOHN7E2/QDvzBHUhX3SEgPyMETaRHRpXX83ZiMrAWqHc67UyeMY3utgwso8X+lLnDosoN3kd9QRe/n33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=fEoWVV5u; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
	:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=maeXPvE+tKNblBFORvaPs0r+TMuJ79CuzqB7LrGx7Xw=; b=fEoWVV5uoTR82cn8GaHyfGL7FZ
	DYEWuPSBZxTWVL4bXvMYL8mGPIne/Y6eaTobbJgToTUs8Y+XZwYw7sVealpuZLHcowch9MPAUCbhK
	cYyEPzP0weLmOXjPNeedbGHyFXURLZBGK7ahJyX9vWsKBLYOPOVNPYQkjkrpVKjdKIR9DWExuLztZ
	6/D/By95EGFF3dqETgFE6uOQACT++ANzWLIUuQRha7m0ku9ozfnueR+D5Es63JXN0oOX2pox3rGky
	Vmxs0XY0SqZ3blwJbtUTl5fhxbBpzbmtWFExtW4sdkZGvx+LOVJdLaFvYjKynL4ntmuxHIs/UI3hR
	d6IjmlgA==;
Received: from 77-38-14-103.dynamic.telemach.net ([77.38.14.103]:54096 helo=[192.168.0.15])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tIPOf-00BNdA-38;
	Tue, 03 Dec 2024 10:40:45 +0100
Message-ID: <e503b751-7c4b-4fac-ab8e-1724fd3639d2@norik.com>
Date: Tue, 3 Dec 2024 10:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Add ti,
 lvds-vod-swing optional properties
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, marex@denx.de
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 upstream@lists.phytec.de, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <20241203085822.2475138-1-andrej.picej@norik.com>
 <20241203085822.2475138-3-andrej.picej@norik.com>
Content-Language: en-GB
In-Reply-To: <20241203085822.2475138-3-andrej.picej@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi all,

On 3. 12. 24 09:58, Andrej Picej wrote:
> Add a optional properties to change LVDS output voltage. This should not
> be static as this depends mainly on the connected display voltage
> requirement. We have three properties:
> - "ti,lvds-termination-ohms", which sets near end termination,
> - "ti,lvds-vod-swing-data-microvolt" and
> - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
> output voltage for data and clock lanes. They are defined as an array
> with min and max values. The appropriate bitfiled will be set if
> selected constraints can be met.
> 
> If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
> end termination will be used. Selecting only one:
> "ti,lvds-vod-swing-data-microvolt" or
> "ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
> constraint for only data/clock lanes will be met. Setting both is
> recommended.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v2:
> - use datasheet tables to get the proper configuration
> - since major change was done change the authorship to myself
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 144 +++++++++++++++++++++++++-
>   1 file changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 57a7ed13f996..44445d7ad52a 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -132,6 +132,16 @@
>   #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
>   #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
>   
> +enum sn65dsi83_channel {
> +	CHANNEL_A,
> +	CHANNEL_B
> +};
> +
> +enum sn65dsi83_lvds_term {
> +	OHM_100,
> +	OHM_200
> +};
> +
>   enum sn65dsi83_model {
>   	MODEL_SN65DSI83,
>   	MODEL_SN65DSI84,
> @@ -147,6 +157,10 @@ struct sn65dsi83 {
>   	struct regulator		*vcc;
>   	bool				lvds_dual_link;
>   	bool				lvds_dual_link_even_odd_swap;
> +	int				lvdsA_vod_swing_conf;
> +	int				lvdsB_vod_swing_conf;
> +	int				lvdsA_term_conf;
> +	int				lvdsB_term_conf;
>   };
>   
>   static const struct regmap_range sn65dsi83_readable_ranges[] = {
> @@ -237,6 +251,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
>   	.max_register = REG_IRQ_STAT,
>   };
>   
> +static const int lvds_vod_swing_data_table[2][4][2] = {
> +	{	/* 100 Ohm */
> +		{ 180000, 313000 },
> +		{ 215000, 372000 },
> +		{ 250000, 430000 },
> +		{ 290000, 488000 },
> +	},
> +	{	/* 200 Ohm */
> +		{ 150000, 261000 },
> +		{ 200000, 346000 },
> +		{ 250000, 428000 },
> +		{ 300000, 511000 },
> +	},
> +};
> +
> +static const int lvds_vod_swing_clock_table[2][4][2] = {
> +	{	/* 100 Ohm */
> +		{ 140000, 244000 },
> +		{ 168000, 290000 },
> +		{ 195000, 335000 },
> +		{ 226000, 381000 },
> +	},
> +	{	/* 200 Ohm */
> +		{ 117000, 204000 },
> +		{ 156000, 270000 },
> +		{ 195000, 334000 },
> +		{ 234000, 399000 },
> +	},
> +};
> +
>   static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
>   {
>   	return container_of(bridge, struct sn65dsi83, bridge);
> @@ -435,12 +479,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
>   
>   	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
> -	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
> +	regmap_write(ctx->regmap, REG_LVDS_VCOM,
> +			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvdsA_vod_swing_conf) |
> +			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvdsB_vod_swing_conf));
>   	regmap_write(ctx->regmap, REG_LVDS_LANE,
>   		     (ctx->lvds_dual_link_even_odd_swap ?
>   		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> -		     REG_LVDS_LANE_CHA_LVDS_TERM |
> -		     REG_LVDS_LANE_CHB_LVDS_TERM);
> +		     (ctx->lvdsA_term_conf ?
> +			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> +		     (ctx->lvdsB_term_conf ?
> +			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
>   	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
>   
>   	le16val = cpu_to_le16(mode->hdisplay);
> @@ -576,10 +624,96 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
>   	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
>   };
>   
> +static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
> +	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
> +{
> +	int i;
> +
> +	for (i = 0; i <= 3; i++) {
> +		if (lvds_vod_swing_data_table[lvds_term][i][0] >= lvds_vod_swing_data[0] &&
> +		lvds_vod_swing_data_table[lvds_term][i][1] <= lvds_vod_swing_data[1] &&
> +		lvds_vod_swing_clock_table[lvds_term][i][0] >= lvds_vod_swing_clk[0] &&
> +		lvds_vod_swing_clock_table[lvds_term][i][1] <= lvds_vod_swing_clk[1])
> +			return i;
> +	}
> +
> +	dev_err(dev, "failed to find appropriate LVDS_VOD_SWING configuration\n");
> +	return -EINVAL;
> +}
> +
> +static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *endpoint;
> +	/* Set so the property can be freely selected if not defined */
> +	u32 lvds_vod_swing_data[2] = { 0, 1000 };
> +	u32 lvds_vod_swing_clk[2] = { 0, 1000 };

I moved the code from milivolts to standard kernel voltage units 
microvolts quite recently and accidentaly forgot to apply these changes 
from my src tree. These should be:
+	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
+	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };

The code was tested with it though.

Will send a v3 ASAP. Sorry for this.

BR,
Andrej

> +	u32 lvds_term = 200;
> +	u8 lvds_term_conf;
> +	int endpoint_reg;
> +	int lvds_vod_swing_conf;
> +	int ret = 0;
> +	int ret_data;
> +	int ret_clock;
> +
> +	if (channel == CHANNEL_A)
> +		endpoint_reg = 2;
> +	else
> +		endpoint_reg = 3;
> +
> +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
> +	of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term);
> +
> +	if (lvds_term == 200)
> +		lvds_term_conf = OHM_200;
> +	else
> +		lvds_term_conf = OHM_100;
> +
> +	if (channel == CHANNEL_A)
> +		ctx->lvdsA_term_conf = lvds_term_conf;
> +	else
> +		ctx->lvdsB_term_conf = lvds_term_conf;
> +
> +	ret_data = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-data-microvolt", lvds_vod_swing_data,
> +			ARRAY_SIZE(lvds_vod_swing_data));
> +	ret_clock = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-clock-microvolt", lvds_vod_swing_clk,
> +			ARRAY_SIZE(lvds_vod_swing_clk));
> +	/* If any of the two properties is defined. */
> +	if (!ret_data || !ret_clock) {
> +		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev,
> +			lvds_vod_swing_data, lvds_vod_swing_clk,
> +			lvds_term_conf);
> +		if (lvds_vod_swing_conf < 0) {
> +			ret = lvds_vod_swing_conf;
> +			goto exit;
> +		}
> +		if (channel == CHANNEL_A)
> +			ctx->lvdsA_vod_swing_conf = lvds_vod_swing_conf;
> +		else
> +			ctx->lvdsB_vod_swing_conf = lvds_vod_swing_conf;
> +	}
> +	ret = 0;
> +exit:
> +	of_node_put(endpoint);
> +	return ret;
> +}
> +
>   static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>   {
>   	struct drm_bridge *panel_bridge;
>   	struct device *dev = ctx->dev;
> +	int ret;
> +
> +	ctx->lvdsA_vod_swing_conf = 0x1;
> +	ctx->lvdsB_vod_swing_conf = 0x1;
> +	ctx->lvdsA_term_conf = 0x1;
> +	ctx->lvdsB_term_conf = 0x1;
> +
> +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
> +	if (ret < 0)
> +		return ret;
>   
>   	ctx->lvds_dual_link = false;
>   	ctx->lvds_dual_link_even_odd_swap = false;
> @@ -587,6 +721,10 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>   		struct device_node *port2, *port3;
>   		int dual_link;
>   
> +		ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_B);
> +		if (ret < 0)
> +			return ret;
> +
>   		port2 = of_graph_get_port_by_id(dev->of_node, 2);
>   		port3 = of_graph_get_port_by_id(dev->of_node, 3);
>   		dual_link = drm_of_lvds_get_dual_link_pixel_order(port2, port3);

