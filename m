Return-Path: <linux-kernel+bounces-433351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA069E5758
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65C41634D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA0218AB0;
	Thu,  5 Dec 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsrwpU1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6B23918D;
	Thu,  5 Dec 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405635; cv=none; b=d5n+xkod4AH3hsdLGATZIJb32ZCoSHs9S59pIit3bMnBFJXdzA/hc2mQXhKiA6A87hHp5hPKPrsbXdg50U9aPz6lB+IiYiBpyVzjKLkMscaY9vwz7X3yyaT/nkObESfgT1kTjHVlckXjqmuzSmpolB/13NWNb0NwS1S3kQn+jSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405635; c=relaxed/simple;
	bh=HY9tTGeW5NW/9Fp7iwxPs9KMW7cXmJeJAVDmaY4R1VE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=V+nYyfs3uuh3Gb0qM67aIrWMxJVjl9FMTgNCcYu7soHa53qPjiR92lfV5SxFVJ6r8xHK1brRTkVj4VNVvlRQDHPtYOpytWISJYxPLieeUiCHXs7cdvY/J08s2HFQ5GQT0g5O16hZT+BleBd1e3R4KAXI6VpUYp7P1FxPP8D3TCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsrwpU1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0318C4CEE0;
	Thu,  5 Dec 2024 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733405634;
	bh=HY9tTGeW5NW/9Fp7iwxPs9KMW7cXmJeJAVDmaY4R1VE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UsrwpU1jhn2CrdcLXusDmzHQxeTYjTOseV6uFBr3sr6C/rFvFwziJqAOQpqxzQuGL
	 RzdajG9/dhis/gxXfRCPrPRImkDFnnxHPZzBxFsPEQ1SmERTmmQtC5TjwhfWWAZJnT
	 Sg6G/Gt8DDY5LH7aJclBgfC3kJBiM5LnL5zJpU6h/EupV2fUtc5gyTAJvnsiGx4UQI
	 xZjeedfI1zEC71nDNpXzq2bhhmthTMIW3SrRsLT7GeW3V148yRO3Rvgh1p13OHdTzb
	 4ssr0tkkLvPN/Zt4AEnXfqt8J18drl7cmPwUbQXf06AC13luQhAH/jkTVAXDwco17y
	 sgipnyP69ENTQ==
Date: Thu, 05 Dec 2024 07:33:52 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: simona@ffwll.ch, devicetree@vger.kernel.org, p.zabel@pengutronix.de, 
 junzhi.zhao@mediatek.com, mripard@kernel.org, matthias.bgg@gmail.com, 
 linux-kernel@vger.kernel.org, tzimmermann@suse.de, krzk+dt@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 airlied@gmail.com, chunkuang.hu@kernel.org, conor+dt@kernel.org, 
 kernel@collabora.com, jitao.shi@mediatek.com, 
 maarten.lankhorst@linux.intel.com, ck.hu@mediatek.com, 
 linux-mediatek@lists.infradead.org, jie.qiu@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-8-angelogioacchino.delregno@collabora.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
 <20241205114518.53527-8-angelogioacchino.delregno@collabora.com>
Message-Id: <173340563286.3304541.16351309995499835638.robh@kernel.org>
Subject: Re: [PATCH v2 07/15] dt-bindings: display: mediatek: Add binding
 for MT8195 HDMI-TX v2


On Thu, 05 Dec 2024 12:45:09 +0100, AngeloGioacchino Del Regno wrote:
> Add a binding for the HDMI TX v2 Encoder found in MediaTek MT8195
> and MT8188 SoCs.
> 
> This fully supports the HDMI Specification 2.0b, hence it provides
> support for 3D-HDMI, Polarity inversion, up to 16 bits Deep Color,
> color spaces including RGB444, YCBCR420/422/444 (ITU601/ITU709) and
> xvYCC, with output resolutions up to 3840x2160p@60Hz.
> 
> Moreover, it also supports HDCP 1.4 and 2.3, Variable Refresh Rate
> (VRR) and Consumer Electronics Control (CEC).
> 
> This IP also includes support for HDMI Audio, including IEC60958
> and IEC61937 SPDIF, 8-channel PCM, DSD, and other lossless audio
> according to HDMI 2.0.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi.yaml        | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: hdmi-tx@1c300000: i2c: False schema does not allow {'compatible': ['mediatek,mt8195-hdmi-ddc'], 'clocks': [[4294967295]]}
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: hdmi-tx@1c300000: i2c: Unevaluated properties are not allowed ('clocks', 'compatible' were unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: /example-0/soc/hdmi-tx@1c300000/i2c: failed to match any schema with compatible: ['mediatek,mt8195-hdmi-ddc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241205114518.53527-8-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


