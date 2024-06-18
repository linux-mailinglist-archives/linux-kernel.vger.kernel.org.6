Return-Path: <linux-kernel+bounces-218667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1D90C376
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47614B21C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D13BB59;
	Tue, 18 Jun 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or9ZDYXV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088E1758F;
	Tue, 18 Jun 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691639; cv=none; b=uj5+1g1uYssSBVjj7IdrYzUMTQaL0akfRyhgsGM7H0Wzc4/Q0gwMuPPxQrNbzvqBlaYmXftxOjmYdAGQvD1EsGQaamajS6fehZEb8ksr5ODG/yLkFNMuTYQoPew/8iNIDQY8nSTfoqe2K4DFGzgXB7bpiD8HUNS4o6HSgbLHZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691639; c=relaxed/simple;
	bh=Pzw8C5Eyyd86/AVH89vHxaK0LKah+NcOcAwArlidsD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIo+/YbnUwAH7x8J5frmKG7yDCadaoKo/iiSrlhVbQ8ZWrpWTlH8OVFXDnVJtB8dQA+oobnLImQwVRyA3Cyp/1GFGoH66gNW/MXLkIlK0NgtBmcNUs2SazbV+c8ZFFl358RwK3ySfG5ChIwjfrR3oNgc/kr9nmqoQZnAkusoOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or9ZDYXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849A9C4AF1C;
	Tue, 18 Jun 2024 06:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691639;
	bh=Pzw8C5Eyyd86/AVH89vHxaK0LKah+NcOcAwArlidsD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=or9ZDYXVN+K7FIVk2cCi23RdUsPSz/kNApo9erBlQgwJlxT7kOJlVr1BE8LSAzUoI
	 j8zoEVIx3W1xzQqeAxxqik56POzTmkdeV3YTgXJMxMkL3iaH4R2yXNsXST3jIpxDgy
	 A+O5CX333/lq02MPWkzPU/8bZZ7Fvsus0K3LsxjJaVVxb74rKcUIgJ2mBj1GGhZyIt
	 lioiqoyBhstcnaA/TSx2tboFWgyz3mwOOTCmvZo/by/5PDYmrteoouTBqlogDZAscV
	 emLKhexuB9O+Ky9rslM3S5+pW+9KUVenkDanjL2fX3Xo8O5WNZuWFZsS1lbj+y+Y8K
	 dyjMNWSu5NnJg==
Message-ID: <79f3ae72-e733-433c-a577-e0092e3ce20e@kernel.org>
Date: Tue, 18 Jun 2024 08:20:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, sebastian.reichel@collabora.com,
 andy.yan@rock-chips.com, s.hauer@pengutronix.de, jbx6244@yandex.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 skhan@linuxfoundation.org
References: <20240617085341.34332-2-shresthprasad7@gmail.com>
 <f691c7f9-cd81-4bdf-a794-95118cb26686@kernel.org>
 <CAE8VWiLqBUq=-PzT2XVKB_C9nvEERM0x-maWU5qt0+aK1Rd-kg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAE8VWiLqBUq=-PzT2XVKB_C9nvEERM0x-maWU5qt0+aK1Rd-kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2024 20:14, Shresth Prasad wrote:

>>> +examples:
>>> +  - |
>>> +    grf: syscon@ff770000 {
>>
>> Drop label... actually entire node looks not needed.
> 
> From what I understand, this `phy` node should be a sub-node of a `grf`
> node which is why it is part of the example.
> 
>>
>>> +      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
>>
>> Drop
>>
>>> +      reg = <0xff770000 0x10000>;
>>
>> Drop
> 
> Removing `reg` causes the following warning:
> Warning (unit_address_vs_reg): /example-0/syscon@ff770000: node has a
> unit name, but no reg or ranges property
> 
> Please let me know what the prefered solution would be here.

Obviously you need to drop entire node... You cannot just drop reg and
leave unit address.

> 
>>
>>
>>> +      #address-cells = <1>;
>>> +      #size-cells = <1>;
>>> +
>>> +      emmcphy: phy@f780 {
>>
>> Drop label
>>
>>> +        compatible = "rockchip,rk3399-emmc-phy";
>>> +        reg = <0xf780 0x20>;
>>> +        clocks = <&sdhci>;
>>> +        clock-names = "emmcclk";
>>> +        drive-impedance-ohm = <50>;
>>> +        #phy-cells = <0>;
>>> +      };
>>> +    };
>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>> deleted file mode 100644
>>> index 57d28c0d5696..000000000000
>>> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>> +++ /dev/null
>>> @@ -1,43 +0,0 @@
>>> -Rockchip EMMC PHY
>>> ------------------------
>>> -
>>> -Required properties:
>>> - - compatible: rockchip,rk3399-emmc-phy
>>> - - #phy-cells: must be 0
>>> - - reg: PHY register address offset and length in "general
>>> -   register files"
>>> -
>>> -Optional properties:
>>> - - clock-names: Should contain "emmcclk".  Although this is listed as optional
>>> -             (because most boards can get basic functionality without having
>>> -             access to it), it is strongly suggested.
>>> -             See ../clock/clock-bindings.txt for details.
>>> - - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
>>> - - drive-impedance-ohm: Specifies the drive impedance in Ohm.
>>> -                        Possible values are 33, 40, 50, 66 and 100.
>>> -                        If not set, the default value of 50 will be applied.
>>> - - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
>>> -                                    line.  If not set, pull-down is not used.
>>> - - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
>>> -                                    If not set, the register defaults to 0x4.
>>> -                                    Maximum value 0xf.
>>> -
>>> -Example:
>>> -
>>> -
>>> -grf: syscon@ff770000 {
>>> -     compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
>>> -     #address-cells = <1>;
>>> -     #size-cells = <1>;
>>> -
>>> -...
>>> -
>>> -     emmcphy: phy@f780 {
>>> -             compatible = "rockchip,rk3399-emmc-phy";
>>> -             reg = <0xf780 0x20>;
>>> -             clocks = <&sdhci>;
>>> -             clock-names = "emmcclk";
>>> -             drive-impedance-ohm = <50>;
>>> -             #phy-cells = <0>;
>>> -     };
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> index 79798c747476..6e1b1cdea680 100644
>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> @@ -176,9 +176,12 @@ allOf:
>>>              Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
>>>
>>>        patternProperties:
>>> -        "phy@[0-9a-f]+$":
>>> -          description:
>>> -            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>> +        "^phy@[0-9a-f]+$":
>>> +          type: object
>>> +
>>
>> Drop blank line
>>
>>> +          $ref: /schemas/phy/rockchip,rk3399-emmc-phy.yaml#
>>> +
>>
>> Drop blank line
> 
> The rest of the document also has these blank lines, which is why I've
> also kept them here. Are you sure I should remove them?

Yes

> 
>>
>>> +          unevaluatedProperties: false
>>>
>>>    - if:
>>>        properties:
>>
>> Nothing in example? Isn't the example for 3399?
>>
>> We want only one complete example of such multi-children devices, so the
>> example can be moved and included in existing one here.
> 
> The example in this file is actually for `rockchip,rk3399-usb2phy` and
> not `rockchip,rk3399-emmc-phy` which is why I haven't touched it.

What? That's gref, not usb2phy.

This patch and your explanations are very confusing.



Best regards,
Krzysztof


