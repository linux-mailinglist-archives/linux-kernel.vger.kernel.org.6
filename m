Return-Path: <linux-kernel+bounces-354115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B618A9937F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD121F21D40
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982071DE4D8;
	Mon,  7 Oct 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgAVRmHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C861865FC;
	Mon,  7 Oct 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331755; cv=none; b=AkWLqs1sXp3WSVzqBd4Srf+Q050E8003aXuZRitJYmwyFT7c5FipQXlvOEE/Ef0mD3Y9ZxIVIl1CoJo702UGr2PnOovWKGwbi65ZlskDgwgj7qAH+p9WAslYwqbRfd8ghjWSmpNrKB1HTNPYvmxUVUTIVNiXLNPRpqA346oAT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331755; c=relaxed/simple;
	bh=AZgOXjS5qYlwsu6tp81KFVorld8zA1+s4cgFUkR1EJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxbQKKD1lpkJtom7NbqRfBJAZBMd75kZvtC+0gcZiXA9OiJsiZ9H19PhyUAs/dageG9KW43zm/ZSqeqlKgRLsA5Nh7ZDnL6HN6pvYcHk+KwpdRnSgDidInXzZpmAn1OjQnvA/l29IcmSp2BjrZ20arIJIMAP7AuPKUUaDI4Ie4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgAVRmHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D24BC4CEC6;
	Mon,  7 Oct 2024 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331754;
	bh=AZgOXjS5qYlwsu6tp81KFVorld8zA1+s4cgFUkR1EJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgAVRmHOxcDWny0Hnv2w5a+yWOr7jlxL23RtpwRZd7uJHjrTidbkGxnZScfDCUnNQ
	 g+4cONt4TSs4+o6Ulmn/BFjnB8W2Bjigf56P7iWrlHjuEnB74SH2tjCosZERvCq59a
	 /noT1zSYOWbCU9VFjtm9gfUrPpZ0Z+BIR7drPi2Hd3nOJXjwM8PeJpM3oghF4k+eiz
	 aWi8uDLo88VI/f6ICZ8nP4SSMeUCvTDm4PSwZfj0vmQQvsi+xZ4WUFqmzGy5HlQ3ei
	 Xt3jjVKTdIqCxRLeZCTAW2LAShCO/o0k4NCx9sik/Bg7iwF1OyvsZ8XME0dtq5J8Nn
	 mGViFB/brrMlQ==
Date: Mon, 7 Oct 2024 15:09:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	imx@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq:
 workaround wrong interrupt-map number
Message-ID: <172833174920.2317928.5857318488649665401.robh@kernel.org>
References: <20241007161823.811021-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007161823.811021-1-Frank.Li@nxp.com>


On Mon, 07 Oct 2024 12:18:23 -0400, Frank Li wrote:
> The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> function to parser interrupt-map. So it doesn't consider '#address-size'
> in parent interrupt controller, such as GIC.
> 
> When dt-binding verify interrupt-map, item data matrix is spitted at
> incorrect position. So cause below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
> interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
> is too short
> 
> Remove interrupt-map restriction to workaround this warning for
> 'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
> Other keep the same restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - remove interrupt-map restriction according rob's suggestion.
> Change from v1 to v2
> - remove duplicate function in commit message
> - only reduce miniItems for after 1088a chips
> - maxItems change to 9. Otherwise report too long.
> ---
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 

Applied, thanks!


