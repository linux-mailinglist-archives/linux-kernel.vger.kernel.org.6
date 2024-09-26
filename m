Return-Path: <linux-kernel+bounces-339807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A9986AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9A283464
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9C173346;
	Thu, 26 Sep 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYN3jqPo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F4156C71;
	Thu, 26 Sep 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316547; cv=none; b=BqhMfCrLTm6NF6oHWA8yzHP3MBs+ortgDT3D3HGrJph63DLRjmJU3ULL/SrvFk2s29YSLaUVKxE6bpt7+N/LzdqMEkE0FDnwyoxmrFSVZLz0Kf0+M2sIbbjY9hCVSbCzQMUfNSUqqWW0djjNWunnYvcy1UYcqTBC6fOs8X1E9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316547; c=relaxed/simple;
	bh=M6ISVRGWt2YWY2xkGb/Zh1/Y2FhcZIYx1Ll7zaW+C08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtHwVL149MOgg1jOW9Fdv3oPVTmoVs/OBxgrSbm1kKtWUYViuOgjSdYOWCc9BGyWCdnElMR8uys/iYwuXm5s1JhmHgPWumjSJXAjKTp82/U/qaKTOdLTS/1yzD0ob/Xq+4meswqDKHaU8Zvi2/avSgysPf5J3zIbhTWCp0UNWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYN3jqPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BC2C4CEC3;
	Thu, 26 Sep 2024 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727316547;
	bh=M6ISVRGWt2YWY2xkGb/Zh1/Y2FhcZIYx1Ll7zaW+C08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYN3jqPoNP5YDqf60G7WyiKAO2OBv9hpFUejKtuQCgTrhIdYCmuW0sxrN7wCGp5fL
	 2YAm9Jye8BOUTlUjMPlVM/zx8zuEWV4OKbEzPGdw3nLqAPPsmwM0HGCbWf78gjRFe7
	 Cy89DDGvSF2EG3set4sjEAVMuUXf83MW+Yy7hYJxQSRUHV6hAwDv+G7LIzHG6kFp3R
	 TWiL7jLgKkxi737wRPytv/lsAWBKHiHB6I0v6EVmWpSv0MVao5WJ8SzN16rV4KiQ+5
	 AygH/X0HluzBMr4VcLlPsrSBcNmI5cfx1nUYLKmWlsuad6izgrsKMZ7gI0KB30R0GZ
	 u3rceLwUs4x1w==
Date: Wed, 25 Sep 2024 21:09:06 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: dsp: fsl,dsp: fix power domain count
Message-ID: <20240926020906.GA2246040-robh@kernel.org>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
 <20240925232008.205802-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925232008.205802-2-laurentiumihalcea111@gmail.com>

On Wed, Sep 25, 2024 at 07:20:03PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Per the current binding, QM/QXP DSPs are supposed to have 4
> power domains, while the rest just 1. For QM/QXP, the 4 power
> domains are: DSP, DSP_RAM, MU13A, MU13B.
> 
> First off, drop MU13A from the count. This is attached to the
> platform device of lsio_mu13. This decreases the count to 3.
> 
> Secondly, drop DSP and DSP_RAM from the count for QXP. These
> are attached to the platform devices of the lpcgs (used as clock
> providers for the DSP).

What's a platform device? Sounds like some Linux implementation detail.

The number of power islands for a h/w block shouldn't be changing.

> 
> With this in mind, the number of required power domains for QXP
> is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).
> 
> Additionally, two extra power domains may be required in the case
> of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes using
> the "-hifi4" compatibles these PDs are optional, while for nodes using
> the "-dsp" compatibles these are mandatory.
> 
> These changes reflect all of this information.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 9af40da5688e..e2f016af1048 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -51,8 +51,6 @@ properties:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 1
> -    maxItems: 4

Top level should be the range of domains that covers all variants.

>  
>    mboxes:
>      description:
> @@ -97,16 +95,55 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            enum:
> -              - fsl,imx8qxp-dsp
> -              - fsl,imx8qm-dsp
> -              - fsl,imx8qxp-hifi4
> -              - fsl,imx8qm-hifi4
> +            const: fsl,imx8qxp-hifi4
>      then:
>        properties:
>          power-domains:
> -          minItems: 4
> -    else:
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-dsp
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 3
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qm-dsp
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 5
> +          maxItems: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qm-hifi4
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 3
> +          maxItems: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mp-dsp
> +              - fsl,imx8mp-hifi4
> +              - fsl,imx8ulp-dsp
> +              - fsl,imx8ulp-hifi4
> +    then:
>        properties:
>          power-domains:
>            maxItems: 1
> @@ -157,10 +194,9 @@ examples:
>                   <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
>                   <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
>          clock-names = "ipg", "ocram", "core";
> -        power-domains = <&pd IMX_SC_R_MU_13A>,
> -                        <&pd IMX_SC_R_MU_13B>,
> -                        <&pd IMX_SC_R_DSP>,
> -                        <&pd IMX_SC_R_DSP_RAM>;
> +        power-domains = <&pd IMX_SC_R_MU_13B>,
> +                        <&pd IMX_SC_R_IRQSTR_DSP>,
> +                        <&pd IMX_SC_R_MU_2A>;
>          mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
>          mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
>          memory-region = <&dsp_reserved>;
> -- 
> 2.34.1
> 

