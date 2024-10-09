Return-Path: <linux-kernel+bounces-356347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FED995FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1761F22D56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5D156960;
	Wed,  9 Oct 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9lBn07f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1131DA5F;
	Wed,  9 Oct 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455465; cv=none; b=SIZd9bowDTSSIdzdAvjSp6q18e1zOqt+SNWYVGN8SNqCeOy2Ra+VpGxgWC9NWh7XFOJXa4k5GmtLYDl/t27eh/bhV53PQO0hKZlEaVU2uT5Go+T2lBXfKekOHNdXvPfH4abfGoQqsRTciGJaU8TFAHyuIzeTfmNXi+Az0ZYY6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455465; c=relaxed/simple;
	bh=i5bI9bYBkdQtiuRREOvIQVOmYuxX3Or8TeWiSNQvLek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghx3MiJatEQ4DogbpNuxlcxpCTywgfnhYF8UFZYV/Z3MxF6RXRtNjFwkiT7eBlTSFPLZYS6c8XG9IC0uT4PrvWT2X5IyAx4ZjmwMO0Qh5r12wESZfux7Yg895k8wjP3ja5/0M4oBuBBmazDoLmttthBtFffAYHfuIpn21eVScxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9lBn07f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B21C4CEC5;
	Wed,  9 Oct 2024 06:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728455464;
	bh=i5bI9bYBkdQtiuRREOvIQVOmYuxX3Or8TeWiSNQvLek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9lBn07f2sVThjU5dMuOej0wAHVmWtRyI5nznSG1d0T+TmpWyWSKbs7hgnLA5gCiG
	 LnXsSpI4RC8XuuFTDLaWoNPXtkkncgv/9+NC1EZP02EZ2W0DYTwCsWxFU/IonMq3OJ
	 VzldIDoP/cfv8FDXyCGNLwbDoc3UqoviBTLDowTkyxrIyUPymHRrnUalHcdMxF1/E2
	 ouZaQTl42QxjLs8IPR85ZQqNegQkP/q4LNUudsWH9Lg1LezYW2QWigEgdPUC1Me1+z
	 XzeTs/PL2OU6/XQM19G4TXykzS0xvKyJc1wXHoX+rXDFsYK2beQ+B/SCCEEoOSe+Kk
	 UrPW0h+0DSV4g==
Date: Wed, 9 Oct 2024 08:31:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, 
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	m.szyprowski@samsung.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: mailbox: Add thead,th1520-mailbox
 bindings
Message-ID: <sknianfahozghrk6tdmcwxbbi6mixgw3y4vskzucga7r7hkfjz@yschcrxbbwm5>
References: <20241008174852.222374-1-m.wilczynski@samsung.com>
 <CGME20241008174909eucas1p1b34518ef9a643313d41349f476f0659a@eucas1p1.samsung.com>
 <20241008174852.222374-3-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008174852.222374-3-m.wilczynski@samsung.com>

On Tue, Oct 08, 2024 at 07:48:51PM +0200, Michal Wilczynski wrote:
> diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> new file mode 100644
> index 000000000000..32c265f39c29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +

If there is going to be new bersion, drop blank line.

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
> +  '#mbox-cells':
> +    const: 2
> +    description: |
> +      Specifies the number of cells needed to encode the mailbox specifier.
> +      The mailbox specifier consists of two cells:
> +        - Destination CPU ID.
> +        - Type, which can be one of the following:
> +            - 0:
> +                - TX & RX channels share the same channel.
> +                - Equipped with 7 info registers to facilitate data sharing.
> +                - Supports IRQ for signaling.
> +            - 1:
> +                - TX & RX operate as doorbell channels.
> +                - Does not have dedicated info registers.
> +                - Lacks ACK support.
> +
> +additionalProperties: false

If there is going to be new bersion, this goes after required:, just
like in example schema and all other bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


