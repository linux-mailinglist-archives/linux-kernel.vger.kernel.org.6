Return-Path: <linux-kernel+bounces-259372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF39394F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367A428408B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31D31A89;
	Mon, 22 Jul 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOEHTv9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337921CFB6;
	Mon, 22 Jul 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681253; cv=none; b=f4jKgnapIva2O1w7GMAe5OsQQbrMqMqDXKC1K3Ss35vvNbsNgy/groRIJxvcF/UcodIs8pwmzk9dBQW9UrCUw38JQICMcARISxUn0Puiimsa3h+vhTxhdDB4rEb8UYaswSCKFzlQJBe/ShLywC2a8Pw09Fu+w0rSCshw7sHFHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681253; c=relaxed/simple;
	bh=2tgPmKD5jahHFSGGCNYlypaO0n4srZA5X95Ro2CcyCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3gLHxIQjtgCoK3Xs+Aj3+2Zrp1/KBuMjmGMWoNiU+vmMIfZZi2Q5Ynn/9g9rxqrVkTnCAYxbxctqk5SNDQp4ul/BMZd10urJk9uM0qwiuFCISWkXaMQOTwHs9yTZRSAuMWx7QlnYteSkMuIr5bpI2coElyPnO9PXvio37u8HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOEHTv9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C445BC116B1;
	Mon, 22 Jul 2024 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681253;
	bh=2tgPmKD5jahHFSGGCNYlypaO0n4srZA5X95Ro2CcyCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOEHTv9b8Namblx8+Js/MGy6ZJOPsnmOPkWQF/Kl2a9FeRyYkmmeSIoYDZatZ9C9b
	 TjWrZWl6xgBfrt98QktIUx8vFvc3mWPg+jerzWM8MO0Qs85Hg3mX4RpsGBpWt8oB5Q
	 fHvKqkkO6569S0dK3+In3PFwqt33b8U/l4B3dTDbfgNn6nQ93skIC02nzgGhhDSb6F
	 NGkeO2TTkk80V6OMwyZyyGrmNQjtnJ3N4yNMsDndib49cmXi+ehyA8YvGSkiUAR8aS
	 p51pCnwyC4UHHhITbu9Vfg195JmwUnQZJ/j/h7yIywtqc/jFAcKnAxH3Co9nZ3uu8h
	 xPRx9mVbkhaHg==
Date: Mon, 22 Jul 2024 14:47:23 -0600
From: Rob Herring <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>,
	Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 05/37] dt-bindings: Add binding for
 kalray,coolidge-apic-mailbox
Message-ID: <20240722204723.GA61731-robh@kernel.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-6-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-6-ysionneau@kalrayinc.com>

On Mon, Jul 22, 2024 at 11:41:16AM +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge APIC Mailbox interrupt-controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: Fixed bindings to adhere to dt-schema
> ---
>  .../kalray,coolidge-apic-mailbox.yaml         | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
> new file mode 100644
> index 0000000000000..334b816b80583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray Coolidge APIC-Mailbox
> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +description: |
> +  Each cluster in the Coolidge SoC includes an Advanced Programmable Interrupt
> +  Controller (APIC) which is split in two part:
> +    - a Generic Interrupt Controller (referred as APIC-GIC)
> +    - a Mailbox Controller           (referred as APIC-Mailbox)
> +  The APIC-Mailbox contains 128 mailboxes of 8 bytes (size of a word),
> +  this hardware block is basically a 1 KB of smart memory space.
> +  Each mailbox can be independently configured with a trigger condition
> +  and an input mode function.
> +
> +  Input mode are:
> +   - write
> +   - bitwise OR
> +   - add
> +
> +  Interrupts are generated on a write when the mailbox content value
> +  match the configured trigger condition.
> +  Available conditions are:
> +   - doorbell: always raise interruption on write
> +   - match: when the mailbox's value equal the configured trigger value
> +   - barrier: same as match but the mailbox's value is cleared on trigger
> +   - threshold: when the mailbox's value is greater than, or equal to, the
> +     configured trigger value
> +
> +  Since this hardware block generates IRQs based on writes to some memory
> +  locations, it is both an interrupt controller and an MSI controller.
> +
> +properties:
> +  compatible:
> +    const: kalray,coolidge-apic-mailbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 0
> +    description:
> +      The IRQ number.
> +
> +  "#address-cells":
> +    const: 0
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    maxItems: 128
> +    minItems: 1
> +    description: |
> +     Specifies the interrupt line(s) in the interrupt-parent controller node;
> +     valid values depend on the type of parent interrupt controller

Your description applies to all 'interrupts' properties and is therefore 
redundant. What you should explain is what are the 1-128 possible 
interrupts. Normally, you have to list each one out unless they are all 
instances of the same type of interrupt.

> +
> +  msi-controller: true

"#msi-cells" should be specified too.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#interrupt-cells"
> +  - "#address-cells"
> +  - interrupt-controller
> +  - interrupts
> +  - msi-controller
> +
> +examples:
> +  - |
> +    apic_mailbox: interrupt-controller@a00000 {
> +        compatible = "kalray,coolidge-apic-mailbox";
> +        reg = <0 0xa00000 0 0x0f200>;
> +        #interrupt-cells = <0>;
> +        interrupt-controller;
> +        interrupt-parent = <&apic_gic>;
> +        interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>, <9>;
> +        msi-controller;
> +    };
> +
> +...
> -- 
> 2.45.2
> 
> 
> 
> 
> 

