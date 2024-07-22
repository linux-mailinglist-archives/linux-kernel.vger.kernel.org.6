Return-Path: <linux-kernel+bounces-259489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E5939714
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF561C218A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5F5A4E9;
	Mon, 22 Jul 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr99pM8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294618042;
	Mon, 22 Jul 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691893; cv=none; b=W8xjEaUjzudDzlU8YvUeXwFWM1vB0jaITy0ZrLfCenf31okh2Z2hePhkcEgInI2YvzbdkSKEYzp8vWyGWyK0O47GavVfcKk5fmOE4NkL6fHRzZ17UEu3x4jzbpzJSBAtCtz9xYnjIqeLvJ1N10AHpel56/2Bvey6yI6uDTtd/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691893; c=relaxed/simple;
	bh=oNdtk3uel5ZWwnZX7ArakQwqdfG5woziXdTgNwRaetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg3EOVNHqbkjSmLizjFABrWQsHtqzg+JvOREYwsBGC4vsiX0Rvn7tgsC7xQprmocDZD7PWBI9M0ZO7IkS851v7VUL/IhRcGgazQtby+2S/MPivvQzFCizrEgi7bfODTZMvZLWSJp996W7ymP84MbfQIe9VZes2KJ4mqxaJIYtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr99pM8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF785C116B1;
	Mon, 22 Jul 2024 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721691893;
	bh=oNdtk3uel5ZWwnZX7ArakQwqdfG5woziXdTgNwRaetg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rr99pM8ziH80rIXoOl8PtYZk5dJH9+K0IarmbYPtgtc4+a4wamCv8lgs50fmVJ/zk
	 PJqj3QfKUxsBCcWRQ459R9Y1uo1yMQNl0VSGxBhkQoaX5xfCEhfnVM3GORmkaIN/+3
	 DkMKTDzuE51Yqs9ukRgW9nMcPhnuHjMAmcAClz07/eqgkjFonBu8O1p2kJfG1ga8Mj
	 t2qxddyZeR203XnqigdIDnMuzCLjc1CGbGcpA7g3rAyCKoIelh/l0oAGpESMrovXrC
	 /x7v+Yncfzgh8i/yOhLlltGbMKkQixPNiAF1xItCoyWR86OSTc+vFuFFp6wBe1SCTw
	 vB7IVmAna0nxA==
Date: Mon, 22 Jul 2024 17:44:45 -0600
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: add schema for imx8ulp SIM
 reset
Message-ID: <20240722234445.GA372356-robh@kernel.org>
References: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
 <20240715164514.8718-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715164514.8718-2-laurentiumihalcea111@gmail.com>

On Mon, Jul 15, 2024 at 12:45:12PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for imx8ulp's SIM reset controller.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../reset/nxp,imx8ulp-avd-sim-reset.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
> new file mode 100644
> index 000000000000..ae03c5750fa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nxp,imx8ulp-avd-sim-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP System Integration Module Reset Controller
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: >

Don't need '>'.

> +  Some instances of i.MX8ULP's SIM may offer control
> +  over the reset of some components of a certain domain
> +  (e.g: AVD-SIM).

Wrap lines at 80 char.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nxp,imx8ulp-avd-sim-reset
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  mux-controller:
> +    $ref: /schemas/mux/reg-mux.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +  - mux-controller
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +    syscon@2da50000 {
> +      compatible = "nxp,imx8ulp-avd-sim-reset", "syscon";
> +      reg = <0x2da50000 0x38>;
> +      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
> +      #reset-cells = <1>;
> +
> +      mux-controller {
> +        compatible = "mmio-mux";
> +        #mux-control-cells = <1>;
> +        mux-reg-masks = <0x8 0x00000200>;
> +      };
> +    };
> -- 
> 2.34.1
> 

