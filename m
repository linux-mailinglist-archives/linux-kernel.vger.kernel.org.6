Return-Path: <linux-kernel+bounces-510624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D37BA31FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22703A9894
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A73D201002;
	Wed, 12 Feb 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxMC7bO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600C20103F;
	Wed, 12 Feb 2025 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344147; cv=none; b=G4x2uASn4fzz8upx/arvnVft+wNMf9Iz4VTQF/XHykkWBoVE8ZPMY4lRwUGF+l6t3qR8ggvcyNqOSMnKnY5V6IsTVRxHeu3yNdnIUDWc5EEzbgysBQvhAOPZNeDSp0ddWr+deg29jpikPH/6RxrH8tFQkQzT0EFOSbEpBCencVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344147; c=relaxed/simple;
	bh=dO8kQ7f4GRkQ9UG4gm8xbzd7RbRvjodzFGlo41ASAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jETrdbs3p4bKbqVwr3wS3s3mXVqWykdlsdHF03FFusJazF9V288fKr2LgyTVsfQZtrOsuwB38d+Yy7Xkr5TpZD9lEEVchY9+1tbWQw6vTuIIv+ZBiCPnkXX5G+J1QEftf7fmrcQAPOCnWyji8hhQcVaVDptHiOEOJKdYGn3RMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxMC7bO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E511C4CEDF;
	Wed, 12 Feb 2025 07:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739344146;
	bh=dO8kQ7f4GRkQ9UG4gm8xbzd7RbRvjodzFGlo41ASAc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxMC7bO7N6u0XwMUb5QrqxgoSU1vY8QiHAuHpKGQlNLGEgazP0nkYCVD1P6jPBGFl
	 M2HCoXFPMJLufIcaSvxgbi02EXEKeLNOj53NP3qThZlhwifSxFMKn/aUVf50ClDxJk
	 mresRF3ejV5XzIcfZJHoMqhWeM7d1gXOhDuuwiY4XTY64/rohsI7nb2EBukFCeLAYa
	 MtYVtnHE5HwAl/LO3bWS2jl3ghnl7IOW1XFKNA0kDNX7iF+JH/mRJKHoo8c9v47YXq
	 Mi3oqXgf6D9qiAopYo3jmQewqHR80nX1e7x+MP12dNEdF7jvuebFx4Ek309piv1Zl8
	 xrTZBNRfL1TfA==
Date: Wed, 12 Feb 2025 08:09:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Message-ID: <20250212-stalwart-sambar-of-satiation-4845dd@krzk-bin>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211225808.3050-2-laurentiumihalcea111@gmail.com>

On Tue, Feb 11, 2025 at 05:58:06PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add binding for imx95's CM7 core, used for audio processing.
> Additionally, introduce a common binding for NXP audio processors with
> Sound Open Firmware (SOF) support.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 +++++++++++++++++++
>  .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


