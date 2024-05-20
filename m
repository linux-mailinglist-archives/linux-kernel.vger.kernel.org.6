Return-Path: <linux-kernel+bounces-183560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF88C9AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EBD1C2029D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29B35894;
	Mon, 20 May 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sBZP3q70"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40A10A24;
	Mon, 20 May 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198329; cv=none; b=vB+MkSzLHbFs8Z4ko9X0UqezOtSjui+sOJHjD6hT2vl6c6PYbCLSNH6jlt5s0LKvjqI/pGPCByghgwPJVgw2LK7Pm+8lwFxl4z2iKLqGeDhiyf7NyR2tmKL9lZawYVW05BZmlP2cIE9ILU+RvIwH8U103qq5gXS+T7xTumrmA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198329; c=relaxed/simple;
	bh=EOPt+eYBdEFPziDoYDP4iEGh4TS4MfnxTFiex2uayMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPrgAr6FLjU92rty37sLT9fTjU1+JJhjXqRcrom/TFYcIv38yjPILybuyG/umF4sW+n0fj7DlUpO236PTYShMEq+MumBZlGDGJAuKkkAJVOFfYmsZywOGdXQ7auqZBINZijL6llP8iyxE04pWHLPl5Npuik7pFBiK4qstZ0Qo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sBZP3q70; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716198319;
	bh=EOPt+eYBdEFPziDoYDP4iEGh4TS4MfnxTFiex2uayMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sBZP3q7093/gCBV34HzpjgWGWv8w3NlPgiN9Ps65dRam5UIIlodF5hirRcLEb4Qxb
	 c/1/b+sFfl2HbyUrpsFn1/6aa3TQ+cQkfcikezjzPbpwzOYL/4AOWXwac7QeKp1cQ6
	 gIeGAChestKBIZdh04zOqL0+ZNBnsYHkFY5qIGqZD3NfyBs1bVo3vVSTIuQ1LBXjEH
	 QG+YlQu7+txFrkpcwse14RXofOVZwGMfcH+VMLju7VeccIDKgtvynG55adKO+AVIdM
	 +iQwWUQU6Yh5WafEVCCpXVxsX01GDrAZhzZq6K9hfZ2VIiploO5sek4iUuSonQ50ow
	 5VSjXUqaEl45A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C4D737820CD;
	Mon, 20 May 2024 09:45:17 +0000 (UTC)
Message-ID: <84cd0ac7-99d9-42cb-af79-a0fba09c1ebb@collabora.com>
Date: Mon, 20 May 2024 11:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/mediatek: Implement OF graphs support for
 display paths
To: Michael Walle <michael@walle.cc>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-4-angelogioacchino.delregno@collabora.com>
 <D1BTQIQ2AQIS.G12ROFB149QB@walle.cc>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <D1BTQIQ2AQIS.G12ROFB149QB@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/05/24 11:49, Michael Walle ha scritto:
> Hi Angelo,
> 
> On Thu May 16, 2024 at 10:11 AM CEST, AngeloGioacchino Del Regno wrote:
>> Implement OF graphs support to the mediatek-drm drivers, allowing to
>> stop hardcoding the paths, and preventing this driver to get a huge
>> amount of arrays for each board and SoC combination, also paving the
>> way to share the same mtk_mmsys_driver_data between multiple SoCs,
>> making it more straightforward to add support for new chips.
> 
> paths might be optional, see comment in mtk_drm_kms_init(). But with
> this patch, you'll get an -EINVAL with a disabled path. See my
> proposals how to fix that below.

I might not be understanding the reason behind allowing that but, per my logic, if
a board does have a path, then it's written in devicetree and enabled - otherwise,
it should not be there at all, in principle.

Can you explain a bit more extensively the reason(s) why we need to account
for disabled paths?

> 
> With these changes and the following two patches I was able to get
> DisplayPort working on vdosys1. vdosys0 wasn't used at all.
> https://lore.kernel.org/r/20240516145824.1669263-1-mwalle@kernel.org/
> https://lore.kernel.org/r/20240517093024.1702750-1-mwalle@kernel.org/
> 
> I've already successfully tested a former version with DSI output on
> vdosys0.
> 
> Thanks for working on this!
> 

Thank you for helping with the testing! :-)

Cheers,
Angelo

