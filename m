Return-Path: <linux-kernel+bounces-568662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9935A69913
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059A698179F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F917211299;
	Wed, 19 Mar 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOq65X+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD21B4156;
	Wed, 19 Mar 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411975; cv=none; b=PqVP69obzWvRwrxalCSVNVJY9n12qjq5hYJaHHZ8XWGphVz3RR/2A07pTZ5ZHRuzfbAFpOi0RF8+Dfew2VouFfuOP7Vr4GNX2/0DXuviwZgPDZwWQO61bJr8v8FLxJp3jvX8O9WehX+VW2OkTM0mJ8xa9WplMWgonvXcolgFbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411975; c=relaxed/simple;
	bh=rBTZsSXJHptqgoAbgRkJSyZwtaoboMo1kjPhVTbE4rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPkabi0xewM2l97BISUq8U+zC0Nf1shZsS9NNESsPGyWyp+uOIVp+ZllNlr1jcKRILdWsbjnXBiLUmGfxswt8oiaGlPz+FppbNie+jOh9Hrg1PD2M14Cj7kahbDnwd3ZTdla4EmHvgbJrbnnp7Y0SSrtw75/gigRyiKpUCDpmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOq65X+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF7C4CEE4;
	Wed, 19 Mar 2025 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411975;
	bh=rBTZsSXJHptqgoAbgRkJSyZwtaoboMo1kjPhVTbE4rA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cOq65X+KWQ3Yea6I7B5j1IKQ8XdjMytwYPEi4+AXjdDqEpg2fUtSFSBXJBDqCgKUk
	 GLHuMHfwMi85zm4YRG79SswLCqAHtp5Ps0DqGSJz8m49P8jjHHl8c+yv4R36lLwBAM
	 kidh4uc3dJFvbOvwHK5h9JauvvwEZeQIAPF84N5cNTDXnW4OnhXq5ztsCB8sePoQms
	 lmXHNS3lUajYteRx9193rjazfpNaqtbkx53zrQhTHj+eUFCLnHHYsAKByatnbNxl43
	 a0FDWxeA7nTxwRLbhBqCuItFNhbQKm1pFX2VrhtCmr9V59SGczaZ/ODmr62EcZqTKf
	 tufoIsKnGJYrQ==
Message-ID: <bb1c12dc-dc71-4c7f-9969-2fe31f632f6b@kernel.org>
Date: Wed, 19 Mar 2025 20:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add TI TPS389008
To: Flaviu Nistor <flaviu.nistor@googlemail.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250319170234.63723-1-flaviu.nistor@gmail.com>
 <20250319170234.63723-3-flaviu.nistor@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250319170234.63723-3-flaviu.nistor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 18:02, Flaviu Nistor wrote:
> Add device tree bindings and an example for the
> TI TPS389008 voltage monitor.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---

This wasn't ever tested, so limited review.

BTW, bindings are before the user.

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tps38908
> +      - items:
> +          - enum:
> +              - ti,tps38908
> +              - ti,tps38906
> +              - ti,tps38904
> +          - const: ti,tps38908
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    description: Required only if a child node is present.

Drop description

> +    const: 1
> +
> +  "#size-cells":
> +    description: Required only if a child node is present.

Drop description


> +    const: 0
> +
> +patternProperties:
> +  "^vmon@[1-8]$":

s/vmon/channel/

> +    description: |
> +      The node contains optional child nodes for up to x channels.
> +      There are 8 channels for TPS389008, 6 channels for TPS389006,
> +      and 4 channels for TPS389004. Each child node describes the information

Then you need allOf:if:then: disallowing these for specific variants.

> +      of the input source. Input channels default to disabled in the chip.
> +      Unless channels are explicitly enabled in device-tree,
> +      input channels will be disabled.
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      reg:
> +        description: |
> +          Must be 1 to 8,

Don't repeat constraints in free form text.

> corresponding to the VMONx
> +          ports of the TPS389008, TPS389006, or TPS389004, respectively.

Drop entire description

> +        enum: [ 1, 2, 3, 4, 5, 6, 7, 8 ]
> +
> +      label:
> +        description: Name of the input source.
> +
> +      ti,vrange-mult-4x:
> +        description: |
> +          Must have values 5 or 20 in order for the analog
> +          conversion to be done correctly.
> +          Value 5 indicates multiply by 1 (x1), and value 20 indicates
> +          multiply by 4 (x4).
> +        type: boolean
> +
> +      ti,vmon-enable:

Drop. Status tells it, no?

> +        description: |
> +          Sets each channel status. By default, all input channels are disabled.
> +            - 0 = channel disabled
> +            - 1 = channel active
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vmon@37 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "ti,tps389008", "ti,tps389006", "ti,tps389004";

Test your code before sending, not after.



Best regards,
Krzysztof

