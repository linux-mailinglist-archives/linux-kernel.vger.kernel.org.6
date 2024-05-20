Return-Path: <linux-kernel+bounces-183943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CA8CA05B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4892C1C20C50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DB013776F;
	Mon, 20 May 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSCuewc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259354C66;
	Mon, 20 May 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220667; cv=none; b=PbWVvz9uErzBryvIE2FsaRKmoO2fU+px0sKF1NBOPmMY43Ut5PRQasReMEHX7gh1MXdn2SLjR7AjO6UzIOqecwPw+nJRpmHSndg42ZGVuw518gQ0Zs2IxPyQgjQQ1VLkPTMjPPuEz6sT/cx7OV98ZZO7HNRHWktCEicUHGFROEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220667; c=relaxed/simple;
	bh=dgi6/+GHc+2bDbv40ImoR2hfMHO0yKR3AM+UeaGAIVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgmwks3/NEGn+Yps019Pko270fHtXXea7Hsy3UJ3F6czgA7U5GTYOe7Or6LW8/P1FrDBrgAGLFDFLGlY86fgQgjEZ2jj4egNS8Rh+g7n2jAC/+WFb5CS+6x5Pw71CRwe2Dy9SQpNoeX4ItYf67NqtYjMwV34ts/b/bi4zYL9Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSCuewc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B15EC2BD10;
	Mon, 20 May 2024 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716220666;
	bh=dgi6/+GHc+2bDbv40ImoR2hfMHO0yKR3AM+UeaGAIVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSCuewc6ybxi/KY4sHRJnx4zOXUWf8WNft00cf6zgJ8RdUqhMXalqvGVcMySGWzG5
	 zlavp9or63s5Ub98qY4S/Xs/JvBVeVYaApH+4ju5y9xKNP6XtcE6fe4BzEpOvgA9tV
	 ITKAzV02QjLJir2h6IYB2fbFcRCDLMQ/GpF2j4rZRz4Ej/WOfMYEd63LfQl9fujdbm
	 x+C55OMbar6VkCb/zdwLj/rHiKOtXsOsTrqzCwMPbYMNwHybtwWV1gzGmLwuMH+8j/
	 tyUBfxFwOcNvki0mM/yyXDpI58iQWhUv0mU7wS7IkCcRw8jPmgF5GgSqoSQjuG0Wke
	 Aj9k1t5nelv+w==
Date: Mon, 20 May 2024 10:57:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
	Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: panel: mipi-dbi-spi: Add a
 pixel format property
Message-ID: <171622065959.617153.198991768265226176.robh@kernel.org>
References: <20240512-panel-mipi-dbi-rgb666-v2-0-49dd266328a0@tronnes.org>
 <20240512-panel-mipi-dbi-rgb666-v2-1-49dd266328a0@tronnes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240512-panel-mipi-dbi-rgb666-v2-1-49dd266328a0@tronnes.org>


On Sun, 12 May 2024 17:25:38 +0200, Noralf Trønnes wrote:
> The MIPI DBI 2.0 specification (2005) lists only two pixel formats for
> the Type C Interface (SPI) and that is 3-bits/pixel RGB111 with
> 2 options for bit layout.
> 
> For Type A and B (parallel) the following formats are listed: RGB332,
> RGB444, RGB565, RGB666 and RGB888 (some have 2 options for the bit layout).
> 
> Many MIPI DBI compatible controllers support all interface types on the
> same chip and often the manufacturers have chosen to provide support for
> the Type A/B interface pixel formats also on the Type C interface.
> 
> Some chips provide many pixel formats with optional bit layouts over SPI,
> but the most common by far are RGB565 and RGB666. So even if the
> specification doesn't list these formats for the Type C interface, the
> industry has chosen to include them.
> 
> The MIPI DCS specification lists the standard commands that can be sent
> over the MIPI DBI interface. The set_address_mode (36h) command has one
> bit in the parameter that controls RGB/BGR order:
>     This bit controls the RGB data latching order transferred from the
>     peripheral’s frame memory to the display device.
> This means that each supported RGB format also has a BGR variant.
> 
> Based on this rationale document the following pixel formats describing
> the bit layout going over the wire:
> - RGB111 (option 1): x2r1g1b1r1g1b1 (2 pixels per byte)
> - BGR111 (option 1): x2b1g1r1b1g1r1 (2 pixels per byte)
> - RGB111 (option 2): x1r1g1b1x1r1g1b1 (2 pixels per byte)
> - BGR111 (option 2): x1b1g1r1x1b1g1r1 (2 pixels per byte)
> - RGB565: r5g6b5 (2 bytes)
> - BGR565: b5g6r5 (2 bytes)
> - RGB666: r6x2g6x2b6x2 (3 bytes)
> - BGR666: b6x2g6x2r6x2 (3 bytes)
> (x: don't care)
> 
> v2:
> - Use 'default: r5g6b5' (Rob)
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  .../bindings/display/panel/panel-mipi-dbi-spi.yaml | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


