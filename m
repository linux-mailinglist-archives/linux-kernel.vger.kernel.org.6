Return-Path: <linux-kernel+bounces-222112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7AF90FCFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525801C2365F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D923EA9B;
	Thu, 20 Jun 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrPd1zqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EC433C4;
	Thu, 20 Jun 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866159; cv=none; b=sM3wxDC9IWH48uCFqr+oCv7eFbSuzxGCQCvoBIr2ZF3wXrYfhgStol+uGdSOgkMjdXo2+01rXXa/Ep/g1aPP7KzTGEaammMJaNoRWIb2P47jGu6JGBdfd2gPWcyinDI30/NXc7pYG3itxx5aVPdXBU14nEePLgpPRo9jseImuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866159; c=relaxed/simple;
	bh=topRIO6jwDZFmxlecZm/hIDN/hz/Byg0GMWQotDDeAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SssUYtarbfpJnEqoGTSzV0FMe1jKgDi4f2jJKR6XD7w5djERnj9XkY7+5xWX/Zu9M58OWAdFdFTNPCJob62PqfoKsJvVcRT+Lzxca81OXK68tjbsiHRHwE1XTF6lfnOigFinyalAXJnasjC22s77sa6fgeX1T557KctrFVOLcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrPd1zqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA6AC32781;
	Thu, 20 Jun 2024 06:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718866158;
	bh=topRIO6jwDZFmxlecZm/hIDN/hz/Byg0GMWQotDDeAU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UrPd1zqHVKnqLaeV8Wbo8p7kMCnFu84MEGLggf+THGRs288d3h3mbUdtCv50/3E9I
	 v6QfJQR+enm8d0q/o0qCp1fJc4NkddhmIt80qLKOOTkqpG3iO4PkZxqPQZrbgbKKmw
	 8cnNV7DZ4zvANzSa2gsDs0YUW9wZhz7I55YYENHjWR9x27DDlMZOPyU2mwDqMr6zZD
	 qdSNbD3mLLlCshX7hhIPacX/EYEyXNokFXo5XW6qMAhgkVbS97YBQiP4lEB1tnODQg
	 sSly9AdloxpVjm/H6PNiiA7stMkI/EAI/8kzT4ShKS1ufJlP9KdLwJ0b408IVgbN/Q
	 cg10Zco+E8w8g==
Message-ID: <e3190fef-3d33-42e5-926f-07d44a4d5f64@kernel.org>
Date: Thu, 20 Jun 2024 08:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: misc: axi-fifo: Add binding for AXI-Stream
 FIFO
To: Mark Watson <markus.c.watson@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZnOAgM+zacF6u1x7@laptop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <ZnOAgM+zacF6u1x7@laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2024 03:06, Mark Watson wrote:
> This resolves a checkpatch warning in drivers/staging/axis-fifo
> regarding a missing devie-tree binding. The full warning is included
> below.
> 
> WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.1" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> +       { .compatible = "xlnx,axi-fifo-mm-s-4.1", },

That's not needed. Drop above reasoning but instead say that you add new
bindings for foo bar (explain what is the hardware).

You did not test your code, so limited review follows.

There is a binding. Just grep for compatible. You might want to do
conversion but then:

Thank you for your patch. There are no DTS users of this binding, so
while such conversions are useful, they have significantly smaller
impact. In the future, please consider converting bindings from active
platforms (arm64 defconfig, arm multi_v7). This would have significantly
bigger impact.

See also:
https://lore.kernel.org/all/6552bcb8-e046-4882-91da-1094fff3d239@linaro.org/

> 
> Signed-off-by: Mark Watson <markus.c.watson@gmail.com>
> ---
>  .../bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml | 214 ++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
> new file mode 100644
> index 000000000000..cfb335752054
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
> @@ -0,0 +1,214 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s-4.1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI-Stream FIFO v4.1 IP core
> +

Missing maintainers. Why would we care about hardware if there is no one
to interested in it?

> +description: |
> +  The Xilinx AXI-Stream FIFO v4.1 IP core has read and write AXI-Stream FIFOs,
> +  the contents of which can be accessed from the AXI4 memory-mapped interface.
> +  This is useful for transferring data from a processor into the FPGA fabric.
> +  The driver creates a character device that can be read/written to with
> +  standard open/read/write/close operations.
> +
> +  See Xilinx PG080 document for IP details.
> +
> +  Currently supports only store-forward mode with a 32-bit AXI4-Lite
> +  interface.
> +
> +  DOES NOT support:
> +    - cut-through mode
> +    - AXI4 (non-lite)
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-fifo-mm-s-4.1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: interrupt

