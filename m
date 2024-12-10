Return-Path: <linux-kernel+bounces-439202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CD9EAC27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C1818833B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CA21576B;
	Tue, 10 Dec 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly0DlkXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64396226549;
	Tue, 10 Dec 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822983; cv=none; b=KdslbSY/AsNJHOFiUsY7tMOZl6pjVkLXeQwof6BA15vAqXSJSpgpEy9MTzdwMlBuSJ/RqTpraXRf6a8+3TM+lM8N09F4ekEom+XKNzdiDJD5BsSiY+UxrZwYCwXK3C2ROxTpa9yEzCkewspZLDXAIt1LEnYpb3cry7e/aAimMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822983; c=relaxed/simple;
	bh=nSnXU+fg189Nx6ZOb9wZiFIXD0OOIZENaWUmLYaSdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcRsG+HNySdP2wcxEeVzHnGF0C9ii1PFkUQRusCw7nYGy9RyFpPijhzPqfONzVZa8hWnES1Gk8W/9ITRWo/mcIne7ENtEhoANfQPM/E0C0aYAVYy8LjdgKGghULG5+GmfQ/cOJTnEnpj4coVSV75MXe0pkjOJM1e30pio6aDFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly0DlkXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B182C4CED6;
	Tue, 10 Dec 2024 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733822982;
	bh=nSnXU+fg189Nx6ZOb9wZiFIXD0OOIZENaWUmLYaSdiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ly0DlkXZB+SZBuuH/xP9VZyp1sgOaP90LccakGQzXKIM2NT1M/7Sh3Cx9WucnC0K+
	 S0WRp0tj1L1Qau9Troi4kqhdNqbd2wSUysrGZI/ojuCAUrNJKYgUDpgc5uNM6IWnr8
	 NmViTaNlYR7F5jtRv+krxr1XtK/sp1p/E2oAdg8GQNvU1NjPVkF83PbEe75kJz6YW5
	 31MwOF78QR0hTHjD0xse7kwJnAH1ixn2mVXwflI3x/cmGTb+GxBOcKXyu2ciiQZXig
	 suByIpc0arlkOPX7ZaTzNhqqKilx01RflLqnhd8m8cODqWGYJWAxhx6e/iaVnT+QqE
	 NU3PChTo8vXeA==
Date: Tue, 10 Dec 2024 10:29:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bard Liao <bardliao@realtek.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: convert rt5682.txt to dt-schema
Message-ID: <uedkwiuuwi3tfqvi3zzcnays4ytl7l2phg5g6wqwire6ywc2ce@goouwpzb5hi6>
References: <20241204-topic-misc-rt5682-convert-v1-1-0fedc4ab15e8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-rt5682-convert-v1-1-0fedc4ab15e8@linaro.org>

On Wed, Dec 04, 2024 at 11:52:34AM +0100, Neil Armstrong wrote:
> +  realtek,dmic-delay-ms:
> +    description:
> +      Set the delay time (ms) for the requirement of the particular DMIC.
> +
> +  realtek,amic-delay-ms:
> +    description:
> +      Set the delay time (ms) for the requirement of the particular platform or AMIC.

Please wrap at 80.

This wasn't present in the old binding, so mention reason of adding it
in the commit msg.

> +
> +  realtek,dmic-clk-driving-high:
> +    type: boolean
> +    description:
> +      Set the high driving of the DMIC clock out.
> +
> +  clocks:
> +    items:
> +      - description: phandle and clock specifier for codec MCLK.

...

> +
> +  DBVDD-supply:
> +    description: Regulator supplying I/O power through the DBVDD pin.
> +
> +  LDO1-IN-supply:
> +    description: Regulator supplying power to the digital core and charge pump
> +      through the LDO1_IN pin.
> +
> +unevaluatedProperties: false

And since I expect a new version: please move unevaluatedProps after
required: block.

> +
> +required:
> +  - compatible
> +  - reg
> +  - AVDD-supply
> +  - VBAT-supply
> +  - MICVDD-supply
> +  - DBVDD-supply
> +  - LDO1-IN-supply


Best regards,
Krzysztof


