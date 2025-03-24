Return-Path: <linux-kernel+bounces-573978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82DA6DF34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4123A7C27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD24261584;
	Mon, 24 Mar 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYwYfGSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E51CD1E4;
	Mon, 24 Mar 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832156; cv=none; b=ijQA8rdP2GDTQmzrUHSjo0fAJwVtm7HINBEGozSO3MEC93VX04mYvNb7Ikz9hbApAEyNLyO/Gbplq4M0gNzg54eCl5L7MdwknvRbJFKSDBjafcoTm30BpbNCMPAQtsxrkZtkQTAQc+HOJhVvPIvuqVxsfLsa4XViBK450w3aCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832156; c=relaxed/simple;
	bh=lO70/EyOTHsSUCsToe3wwdpu/s9KqX41Qnit5o85758=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V42JDEuTS1kfuPMLiVOnuz57rRzB//JemqB80UurZKDon6g2T11K4JtJz/ZvPHWVtzikWTJ5RLXQ80HfK3dNDTESqzU1OsJHjDFxqgeMe2Nt97jjKnq+mVeZVCxBpKi9cd6Hr1sRL/2pk6i5lyf5AUjBYVVcpGl0IkEvfBtmdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYwYfGSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EC6C4CEDD;
	Mon, 24 Mar 2025 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832155;
	bh=lO70/EyOTHsSUCsToe3wwdpu/s9KqX41Qnit5o85758=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYwYfGSZVzY31upbyL96Mn2jcC6wRm9sskzWthKcQ05zB6hH9VZVivy37hpuecwwl
	 xc2cFdT2vZ5M7IjIYVJ6TZuD6OUHfwsb26FmHK6iijmHFu2rBYCrdXeACBHEqImCbu
	 OH06I7Goiyrr9tiCwAvThh7vEAbwwHqzkhjTRWGsDcDJ0Jhr/y6cL6cEme8Wz8+/pO
	 Yqe5AYNV3x7zfSs1n3TOg8GMJluf8wXbd9OiiqYwdjq0lhiy93wOFoWpfycs8xnFL0
	 5XqidcdArCoZQE38NAu06CxseJ9qKIeK02KWZG/Sk34UbSU9a6zm2heVsfXUyDqjPY
	 ew4royVay7aKw==
Date: Mon, 24 Mar 2025 11:02:34 -0500
From: Rob Herring <robh@kernel.org>
To: "paul-pl.chen" <paul-pl.chen@mediatek.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, chunkuang.hu@kernel.org,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com,
	nancy.lin@mediatek.com, singo.chang@mediatek.com,
	xiandong.wang@mediatek.com, sirius.wang@mediatek.com,
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 05/15] dt-bindings: display: mediatek: add OUTPROC
 yaml for MT8196
Message-ID: <20250324160234.GA113887-robh@kernel.org>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
 <20250321093435.94835-6-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321093435.94835-6-paul-pl.chen@mediatek.com>

On Fri, Mar 21, 2025 at 05:33:34PM +0800, paul-pl.chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> Add mediate,outproc.yaml to support OUTPROC for MT8196.
> MediaTek display overlap output processor, namely OVL_OUTPROC
> or OUTPROC,handles the post-stage of pixel processing in the
> overlapping procedure.
> 
> Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,outproc.yaml    | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,outproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,outproc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,outproc.yaml
> new file mode 100644
> index 000000000000..f42e9abc1436
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,outproc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,outproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek display overlap output processor
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  MediaTek display overlap output processor, namely OVL_OUTPROC or OUTPROC,
> +  handles the post-stage of pixel processing in the overlapping procedure.
> +  OVL_OUTPROC manages pixels for gamma correction and ensures that pixel
> +  values are within the correct range.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8196-outproc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        disp_ovl0_outproc0: outproc@32970000 {

Drop unused labels.

> +            compatible = "mediatek,mt8196-outproc";
> +            reg = <0 0x32970000 0 0x1000>;
> +            clocks = <&ovlsys_config_clk 49>;
> +            interrupts = <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH 0>;
> +        };
> +    };
> -- 
> 2.45.2
> 

