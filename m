Return-Path: <linux-kernel+bounces-230610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE10917F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61D71F2160E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9617D37E;
	Wed, 26 Jun 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dCWAU9Xc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC149C52
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400170; cv=none; b=BLvboDnfPYT9+xDqqVr1AjtbG4/a5bwjRKNHUcpuDAe3bT1yPUCLTtJ2vQyeHFLXi2RjH8ShdcPaK4IIaXRicyamccUwcIB9bizI0FBB5qlBohUlpARhm9qLCqmDeXvK2JNPcBp0OM1zm9oNKfX/ErypeMZ7lmgJ/FvaMfZ6dEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400170; c=relaxed/simple;
	bh=hUDZyxr8E0VhpPuOMhpLErVrjQ/SFZ7QlGb6et9BwuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ql3h6FnsNn1K7TEzOvmNsBzW1+beBXKjzYJQ3WHubiqXvxSi3lvpasT1mMC8DfnJ7FExvPhr4pn9TSK2q2ZFOEWSeHuQcnMq62hACAzo8mhxlNUaEasGGO15WiuS3JriGUJ1spSpcrIVRZN5UUw2hNfBQEFkrvYzLpo2wDNpL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dCWAU9Xc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C119CFD6;
	Wed, 26 Jun 2024 13:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1719400143;
	bh=hUDZyxr8E0VhpPuOMhpLErVrjQ/SFZ7QlGb6et9BwuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCWAU9XcLhm5CEipAGWVQfywI9aIHkN4VDyS+xuk8QN27A1MRIkXdMs/79hRMmrq1
	 YImTMqaYC0fsE+onx6aflsejpgde4F/NvKV85ncskJmzpsTWtkzvHrQEQF+7oai9sF
	 B7yqyfeLHq8Dz5chtLp0IfS8Fvs8b9y0VVo8ZRII=
Message-ID: <73e4d081-f5f4-4e6f-988c-43bbc312632a@ideasonboard.com>
Date: Wed, 26 Jun 2024 14:09:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/bridge: cdns-dsi: Support atomic bridge APIs
To: Aradhya Bhatia <a-bhatia1@ti.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>,
 Thierry Reding <treding@nvidia.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Jai Luthra <j-luthra@ti.com>
References: <20240622110929.3115714-1-a-bhatia1@ti.com>
 <20240622110929.3115714-10-a-bhatia1@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240622110929.3115714-10-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/06/2024 14:09, Aradhya Bhatia wrote:
> Change the existing (and deprecated) bridge hooks, to the bridge
> atomic APIs.
> 
> Add drm helpers for duplicate_state, destroy_state, and bridge_reset
> bridge hooks.
> 
> Further add support for the input format negotiation hook.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> ---
>   .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 51 ++++++++++++++++---
>   1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index cad0c1478ef0..c9697818308e 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -655,7 +655,8 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>   	return MODE_OK;
>   }
>   
> -static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
> +static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *old_bridge_state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
> @@ -679,7 +680,8 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
>   	pm_runtime_put(dsi->base.dev);
>   }
>   
> -static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
> +static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +						struct drm_bridge_state *old_bridge_state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
> @@ -755,7 +757,8 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
>   	dsi->link_initialized = true;
>   }
>   
> -static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
> +static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					  struct drm_bridge_state *old_bridge_state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
> @@ -906,7 +909,8 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>   	writel(tmp, dsi->regs + MCTL_MAIN_EN);
>   }
>   
> -static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> +static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					      struct drm_bridge_state *old_bridge_state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
> @@ -918,13 +922,44 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>   	cdns_dsi_hs_init(dsi);
>   }
>   
> +static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
> +					       struct drm_bridge_state *bridge_state,
> +					       struct drm_crtc_state *crtc_state,
> +					       struct drm_connector_state *conn_state,
> +					       u32 output_fmt,
> +					       unsigned int *num_input_fmts)
> +{
> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +	struct cdns_dsi *dsi = input_to_dsi(input);
> +	struct cdns_dsi_output *output = &dsi->output;
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	input_fmts[0] = drm_mipi_dsi_get_input_bus_fmt(output->dev->format);
> +	if (!input_fmts[0])
> +		return NULL;
> +
> +	*num_input_fmts = 1;
> +
> +	return input_fmts;
> +}
> +
>   static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>   	.attach = cdns_dsi_bridge_attach,
>   	.mode_valid = cdns_dsi_bridge_mode_valid,
> -	.disable = cdns_dsi_bridge_disable,
> -	.pre_enable = cdns_dsi_bridge_pre_enable,
> -	.enable = cdns_dsi_bridge_enable,
> -	.post_disable = cdns_dsi_bridge_post_disable,
> +	.atomic_disable = cdns_dsi_bridge_atomic_disable,
> +	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
> +	.atomic_enable = cdns_dsi_bridge_atomic_enable,
> +	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_get_input_bus_fmts = cdns_dsi_bridge_get_input_bus_fmts,
>   };
>   
>   static int cdns_dsi_attach(struct mipi_dsi_host *host,


