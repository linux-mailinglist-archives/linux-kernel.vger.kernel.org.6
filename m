Return-Path: <linux-kernel+bounces-174173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C08C0B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FA5284C33
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55C1494BF;
	Thu,  9 May 2024 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u65x0Dyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED514900A;
	Thu,  9 May 2024 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234030; cv=none; b=mlxU89exkhM1r6oU1q0YCFo5AN5H4kmFgt7v6eg5NU5lyrFoO9pGhw2UtHrf93bUD2zosOhE15qikQSWLe4DPALj+cKs2Tjq8EiJ9pMgY5S9jrQDscNpMiG4Vt2zldWVe4ip14xriW5WmVYKBQWO6VbV8K2DJzfXGn95p949Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234030; c=relaxed/simple;
	bh=nUxDYR94Olupa1Zo0d7qXT5PpHsBib40UnrN6ICzzx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGkcvMzJRP+938ORcBNCaNN8yGYy6GGqYo6CbGJEhCF9A/8W4HPBDyhU8sB6ya7sGxR+Uw68j2ou5Pvj6aT6QCh3XTRZP+Q2fpQeCdEizJOmCwEoz+iZy2HJFLiHLciNyxMHMeBQmTR+CzktRHnOCqdSBB72rDHK+6HugT4MbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u65x0Dyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E74C2BD11;
	Thu,  9 May 2024 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715234030;
	bh=nUxDYR94Olupa1Zo0d7qXT5PpHsBib40UnrN6ICzzx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u65x0Dyrpl3LrMYvbjuPFSCh3Ujw5TOu8wcotWnjrweAqHXG7+pIly002g8PAwYBs
	 S8o6aaZ6cuZKk1YM7mFy89Vj9k0j4US8LxT48sP8U4SejCWB5vD+0D74/oTwzvOo1k
	 PuUrE0dLifZUTxOvpevaNez5TCHQO/lRaZnx+9oq+b+tJTuQ18OymnMv+3m+uv5Mrw
	 P9fBedwdgf6Xe8iUa3Myk1RhabMkabvPfLRRG6EYJlx2has9k+MSFHR8alS90wunJZ
	 /g97J1OKvtX4ULJRDcbcn+3APk913M8eVThXM5aN8IlDhavhX9EhXKP5Ovri4f0E91
	 Edwe1V0Ax7b5w==
Message-ID: <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
Date: Thu, 9 May 2024 07:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
To: Vabhav Sharma <vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Franck LENORMAND <franck.lenormand@nxp.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com, daniel.baluta@nxp.com
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 02:45, Vabhav Sharma wrote:
> Document the secvio device tree bindings.
> 
> The tampers are security feature available on i.MX products and
> managed by SNVS block.The tamper goal is to detect the variation
> of hardware or physical parameters, which can indicate an attack.
> 
> The SNVS, which provides secure non-volatile storage, allows to
> detect some hardware attacks against the SoC.They are connected
> to the security-violation ports, which send an alert when an
> out-of-range value is detected.
> 
> The "imx-secvio-sc" module is designed to report security violations
> and tamper triggering via SCU firmware to the user.
> 
> Add the imx-scu secvio sub node and secvio sub node description.
> 
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

That's not v1, right? What changed? Why do we have to guess this?

This is thoroughly documented in kernel process so read the
documentation before posting.


>  .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35 ++++++++++++++++++++++
>  .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> new file mode 100644
> index 000000000000..30dc1e21f903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-secvio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Security Violation driver

Bindings are for hardware, not drivers. Describe hardware.

> +
> +maintainers:
> +  - Franck LENORMAND <franck.lenormand@nxp.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Receive security violation from the SNVS via the SCU firmware. Allow to
> +  register notifier for additional processing

Notifier? That's a Linux thing, how does it relate to the hardware?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-sc-secvio

Missing SoC compatibles.

So no, that's just abuse of DT to instantiate driver.

NAK. Drop the binding.

Best regards,
Krzysztof


