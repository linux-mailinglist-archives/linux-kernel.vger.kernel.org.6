Return-Path: <linux-kernel+bounces-371815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CA9A40B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D63282E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1881DFDAC;
	Fri, 18 Oct 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Q0Y07X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84A18E37A;
	Fri, 18 Oct 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260465; cv=none; b=nh3jt8gOJVo9BUhBEF7RCeEMy/9h9F6OJo+Oe2b7TrXtv4eGQIQE0Nd1vqVPq3vaabfdTveJWqJOHP+SP0Qa8yJvuWg74AZGYY8PAonyXBTUTrjKc6WypcAgY1CQzkgG+Lo121YML8h7R8SN57ABFnqkBqZKReZqwJKPSSmdx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260465; c=relaxed/simple;
	bh=jP86ztaI7J7tDYRP3BDZCBNNTfKOBEbCWzoC6TZLm/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbRDH/F89fckfTyWrhs/ceUmPbX5ieoNdLPoiqzWzzhatsyUGkHt4fXwde74CpO1MX+G9ibn4IpUmTKGacOIyW01Y6CQbcHFflSev6bh8Rj3KDV3d3FAJ5OcvCsndZHoFgsa2NWJI0pwNsSMMUh11t+WsiLa3cVb0cprYAQ/Toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Q0Y07X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB07C4CEC3;
	Fri, 18 Oct 2024 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260464;
	bh=jP86ztaI7J7tDYRP3BDZCBNNTfKOBEbCWzoC6TZLm/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6Q0Y07XzVHt/2gRQaTd9zrJvhbDYizQ0diq0zu/hyI9F0AgflngmX4ILrzaEM/52
	 I4F4GIOcj14qnEM+G/Hj/xthUIaHxFvnnJdzwbpFhZtYh0YKOYR1fnh0+eajEYZkcV
	 U+FG1hrjX8nxgrZfcugthLPoH6EX2UvEuOc0mUy7gjy48yvhIF84cnBlioYayfhRpb
	 VWTfafDg4nMZxgPXmus4trGw6lUbiJoxovzu64e42NzWvdc0X9S0Gh8Mle6KdXpzcY
	 ws3M0cu+vkb0rOEtc56sjOxkkz3eOQLniwN/jmI5fBH8DdKG0ub4mhcYTUneQ4qrz5
	 mEdcgx66zQlwQ==
Date: Fri, 18 Oct 2024 09:07:43 -0500
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241018140743.GA98324-robh@kernel.org>
References: <20241018105505.28005-1-francesco@dolcini.it>
 <20241018105505.28005-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018105505.28005-2-francesco@dolcini.it>

On Fri, Oct 18, 2024 at 12:55:04PM +0200, Francesco Dolcini wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> host controller. The controller supports software configuration
> through PCIe registers, such as controlling the PWRONx polarity
> via the USB control register (E0h).
> 
> Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> as an example.
> 
> Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v3: use lowercase hex in compatible
> v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> ---
>  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> new file mode 100644
> index 000000000000..7083e24d279c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
> +
> +maintainers:
> +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> +
> +description:
> +  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> +  The TUSB7320 supports up to two downstream ports, the TUSB7340 supports up
> +  to four downstream ports.

XHCI controller, should be referencing usb-xhci.yaml.

> +
> +properties:
> +  compatible:
> +    const: pci104c,8241

2 parts mentioned above, but only 1 PCI ID?

> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,tusb7320-pwron-active-high:

Drop 'tusb7320-'

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Configure the polarity of the PWRONx# signals. When this is present, the PWRONx#
> +      pins are active high and their internal pull-down resistors are disabled.
> +      When this is absent, the PWRONx# pins are active low (default) and their internal
> +      pull-down resistors are enabled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";

You can move this up a level and get rid of this middle node. 

> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +            bus-range = <0x01 0xff>;

Not needed for examples.

> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            usb@0 {
> +                  compatible = "pci104c,8241";
> +                  reg = <0x10000 0x0 0x0 0x0 0x0>;

In FDT, we generally don't know the bus number because the OS assigns 
them. So it should always be 0 in 'reg'.

Rob

