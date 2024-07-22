Return-Path: <linux-kernel+bounces-259375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53C9394F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA29E2848D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F731383B1;
	Mon, 22 Jul 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlqbWYa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D923746;
	Mon, 22 Jul 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681439; cv=none; b=d10YLB0H1KYrBTdSF4yFX7Ioudp+3H7OVu4ToxNcqpk2iFVWZiu1t2aNN2mzaW50It+O65HS16J7zOo/IxFTRU1zizwBWAG6QjCieWVFP8RyuASOeUN6zZ1LJAeKc5Vi8Vow0R3reAmJJFWj6dQb+pCw+o2zU5sopztQEhb+q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681439; c=relaxed/simple;
	bh=YP5e3fd82tf3LmHJGycUS/ROzaoPMd6vjQXdqMvKjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiF8QufHsu6u34IVBUmg+rsYZV4WoSO3bhLXsJlxR/temyZ7r7+srI9qURBy6mAMI+v3degHpoQz/2QEyzApfYY4+DGoIYn6QPFXnLKPpiYogKyAntbtfAKHQUwUQKKJEibattu2prxUIu8zDn34RHR3BLiRtfz2UV3NGj+fJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlqbWYa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E084C116B1;
	Mon, 22 Jul 2024 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681438;
	bh=YP5e3fd82tf3LmHJGycUS/ROzaoPMd6vjQXdqMvKjjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlqbWYa1TdDkV+wXA7PdufLGfGmProbYffrfbTxEWC2cE6Tjsuvroc2SMEmNg6MJy
	 KCHnT4W9C/sh3ZWrjx+2bn9fKuWv0mnWsjjadWJ32oagQljSOgu3nhC3AUC6KLHXDZ
	 fWlEtigsBIpeHEQjlN92e5+Eh014f1sMf85LMF9rRbUh/l5xJEVRCMiS1z1fNnbKTZ
	 Ofn9EyUrTZPro5LeLHaVozCPUxbHEQgZUMuEysJy30KqXesOZdeYwakK2FWhKUG+WS
	 PkYXPlGhZyEIQwMsO/1zuVzd23pkf/hSZ1qUFiFtlftsyR+hYKbe0KA6OmcUnuCm5i
	 dMmL4c6wD5GAA==
Date: Mon, 22 Jul 2024 14:50:30 -0600
From: Rob Herring <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>,
	Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 07/37] dt-bindings: Add binding for
 kalray,coolidge-ipi-ctrl
Message-ID: <20240722205030.GA68733-robh@kernel.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-8-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-8-ysionneau@kalrayinc.com>

On Mon, Jul 22, 2024 at 11:41:18AM +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge IPI controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3:
> - fixed bindings to adhere to dt-schema
> - moved to interrupt-controller directory, like the related driver
> ---
>  .../kalray,coolidge-ipi-ctrl.yaml             | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
> new file mode 100644
> index 0000000000000..91e3afe4f1ca5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray Coolidge SoC Inter-Processor Interrupt Controller (IPI)
> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +description: |
> +  The Inter-Processor Interrupt Controller (IPI) provides a fast synchronization
> +  mechanism to the software. It exposes eight independent set of registers that
> +  can be use to notify each processor in the cluster.
> +  A set of registers contains two 32-bit registers:
> +    - 17-bit interrupt control, one bit per core, raise an interrupt on write
> +    - 17-bit mask, one per core, to enable interrupts
> +
> +  Bit at offsets 0 to 15 selects cores in the cluster, respectively PE0 to PE15,
> +  while bit at offset 16 is for the cluster Resource Manager (RM) core.
> +
> +  The eight output interrupts are connected to each processor core interrupt
> +  controller (intc).

It says there are 16 interrupt outputs below...

> +
> +properties:
> +  compatible:
> +    const: kalray,coolidge-ipi-ctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    maxItems: 16
> +    description: |
> +      Specifies the interrupt line the IPI controller will raise on the core INTC.
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 0
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +examples:
> +  - |
> +    ipi: inter-processor-interrupt@ad0000 {
> +        compatible = "kalray,coolidge-ipi-ctrl";
> +        reg = <0x00 0xad0000 0x00 0x1000>;
> +        #interrupt-cells = <0>;
> +        interrupt-controller;
> +        interrupts-extended = <&core_intc0 24>,
> +                              <&core_intc1 24>,
> +                              <&core_intc2 24>,
> +                              <&core_intc3 24>,
> +                              <&core_intc4 24>,
> +                              <&core_intc5 24>,
> +                              <&core_intc6 24>,
> +                              <&core_intc7 24>,
> +                              <&core_intc8 24>,
> +                              <&core_intc9 24>,
> +                              <&core_intc10 24>,
> +                              <&core_intc11 24>,
> +                              <&core_intc12 24>,
> +                              <&core_intc13 24>,
> +                              <&core_intc14 24>,
> +                              <&core_intc15 24>;
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

