Return-Path: <linux-kernel+bounces-417467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62F9D546E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C10B22441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E21C8FB3;
	Thu, 21 Nov 2024 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1zAqew2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC88145A03;
	Thu, 21 Nov 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222958; cv=none; b=bhAfG/hBEtypyCxESJF9JK0vQNRWRjq5OOMjPRvJtYgkbmEYLlXZHK/0+2AwHpVCVg1LsLlGcDBBHX9KfMiie45ZxqjvDnjE5zzg4mr1CxC0HTkQO8WGEi48yC/g7/dB7Z6YDSyhdhrYgQNSb+lX+o0Cd9vufdzygsNOthzxC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222958; c=relaxed/simple;
	bh=GM3w9B7r/t0zBm+hXRgtpgZU0x9idteO2H6rmGktuaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDBQDtJnTGreX8XK5Dod4W2QL4JTbPORlOmhWH48bKQl7Pl2NRHM+pjrre3zzju4rHtScr7GY/POV4/P5n20hHZODEC1lp7mOZRx4KfL/6G8/99Zpra1qwTJxtFmIExzkgC0VVZQTz3+ovi1CH+yhRIbkBc9wZtC2kFY8JpbpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1zAqew2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3C7C4CECC;
	Thu, 21 Nov 2024 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732222957;
	bh=GM3w9B7r/t0zBm+hXRgtpgZU0x9idteO2H6rmGktuaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1zAqew2MWcEEWPd9iStevglFRhfKSXOylhXAK6bkhjqwDXmpznRQJINCU4m1GPPE
	 PLdZ88moM1eAZ1roOlNBOKJrOzGmZzu0+Avl1rUuIyRh3kyevAGWE9+tYvsUKmQNsB
	 Pyr+/wtS9OBbDl/IRXMRM9/pfebUb0Nd2XDgRuaNvoYpXBGFJvfBMaMhN9tgev7uK9
	 Q0ljzrDg3kH9DIh5r4+Ep7HqFspUHrPHYN6rQq+4wotDF0YSFcIRHMH4h+VtqnkxlZ
	 dp6B1P6Q9NOqlpxIIlYxqOMhE/DA1KTvOJyADV2rRcmqq5P1+R9qTYa9vMuMwTPQ6c
	 96h2d2/jH8Lhw==
Date: Thu, 21 Nov 2024 15:02:35 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, ck.hu@mediatek.com,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/7] dt-bindings: display: mediatek: Add binding for
 HDMIv2 DDC
Message-ID: <20241121210235.GA3798341-robh@kernel.org>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120124512.134278-2-angelogioacchino.delregno@collabora.com>

On Wed, Nov 20, 2024 at 01:45:06PM +0100, AngeloGioacchino Del Regno wrote:
> Add a binding for the Display Data Channel (DDC) IP in MediaTek
> SoCs with version 2 HDMI TX IP.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> new file mode 100644
> index 000000000000..d85e8ed2ffa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek HDMI Display Data Channel (DDC) v2
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - CK Hu <ck.hu@mediatek.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt8195-hdmi-ddc
> +      - items:
> +          - const: mediatek,mt8188-hdmi-ddc
> +          - const: mediatek,mt8195-hdmi-ddc
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdmi {
> +        hdmi_ddc: i2c {
> +            compatible = "mediatek,mt8195-hdmi-ddc";
> +            clocks = <&clk26m>;

Is this really a separate block? Doesn't really look like it. You don't 
even have registers to interact with it.

> +        };
> +    };
> +...
> -- 
> 2.47.0
> 

