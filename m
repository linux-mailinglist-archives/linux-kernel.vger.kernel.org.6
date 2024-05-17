Return-Path: <linux-kernel+bounces-182600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892B8C8D27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7F61C2374B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B08140E46;
	Fri, 17 May 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCd8nWTr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C445007;
	Fri, 17 May 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975985; cv=none; b=sOARzCVkxCNPBM3N1Ow5irluScnjO6hZNqxIEhUCMNVZF1MZJIyDVztVOakXjzJ4VrZKSyW86M3e5Ff91Ql1N1/+y7AiJYYwJkkpo1eK67svx+/1ObaTAK9qQuC+UG3WXv39BT664kFKmTWvpY1IDig/i/tEgViKQvbt24ANsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975985; c=relaxed/simple;
	bh=dYYtjZRFg1w3fItuQaPCJGU5QXhIg35KUK9e0MdEWpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxa21BKV1qXwzureoOEIsv9ojAM7Ay7c5FLQPFwct+qv+j1jyJn/b8xDecqV66bizNl/Q3edfW2pZ+/OfNyGH4E7DxMhSk8WcZM3modV5pu+LftpA+/leBUI0t/3TLZeHZD0G/UIZKv6NVkOAWhMSuarXN0Kq+hQ1k0rlx+E48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCd8nWTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707BDC2BD10;
	Fri, 17 May 2024 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715975984;
	bh=dYYtjZRFg1w3fItuQaPCJGU5QXhIg35KUK9e0MdEWpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCd8nWTrqP1F+FxyMtyqxSqIGrdlOE3jZE9tZ1LGythn4sC5NqUz+wJ8GuWmnS07k
	 o1mt2HfxUPx2/+Psc31tEMwCL9JbR9kMgOppdvl1q0WnrBqD3mdvEf2lSUQjffdI1p
	 nAUiCtDA2rQK7XHnun/A147wzBMDhRLi0SVHG6lMfid0XKCAyUcWd5cUUIFf4lyfCa
	 GgN5QTmnFH0djiCEzmpzW/13H144vuiHcV0RqpMOe6uqhEsvCQl9j9Vw4YkMuAomjU
	 Mh5gKa36JIlgU3PjY1kRurlXXQq9FxHpoTzIn3pw8MuzjkMJEubXOI6VsubL6ceW8I
	 EcX1Rhh7jgTjw==
Date: Fri, 17 May 2024 14:59:43 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: add schema for imx8ulp SIM reset
Message-ID: <20240517195943.GA2854624-robh@kernel.org>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516204031.171920-2-laurentiumihalcea111@gmail.com>

On Thu, May 16, 2024 at 11:40:28PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for imx8ulp's SIM reset controller.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
> new file mode 100644
> index 000000000000..ec9a5c73e83c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nxp,imx8ulp-sim-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP System Integration Module Reset Controller
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  Some instances of i.MX8ULP's SIM may offer control over the
> +  reset of some components of a certain domain (e.g: AVD-SIM).
> +  As far as the DT is concerned, this means that the reset
> +  controller needs to be a child of the SIM node.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8ulp-avd-sim-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +    syscon@2da50000 {
> +      compatible = "nxp,imx8ulp-avd-sim", "syscon";
> +      reg = <0x2da50000 0x38>;
> +      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
> +
> +      reset-controller {
> +        compatible = "nxp,imx8ulp-avd-sim-reset";
> +        #reset-cells = <1>;
> +      };
> +    };

Why do you need a child node here? No DT resources or anything for this 
'sub-block'. Just put "#reset-cells" in the parent node.

(Note that examples for MFDs like this go in the MFD binding rather than 
having incomplete examples here.)

Rob

