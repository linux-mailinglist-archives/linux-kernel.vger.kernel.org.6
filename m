Return-Path: <linux-kernel+bounces-510820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E368A3227F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C503A91C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD72063CC;
	Wed, 12 Feb 2025 09:36:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD820ADC7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353001; cv=none; b=m6Ik/Yi1chtpHNvySJajSnzU8iDK27GQQOfB0HgcuvsmItOfzzj3B8W/t4Ew8fE0YHJj6bjr/qQofCSZoUXBk5eo8pcSvDyJemA0rPRuV3H8dWIuoOFNJsNLiskuKMx0+8izbprnBu29fxlDbxbcbqLv/AXbQFpcgh86peE+Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353001; c=relaxed/simple;
	bh=fJ0oQVoe3v+GZGtKDqY/m+T+upxz/j86dCJyFecV9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYYF+mgQQWnFGMDYmLOZaLCh1zZjLVP1TQd+nuvqpOmEHLbEyorcChc5nbudBGaaonW8QgqSrzjH3b4vb4QWKR6kwu5BbmrNYVe1omhbCpgEZXcZDJuRwyEdh6MhiZkd1fLcAJXa0bp+1MBTgcYmICKk9tsXqPx6/YqbmFELgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ti9AB-0003qj-6V; Wed, 12 Feb 2025 10:36:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ti9AA-000Z2U-1y;
	Wed, 12 Feb 2025 10:36:10 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ti9AA-00AzSK-1c;
	Wed, 12 Feb 2025 10:36:10 +0100
Date: Wed, 12 Feb 2025 10:36:10 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Message-ID: <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-02-11, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add binding for imx95's CM7 core, used for audio processing.
> Additionally, introduce a common binding for NXP audio processors with
> Sound Open Firmware (SOF) support.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 +++++++++++++++++++
>  .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> new file mode 100644
> index 000000000000..f00ae3219e15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,imx95-cm7-sof.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP imx95 CM7 core
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: NXP imx95 CM7 core used for audio processing
> +
> +properties:
> +  compatible:
> +    const: fsl,imx95-cm7-sof

Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
add the -sof suffix instead of -audio or so? SOF is a software project
but you can clearly run different software on the audio-copro as well.

Regards,
  Marco

> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: sram
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  memory-region-names:
> +    const: dma
> +
> +  port:
> +    description: SAI3 port
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - memory-region
> +  - memory-region-names
> +  - port
> +
> +allOf:
> +  - $ref: fsl,sof-cpu.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    cm7-cpu@80000000 {
> +        compatible = "fsl,imx95-cm7-sof";
> +        reg = <0x80000000 0x6100000>;
> +        reg-names = "sram";
> +        mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
> +        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> +        memory-region = <&adma_res>;
> +        memory-region-names = "dma";
> +        port {
> +            /* SAI3-WM8962 link */
> +            endpoint {
> +                remote-endpoint = <&wm8962_ep>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> new file mode 100644
> index 000000000000..31863932dbc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP audio processor common properties
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +properties:
> +  mboxes:
> +    maxItems: 4
> +
> +  mbox-names:
> +    items:
> +      - const: txdb0
> +      - const: txdb1
> +      - const: rxdb0
> +      - const: rxdb1
> +
> +required:
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: true
> -- 
> 2.34.1
> 
> 
> 

