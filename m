Return-Path: <linux-kernel+bounces-314298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29696B17D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8601C20A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6483012E1E9;
	Wed,  4 Sep 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DttYROLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75581742;
	Wed,  4 Sep 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431073; cv=none; b=XL/kpkLINfwvvxT7z8KBSOK+LwJdcgV9AKJdYvM4Qx7H03gqgzBIaPG009hrGE8BYcfHARpy9ZtSDhnuzSjxUUtj7aRb798h44IfCGYCt29jl9m3oRmNLSU5yqD/OkRVzPFfvDOeK5lFppneJ0TRnn9MugNOj8cJasUasj2E9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431073; c=relaxed/simple;
	bh=buYlvEPomhrjjppJjFYn7cKL+9ZUeYHiDHtVHWJksc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5AzLKHh86qFXb46f01HQoNO5kTJ9g+XRxxwn93yNiulfFOagsF/8xq8cRe2AGFCoAYM206c2yZs/uLbYWEDi2Azbq0ft5abl13gcKogBfr7QzCMcEwitp5FPtQjrReZq82JxJhIEbVA9wbuqdmSnrgKUtypCLIqJgFAp/MP4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DttYROLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B3C4CEC2;
	Wed,  4 Sep 2024 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725431073;
	bh=buYlvEPomhrjjppJjFYn7cKL+9ZUeYHiDHtVHWJksc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DttYROLXZN6O6US6OIRlGB7HLEgQH8GA0UWV8KoAASk29DgZjW8HI4nmCCXi5HBC1
	 iHtg29HEMoifugMxZ05e23jOPLLguFHpCiVxSOvsHWc8kpdrFicHnYgGQWoJZTmqww
	 I37Y2Jw2sxVBoWw3XcxyZXEANp0b+3drHDYtLx8ZiiaGIAZlbuVTS2Q50QD77ZVlzk
	 upDb2TRGZ2tO+Ok844XEpij+Gqn31Jne7RXQOLPaTLw1C3gYZJDnWiETPPDIaU6dni
	 kyuLqJIV9tl7v6cIFbHUniyA362Sw1l/2304Nwo30d5ewZ5tUNDsSvvpGb+MjUIJcc
	 3eGJ849nL5S9w==
Date: Wed, 4 Sep 2024 08:24:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	broonie@kernel.org, angelogioacchino.delregno@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Fix various typos
Message-ID: <roke3xgy6axn5d3iwv5t7j57zktojygfkcax5ldvkixyok4v4i@2k557uh7rjpo>
References: <20240903164242.2188895-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903164242.2188895-1-eleanor15x@gmail.com>

On Wed, Sep 04, 2024 at 12:42:42AM +0800, Yu-Chun Lin wrote:
> Corrected several typos in Documentatin/devicetree/bindings files.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

These tags do not apply anymore. Your patch changed significantly. Drop
them or wait for re-confirming of tag.

> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
> v1 -> v2
> I took Krzysztof's advice to fix more typos.
> 
> v1
> Link: https://lore.kernel.org/lkml/ZtUTg0C81FwChfDh@visitorckw-System-Product-Name/T/

...

> diff --git a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> index 1978fbb77a6c..d5b930524b53 100644
> --- a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> @@ -16,7 +16,7 @@ description:
>    can be connected to CMOS image sensors from various vendors, supporting both
>    MIPI CSI-2 and parallel interfaces. It can also output on either MIPI CSI-2
>    or parallel. The hardware is capable of transmitting and receiving MIPI
> -  interlaved data strams with data types or multiple virtual channel
> +  interlaved data streams with data types or multiple virtual channel

interleaved

>    identifiers.

Best regards,
Krzysztof


