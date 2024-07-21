Return-Path: <linux-kernel+bounces-258134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6567938438
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FF1B20ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B02D512;
	Sun, 21 Jul 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe+LLKZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1932C2C8;
	Sun, 21 Jul 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721554280; cv=none; b=lWlEQT+MopeieQVZcK02Cb9xrl9YqL2Bpx9MsAM+2JT3ZSVpb21dPpJottFcsIP9WQCKtXdRBtWQUsEo6/lBooZJgh+JjgvJlID4Wts5t9JNslTUbjybt6WzgYiZWqnBWn6W6AiAll9gS/t3UEDYJP5jbBYtclCk5OUcPcm31iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721554280; c=relaxed/simple;
	bh=/PmgbeCC1miQO2Z6wIYp1XoBA7ytgIEWOFMFofA5oP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boggKn8wWOh4jPtU5q+LQRPZgou73v3f5HdEC5cyGf/UPbcNNLt/AObNThhSFOY1sIx7dS/tGEIUyNeJVWBOi/QIrusJ50be7icFMksklmR0ZnmwUmqP3Q1AxKix/vcJnAE9/u/LfbQfurUztGGiIscrxBpTB0EYwfD1vC0ppKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe+LLKZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2ABC116B1;
	Sun, 21 Jul 2024 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721554280;
	bh=/PmgbeCC1miQO2Z6wIYp1XoBA7ytgIEWOFMFofA5oP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pe+LLKZ0cPrXyAJeUy/MABKFGvNHRM1d6LlnA9RiESSzyBrJcmxeEiWFhmsiNpyLn
	 ROTp9KkJB/aOax2EVhEvwOUEX5LuV7qnMVEFYTqvKGoEF+lpy0LqzzKrnGObQsrmwe
	 g5xPgd5phMhWb03B3cNSKYiz2fNIEdcOdoM6SmMlNA6oWqZhO+cMPizChA0TZRXlz0
	 7OxWYnKpqpvGRlwBJExifz7fVqHUaQJUfoP4HF4b+9hxr5EMp336hb7rYGy7NWr766
	 Knu7j7PxbHK/yeWNde2ICuthO04IDyF9YWcBSdmukhOnTYq65+exX+30XfvMqZ5uRF
	 agqPJcKqfbDTg==
Message-ID: <d48d261f-c428-4b96-9a88-725e29f6648f@kernel.org>
Date: Sun, 21 Jul 2024 11:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
To: Josua Mayer <josua@solid-run.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
 <20240720-a38x-utmi-phy-v3-3-4c16f9abdbdc@solid-run.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240720-a38x-utmi-phy-v3-3-4c16f9abdbdc@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2024 16:19, Josua Mayer wrote:
> Armada 38x USB-2.0 PHYs are similar to Armada 8K (CP110) and can be
> supported by the same driver with small differences.
> 
> Add new compatible string for armada-38x variant of utmi phy.
> Then add descriptions and names for two additional register definitions
> that may be specified instead of a syscon phandle.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../phy/marvell,armada-cp110-utmi-phy.yaml         | 34 ++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> index 9ce7b4c6d208..246e48d51755 100644
> --- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> @@ -23,12 +23,36 @@ description:
>    UTMI PHY1  --------\
>                        1.H----- USB HOST1
>  
> +  On Armada 380 there is an additional USB-2.0-only controller,
> +  and an additional UTMI PHY respectively.
> +  The USB device controller can only be connected to a single UTMI PHY port,
> +  either UTMI PHY0 or UTMI PHY2.
> +
> +
> +

One blank line is enough.

>  properties:
>    compatible:
> -    const: marvell,cp110-utmi-phy
> +    enum:
> +      - marvell,a38x-utmi-phy
> +      - marvell,cp110-utmi-phy
>  
>    reg:
> -    maxItems: 1
> +    anyOf:

That's oneOf.

> +      - items:
> +          - description: UTMI registers
> +      - items:
> +          - description: UTMI registers
> +          - description: USB config register
> +          - description: UTMI config registers
> +
> +  reg-names:
> +    anyOf:

oneOf

> +      - items:
> +          - const: utmi
> +      - items:
> +          - const: utmi
> +          - const: usb-cfg
> +          - const: utmi-cfg
>  
>    "#address-cells":
>      const: 1
> @@ -38,13 +62,14 @@ properties:
>  
>    marvell,system-controller:
>      description:
> -      Phandle to the system controller node
> +      Phandle to the system controller node.
> +      Optional when usb-cfg and utmi-cfg regs are given.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
>  # Required child nodes:
>  
>  patternProperties:
> -  "^usb-phy@[0|1]$":
> +  "^usb-phy@[0|1|2]$":

[0-2]

>      type: object
>      description:
>        Each UTMI PHY port must be represented as a sub-node.
> @@ -68,7 +93,6 @@ required:
>    - reg
>    - "#address-cells"
>    - "#size-cells"
> -  - marvell,system-controller

you miss here allOf:if:then: narrowing and marvell,system-controller per
each variant.



Best regards,
Krzysztof


