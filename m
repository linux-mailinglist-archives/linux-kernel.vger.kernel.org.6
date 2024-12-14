Return-Path: <linux-kernel+bounces-445974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE09F1E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F485167FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026118787F;
	Sat, 14 Dec 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6UGnoy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B2262BE;
	Sat, 14 Dec 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734171895; cv=none; b=HKOGb9vZFsJB4apCVkHRaa06V3YgY+A5RMNDPl8dkwrKAPWqFglNoigdc0iA4XYjHiAcrzI4zuv2rPYzLit3i/1GhLeN8B9J3QQ92fnN7gAODPf8xtjlaW07BrFNS3pFgc5F40eHWPyEV9fdDYV5Nr8FeONqYEur0EnYmSxMYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734171895; c=relaxed/simple;
	bh=HmGD+VD1QrGKFAV8q0OlZbFcKLkHq5d9XiU9d+c31Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PomrRMBA0fT7/0dfI29T1aJ1qAkNhNzU2cCA6I37zgSZhlN/pIHEmHO3D64QcgZwo5Btxw9UTS5gFfbv+ktHHosDMekrSc0GEMKiRi0y9UdTi339TqIaZL0m2OR4ryUvSvv3hXMFhejprWztHPH2Od3o72NID910VaX/q6LUZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6UGnoy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7BCC4CED1;
	Sat, 14 Dec 2024 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734171895;
	bh=HmGD+VD1QrGKFAV8q0OlZbFcKLkHq5d9XiU9d+c31Ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h6UGnoy0cDV0cTN8hJDFotdrwON4u9zfwzskK/uw+Wa2uwbrARTQuPF30Xm/yv8Cn
	 3rBA6z7YAlv3JYmMwGSAIa0QkbAmHkd8/Fg3n8hZKQgc7tmXEKsjXpxiEzyJze7KGa
	 H9Y+SA3el0Z7I6gA75S3hs7bOwc40rsrRyLQ+1iPsIW35cn12QYwxc7PncIyygvsSl
	 Am1QvDKRwCmziUdzAGqXbgsMyj7qdGwSA40sJl3i3SUJDymZLliBVCVNCzNwTXIWGB
	 h/1+2+Lnq9EgVlFxweBIHChq6lBjWLK0QXUcINQk2NTeW55uLFHsXlcVe+FvGfEP9H
	 cOahl8PUYg7Sg==
Message-ID: <b3ba90ed-dbc1-413a-bef5-e49adb9153e0@kernel.org>
Date: Sat, 14 Dec 2024 11:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xlnx: dt-bindings: xlnx,i2s: Convert to json-schema
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
 <20241213165240.3652961-2-vincenzo.frascino@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241213165240.3652961-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2024 17:52, Vincenzo Frascino wrote:
> Convert the Xilinx I2S device tree binding documentation to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument, so you will
not CC people just because they made one commit years ago). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.
</form letter>

> ---
>  .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 -------
>  .../devicetree/bindings/sound/xlnx,i2s.yaml   | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml


Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> 
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
> deleted file mode 100644
> index 5e7c7d5bb60a..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Xilinx I2S PL block
> -
> -The IP supports I2S based playback/capture audio
> -
> -Required property:
> - - compatible: "xlnx,i2s-transmitter-1.0" for playback and
> -	       "xlnx,i2s-receiver-1.0" for capture
> -
> -Required property common to both I2S playback and capture:
> - - reg: Base address and size of the IP core instance.
> - - xlnx,dwidth: sample data width. Can be any of 16, 24.
> - - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
> -		      supported channels = 2 * xlnx,num-channels
> -
> -Example:
> -
> -	i2s_receiver@a0080000 {
> -		compatible = "xlnx,i2s-receiver-1.0";
> -		reg = <0x0 0xa0080000 0x0 0x10000>;
> -		xlnx,dwidth = <0x18>;
> -		xlnx,num-channels = <1>;
> -	};
> -	i2s_transmitter@a0090000 {
> -		compatible = "xlnx,i2s-transmitter-1.0";
> -		reg = <0x0 0xa0090000 0x0 0x10000>;
> -		xlnx,dwidth = <0x18>;
> -		xlnx,num-channels = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
> new file mode 100644
> index 000000000000..b8bda7c28d37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for Xilinx I2S PL block

There is never "Device-tree bindings for" in the title. Please start
bindings from some existing sources or example-schema.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.


> +
> +description: |
> +  The IP supports I2S based playback/capture audio.
> +
> +maintainers:
> +  - Vincenzo Frascino <vincenzo.frascino@arm.com>
> +  - Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: xlnx,i2s-receiver-1.0
> +      - const: xlnx,i2s-transmitter-1.0
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Base address and size of the IP core instance.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  "#address-cells":
> +    maxItems: 1

no, drop or explain. There was nothing like that in old bindingg.

> +
> +  "#size-cells":
> +    maxItems: 1

Drop


> +
> +  xlnx,dwidth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1

Drop


> +    oneOf:
> +      - const: 16
> +      - const: 24

That's just enum.

> +    description: |
> +      Sample data width. Can be any of 16, 24.
> +
> +  xlnx,num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1

Drop

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Number of I2S streams.
> +    minimum: 1
> +    maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,dwidth
> +  - xlnx,num-channels
> +
> +additionalProperties: false

unevaluatedProperties instead

> +
> +examples:
> +  - |
> +    i2s_receiver@a0080000 {

i2s@

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "xlnx,i2s-receiver-1.0";
> +      reg = <0x0 0xa0080000 0x0 0x10000>;
> +      xlnx,dwidth = <0x18>;
> +      xlnx,num-channels = <1>;
> +    };
> +    i2s_transmitter@a0090000 {
> +      compatible = "xlnx,i2s-transmitter-1.0";

Drop the node, one example is enough since they do not differ.


Best regards,
Krzysztof

