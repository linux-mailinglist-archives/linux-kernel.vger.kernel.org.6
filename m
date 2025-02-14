Return-Path: <linux-kernel+bounces-514614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E19A35950
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6413A4ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDC227BA6;
	Fri, 14 Feb 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcKuSoQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F671189B9D;
	Fri, 14 Feb 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522941; cv=none; b=PgUDEcuSDal5XlNCcXn2whkaghZC5dmgZlekwevm/cbvNEGC4NvZQH8X55tOc2l4H+hO5iLhpwpj99K0gGFqoAjRiyh6w69GYbyP0Sje0xAhmhZBVLoSO29yZHy1f2FKyQXrUOtTGkOahpsOp+mA8IKTdrhB2j+HEYBNnRKT7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522941; c=relaxed/simple;
	bh=WmV04MPnFaon6zaZ8p5gO3YrG+dbYIloJXb1/ltHrvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGM8jJ7Un3Q+t2H39e75S4KLXhkp1gFqZ2mLRplV6WOEJSSb6Ip1Ux40TqwM2JHwHUe7K/Zt+1ing4tV8QNr0griy8NZiKOK9cXKL7Mjoun0JuWoSKM3MDKLFH9JBnWAoJ+6hGj6xCfiGh+K+RuLaZPzuR3mT23tyIDaIAyro6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcKuSoQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9C2C4CEDF;
	Fri, 14 Feb 2025 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522940;
	bh=WmV04MPnFaon6zaZ8p5gO3YrG+dbYIloJXb1/ltHrvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcKuSoQNuodvlie1cZdUqIFzaaz4Q+bElNQWC7V87q21/j9UNBbO7qdf36O2kDMGi
	 VlNzxWxCoConcVaj3v5pdyvA5QyV/g0a9qz6NiqJ1+xj9Afzv7rFWoGkxHDt7Z0TGm
	 gv+bfLlN32A6o/i724hWn1qWHp8OkA4eJfpkwQJF3qQ9p3MGdfZKYvKVfZgNjrQfE2
	 +q82AMksdN4ALr/a8EJk8i/JNXWKkDAW6W+0weh4ajDYQnQCH2jMJOX0MK++9ib6ne
	 IILl4Zaac8D8Pw/fqPN6KWGNSOQozr4v1lsqCvhu1uKH31z28IzDMdP/ALfFE/JTzR
	 wmAEGxSg2pK5Q==
Date: Fri, 14 Feb 2025 09:48:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH 4/4] [PATCH 4/4] arm64: dts: marvell: cp11x: Add reset
 controller node
Message-ID: <20250214-famous-rainbow-pig-d4bd3b@krzk-bin>
References: <20250214065833.530276-1-dingwei@marvell.com>
 <20250214065833.530276-6-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214065833.530276-6-dingwei@marvell.com>

On Thu, Feb 13, 2025 at 10:58:33PM -0800, Wilson Ding wrote:
> The unit soft-reset configuration register is part of the system
> controller register.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 161beec0b6b0..b82003df15e0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -273,6 +273,12 @@ CP11X_LABEL(gpio2): gpio@140 {
>  					 <&CP11X_LABEL(clk) 1 17>;
>  				status = "disabled";
>  			};
> +
> +			CP11X_LABEL(soft_reset): soft-reset@268 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Usually: reset-controller

Best regards,
Krzysztof


