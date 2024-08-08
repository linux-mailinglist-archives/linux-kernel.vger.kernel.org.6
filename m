Return-Path: <linux-kernel+bounces-279403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EE94BCE1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EB4B228B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936718C344;
	Thu,  8 Aug 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUhch7z6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89F126F1E;
	Thu,  8 Aug 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118681; cv=none; b=NHUhK8JATzsbTnYYtb+nHKTwtDAvkytThSQNJz8l03IKYxuPMNfHcW6KMeY/9NaBuefp4lMb8FsQ3G3uVSspRDGjkBASnFNyA/0ClJCoGEhXYcQyxjA7jcAS4loVMf21Kxgjos+ZY3WZz7E+p3jCwCeOAbkEV6TpkHVxrXWGriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118681; c=relaxed/simple;
	bh=CuuuqrCpe3lD6WoXCd4Ve65BdO8B/nlv4zg4EVOsj2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCcmnQdqDgYbUjlI22OaN08bGBxLvljtIzdS6isKziiMKb9ZwtKNSwXBU69n/MdYVpmJ/K4orun44oRMZQYyKfx7Be/VobC7LwWq0WOvFeOPEH6UU4H2pug8bSikpqY2i6vVLN4bciKIcLMwr8zj0SqkYF3au9Pc0whuFk20pcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUhch7z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC2C32782;
	Thu,  8 Aug 2024 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723118680;
	bh=CuuuqrCpe3lD6WoXCd4Ve65BdO8B/nlv4zg4EVOsj2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XUhch7z637LfBfCSYLIrMwJfOURvB9rzd/X9a/6/qRtX0BFkGcl9KkzgelzeYmcEw
	 m0xRTZMdJYA+CKbHQBE+gSaOEodBoNQ+Q3WrTOeaTyhH+4GQQUAlA58mznv9RMY+14
	 oJ5y7AxA+0sM03KSROCQ8crXwEs5q8fknuB2jJuxrbY78w4GEbMqUlTfiGdvrLtlGo
	 GanQf8vtg5THk5jHR5TQEgzz035Temq9/sG+qIJd2w2HN4WhSccTzYfs5eBl/j4OKf
	 1HHXXzshBgOkVGcsx3UeNCR8yQEg05tvrR1vIJOipcRg68/Va9OgNe8GGiiBDqdVGR
	 6zQhYAvDOiYLw==
Message-ID: <2d89c86b-28b4-439f-824b-1d0560ff36bd@kernel.org>
Date: Thu, 8 Aug 2024 14:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: mt6397: Convert to DT schema
 format
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240808105722.7222-1-macpaul.lin@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240808105722.7222-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:57, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> New updates in this conversion:
>  - Align generic names of DT schema "audio-codec" and "regulators".
>  - mt6397-regulators: Replace the "txt" reference with newly added DT
>    schema.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 202 ++++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        | 110 ----------

You are doing conversions in odd order... and ignore my comments. The
example from your regulator binding is supposed to be here - I wrote it
last time.

Due to doing changes totally unsynchronized, this CANNOT be merged
without unnecessary maintainer coordination, because of dependency.

Sorry, that's not how it works for MFD devices.

Perform conversion of entire device in ONE patchset.

>  2 files changed, 202 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
> 
> Changes for v1:
>  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
>    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> new file mode 100644
> index 0000000..cfbf2215
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6397/MT6323 Multifunction Device
> +
> +maintainers:
> +  - Sen Chu <sen.chu@mediatek.com>
> +  - Macpaul Lin <macpaul.lin@mediatek.com>
> +
> +description: |
> +  MT6397/MT6323 is a multifunction device with the following sub modules:

MFD is Linuxism, avoid it.

> +  - Regulator
> +  - RTC
> +  - Audio codec
> +  - GPIO
> +  - Clock
> +  - LED
> +  - Keys
> +  - Power controller
> +
> +  It is interfaced to host controller using SPI interface by a proprietary hardware
> +  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
> +  See the following for pwarp node definitions:
> +  ../soc/mediatek/mediatek,pwrap.yaml

Drop, instead add proper ref or compatible in parent node.

> +
> +  This document describes the binding for MFD device and its sub module.

Drop

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt6323
> +          - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
> +          - mediatek,mt6357
> +          - mediatek,mt6358
> +          - mediatek,mt6359
> +          - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6366 # "mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366

Drop comment, it is obvious. Don't repeat constraints in free form text.

> +          - const: mediatek,mt6358
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  rtc:
> +    type: object
> +    unevaluatedProperties: false
> +    description:
> +      Real Time Clock (RTC)
> +      See ../rtc/rtc-mt6397.txt

No, convert the binding.

> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6323-rtc
> +              - mediatek,mt6331-rtc
> +              - mediatek,mt6358-rtc
> +              - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-rtc # RTC MT6366

Drop all such comments.

> +              - const: mediatek,mt6358-rtc
> +
> +  regulators:
> +    type: object
> +    oneOf:
> +      - $ref: /schemas/regulator/mediatek,mt6358-regulator.yaml
> +      - $ref: /schemas/regulator/mediatek,mt6397-regulator.yaml

And how is it supposed to be tested?



> +    unevaluatedProperties: false
> +    description:
> +      Regulators
> +      For mt6323, see ../regulator/mt6323-regulator.txt

Drop, useless.

> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6323-regulator
> +              - mediatek,mt6358-regulator
> +              - mediatek,mt6397-regulator
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-regulator # Regulator MT6366
> +              - const: mediatek,mt6358-regulator
> +
> +  audio-codec:
> +    type: object
> +    unevaluatedProperties: false

This does not make sense. You do not have any ref here.

> +    description:
> +      Audio codec
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6397-codec
> +              - mediatek,mt6358-sound
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-sound # Codec MT6366
> +              - const: mediatek,mt6358-sound

This wasn't in the old binding. Commit msg also does not explain why you
are doing changes from conversion.

> +
> +  clk:
> +    type: object
> +    unevaluatedProperties: false

Again, no, it does not work like this. See example schema for
explanation of this.

Convert all children - entire device. Then either use ref or
additionalProperties: true. See Qualcomm mdss bindings for example.

> +    description:
> +      Clock

Your descriptions are useless. You just said "clk" node is "clock". Really?

> +    properties:
> +      compatible:
> +        const: mediatek,mt6397-clk
> +
> +  led:
> +    type: object
> +    unevaluatedProperties: false
> +    description:
> +      LED
> +      See ../leds/leds-mt6323.txt for more information

No

> +    properties:
> +      compatible:
> +        const: mediatek,mt6323-led
> +
> +  keys:
> +    type: object
> +    $ref: /schemas/input/mediatek,pmic-keys.yaml
> +    unevaluatedProperties: false
> +    description: Keys

Keys are keys? Could keys be anything else?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pwrap {

Drop

> +        pmic {
> +            compatible = "mediatek,mt6397";
> +            interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            mt6397_codec: audio-codec {
> +                compatible = "mediatek,mt6397-codec";
> +            };
> +
> +            mt6397_regulators: regulators {
> +                compatible = "mediatek,mt6397-regulator";
> +
> +                mt6397_vpca15_reg: buck_vpca15 {
> +                    regulator-name = "vpca15";
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <1400000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-always-on;
> +                };
> +
> +                mt6397_vgp4_reg: ldo_vgp4 {
> +                    regulator-name = "vgp4";
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-enable-ramp-delay = <218>;
> +                };
> +            };

Incomplete.

The parent device example is supposed to be 100% complete.

Best regards,
Krzysztof


