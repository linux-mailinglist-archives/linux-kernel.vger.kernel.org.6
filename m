Return-Path: <linux-kernel+bounces-176156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA68C2AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809D71C22581
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF54D9F2;
	Fri, 10 May 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB6vkmI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C134CB4E;
	Fri, 10 May 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371746; cv=none; b=iiNUw/MA/q2qwRi9B5VNWjJCw26QQmRkkYpS7KDavvN2AssejpFgk99HNaA1ZybxhA0KogOm9FL9+or5d1kx02lxhc1cv1dNtkuNVr0L6GWapV6lT6O9hRvkLZHxfjEW1ezN3Sxso0lFIR6+7iltyvGurfHCXopAaF7xev66a/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371746; c=relaxed/simple;
	bh=WbY0QNkzU5FHLjWQNa5GB+HlPBZoGMhX888ryhFyDBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4mxW7tuoTczwOKT7lIu2iBU20+skC/uWNK2jkRhZn4AJf6jYFL6nEz4c4PZb9rhI1vbNtSoqF/hmfMJDK3+dBuWl4OKIBDCDK202MchcfLTslzflEkM/ZK+DN4SXcE42nMR7s2xqKQERudJ+d2io93VIDzwyDlQ0iAJngtqm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB6vkmI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300EAC113CC;
	Fri, 10 May 2024 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715371745;
	bh=WbY0QNkzU5FHLjWQNa5GB+HlPBZoGMhX888ryhFyDBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB6vkmI6rFllxSJs8EHd0yoIgd0lapuu5TAuXQ2LflMUEDDpyNzx+T/I/YG236rQq
	 aUQuwWa7DFKFyYRFVZ8So9IASCbEwkphWQHb9YWA+hu6b5WUP7sSNgNI2GJnU+vB7A
	 dkBKJB8/FFvKV8yHYEAoPRiJPheHjc66p3dg+L0o3940G1GCyN2EMklIkyHcGBQFhF
	 se8Utg8w6oSjUDQ+eop1vWT34TEyL8Z4uEk25GFKuvMVsbefe+Oz8LF1eiuXTb0orZ
	 zZ8DgP3iwaC9L+L7+mnjJi4tdK9jj+ham/mwihAnUCKono3YPqi+ljfPryWrqoMYNa
	 qyQl+ET7CntbQ==
Date: Fri, 10 May 2024 15:09:03 -0500
From: Rob Herring <robh@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20240510200903.GA628922-robh@kernel.org>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>

On Fri, May 10, 2024 at 06:57:28PM +0530, Pankaj Gupta wrote:
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
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 186 +++++++++++++++++++++
>  1 file changed, 186 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> new file mode 100644
> index 000000000000..a858ef6965cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> @@ -0,0 +1,186 @@
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
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-ele
> +      - fsl,imx93-ele

You basically have 0 properties in the parent node. What's the point of 
it? Either just get rid of it and define the child nodes independently 
or make the parent contain all the resources.

> +
> +patternProperties:
> +  "^[0-9a-z]*-if@[0-9]+$":

unit-addresses are hex. 

> +    type: object
> +    description:
> +      Communication interface to secure-enclave node, that defines hardware
> +      properties to required to establish the communication. There can be
> +      multiple interfaces to the same secure-enclave. Each interface is
> +      enumerated with reg property. It optionally defines properties
> +      depending on the compatible string and interface enum identifier.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: Identifier of the communication interface to secure-enclave.

What are the identifiers based on? Is the value significant to s/w? Kind 
of looks like you just made up indices.

How many child nodes do you have? Is it fixed per SoC?

> +
> +      mboxes:
> +        description: contain a list of phandles to mailboxes.
> +        items:
> +          - description: Specify the mailbox used to send message to se firmware
> +          - description: Specify the mailbox used to receive message from se firmware
> +
> +      mbox-names:
> +        items:
> +          - const: tx
> +          - const: rx
> +          - const: txdb
> +          - const: rxdb
> +        minItems: 2
> +
> +      memory-region:
> +        description: contains a list of phandles to reserved external memory.
> +        items:
> +          - description: It is used by secure-enclave firmware. It is an optional
> +              property based on compatible and identifier to communication interface.
> +              (see bindings/reserved-memory/reserved-memory.txt)
> +
> +      sram:
> +        description: contains a list of phandles to sram.
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        items:
> +          - description: Phandle to the device SRAM. It is an optional property
> +              based on compatible and identifier to communication interface.
> +
> +    required:
> +      - reg
> +      - mboxes
> +      - mbox-names
> +
> +allOf:
> +  # memory-region
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-ele
> +              - fsl,imx93-ele

What else would they contain? Those are the only compatibles defined 
here.

> +    then:
> +      patternProperties:
> +        "^[0-9a-z]*-if@[0-9]+$":
> +          allOf:
> +            - if:

These conditionals are hard to follow. Probably a sign some of this 
needs to be separate or simplified.

> +                properties:
> +                  reg:
> +                    items:
> +                      - enum:
> +                          - 0
> +              then:
> +                required:
> +                  - memory-region
> +              else:
> +                not:
> +                  required:
> +                    - memory-region
> +  # sram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-ele
> +    then:
> +      patternProperties:
> +        "^[0-9a-z]*-if@[0-9]+$":
> +          allOf:
> +            - if:
> +                properties:
> +                  reg:
> +                    items:
> +                      - enum:
> +                          - 0
> +              then:
> +                required:
> +                  - sram
> +              else:
> +                not:
> +                  required:
> +                    - sram
> +
> +additionalProperties: false

