Return-Path: <linux-kernel+bounces-416696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62159D48E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B801F22244
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E71BE84B;
	Thu, 21 Nov 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti0bBJev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EF16F288;
	Thu, 21 Nov 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178031; cv=none; b=kmgtRZy9gR0Oi8bvr0ornsogOsMVT8A4KFC54pNODK5+VYZxe82kkOdhJ20mmn0aHZwoC58jzaUUPo2m3wBhpuqNPQoxtPGw3ROYKEyvLUBjMZY4PVlIhmw6jD23AaPOqgiY1tGljDVotXt1zgKiFGGhbhktdfj4EypL2LcbLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178031; c=relaxed/simple;
	bh=UVjC0lCppiZvBvU2+0HigKCKmBE9kV1WjWjDjVRBwE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsmOBjwgHFPQw/NoU4sIn1l++hMj9z0f9x/+koBummgRxCW1vjnPP5J53CDsq4bpu4/mrNXtH+hKdKi4r7KJ897RKyuf34MZE0lFMxl0jYO4l9QpJN0dyD29cWusPsO5+DpTpUYnSzNrqIhDE5DklkSElMlm7IK+fnVCLrRN7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti0bBJev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA7C4CECE;
	Thu, 21 Nov 2024 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732178031;
	bh=UVjC0lCppiZvBvU2+0HigKCKmBE9kV1WjWjDjVRBwE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti0bBJevIFY8qI62pjuK02REqFvaKiofsgncbwXVs1ECJiUdZx+2FdldMx3yV2eJM
	 49Mw7OkthBNxaiCBN0XTKTYtbfC000cv6M7BnVVR5AcbAW3BG0VVMK0jZiCiokhkkz
	 G8BkGJdReMQYF7QjCBr1C7+Hb6lB/aJRoJGHyQxkW9YsanbS7tF+S08FGBh4Wn7Uzy
	 0jAYDuoU9IGt8FS96rGZfSf/dz8W5KFadxGskjscN8viNcD4JazBQmY0Ye/rhmNkM8
	 4M1gnyahkq/dJhizwMva/bbf35uK70qk7Qm0VNaqvqFrb3M/sMNm7ITUHWQbdRmiI5
	 pMFY3qBibpeDA==
Date: Thu, 21 Nov 2024 09:33:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Friday Yang <friday.yang@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: mediatek: Add mt8188 SMI
 reset control binding
Message-ID: <w4vy6wpjdnadpgmjn322wgwqch7udywjidfvmztexxkthiqzxo@uerntotbvr5c>
References: <20241120063305.8135-1-friday.yang@mediatek.com>
 <20241120063305.8135-2-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120063305.8135-2-friday.yang@mediatek.com>

On Wed, Nov 20, 2024 at 02:32:55PM +0800, Friday Yang wrote:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> To support SMI clamp and reset operation in genpd callback, add
> SMI LARB reset controller in the bindings. Add index in
> mt8188-resets.h to query the reset signal in the SMI reset
> control driver.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>  .../bindings/reset/mediatek,smi-reset.yaml    | 53 +++++++++++++++++++
>  include/dt-bindings/reset/mt8188-resets.h     | 11 ++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> new file mode 100644
> index 000000000000..77a6197a9846
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/mediatek,smi-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SMI Reset Controller
> +
> +maintainers:
> +  - Friday Yang <friday.yang@mediatek.com>
> +
> +description: |
> +  This reset controller node is used to perform reset management
> +  of SMI larbs on MediaTek platform. It is used to implement various
> +  reset functions required when SMI larbs apply clamp operation.
> +
> +  For list of all valid reset indices see
> +    <dt-bindings/reset/mt8188-resets.h> for MT8188.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8188-smi-reset
> +

Where is MMIO space?

> +  "#reset-cells":
> +    const: 1
> +    description:
> +      The cell should be the device ID. SMI reset controller driver could
> +      query the reset signal of each SMI larb by device ID.
> +
> +  mediatek,larb-rst:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Ah, here it is? No, that is not how you access device MMIO. Use reg
property for this. That's a gross misrepresentation of hardware.

Best regards,
Krzysztof


