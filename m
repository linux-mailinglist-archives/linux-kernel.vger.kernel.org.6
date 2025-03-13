Return-Path: <linux-kernel+bounces-559128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE6A5EFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE033B0A04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4F264FAE;
	Thu, 13 Mar 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aOpurYN4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D596264626;
	Thu, 13 Mar 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858890; cv=none; b=snhs+1hWBOnchlcFuYwHJV2Srhu9NqUqTAEzkjPTJcz0ODffnfucOFz5g7tqKXalLMjz5j//jbuLQUtXvzSjqIJJAviyMnXx/1LQWWGI3DRB8dYfeQmUtSE0J7qd0topXLNozQdOJtspllL0j52kEbluoFoYvynu8C9CzghPcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858890; c=relaxed/simple;
	bh=9bUUyrlL1ue21at6c7tquhKhPsepd9e7Z13RAc1hu3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzhlPVnL3+KXsdOMRh7gPtrpU47MhGy815H1UA67BCpAps6wikpAD6a0qRGJ7M/rWCFtdxTGpZlXmbFsFZWBnBcIzZ1Mv5z3l1cywvvVOt1b7iDqK0UFl/fsSomxLhDdyA5zAP2AiN9Fgi+zqSuV9Q2UwlLS9AAbMfvTm/iBFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aOpurYN4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF8164AD;
	Thu, 13 Mar 2025 10:39:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1741858787;
	bh=9bUUyrlL1ue21at6c7tquhKhPsepd9e7Z13RAc1hu3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aOpurYN4UlhWL6hR4pJd6esKr1xOkkHOk1e2kq34iBnk2Y7E5G6+zP/5cFtaG87HG
	 uzZlZBItIQLtdW0r7RjDfbpMRe5QicGYZXrDIhM3jyr0GkvAVMmlybak9+bzRXpl/Q
	 A1CDDuxVCWTSodZ/WpmiEaLX93FXFpIDl06aD5FE=
Message-ID: <74ffed53-d6df-437a-b997-62fef3ee4d00@ideasonboard.com>
Date: Thu, 13 Mar 2025 11:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/tidss: Add support for AM62L display subsystem
To: Devarsh Thakkar <devarsht@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, aradhya.bhatia@linux.dev,
 s-jain1@ti.com, r-donadkar@ti.com, j-choudhary@ti.com, h-shenoy@ti.com,
 jyri.sarha@iki.fi, airlied@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 simona@ffwll.ch, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <20250306132914.1469387-1-devarsht@ti.com>
 <20250306132914.1469387-4-devarsht@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250306132914.1469387-4-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 06/03/2025 15:29, Devarsh Thakkar wrote:
> Enable display for AM62L DSS [1] which supports only a single display
> pipeline using a single overlay manager, single video port and a single
> video lite pipeline which does not support scaling.
> 
> The output of video port is routed to SoC boundary via DPI interface and
> the DPI signals from the video port are also routed to DSI Tx controller
> present within the SoC.
> 
> [1]: Section 11.7 (Display Subsystem and Peripherals)
> Link : https://www.ti.com/lit/pdf/sprujb4
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V3:
> - Rebase on top of
>    0002-drm-tidss-Update-infra-to-support-DSS7-cut-down-vers.patch
> - Use the generic "tidss_am65x_common_regs" as common reg space
>    instead of creating a new one.
> 
> V2:
> - Add separate common reg space for AM62L
> - Add separate irq enable/disable/read/clear helpers for AM62L
> - Use separate helper function for setting overlay attributes
> - Drop Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>    due to additional changes made in V2.
> 
>   drivers/gpu/drm/tidss/tidss_dispc.c | 46 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
>   drivers/gpu/drm/tidss/tidss_drv.c   |  1 +
>   3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 9b46403dbb0c..0ca0c2106715 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -440,6 +440,47 @@ const struct dispc_features dispc_am62a7_feats = {
>   	.vid_order = {1, 0},
>   };
>   
> +const struct dispc_features dispc_am62l_feats = {
> +	.max_pclk_khz = {
> +		[DISPC_VP_DPI] = 165000,
> +	},
> +
> +	.subrev = DISPC_AM62L,
> +
> +	.common = "common",
> +	.common_regs = tidss_am65x_common_regs,
> +
> +	.num_vps = 1,
> +	.vp_name = { "vp1" },
> +	.ovr_name = { "ovr1" },
> +	.vpclk_name =  { "vp1" },
> +	.vp_bus_type = { DISPC_VP_DPI },
> +
> +	.vp_feat = { .color = {
> +			.has_ctm = true,
> +			.gamma_size = 256,
> +			.gamma_type = TIDSS_GAMMA_8BIT,
> +		},
> +	},
> +
> +	.num_planes = 2,
> +
> +	.vid_info = {
> +		{
> +			.vid_name = "vid",
> +			.vid_lite = false,
> +			.is_present = false,
> +		},
> +		{
> +			.vid_name = "vidl1",
> +			.vid_lite = true,
> +			.is_present = true,
> +		}
> +	},

I don't think this is a good idea. Now you have tidss->num_planes 1, and 
feat->num_planes 2. It get's very confusing.

The naming is also mixed up. You have "vid_info" field, which has 
"plane_info" entries...

My suggestion is to have entries in vid_info only for the instantiated 
vids, like this:

struct vid_info {
	u32 hw_id;
	const char *name; /* Should match dt reg names */
	bool is_lite;
};

While at it, let's change the num_planes name in the feat struct too, to 
num_vids. This will also highlight all the places in the code that use 
the vid structs.

For AM62L it would be:

.num_vids = 1,

{
	.hw_id = 1,
	.name = "vidl1",
	.is_lite = true,
}

  Tomi


