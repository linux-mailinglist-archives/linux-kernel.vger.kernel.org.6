Return-Path: <linux-kernel+bounces-377517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AA9ABFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D301F24CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86114EC77;
	Wed, 23 Oct 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Ih+t0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB4136345;
	Wed, 23 Oct 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667577; cv=none; b=QvFHqaw9UvdW8AoYMcOZJ/bbNpr1/eByKX7L734MhTOznAtI1zoHyCZS/8K+6etsisXoI02yrO1HIghV0LwXR+hJi7tQB+3l9fI4zCZQOoXpFfVIUFZUHMROmr1aUN6E5kGtkEXH5Jwg4FD12onSTcHkDzjZKZQoKBboEhD90M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667577; c=relaxed/simple;
	bh=VdAmmR1q9hIZ7QKFYpKw2KgGmh6wOkVGPlNKY/M0BEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNjyimZpWuUJknkgQ9BtAZOI992wHTHIlEfbBKTUMcWDzRvgg+tJi9QsjW8wpwpJAsq+d38jcTNyS+IvZ1E3gxSnyGRKN1+IT8BwBn1mxaY4D/E+23pP9xIKGMUTxDbdttsu7PJ7e/hO5vXbkeILGyEvtIl7cU6jZtUpWQ8Yn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Ih+t0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0173C4CEC6;
	Wed, 23 Oct 2024 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729667577;
	bh=VdAmmR1q9hIZ7QKFYpKw2KgGmh6wOkVGPlNKY/M0BEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5Ih+t0rgmNOx2rhBBLfMHvYNEH5k5djcyz8/X7AHUpO1pj4l0JPqQZNs955amqck
	 fY1R+kYyIC4IZTVej4qNoC3oEs9ER6leRHB6ZfoAurHlK4uQNkCASrgUJeY7OQAJzn
	 aikGTLtUHdZ/1rPYM/ykldv3+u2f3QjxiK1j9sH7WoPDpMoPRHYsUElLKufGfd4aCF
	 MXGeukBA8Sy3mGaBGI48ncnTubHktBeCZXIPtnX367Qj1qnIrMCznCkFuRkA4axjtC
	 LJ0UgAUpR4lA7GYYjhB2OxVwfnOaAKkO+W3BFK6iwy7MsOsZDI2HRZmtmeLjtq4Bi6
	 N6LuBjWen3Mbw==
Date: Wed, 23 Oct 2024 09:12:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, 
	Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2] dt-bindings: soc: bcm: Convert
 raspberrypi,bcm2835-power to Dt schema
Message-ID: <lfzxcilud65ype66frb7eihq2hvranzxp6fomjvjyxvciiixlj@2efv5266wt5r>
References: <20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com>

On Tue, Oct 22, 2024 at 06:17:03PM +0000, Karan Sanghavi wrote:
> Convert the raspberrypi,bcm2835-power binding to Dt schema
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Changes in v2:
> - Added original file maintainers
> - Removed unnecessary headers from example and formating from description 
> - Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
> ---

> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/bcm/raspberrypi,bcm2835-power.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 power domain driver

Drop "driver"

> +
> +maintainers:
> +  - Alexander Aring <alex.aring@gmail.com>
> +  - Eric Anholt <eric@anholt.net>
> +
> +description:
> +  The Raspberry Pi power domain driver manages power for various subsystems

Drop "driver"

> +  in the Raspberry Pi BCM2835 SoC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - raspberrypi,bcm2835-power
> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle

phandle to what? Missing description.

> +
> +  '#power-domain-cells':

Use consistent quotes, either ' or ".

> +    const: 1
> +
> +required:
> +  - compatible
> +  - firmware
> +  - "#power-domain-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    power: power {

Drop label. Node name: power-controller

I don't think this passes tests because of this. See power-domain.yaml
schema.

Best regards,
Krzysztof


