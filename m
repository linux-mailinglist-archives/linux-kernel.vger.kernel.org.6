Return-Path: <linux-kernel+bounces-342247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DD988C80
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B12283680
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEA1A01C4;
	Fri, 27 Sep 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZBsGNZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650A16F909;
	Fri, 27 Sep 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476348; cv=none; b=G3XvEE9FSMCVCf8IN7h+fDmmXseBbP2yUdYYRegagUPEH4mxcAE7bDSUXT4g3jj00yU/EOCbd4at6yN1t5R8AZ2B5S1Gge6UHyIpXP9ZYOOIxcIKeLcfMhyE4QyLUF8DjOgsPuf1JdYYnSdMTzu7fFoE+zB7jobSHKBvUUY3MxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476348; c=relaxed/simple;
	bh=saH4LjPEzRLlPysFm5GNlLBTMwG5yytpd3WGfVUXEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scLeQOHxzkUagEK5WtnICaLA4eO9P8KiauxRjv5eS7AXlluVnSHQc5NkQDOLlrGQ4KYQK9o+gfLwOp7n9pDCKsgKUsuleQCalAlMsMAcvxDTLLQeaX7xCp9HUTMlx+pNk24uhaFydEFZgGR9jc0xpphawdqg5SPJ9lPPs1KoKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZBsGNZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D40C4CEC9;
	Fri, 27 Sep 2024 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727476348;
	bh=saH4LjPEzRLlPysFm5GNlLBTMwG5yytpd3WGfVUXEyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZBsGNZuq9MB/AGCvy2dlV0PCwMC6bCDrwHmdtoqUwW9glT8YLYabhE+3KvBu8TFD
	 wXl0EIkmZw6cJL8G9pYJUpYFXHWuMaNjhJDXBmVFv7fhufOGFlFGGLOIFDfXgErAUu
	 OPrd35dCrJl7dG1qoMcD//EtqCgVCjahvHh7aA4MwfWsNQdJCoKLVc+LqtF2GJFBCu
	 7Gc9JesiDOU+R7KQCHluFcTaH0EJzgugNgfmqpaA673/IpXt21sZu7jnMiV8cXtQLb
	 F4mDHCOxEz09IvMTUlKFz+zLggOrvodQG5sJFItec4dAhoYoz+x6JvYTEAMl2AzoPj
	 tVWbiyzwa8yjA==
Date: Fri, 27 Sep 2024 17:32:27 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/3] dt-bindings: mailbox: Add
 thead,th1520-mailbox bindings
Message-ID: <20240927223227.GA152909-robh@kernel.org>
References: <20240927094207.1650085-1-m.wilczynski@samsung.com>
 <CGME20240927094215eucas1p1be4d58084ff19e47450dcad3e6da5f5e@eucas1p1.samsung.com>
 <20240927094207.1650085-3-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927094207.1650085-3-m.wilczynski@samsung.com>

On Fri, Sep 27, 2024 at 11:42:06AM +0200, Michal Wilczynski wrote:
> Add bindings for the mailbox controller. This work is based on the vendor
> kernel. [1]
> 
> Link: https://github.com/revyos/thead-kernel.git [1]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/mailbox/thead,th1520-mbox.yaml   | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> new file mode 100644
> index 000000000000..b517d0c6eb12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/thead,th1520-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-head TH1520 Mailbox Controller
> +
> +description:
> +  The T-head mailbox controller enables communication and coordination between
> +  cores within the SoC by passing messages (e.g., data, status, and control)
> +  through mailbox channels. It also allows one core to signal another processor
> +  using interrupts via the Interrupt Controller Unit (ICU).
> +
> +maintainers:
> +  - Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: thead,th1520-mbox
> +
> +  reg:
> +    items:
> +      - description: Mailbox local base address
> +      - description: Remote ICU 0 base address
> +      - description: Remote ICU 1 base address
> +      - description: Remote ICU 2 base address
> +
> +  reg-names:
> +    items:
> +      - const: local
> +      - const: remote-icu0
> +      - const: remote-icu1
> +      - const: remote-icu2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  thead,icu-cpu-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

Don't need '|' if no formatting.

> +      CPU ID associated with the Interrupt Controller Unit (ICU). This ID should
> +      correspond to a valid CPU core in the system. The value must be between 0
> +      and (N - 1), where N is the total number of CPU cores in the SoC.
> +    minimum: 0
> +    maximum: 3

The normal way we associate a node with some subset of CPUs is the 
'cpus' property linking to the CPU node.

Or is this CPUs which are not part of what Linux is running on (i.e. the 
SMP cores).

> +
> +  '#mbox-cells':
> +    const: 2
> +    description: |
> +      Specifies the number of cells needed to encode the mailbox specifier.
> +      The mailbox specifier consists of two cells:
> +        - The first cell is the destination CPU ID.
> +        - The second cell is the mailbox channel ID.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - thead,icu-cpu-id
> +  - '#mbox-cells'
> +
> +examples:
> +  - |
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      mailbox@ffffc38000 {
> +        compatible = "thead,th1520-mbox";
> +        reg = <0xff 0xffc38000 0x0 0x4000>,
> +              <0xff 0xffc44000 0x0 0x1000>,
> +              <0xff 0xffc4c000 0x0 0x1000>,
> +              <0xff 0xffc54000 0x0 0x1000>;
> +        reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
> +        interrupts = <28>;
> +        thead,icu-cpu-id = <0>;
> +        #mbox-cells = <2>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df4d7be6cf35..a6028f850a25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19943,6 +19943,7 @@ L:	linux-riscv@lists.infradead.org
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

