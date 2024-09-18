Return-Path: <linux-kernel+bounces-332930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19097C0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0861C213A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E61CB327;
	Wed, 18 Sep 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV2bbYBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593311CBE9B;
	Wed, 18 Sep 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691790; cv=none; b=HA3Sgi9ES0nM/ygxjfch/1JoOyv+rYFgd8a+QE+LA+qCEc0jo4sWtM8mKqLxGGKyyvYMO/ctXQj524tcV5j8v/MEyl95kBkfuEERnppw/e48vERvyuz1R1NQ14dGthRiMbQHZiBlGPFTy+HLf1gn2ZdXH/8II+h8RO5C27sRISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691790; c=relaxed/simple;
	bh=jLXGdlNCFg+BK+lLlFr6ileb70P/yCxiVQtZsN+AUXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICj91/3KJRVS765SRz79od5vyH41VO1CB70P8ev7rHI9Rxt+TPp+XuHDfxdAqX+GpjUJ2y1HEJ6fNfmq88jzeoKBvgnJxzzeAt46HBFUfGmhJkYn2tHm//umVmJYl1BS1QTbYtFYaL6UU0rQzCBnPFCKhU0L7gbDIdwOo4WEJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV2bbYBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA26C4CEC2;
	Wed, 18 Sep 2024 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691789;
	bh=jLXGdlNCFg+BK+lLlFr6ileb70P/yCxiVQtZsN+AUXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZV2bbYBX/93/uV2gwgeZp4D2BYXt/WRbYyl/xATC9j8CgNVw+2Ck1agp4CFaLxUiX
	 wmnp4l1nCcenVzCzXgmsf2n4gr8YkF31K1wPtHGGhXuJJKv8vRnE5ZdqL5HGcJM4YG
	 rA9e+EWsoYW9JrMD2IkUWIA6OEzfAE7CUXGLICuARnltLKZJ1OJaiwcIRigS7TZNUV
	 0UdntAK1CgNzMi0fur4kyJiEDZ0edoBjgyIAbsFhOrp9vEKs88/PuDZ5zHRZeD+8Ry
	 lnkvVYPDzA+dtFaRTWqqqTYdJEy/uLQolMmuOT8kU9M4vtDpiSwn25aX+LJkdW5pCz
	 bmh5aRHEdGXoA==
Date: Wed, 18 Sep 2024 15:36:27 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/3] dt-bindings: mailbox: Add
 thead,th1520-mailbox bindings
Message-ID: <20240918203627.GA2069046-robh@kernel.org>
References: <20240918134901.193033-1-m.wilczynski@samsung.com>
 <CGME20240918134926eucas1p1df23a583b356505939d4c5501bd6c80f@eucas1p1.samsung.com>
 <20240918134901.193033-3-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918134901.193033-3-m.wilczynski@samsung.com>

On Wed, Sep 18, 2024 at 03:49:00PM +0200, Michal Wilczynski wrote:
> Add bindings for the mailbox controller. This work is based on the vendor
> kernel. [1]
> 
> Link: https://github.com/revyos/thead-kernel.git [1]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/mailbox/thead,th1520-mbox.yaml   | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> new file mode 100644
> index 000000000000..f446fae76398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/thead,th1520-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-head TH1520 Mailbox Controller
> +
> +description: |

Don't need '|' if no formatting.

> +  The T-head mailbox controller enables two cores within the SoC to
> +  communicate and coordinate by passing messages (e.g., data, status,
> +  and control) through the mailbox channels. It also provides the ability
> +  for one core to signal the other processor using interrupts.
> +
> +maintainers:
> +  - Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: thead,th1520-mbox
> +
> +  reg:
> +    description: Contains base addresses and sizes for the mailbox and remote ICUs.

Drop. Redundant.

> +    items:
> +      - description: Mailbox local base address
> +      - description: Remote ICU 0 base address
> +      - description: Remote ICU 1 base address
> +      - description: Remote ICU 2 base address
> +
> +  reg-names:
> +    items:
> +      - const: local_base

Just 'local'

> +      - const: remote_icu0
> +      - const: remote_icu1
> +      - const: remote_icu2
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt for the mailbox controller.

Drop description. That's obvious.

> +
> +  clocks:
> +    maxItems: 1
> +    description: Clock phandle for the mailbox controller.

Drop

> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +
> +  icu_cpu_id:

Needs a vendor prefix and s/_/-/.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: CPU ID for the ICU.

Constraints?

Nowhere in this patch is ICU defined.

> +
> +  '#mbox-cells':
> +    const: 2
> +    description: Number of cells required to encode the mailbox specifier.

You need to say what each cell contains.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - icu_cpu_id
> +  - '#mbox-cells'
> +
> +dependencies:
> +  clock-names: [ clocks ]

Core schema already does this.

> +
> +examples:
> +  - |
> +    mbox_910t: mbox@ffffc38000 {

Drop unused labels.

Standard name is 'mailbox', not 'mbox'.

> +      compatible = "thead,th1520-mbox";
> +      reg = <0xff 0xffc38000 0x0 0x4000>,
> +            <0xff 0xffc44000 0x0 0x1000>,
> +            <0xff 0xffc4c000 0x0 0x1000>,
> +            <0xff 0xffc54000 0x0 0x1000>;
> +      reg-names = "local_base", "remote_icu0", "remote_icu1", "remote_icu2";
> +      interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +      icu_cpu_id = <0>;
> +      #mbox-cells = <2>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7331b30deef8..49198b2ed2e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19719,6 +19719,7 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  T:	git https://github.com/pdp7/linux.git
>  F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> +F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
>  F:	drivers/mailbox/mailbox-th1520.c
> -- 
> 2.34.1
> 

