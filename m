Return-Path: <linux-kernel+bounces-175965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FE8C27FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2560B1F211E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6DF171663;
	Fri, 10 May 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4m+dHD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A712AAD5;
	Fri, 10 May 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355532; cv=none; b=d2LHLFulcYY5syXnpEh5omOwXpu1EsdRNHtXE1ho9PzMwjYNmsODRIT4Vz76VAD8X4AXBitfUSfd7qbo/ihT45RtoM5ifTqg0f2WJY4e5ay7i9W28aXHBEOBRMC6ZpM2ZMNo4f+fWFsrCnXumWE9WN7f6qIfilqBgB5U4c0DPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355532; c=relaxed/simple;
	bh=5i/Kwz7QCD09ox7fq0+nK+iuNVgav4u7fr/M1k9fkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxGmZD23AV1JyLA79iMoTbxcCeA24xMYACTY7j3hb0HgqV+ViLhkjlX95AB0AllBnuedaLrGE5i4kdO+O4EsExNE08b1CgHaQcnsWATp/VAmhatkw3nr+QGstLd5WJ44LaTX9gGEhbjKmztv17JkVrw8dbRnQoGLZENcC5EONms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4m+dHD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81117C113CC;
	Fri, 10 May 2024 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715355531;
	bh=5i/Kwz7QCD09ox7fq0+nK+iuNVgav4u7fr/M1k9fkGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4m+dHD8MracwXhQxc+HGvMM7x1N6E+yIVYj0BVRNfpR4cYP8M2xhklBBxbbTOam+
	 o1s1UzSaLNLahxTkZo3hGkAw/9i5mz4OE1qRquZm1qsFeIcdIAswRHAF/oKVTy1U/s
	 7xOhUSBjoOsn1zmsLJXq1/sK6yj29qTMzs71rBixyPYwB02YqA0aOsHREhwwjpuThP
	 DnSAxMb59p3CCP5XT8z2GtK8xQotVUCqE4Zx+53dizwzQzrjqX5L3NI9vDjz5haYNn
	 36Atqs8xCY1wAoZBYSgLWCJ7ZppgmbycjLkcmfBrk5t5H16ktF5b1yUaFa8nO/Nj3J
	 0j2p6WNko87ZA==
Date: Fri, 10 May 2024 10:38:49 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240510153849.GA308062-robh@kernel.org>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>

On Thu, May 09, 2024 at 01:56:20PM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> initialization according to board design.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8qm-hsio.yaml         | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> new file mode 100644
> index 000000000000..e8648cd9fea6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8QM SoC series HSIO SERDES PHY
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-hsio
> +      - fsl,imx8qxp-hsio
> +  reg:
> +    minItems: 4
> +    maxItems: 4

Need to define what is each entry:

items:
  - description: ...
  - description: ...
  - description: ...
  - description: ...


> +
> +  "#phy-cells":
> +    const: 3
> +    description:
> +      The first defines lane index.
> +      The second defines the type of the PHY refer to the include phy.h.
> +      The third defines the controller index, indicated which controller
> +      is bound to the lane.
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: phy
> +      - const: ctrl
> +      - const: misc
> +
> +  clocks:
> +    minItems: 5
> +    maxItems: 14
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 14
> +
> +  fsl,hsio-cfg:
> +    description: Refer macro HSIO_CFG* include/dt-bindings/phy/phy-imx8-pcie.h.

I can't, it's not in this patch. But it should be.

Please say something about what this is for, not just refer to header.

> +    $ref: /schemas/types.yaml#/definitions/uint32

       maximum: 3

> +
> +  fsl,refclk-pad-mode:
> +    description:
> +      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
> +      provided externally via the refclk pad) or OUTPUT(PHY refclock is
> +      derived from SoC internal source and provided on the refclk pad).
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ "input", "output" ]

default?

Really, this could just be a boolean for the non-default mode.

> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - fsl,hsio-cfg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-hsio
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: apb_pclk0
> +            - const: phy0_crr
> +            - const: ctl0_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 1

Should be maxItems? min is already 1.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-hsio
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: pclk1
> +            - const: apb_pclk0
> +            - const: apb_pclk1
> +            - const: pclk2
> +            - const: epcs_tx
> +            - const: epcs_rx
> +            - const: apb_pclk2
> +            - const: phy0_crr
> +            - const: phy1_crr
> +            - const: ctl0_crr
> +            - const: ctl1_crr
> +            - const: ctl2_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +    hsio_phy@5f1a0000 {

phy@...

> +        compatible = "fsl,imx8qxp-hsio";
> +        reg = <0x5f1a0000 0x10000>,
> +              <0x5f120000 0x10000>,
> +              <0x5f140000 0x10000>,
> +              <0x5f160000 0x10000>;
> +        reg-names = "reg", "phy", "ctrl", "misc";
> +        clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +                 <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +                 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +                 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +                 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr", "misc_crr";
> +        power-domains = <&pd IMX_SC_R_SERDES_1>;
> +        #phy-cells = <3>;
> +        fsl,hsio-cfg = <IMX8Q_HSIO_CFG_PCIEB>;
> +        fsl,refclk-pad-mode = "input";
> +    };
> +...
> -- 
> 2.37.1
> 

