Return-Path: <linux-kernel+bounces-251045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D593002B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0069282D73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B383177982;
	Fri, 12 Jul 2024 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4MXN3kq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E81426C;
	Fri, 12 Jul 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807439; cv=none; b=q2H1Z2MkbHM/23SRdUq29WAN99FQSOdpUR9+ciqAnRYreSPVnsFVplMvW1rFVsqaS6BZtsrMjwmWMS38uTz5XNcc4Dx63TB6Aav45T9vjUInLZ1HhbUvMbij6ynFYZ7YPQg7I+o8uyUkEE60zvH6Y/Xc9T/V++Jp3x7Rv6asKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807439; c=relaxed/simple;
	bh=YdhC12U5itgKxqr69NX603o+N3odPAcmCvIKxGDxGf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpcSX65wybRwTgdLh0e/Aq0drJYJlRf18Suauc/ZWEDYafhioVml+n4LArGxOs5oyl4YKIR/CPUaCPNPkawJjUCYW0XCTs8FykXS2Mr1sftCAduaTcsDLgVlr7Vj7dKn6d77aLfcM/7uuN5Ng9TsVkBPeKtoAQU3KTQ9z22FzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4MXN3kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028F1C32782;
	Fri, 12 Jul 2024 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807439;
	bh=YdhC12U5itgKxqr69NX603o+N3odPAcmCvIKxGDxGf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4MXN3kqqSE4oo1tx8R+NhLvcPeRcj5FbpqkyDkqzPumnReJj+eSnRoQmBWGKwKxf
	 VVk6QPIoe3cOXsHG7EFwErKWwFQy+exX2TybdHm1GFdZhPrXn6SZCSJKVcCr0n/NDl
	 as86teConu5ENQofD9s0F+Unckg4Jqhvm129geRYAJs8fZBj1KS+GYNJ1I80rYfAJu
	 MxDYyB9DiXE/NGqg9ryCKXi+SpTOGJVjB8XeieozImBKYSFyllNgWz6EMJI0O0kpXT
	 0OvSdILp5/hY4xJdPJH3Q4acWHXCG2obkdHDUNjr7gm3zyzWc5mbHIHbhqvgCgf4vt
	 eSsGVmexmI9tg==
Date: Fri, 12 Jul 2024 12:03:58 -0600
From: Rob Herring <robh@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20240712180358.GA1286437-robh@kernel.org>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>

On Fri, Jul 12, 2024 at 11:49:57AM +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
> 
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> new file mode 100644
> index 000000000000..bd99505de6e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> +  enables features like
> +    - Hardware Security Module (HSM),
> +    - Security Hardware Extension (SHE), and
> +    - Vehicular to Anything (V2X)
> +
> +  Communication interface to the secure-enclaves is based on the
> +  messaging unit(s).
> +
> +properties:
> +  $nodename:
> +    pattern: "firmware@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se
> +      - fsl,imx93-se
> +      - fsl,imx95-se
> +
> +  reg:
> +    maxItems: 1
> +    description: Identifier of the communication interface to secure-enclave.

I don't understand what this is. How does someone determine what the 
value should be? Are there constraints on the values?

> +
> +  mboxes:
> +    items:
> +      - description: mailbox phandle to send message to se firmware

"mailbox phandle to " is redundant. Drop.

> +      - description: mailbox phandle to receive message from se firmware
> +
> +  mbox-names:
> +    description: two names are to be listed, one for rx and other one for tx.
> +      The name can be any of the below list.

I think this can be dropped. The schema says all this.

> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  memory-region:
> +    items:
> +      - description: The phandle to the reserved external memory, the only
> +          accessible memoryregion to secure enclave(SE) firmware. It is an
> +          optional property based on compatible.
> +          (see bindings/reserved-memory/reserved-memory.txt)

Drop. 'maxItems: 1' is sufficient.

> +
> +  sram:
> +    items:
> +      - description: It is an optional property based on compatible.

Drop. 'maxItems: 1' is sufficient.

> +
> +required:
> +  - compatible
> +  - reg
> +  - mboxes
> +  - mbox-names
> +
> +allOf:
> +  # memory-region
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +              - fsl,imx93-se
> +    then:
> +      required:
> +        - memory-region
> +    else:
> +      properties:
> +        memory-region: false
> +
> +  # sram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +    then:
> +      required:
> +        - sram
> +
> +    else:
> +      properties:
> +        sram: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      firmware@0 {
> +        compatible = "fsl,imx95-se";
> +        reg = <0x0>;
> +        mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> +        mbox-names = "tx", "rx";
> +      };
> +    };
> +...
> 
> -- 
> 2.34.1
> 

