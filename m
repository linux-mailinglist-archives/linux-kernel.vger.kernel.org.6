Return-Path: <linux-kernel+bounces-432795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB449E506C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D279281D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787541D5166;
	Thu,  5 Dec 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUQvwMNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53541D04A4;
	Thu,  5 Dec 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389173; cv=none; b=uCUeSfVgOtG1TMce7gKQACltQsFThddB4e7/WvZgVk2zA+8xW323KF3+29X9vWbaB9EguFzYenzVfdTxOiqJtnsEZupqk+stlzUDL9SpUg9GOfrt/wS89nIxOyTYpog1vLjnVMfIuQQ3ioGvqlUO6O+5mYMc14y1SIIOJLlHulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389173; c=relaxed/simple;
	bh=lAD0H7r9Zo/MaMQfVUNhKvp+1r5Ka3oxbUXiz3DROB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2oBycrYUlctGt0uZCwxddiPqGBmDvWHg8ClWWWfZRLHb/iZk/fDA44PGSi+QzbFNoEgL9/e4BSR7nEfDU8ryVnR1j8VyEBMcU+Xuz9QuLpRzifK2ZZoRfXDBN4mWt637Eyg1Fn+EQe7/qh2m6YWRCf+KnygUNvZmVFFKYZyZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUQvwMNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D11C4CED1;
	Thu,  5 Dec 2024 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733389173;
	bh=lAD0H7r9Zo/MaMQfVUNhKvp+1r5Ka3oxbUXiz3DROB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUQvwMNjzDcm1gAp4xoQV4yL+JEctE+SXiIkys+MqlAWFVWlMlCuc6iCfgjNYKMg1
	 fMRiClgEFcGYvk1F4fLhvUSG0LVqn3BW68epJteQtL/TtKKd8YaFtidFS+dxqlem7H
	 TsWwMrQEQ+ivRSIpaAYEJ8HoAzj5yYvbcPJqbfl1ongVvgZpgwDIW8a7IXIylm8Kh3
	 nNkdwGvLbms6P614vxyJzLWMlvCDgniJODQZK3QJ1AnlcCn5zpbQKp67ol3YiMc5/y
	 zimn+mWChaIvOwNR+Hl5mbzcyVWB9ygqluBYiUKSUcxO0Jx/IBEEU/V47RmjUCj9rF
	 6vVFNT9X9iPDw==
Date: Thu, 5 Dec 2024 09:59:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, V.Sethi@nxp.com, 
	meenakshi.aggarwal@nxp.com
Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: imx: add nvmem phandle
Message-ID: <vxe5ml2zwg2kg5ui2mz4ws2mc3fj6whvnvvft3x6ezr7fhkdrd@ipghbtncp3en>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
 <20241205-secvio-v4-1-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-1-5c37cdc39573@nxp.com>

On Thu, Dec 05, 2024 at 05:56:32AM +0100, Vabhav Sharma wrote:
> nvmem phandle is required by secvio driver to
> read fuse.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> index 557e524786c2..c88d9c2dac24 100644
> --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -112,6 +112,9 @@ properties:
>            - const: rx2
>            - const: rx3
>            - const: gip3

Unresolved comment. I would normally add conditional ack, but this is
second time you ignore comments, so I don't trust you on that. Sad that
such trivial things will require respin.

> +  nvmem:
> +    description:
> +      phandle of NVMEM controller provided by the SCU

Best regards,
Krzysztof


