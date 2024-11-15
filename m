Return-Path: <linux-kernel+bounces-411309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B89CF605
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A71F23BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016C1E231D;
	Fri, 15 Nov 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SwHqjAkB"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA818BBB4;
	Fri, 15 Nov 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702228; cv=none; b=ohfFrp4cWVYY7vioj8pE42pzYqlwW4uZKBG/IhU8EVCiL3Tr5zh9T+X+85GLRBCqjOKxQX4cc1qD+GMPY1Z+F4rwHpLTfmpf5uUmCNJ7DK6Y7nzKrCGhc/H8E9y7oPwKu5oJuf/WQ4v8yt24hiURRsxoAziANR/G/cfQDGTWnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702228; c=relaxed/simple;
	bh=8ojz8AkGcjSHxh3VejqBKCWYDfc/mr3/2GB7b09HBgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEaqHHSvETm/Tpim4c4jyQSPBSqp6GHULWsHfBOMpjGy5Q0SmvuAFKmT/i3Hl8iGTalCyFTdnhOWqcZrqkS9/JJXNbDy7KOJIZ8ZC0HzB9caXUmnhNTmWTmSxXGYw6biRBZ9YqsUgLtIpKOKGvjK9BjY0bq/7lWyyIPJ965lruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=SwHqjAkB; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RoMTJSxUCqwV3jHpR4yN3f93otmQPhOIxK2FMmhdpg8=; b=SwHqjAkBobiRQyfAfc717iWPbd
	x9rtotNxRsOmv2kxJJO+WkzCrQ1Pn8Rfi2IPyQPHdpYb6ShHXsTmFaRh0KrIrSAi8f5uqmfxOGbFp
	pHxO4BIVNy/R7tfKWRXD69gD5d736dcpPmeCiPbVIrtVE+YTKM/HOWIlte2/thswYUZhW855DO8RH
	RlL+HexA17N0ypo6w6WChupdOgdNB3shFc7ArXueAt8GVgp41sVAoqAy8/H8arWJxiXG9z2C71vyJ
	aupgt8JsWX8wwNHA1w5buMMabjMbEjCc9P9z3Pt9nt8MreJYtgsozFk9gUqUvoY08y6WKIkSgASZ1
	neyAIrNQ==;
Date: Fri, 15 Nov 2024 21:05:43 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rogerq@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] dt-bindings: mfd: omap-usb-tll: convert to YAML
Message-ID: <20241115210543.7cfcd7ba@akair>
In-Reply-To: <20241114185830.10025-1-karprzy7@gmail.com>
References: <20241114185830.10025-1-karprzy7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 14 Nov 2024 19:58:30 +0100
schrieb Karol Przybylski <karprzy7@gmail.com>:

> Conversion of omap-usb-tll.txt into yaml format, inspired by discussion in [1]
> 
> All feedback greatly appreciated, especially about what to put in 'maintainer'
> 
> 1 - https://lore.kernel.org/all/cd915c18-7230-4c38-a860-d2a777223147@kernel.org/
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  .../devicetree/bindings/mfd/omap-usb-tll.txt  | 27 ----------
>  .../devicetree/bindings/mfd/omap-usb-tll.yaml | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
> deleted file mode 100644
> index c58d70437fce..000000000000
> --- a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -OMAP HS USB Host TLL (Transceiver-Less Interface)
> -
> -Required properties:
> -
> -- compatible : should be "ti,usbhs-tll"
> -- reg : should contain one register range i.e. start and length
> -- interrupts : should contain the TLL module's interrupt
> -- ti,hwmod : must contain "usb_tll_hs"
> -
> -Optional properties:
> -
> -- clocks: a list of phandles and clock-specifier pairs, one for each entry in
> -  clock-names.
> -
> -- clock-names: should include:
> -  * "usb_tll_hs_usb_ch0_clk" - USB TLL channel 0 clock
> -  * "usb_tll_hs_usb_ch1_clk" - USB TLL channel 1 clock
> -  * "usb_tll_hs_usb_ch2_clk" - USB TLL channel 2 clock
> -
> -Example:
> -
> -	usbhstll: usbhstll@4a062000 {
> -		compatible = "ti,usbhs-tll";
> -		reg = <0x4a062000 0x1000>;
> -		interrupts = <78>;
> -		ti,hwmods = "usb_tll_hs";
> -	  };
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
> new file mode 100644
> index 000000000000..f49417d1faf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/omap-usb-tll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP HS USB Host TLL (Transceiver-Less Interface)
> +
> +maintainers:
> +  - <maintainer@kernel.org>
> +
Roger? 

> +properties:
> +  compatible:
> +    enum:
> +      - ti,usbhs-tll
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmod:
> +    const: usb_tll_hs
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: usb_tll_hs_usb_ch0_clk
> +      - const: usb_tll_hs_usb_ch1_clk
> +      - const: usb_tll_hs_usb_ch2_clk
> +    minItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,hwmod

keeping the binding in pace with reality... ti,hwmod should
be deprecated. 

Regards,
Andreas