No, drop entire property.

> +
> +  interrupt-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Drop property.

> +
> +  xlnx,axi-str-rxd-protocol:
> +    const: XIL_AXI_STREAM_ETH_DATA
> +
> +  xlnx,axi-str-rxd-tdata-width:
> +    const: 0x20
> +
> +  xlnx,axi-str-txc-protocol:
> +    const: XIL_AXI_STREAM_ETH_CTRL
> +
> +  xlnx,axi-str-txc-tdata-width:
> +    const: 0x20
> +
> +  xlnx,axi-str-txd-protocol:
> +    const: XIL_AXI_STREAM_ETH_DATA
> +
> +  xlnx,axi-str-txd-tdata-width:
> +    const: 0x20

Drop all these.

> +
> +  xlnx,axis-tdest-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,axis-tid-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,axis-tuser-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No clue what are these. Drop.

> +
> +  xlnx,data-interface-type:
> +    const: 0x0
> +
> +  xlnx,has-axis-tdest:
> +    const: 0x0
> +
> +  xlnx,has-axis-tid:
> +    const: 0x0
> +
> +  xlnx,has-axis-tkeep:
> +    const: 0x1
> +
> +  xlnx,has-axis-tstrb:
> +    const: 0x0
> +
> +  xlnx,has-axis-tuser:
> +    const: 0x0

Drop everything above.

> +
> +  xlnx,rx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,rx-fifo-pe-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,rx-fifo-pf-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,s-axi-id-width:
> +    const: 0x4
> +
> +  xlnx,s-axi4-data-width:
> +    const: 0x20
> +
> +  xlnx,select-xpm:
> +    const: 0x0
> +
> +  xlnx,tx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,tx-fifo-pe-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,tx-fifo-pf-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No standard properties?

> +
> +  xlnx,use-rx-cut-through:
> +    const: 0x0
> +
> +  xlnx,use-rx-data:
> +    const: 0x1
> +
> +  xlnx,use-tx-ctrl:
> +    const: 0x0
> +
> +  xlnx,use-tx-cut-through:
> +    const: 0x0
> +
> +  xlnx,use-tx-data:
> +    const: 0x1
> +
> +  xlnx,tx-max-pkt-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,rx-min-pkt-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No, drop all these.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-parent
> +  - xlnx,axi-str-rxd-protocol
> +  - xlnx,axi-str-rxd-tdata-width
> +  - xlnx,axi-str-txc-protocol
> +  - xlnx,axi-str-txc-tdata-width
> +  - xlnx,axi-str-txd-protocol
> +  - xlnx,axi-str-txd-tdata-width
> +  - xlnx,axis-tdest-width
> +  - xlnx,axis-tid-width
> +  - xlnx,axis-tuser-width
> +  - xlnx,data-interface-type
> +  - xlnx,has-axis-tdest
> +  - xlnx,has-axis-tid
> +  - xlnx,has-axis-tkeep
> +  - xlnx,has-axis-tstrb
> +  - xlnx,has-axis-tuser
> +  - xlnx,rx-fifo-depth
> +  - xlnx,rx-fifo-pe-threshold
> +  - xlnx,rx-fifo-pf-threshold
> +  - xlnx,s-axi-id-width
> +  - xlnx,s-axi4-data-width
> +  - xlnx,select-xpm
> +  - xlnx,tx-fifo-depth
> +  - xlnx,tx-fifo-pe-threshold
> +  - xlnx,tx-fifo-pf-threshold
> +  - xlnx,use-rx-cut-through
> +  - xlnx,use-rx-data
> +  - xlnx,use-tx-ctrl
> +  - xlnx,use-tx-cut-through
> +  - xlnx,use-tx-data
> +  - xlnx,tx-max-pkt-size
> +  - xlnx,rx-min-pkt-size
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    axi_fifo_mm_s_0: axi_fifo_mm_s@43c00000 {

Drop label. No underscores in node names.


Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "xlnx,axi-fifo-mm-s-4.1";
> +      interrupt-names = "interrupt";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 29 4>;

Use proper defines.


Best regards,
Krzysztof


