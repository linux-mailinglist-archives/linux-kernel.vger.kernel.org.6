Return-Path: <linux-kernel+bounces-513568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A46A34BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F5C162370
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A32222A6;
	Thu, 13 Feb 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nor8JpPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78E28A2D6;
	Thu, 13 Feb 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467349; cv=none; b=Y3KSbA8yaBAYa5XajzF9E6GR7xmJmu8kVQ6nrE1/Jdc/Ge9Om5kH/TE4f6Z8GY8Ls3TNt0iINFCV17cJ9nhND2KMKizZ5BdiNBznGe+gFdO4PzOYjahkS9SqpMnUeGWsQ2fn2fHr+fhHVN1ttN/4FCWE5fhfD3n141GiSFgkUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467349; c=relaxed/simple;
	bh=l0FlV3JhqBNb6Iht2yHMwP7PfD3TpYDSZvC58kqj4RM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Qz1erVAmowLCXnZkUoChSMr8QWPGrYxbRcpvaLHiwBo7LPWYnTZPdtCONkOgjEzM6n3xjnokYFiJj6ReH5iUr0KksgbGuFjJMelkBDg4Kg3jzONQB6xhb2GwcJG3wNUvNQH9fcQDdVF+vaZbJakyzEp3EeXvGjeWtv+mfOiEdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nor8JpPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB04C4CEE4;
	Thu, 13 Feb 2025 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467349;
	bh=l0FlV3JhqBNb6Iht2yHMwP7PfD3TpYDSZvC58kqj4RM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Nor8JpPQH4ysaE2ZABWo48WXNTp5scAGRpgLahkWwLdOn/x6ZOv5zuPNxKJJpWLR8
	 cpkQYQkafOsOBwzpKKRaOTmIWZyf1wJj1dQfvofUjXwzC6BFbGTx+YYDO5WL53ENmv
	 0axggrRHUfooRztP4qO1wrZ6cYro0D2FaKLbNwitKmQin7VsK1nJ0oS5Y7zDxbnD8W
	 msJif7Y5XQFuxN/XZpIAk3hyo61SGscfzgkgDT6BJhEehzRgCJAeOl/zhi1k6s08bq
	 EwLQ2ix4q5anihWhLRverV+znGn+FFT2SU6I9pLD+f+biNxDr/UI6pLc/t3RljXFOd
	 U1Vl6ccUlhykA==
Date: Thu, 13 Feb 2025 11:22:28 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250212204258.57514-1-krzysztof.kozlowski@linaro.org>
References: <20250212204258.57514-1-krzysztof.kozlowski@linaro.org>
Message-Id: <173946704368.3328478.14106859473786211510.robh@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: marvell: armada: Align GPIO hog name with
 bindings


On Wed, 12 Feb 2025 21:42:58 +0100, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warnings like:
> 
>   armada-385-clearfog-gtr-s4.dtb: wifi-disable: $nodename:0: 'wifi-disable' does not match '^.+-hog(-[0-9]+)?$'
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Add forgotten Rb tag.
> ---
>  arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi | 8 ++++----
>  arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/marvell/' for 20250212204258.57514-1-krzysztof.kozlowski@linaro.org:

arch/arm/boot/dts/marvell/armada-388-clearfog-base.dtb: gpio@18100: Unevaluated properties are not allowed ('gpio-ranges', 'phy1-reset-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dtb: gpio@18100: Unevaluated properties are not allowed ('gpio-ranges', 'wifi-disable-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dtb: gpio@18140: Unevaluated properties are not allowed ('gpio-ranges', 'lte-disable-hog', 'poe-reset-hog', 'sar-isolation-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dtb: gpio@18100: Unevaluated properties are not allowed ('gpio-ranges', 'wifi-disable-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dtb: gpio@18140: Unevaluated properties are not allowed ('gpio-ranges', 'lte-disable-hog', 'poe-reset-hog', 'sar-isolation-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#






