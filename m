Return-Path: <linux-kernel+bounces-217574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8E90B1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09538289049
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D519A291;
	Mon, 17 Jun 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="Q7r8/ReF"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D519A289;
	Mon, 17 Jun 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631234; cv=none; b=FeYeXWGXoYjMunwpZEJfoyKN6DTNBwwoI9PybiEnUUXWeGzWh/S/2SXisrljF5fW0bC2hGUb4WEHYbwXa3HuGlFpNLriHuEZsFIWI7Sc+jV/Wcmjj8eDV86/1m0sjjhB5sItFL3jJKUb1rwijJmxmeX74WyWi8EdbRpGfCjzmSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631234; c=relaxed/simple;
	bh=EPUP2P2rkyMTmnSsXy3vgtNnCWIN0xxM5+rBzw/2SoI=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=FEmF8B3JUsolUDYiYWKIBi5aC2yUFEQRTPE9Zxb8I7Y4Tt1CizG6ipEarjy1JqWAtvEAzGhVBg0+dI4C1KOlLHFdcvIjFER3WTNyFay1cFaaahhz41uaKe6OjagmUeqMY9N71C7ck5Bml2pin2WGF+EkJlreyYQhZG5/HE+1HHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=Q7r8/ReF; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 96978230;
	Mon, 17 Jun 2024 15:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1718630690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=XGdpwMen/VgLH0fpEvgI0LtL3f1BjG5LVb+4IVUtO6g=;
	b=Q7r8/ReFl6eYZ20WbkLEG4pnme+d5/YemdIP1r/VSRiuZSaXALnMwSvEQtfBQmGIeuKwli
	7IgsDxezpqkFORBSDX/00zj6LMUQdhJ1w10ODWF1zincbDxWWJ3bVWuMJEnm3AfA99e0Ko
	qk6C6Uz3D4jyGQHsxN4V7+zfscZia/PyhnxM5gAdkvqwrH8iGaG27oNv13rR14i6Dh717S
	FDS+sXX/et9Mh92whUvH31TlnkcsyDREwLFoRXtKYwBWubvVpUXqlrAh9UUST/HEVkOwyZ
	8UD4+YUy77ZcBJFWpYlTWmnXl2ERnMkHGXqoivpF0lvyD8hP+5Aw8VlG5ckeTQ==
Content-Type: multipart/signed;
 boundary=cd73275ec8ec08f02789c22d654dfdbdccd7e263beb5db59c37f41efc36e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 17 Jun 2024 15:24:39 +0200
Message-Id: <D22BQAOFJWVJ.2Y9FKAAR57BHK@walle.cc>
From: "Michael Walle" <michael@walle.cc>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v7 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Cc: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
 <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <matthias.bgg@gmail.com>,
 <shawn.sung@mediatek.com>, <yu-chang.lee@mediatek.com>,
 <ck.hu@mediatek.com>, <jitao.shi@mediatek.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <wenst@chromium.org>,
 <kernel@collabora.com>, <sui.jinfeng@linux.dev>, "Alexandre Mergnat"
 <amergnat@baylibre.com>
X-Mailer: aerc 0.16.0
References: <20240612065634.26569-1-angelogioacchino.delregno@collabora.com>
 <20240612065634.26569-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240612065634.26569-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--cd73275ec8ec08f02789c22d654dfdbdccd7e263beb5db59c37f41efc36e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Angelo,