>> +/**
>> + * mtk_drm_of_ddp_path_build_one - Build a Display HW Pipeline for a CRTC Path
>> + * @dev:          The mediatek-drm device
>> + * @cpath:        CRTC Path relative to a VDO or MMSYS
>> + * @out_path:     Pointer to an array that will contain the new pipeline
>> + * @out_path_len: Number of entries in the pipeline array
>> + *
>> + * MediaTek SoCs can use different DDP hardware pipelines (or paths) depending
>> + * on the board-specific desired display configuration; this function walks
>> + * through all of the output endpoints starting from a VDO or MMSYS hardware
>> + * instance and builds the right pipeline as specified in device trees.
>> + *
>> + * Return:
>> + * * %0       - Display HW Pipeline successfully built and validated
>> + * * %-ENOENT - Display pipeline was not specified in device tree
>> + * * %-EINVAL - Display pipeline built but validation failed
>> + * * %-ENOMEM - Failure to allocate pipeline array to pass to the caller
>> + */
>> +static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path cpath,
>> +					 const unsigned int **out_path,
>> +					 unsigned int *out_path_len)
>> +{
>> +	struct device_node *next, *prev, *vdo = dev->parent->of_node;
>> +	unsigned int temp_path[DDP_COMPONENT_DRM_ID_MAX] = { 0 };
>> +	unsigned int *final_ddp_path;
>> +	unsigned short int idx = 0;
>> +	bool ovl_adaptor_comp_added = false;
>> +	int ret;
>> +
>> +	/* Get the first entry for the temp_path array */
>> +	ret = mtk_drm_of_get_ddp_ep_cid(vdo, 0, cpath, &next, &temp_path[idx]);
>> +	if (ret) {
>> +		if (next && temp_path[idx] == DDP_COMPONENT_DRM_OVL_ADAPTOR) {
>> +			dev_err(dev, "Adding OVL Adaptor for %pOF\n", next);
>> +			ovl_adaptor_comp_added = true;
>> +		} else {
>> +			if (next)
>> +				dev_err(dev, "Invalid component %pOF\n", next);
>> +			else
>> +				dev_err(dev, "Cannot find first endpoint for path %d\n", cpath);
>> +
>> +			return ret;
>> +		}
>> +	}
>> +	idx++;
>> +
>> +	/*
>> +	 * Walk through port outputs until we reach the last valid mediatek-drm component.
>> +	 * To be valid, this must end with an "invalid" component that is a display node.
>> +	 */
>> +	do {
>> +		prev = next;
>> +		ret = mtk_drm_of_get_ddp_ep_cid(next, 1, cpath, &next, &temp_path[idx]);
>> +		of_node_put(prev);
>> +		if (ret) {
>> +			of_node_put(next);
>> +			break;
>> +		}
>> +
>> +		/*
>> +		 * If this is an OVL adaptor exclusive component and one of those
>> +		 * was already added, don't add another instance of the generic
>> +		 * DDP_COMPONENT_OVL_ADAPTOR, as this is used only to decide whether
>> +		 * to probe that component master driver of which only one instance
>> +		 * is needed and possible.
>> +		 */
>> +		if (temp_path[idx] == DDP_COMPONENT_DRM_OVL_ADAPTOR) {
>> +			if (!ovl_adaptor_comp_added)
>> +				ovl_adaptor_comp_added = true;
>> +			else
>> +				idx--;
>> +		}
>> +	} while (++idx < DDP_COMPONENT_DRM_ID_MAX);
> 
> /* The device might not be disabled. In that case, don't check the last
>   * entry but just report the missing device. */
> if (ret == -ENODEV)
> 	return ret;
> 
>> +
>> +	/* If the last entry is not a final display output, the configuration is wrong */
>> +	switch (temp_path[idx - 1]) {
>> +	case DDP_COMPONENT_DP_INTF0:
>> +	case DDP_COMPONENT_DP_INTF1:
>> +	case DDP_COMPONENT_DPI0:
>> +	case DDP_COMPONENT_DPI1:
>> +	case DDP_COMPONENT_DSI0:
>> +	case DDP_COMPONENT_DSI1:
>> +	case DDP_COMPONENT_DSI2:
>> +	case DDP_COMPONENT_DSI3:
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid display hw pipeline. Last component: %d (ret=%d)\n",
>> +			temp_path[idx - 1], ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	final_ddp_path = devm_kmemdup(dev, temp_path, idx * sizeof(temp_path[0]), GFP_KERNEL);
>> +	if (!final_ddp_path)
>> +		return -ENOMEM;
>> +
>> +	dev_dbg(dev, "Display HW Pipeline built with %d components.\n", idx);
>> +
>> +	/* Pipeline built! */
>> +	*out_path = final_ddp_path;
>> +	*out_path_len = idx;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_node *node,
>> +				     struct mtk_mmsys_driver_data *data)
>> +{
>> +	struct device_node *ep_node;
>> +	struct of_endpoint of_ep;
>> +	bool output_present[MAX_CRTC] = { false };
>> +	int ret;
>> +
>> +	for_each_endpoint_of_node(node, ep_node) {
>> +		ret = of_graph_parse_endpoint(ep_node, &of_ep);
>> +		of_node_put(ep_node);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret, "Cannot parse endpoint\n");
>> +			break;
>> +		}
>> +
>> +		if (of_ep.id >= MAX_CRTC) {
>> +			ret = dev_err_probe(dev, -EINVAL,
>> +					    "Invalid endpoint%u number\n", of_ep.port);
>> +			break;
>> +		}
>> +
>> +		output_present[of_ep.id] = true;
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (output_present[CRTC_MAIN]) {
>> +		ret = mtk_drm_of_ddp_path_build_one(dev, CRTC_MAIN,
>> +						    &data->main_path, &data->main_len);
>> +		if (ret)
> if (ret && ret != -ENODEV)
> 
>> +			return ret;
>> +	}
>> +
>> +	if (output_present[CRTC_EXT]) {
>> +		ret = mtk_drm_of_ddp_path_build_one(dev, CRTC_EXT,
>> +						    &data->ext_path, &data->ext_len);
>> +		if (ret)
> likewise
> 
>> +			return ret;
>> +	}
>> +
>> +	if (output_present[CRTC_THIRD]) {
>> +		ret = mtk_drm_of_ddp_path_build_one(dev, CRTC_THIRD,
>> +						    &data->third_path, &data->third_len);
>> +		if (ret)
> likewise
> 
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> -michael




