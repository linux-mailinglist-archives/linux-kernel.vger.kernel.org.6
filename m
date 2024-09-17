Return-Path: <linux-kernel+bounces-331324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA097AB50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EF01F2113D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2871750;
	Tue, 17 Sep 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b806YLFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB5132139;
	Tue, 17 Sep 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553711; cv=none; b=TDIHItp8Xqf1NDbRSdQt5aHycHl6I4jcFz7bFU6rzuj0037E+3jDvQcBwwDEJPvaUrEc+ngfO02LSacikJdfcquOJCZDjg4YCgXwekpg3BI1BCXtxjeQQ+vbndGMWg4ku4tkgGSwuFCEhyJiLTptjP4sr03fJAKTYHviSSAFg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553711; c=relaxed/simple;
	bh=aJPxLpvFIUFAi+Q31pxB6zY+VxnHP2JJjx37Fi0l3Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqQ/3tYBjc1rJg28JMMDol2o7Q1j5aHik/+8Ao6Waqh8ZCz/I+YAstyHl9NGcuWG17Q/vWcvyuFgzb4pe9lIJYfySA+k+8gOXlKi/8v7DOrLn8sNH1HO8m2RrqdTiLfOSu4QJKc4gHpd/dhDZoLlqUiY6GeCqWzAqDd01RIP14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b806YLFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB03C4CEC6;
	Tue, 17 Sep 2024 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726553710;
	bh=aJPxLpvFIUFAi+Q31pxB6zY+VxnHP2JJjx37Fi0l3Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b806YLFQapJe6xnW1+aKdJJpYmsvawavG40vkyB+YqZbQeOP6ga/4l/t6LWVEi9+v
	 ZDSIrowayhwzvQaMGa9Do1dcBdTHsufbr7jqJCaca02pHB2BmHO/95v/QHIeDJlJ/E
	 VUQnQ8QTWC9fvtTtgakdt0abR/uQRHrSmhCSZdkGlUzR6jl/Vv/ISfoZjZnqh15sjp
	 rz/ZZ+ZZdrXSRKDQ1+4ek8hvjZEnqNIEH+YoUkuNYhG9X9Br5gz34hiBFscN6uqf4n
	 jexzM3C29FYzfzI6LQXIYpOb5SahFhpUssTAuk7QycLrkk0kULmDstsyvzdpP7v9Nm
	 U5zYR8MRQ0mzQ==
Date: Tue, 17 Sep 2024 08:15:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
	Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Message-ID: <enzkaomrdmftp5adcexj55zklgzo7hx25becllpnib2rqmhn2d@hu3yylm6nnej>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>

On Mon, Sep 16, 2024 at 10:23:08PM +0000, Haylen Chu wrote:
> Add documentation to describe Spacemit K1 system controller registers.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  .../soc/spacemit/spacemit,k1-syscon.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> new file mode 100644
> index 000000000000..4e3a72b48aff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/spacemit/spacemit,k1-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit K1 SoC System Controller
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +description:
> +  The Spacemit K1 SoC system controller provides access to shared register files
> +  for related SoC modules, such as clock controller and reset controller.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - spacemit,k1-apbc-syscon
> +          - spacemit,k1-apbs-syscon
> +          - spacemit,k1-apmu-syscon
> +          - spacemit,k1-mpmu-syscon
> +      - const: syscon
> +      - const: simple-mfd

Drop, not used. Or make the binding complete.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":

Drop

> +    const: 1
> +
> +  "#size-cells":

Drop, not used.

> +    const: 1
> +
> +additionalProperties: false

This goes after required:

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    syscon_mpmu: system-controller@d4050000 {
> +        compatible = "spacemit,mpmu-syscon", "syscon", "simple-mfd";

This is example from something entirely different.

> +        reg = <0xd4050000 0x209c>;
> +    };
> -- 
> 2.46.0
> 

