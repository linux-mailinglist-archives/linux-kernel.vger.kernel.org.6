Return-Path: <linux-kernel+bounces-547305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919FEA50588
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282DC7A3B52
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3091AC44D;
	Wed,  5 Mar 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjjbyQHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156E1A5BBF;
	Wed,  5 Mar 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193190; cv=none; b=sKO1ptEoDUIgnCXIFOBAAyM09377+7zhJxRqoTkfV7jeqPrzxsTggTzYmzOmMMUAsKyPy+rRhjHg2mEY67DDIH7cjG5Wi7qJPMuQDNbncMxl1VknK43gWngYDGB6K4EHsXEQ8X/tKS1G/Ns1L+y0743h5f85/UD8Aw4X3UdiIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193190; c=relaxed/simple;
	bh=5R+bfCWSs0CHr+4SSHK1pIvtQQhw4GPWfj0W69fAkXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLVDeivjKpEyMyDGcQ9LnqvfxmbpfSYDMWLb/3d+0OoPROZBwJCF5WXQNGmKKJoSjTavQJWhEWNoBZlzaOZ8yH8j7TunPMyncA4V3f82JtVIFvwRutKvneqRcTecX3xTYgXdEF5vvOzk6UgRak32U1+rIxjjPQ3e/JvGOMI8AJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjjbyQHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80768C4CED1;
	Wed,  5 Mar 2025 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741193189;
	bh=5R+bfCWSs0CHr+4SSHK1pIvtQQhw4GPWfj0W69fAkXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjjbyQHSEB3yA22fSpVSJRaEeGXTbXrmkP5/dCpYJnECMFDRectCzrJEh7nPQgMbJ
	 /QWKDpAXRo8VKVQvNvwhypmWNoyb5v8Z2WgolFKvD6ULWtEeSOIyrAYb79XorXJtGk
	 XiOMotXGo5WZO9WZzcA8S8c7D3gbgMFvV2ej1DJW1FF3KOCuld8iLldC1Wrch0M2Vf
	 kRnb2p4pNr3WYUqbmg/ZmWHmRsGmwUnZmEOiQy7YSAPTuJgemH4vXPXvjfdeB+Eijl
	 UcNJdISBztpd9R7sw8tuXb6GGIRlYIaOcxtQ/gKvFwn8xqzK/C+DxsvN8R9d4+ps/r
	 5Z9gQFbpix4gw==
Date: Wed, 5 Mar 2025 10:46:27 -0600
From: Rob Herring <robh@kernel.org>
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Jason-ch Chen <jason-ch.chen@mediatek.com>
Subject: Re: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Message-ID: <20250305164627.GA2117924-robh@kernel.org>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
 <20250305082047.15746-4-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305082047.15746-4-jjian.zhou@mediatek.com>

On Wed, Mar 05, 2025 at 04:20:40PM +0800, Jjian Zhou wrote:
> This patch adds document for mediatek vcp mbox.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  .../bindings/mailbox/mtk,vcp-mbox.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
> new file mode 100644
> index 000000000000..d5afe295af14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mtk,vcp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Video Companion Processor (VCP) mailbox
> +
> +maintainers:
> +  - Jjian Zhou <Jjian.Zhou@mediatek.com>
> +
> +description: |

Don't need '|' if no formatting

> +  The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
> +  messages through 64 32-bit wide registers. It has 32 interrupt vectors in
> +  either direction for signalling purposes.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-vcp-mbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    vcp_mailbox0: mailbox@31b80000 {
> +        compatible = "mediatek,mt8196-vcp-mbox";
> +        reg = <0x31b80000 0x1000>;
> +        interrupts = <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #mbox-cells = <0>;
> +    };
> -- 
> 2.45.2
> 

