Return-Path: <linux-kernel+bounces-406241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD29C5C85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE5E281AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F6205AA8;
	Tue, 12 Nov 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/j+Kb/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5C20515A;
	Tue, 12 Nov 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426763; cv=none; b=Z64Ru4mqiKrc370Ft0ShSrRZks4AcF4rInlOAzM4Hh25q5ovVdJPV586/HHjnJPYVt46t/la2SrskLpK4IiAh7OcLmTHJ+NwR6fL3KeJBS9ks+X9xnROqtlmOahuMMulJ/hNDnbiq9wlJfLf5hOzgUezYmaEjRSvBiUxqWYENvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426763; c=relaxed/simple;
	bh=UUY+nywhlA43k/CT1WVs+YWMQzL1KhT46qsg2zq7Pt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOGByJ7SgzKYFu39elY7GTh1JFcTJbUTwBPY0PhvU9Vgli8rGd8S9fIqRRO2wmwaBJh+KPbb6NwxGjkGcCsZEVEAJRbuT1d9RhC4wqHwIyZ0uPuuBoQ56cLKlLADholTynjJDxh3QR8CRdIoSf+YBkZkOSyfQPFA6+9rB7A8gKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/j+Kb/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696A3C4CECD;
	Tue, 12 Nov 2024 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426762;
	bh=UUY+nywhlA43k/CT1WVs+YWMQzL1KhT46qsg2zq7Pt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/j+Kb/2M4dJzUGNMWXrPoEFn6ylMpxOwLOCsnnO/sLBVKjbq9TXkyz0e9ZClH9II
	 6UM16398+R2QDuW9Y5JtGYBnLqZdDZwS9JH1QDFFKWKjmFdrZK2VF84iGrhUvvnGBs
	 GNMHUTZmJHCAaSLQhxDCkh5FU6JEFRxkJaWmS/ZMYXkgYYAqcPIkH1E0ukZQs8g4eB
	 ORBrbraQB/3fALkdHuYs+6ebYpf2U8PzL27LJddgQ2zeRFJ8cdIDoJralEGss4PkT5
	 RoyQrdi/+0pisr8Dd4GGKlSNk8HtBMVjfG+tPtP/bW2eKKiD5NHnBCX9pgoCREwx5c
	 JP5x2UI+Y81ew==
Date: Tue, 12 Nov 2024 09:52:40 -0600
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, tglx@linutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042
 MSI
Message-ID: <20241112155240.GA956207-robh@kernel.org>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <5186bb9c7feebb87136eb5e5e117fb1142dba4c2.1731296803.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5186bb9c7feebb87136eb5e5e117fb1142dba4c2.1731296803.git.unicorn_wang@outlook.com>

On Mon, Nov 11, 2024 at 12:01:36PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 MSI controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../sophgo,sg2042-msi.yaml                    | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> new file mode 100644
> index 000000000000..9fe99b74c211
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 MSI Controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description:
> +  This interrupt controller is in Sophgo SG2042 for transforming interrupts from
> +  PCIe MSI to PLIC interrupts.
> +
> +allOf:
> +  - $ref: /schemas/interrupts.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-msi
> +
> +  reg:
> +    items:
> +      - description: clear register
> +
> +  reg-names:
> +    items:
> +      - const: clr
> +
> +  sophgo,msi-doorbell-addr:
> +    description:
> +      u64 value of the MSI doorbell address
> +    $ref: /schemas/types.yaml#/definitions/uint64

Why not use a 'reg' entry?

In any case, this should be a translatable address (i.e. honor 
#address-cells/#size-cells and ranges).

> +
> +  sophgo,msi-base-vec:
> +    description:
> +      u32 value of the base of parent PLIC vector allocated
> +      to MSI.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 64
> +    maximum: 95
> +
> +  sophgo,msi-num-vecs:
> +    description:
> +      u32 value of the number of parent PLIC vectors allocated
> +      to MSI.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32

Use 'msi-ranges' for these.

> +
> +  msi-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - msi-controller
> +  - sophgo,msi-doorbell-addr
> +  - sophgo,msi-base-vec
> +  - sophgo,msi-num-vecs
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    msi: msi-controller@30000000 {
> +      compatible = "sophgo,sg2042-msi";
> +      reg = <0x30000000 0x4>;
> +      reg-names = "clr";
> +      msi-controller;
> +      sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
> +      sophgo,msi-base-vec = <64>;
> +      sophgo,msi-num-vecs = <32>;
> +      interrupt-parent = <&plic>;
> +    };
> -- 
> 2.34.1
> 

