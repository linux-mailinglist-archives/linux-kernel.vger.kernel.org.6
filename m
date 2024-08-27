Return-Path: <linux-kernel+bounces-302685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D106F9601D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E697B212FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CD1448E0;
	Tue, 27 Aug 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6C41AYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466A179A8;
	Tue, 27 Aug 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740582; cv=none; b=uZI1DiDNsPV+DDzmq3cNMafJawVnGTBdwuAwP8PbJoBNirOq/9xQSJTYtq3qPZDpUn6KB9LiWQyFXoFeKVyirbugA2JP+f76IdEY36o7S3FeEqBrbsRDOrcHbyfGAnIX36nKoKa4bcigW+VYWy/kRu7ycu191YIHThRXw7+v/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740582; c=relaxed/simple;
	bh=kkYDRMWnwlNvBj7xJwsJkj46c/GEIBNjFYmeMKIhngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMpvL0sdnsJDWkNV0ytlmzEOfArU6AfJCOMn+Dm7p5sYgz6nFDW6prvwmqJ5bzGee9wZCIXuSaTepUr22IT4zPda4eev5PVrS+xniRGDfX0EfeheQefbtxXIhACscrW7Y6VpGWq0LGwC7KJnWthAkJTKC4XvvNXxG5yKLz+yxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6C41AYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F98C91B7A;
	Tue, 27 Aug 2024 06:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724740582;
	bh=kkYDRMWnwlNvBj7xJwsJkj46c/GEIBNjFYmeMKIhngY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6C41AYHGrcEhJ2XQJ6C5s2yMwY3XSQBQKRoEl++MpcE5ebWaBbpbxXWOcKUzgdPp
	 1s8epw/Dy156dGAuvOInDzL4Z42y2xYpF0W/Jrb45yme8VJZA0oeYDZl4QyDN2X2O3
	 RqHaT4QzgsbCAnVYwkZnLJhPLBo4LDHms05oJulKkZ/un1vNmzuMqKDvf4Ysn5VU+m
	 nPDKC0KtScwugwVJHRs0/33eAxzQGSNU1iLaPl7LMSd7jE/EJWy6NBz5o7p4WGD4Na
	 pzUPpcyreLuFjKk/0uskhmOCl6NCrKxgoeEV3F+BRV28Q+Ccn9d5Jiq+954F2a6u+n
	 jzBogXgC/OEYw==
Date: Tue, 27 Aug 2024 08:36:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: soc: ti: Add AM65 peripheral
 virtualization unit
Message-ID: <6m4znz74jzktnyjmt2sec3gudr7cij4xax4b27qb5ypcnllely@dw5z576bge6j>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <a167791956834ca40c39acde8a55a1de41809b36.1724709007.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a167791956834ca40c39acde8a55a1de41809b36.1724709007.git.jan.kiszka@siemens.com>

On Mon, Aug 26, 2024 at 11:50:02PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU allows to define a limited set of mappings for incoming DMA
> requests to the system memory. It is not a real IOMMU, thus hooked up
> under the TI SoC bindings.

You still keep developing it on wrong, old kernel (or not using
get_maintainers.pl, but this one seems too obvious so I assumed wrong
kernel).

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../bindings/soc/ti/ti,am654-pvu.yaml         | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
> new file mode 100644
> index 000000000000..fd0f86fa27b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) Siemens AG, 2024
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/ti,am654-pvu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM654 Peripheral Virtualization Unit
> +
> +maintainers:
> +  - Jan Kiszka <jan.kiszka@siemens.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am654-pvu
> +
> +  reg:
> +    minItems: 2

maxItems instead.

> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: tlbif
> +
> +  interrupts:
> +    items:
> +      - description: fault interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: pvu
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ti-pvu@30f80000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

for sure "ti" is not generic. pvu is the device name.

Best regards,
Krzysztof

