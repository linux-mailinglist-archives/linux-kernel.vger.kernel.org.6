Return-Path: <linux-kernel+bounces-230408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDB917C61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A49D1F21503
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059D16CD06;
	Wed, 26 Jun 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvGuClsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304A1684A1;
	Wed, 26 Jun 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393985; cv=none; b=NtEUfORJss2NUpTi8hr2nm38fXETWgDhQ0h3OWOqCqBTOef+M9yzacXR8+nKkjLejj9TZjkonUOExNtyPup6ufWP+nErxo/I6po4tNXwc8hfGKiYkgFWyKQG4RQhtxNUZy9usor4MY1lKmMwbNVtaDhLLvZrPYjlckD3C+WqnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393985; c=relaxed/simple;
	bh=dU3Jf3E3jO241GPXBxa5WTQyTqsdhtXznavqyzipez4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkj69nNb1lkvLPu2DSW3Y6yJiXwAHamAfBtAFlWqC+UducMYjhp7CcJ+hDap5byvpp8XLNmyD1UE83/yMVQ48GO105/dxG2vUAe4yTwB0uwn+++bFPjv4UvEtaEefOI6c3O33+3SR3P2DBzySqA/qxQ9iy+Sl5I9khiE0uqAkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvGuClsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBBFC2BD10;
	Wed, 26 Jun 2024 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719393983;
	bh=dU3Jf3E3jO241GPXBxa5WTQyTqsdhtXznavqyzipez4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvGuClsMJi8Rp5M0RmlNKoW4ESnGgHPbSrZJoPtoYSDaSmDo5+swAXK28qxLyyiZH
	 mKe0G9ToslSNeZIImr+2HbQVjZMejq1eR69llSY24KIH8Kod1+Ingn/g+3bRRTAMni
	 7bPa28aQrqF3pQJzNHCU9lPqf4Egb4RvxuKrVH+m6iht67yhELWkZcfad5182D3qqn
	 5MsF+3YAWmm5mMUb1qIaJy3dtzrHgK63MFnFJ85LpBym5CvLy7jTPnxfBHiDhUI+Nt
	 k7X+Ol9GVwBYzfzog+bGwG/42nVgRd65OuhvDGSsCJ75Zve3PL0URTdVgXmK2JPaPb
	 BHdJLxs9jNFTA==
Message-ID: <b354d11e-9031-47f1-8a23-bbd14ea3d5dd@kernel.org>
Date: Wed, 26 Jun 2024 11:26:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: usb: Convert fsl-usb to yaml
To: Frank Li <Frank.Li@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240625022541.2007010-1-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240625022541.2007010-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 04:25, Frank Li wrote:
> Convert fsl-usb binding doc to yaml format.
> 
> Additional change:


> -	usb@4000 {
> -		compatible = "fsl,mpc5121-usb2-dr";
> -		reg = <0x4000 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		interrupt-parent = < &ipic >;
> -		interrupts = <44 0x8>;
> -		dr_mode = "otg";
> -		phy_type = "utmi_wide";
> -		fsl,invert-drvvbus;
> -		fsl,invert-pwr-fault;
> -	};
> diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.yaml b/Documentation/devicetree/bindings/usb/fsl-usb.yaml
> new file mode 100644
> index 0000000000000..8b5724e213f09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl-usb.yaml

fsl,usb.yaml
or: fsl,usb2.yaml

> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The device node for a USB controller that is part of a Freescale
> +  SOC is as described in the document "Open Firmware Recommended
> +  Practice: Universal Serial Bus" with the following modifications
> +  and additions.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl-usb2-mph
> +          - fsl-usb2-dr
> +          - fsl-usb2-dr-v2.2

It cannot be standalone and not-standalone. Cannot be both. Choose one.

> +      - items:
> +          - enum:
> +              - fsl-usb2-dr-v2.2
> +              - fsl-usb2-dr-v2.5
> +          - const: fsl-usb2-dr
> +
> +  phy_type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ulpi, serial, utmi, utmi_wide]
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  port0:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates port0 is connected for fsl-usb2-mph compatible controllers.
> +
> +  port1:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates port1 is connected for "fsl-usb2-mph" compatible controllers.
> +
> +  fsl,invert-drvvbus:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      for MPC5121 USB0 only. Indicates the
> +      port power polarity of internal PHY signal DRVVBUS is inverted.
> +
> +  fsl,invert-pwr-fault:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      for MPC5121 USB0 only. Indicates
> +      the PWR_FAULT signal polarity is inverted.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - phy_type

Keep the same order as in "properties:". Preferably this order, so
adjust "properties:" to match "required:".

> +
> +allOf:
> +  - $ref: usb-drd.yaml#
> +


Best regards,
Krzysztof