> +/**
> + * mtk_drm_of_ddp_path_build_one - Build a Display HW Pipeline for a CRT=
C Path
> + * @dev:          The mediatek-drm device
> + * @cpath:        CRTC Path relative to a VDO or MMSYS
> + * @out_path:     Pointer to an array that will contain the new pipeline
> + * @out_path_len: Number of entries in the pipeline array
> + *
> + * MediaTek SoCs can use different DDP hardware pipelines (or paths) dep=
ending
> + * on the board-specific desired display configuration; this function wa=
lks
> + * through all of the output endpoints starting from a VDO or MMSYS hard=
ware
> + * instance and builds the right pipeline as specified in device trees.
> + *
> + * Return:
> + * * %0       - Display HW Pipeline successfully built and validated
> + * * %-ENOENT - Display pipeline was not specified in device tree
> + * * %-EINVAL - Display pipeline built but validation failed
> + * * %-ENOMEM - Failure to allocate pipeline array to pass to the caller
> + */
> +static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_cr=
tc_path cpath,
> +					 const unsigned int **out_path,
> +					 unsigned int *out_path_len)
> +{
> +	struct device_node *next, *prev, *vdo =3D dev->parent->of_node;
> +	unsigned int temp_path[DDP_COMPONENT_DRM_ID_MAX] =3D { 0 };
> +	unsigned int *final_ddp_path;
> +	unsigned short int idx =3D 0;
> +	bool ovl_adaptor_comp_added =3D false;
> +	int ret;
> +
> +	/* Get the first entry for the temp_path array */
> +	ret =3D mtk_drm_of_get_ddp_ep_cid(vdo, 0, cpath, &next, &temp_path[idx]=
);
> +	if (ret) {
> +		if (next && temp_path[idx] =3D=3D DDP_COMPONENT_DRM_OVL_ADAPTOR) {
> +			dev_err(dev, "Adding OVL Adaptor for %pOF\n", next);
> +			ovl_adaptor_comp_added =3D true;
> +		} else {
> +			if (next)
> +				dev_err(dev, "Invalid component %pOF\n", next);
> +			else
> +				dev_err(dev, "Cannot find first endpoint for path %d\n", cpath);
> +
> +			return ret;
> +		}
> +	}
> +	idx++;
> +
> +	/*
> +	 * Walk through port outputs until we reach the last valid mediatek-drm=
 component.
> +	 * To be valid, this must end with an "invalid" component that is a dis=
play node.
> +	 */
> +	do {
> +		prev =3D next;
> +		ret =3D mtk_drm_of_get_ddp_ep_cid(next, 1, cpath, &next, &temp_path[id=
x]);
> +		of_node_put(prev);
> +		if (ret) {
> +			of_node_put(next);
> +			break;
> +		}
> +
> +		/*
> +		 * If this is an OVL adaptor exclusive component and one of those
> +		 * was already added, don't add another instance of the generic
> +		 * DDP_COMPONENT_OVL_ADAPTOR, as this is used only to decide whether
> +		 * to probe that component master driver of which only one instance
> +		 * is needed and possible.
> +		 */
> +		if (temp_path[idx] =3D=3D DDP_COMPONENT_DRM_OVL_ADAPTOR) {
> +			if (!ovl_adaptor_comp_added)
> +				ovl_adaptor_comp_added =3D true;
> +			else
> +				idx--;
> +		}
> +	} while (++idx < DDP_COMPONENT_DRM_ID_MAX);
> +
> +	/*
> +	 * The device component might not be disabled: in that case, don't

Sorry there was a typo in my proposal, This should either be
"not be enabled" or "be disabled".

> +	 * check the last entry and just report that the device is missing.
> +	 */
> +	if (ret =3D=3D -ENODEV)
> +		return ret;
> +

..

> +static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_n=
ode *node,
> +				     struct mtk_mmsys_driver_data *data)
> +{
> +	struct device_node *ep_node;
> +	struct of_endpoint of_ep;
> +	bool output_present[MAX_CRTC] =3D { false };
> +	bool valid_output_found =3D false;
> +	int ret;
> +
> +	for_each_endpoint_of_node(node, ep_node) {
> +		ret =3D of_graph_parse_endpoint(ep_node, &of_ep);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Cannot parse endpoint\n");
> +			break;
> +		}
> +
> +		if (of_ep.id >=3D MAX_CRTC) {
> +			ret =3D dev_err_probe(dev, -EINVAL,
> +					    "Invalid endpoint%u number\n", of_ep.port);
> +			break;
> +		}
> +
> +		output_present[of_ep.id] =3D true;
> +	}
> +
> +	if (ret) {
> +		of_node_put(ep_node);
> +		return ret;
> +	}
> +
> +	if (output_present[CRTC_MAIN]) {
> +		ret =3D mtk_drm_of_ddp_path_build_one(dev, CRTC_MAIN,
> +						    &data->main_path, &data->main_len);
> +		if (ret =3D=3D 0)
> +			valid_output_found =3D true;
> +		else if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> +
> +	if (output_present[CRTC_EXT]) {
> +		ret =3D mtk_drm_of_ddp_path_build_one(dev, CRTC_EXT,
> +						    &data->ext_path, &data->ext_len);
> +		if (ret =3D=3D 0)
> +			valid_output_found =3D true;
> +		else if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> +
> +	if (output_present[CRTC_THIRD]) {
> +		ret =3D mtk_drm_of_ddp_path_build_one(dev, CRTC_THIRD,
> +						    &data->third_path, &data->third_len);
> +		if (ret =3D=3D 0)
> +			valid_output_found =3D true;
> +		else if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> +
> +	if (!valid_output_found)
> +		return -ENODEV;

This doesn't work. My proposal just ignored the ENODEV error. Now
you'll return ENODEV if there is no output for a given mmsys. In my
case, that is true for the first mmsys. Subsequent mmsys's doesn't
get probed in that case, it seems.

Anyway, you shouldn't return ENODEV here because disabled just
means not available, i.e. it should be treated the same as
"output_present[] =3D=3D false".

-michael

--cd73275ec8ec08f02789c22d654dfdbdccd7e263beb5db59c37f41efc36e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZnA5GREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+ASJAYC5JN+RTspgt+HYGXjHGvvwdfLZI0lFGsC8
Wfx4Gsm/0IQYKRPLKUPUGvw/uRVNvC8BgM5HLmpkNhLtPn53MJEf34RxT+WAajRa
cRfle3/fAZq7yCb+dvJXI3q8ygyun07X5Q==
=1Wb1
-----END PGP SIGNATURE-----

--cd73275ec8ec08f02789c22d654dfdbdccd7e263beb5db59c37f41efc36e--

