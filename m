Return-Path: <linux-kernel+bounces-284416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225D9500B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B911C210D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095D16D33F;
	Tue, 13 Aug 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcNY7uh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DB13C691;
	Tue, 13 Aug 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539822; cv=none; b=Qw6wdZ1cztNkFsDfbUQTLkaT+GBUpnvBYOxKOROzNzaeG8kwuOUQN72GaE7Zq6tAj2NJ+SLiPjpuJIf05epDexwLHxRxSKzhSuE6bbuqsb/I4Ea3gxFco+s5BjrUM4Y4p4tWeam0D+lA1EpnexCQOCpKER7l/eClbweGn2YnN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539822; c=relaxed/simple;
	bh=H8hnNv+J4S+YPQvGe44l1KR9nKbvjwvpol+4qgAi6oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xqw7XVCV2mH/IDnFbVyRg70O37APYPjOKJcIQSPaRQjUj/u3M+oT+ai2v9uRcFuxQwECcGbvsKKwjKcxmHkIuRYse9r+lnwz5FSDrboHKiRJvgV7dh5KyYsTloQ84Q8XNuo2bGphOOwHR2O+pUOR3FRXwbt3ERk9Wdk5K0muzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcNY7uh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0BC4AF0B;
	Tue, 13 Aug 2024 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723539821;
	bh=H8hnNv+J4S+YPQvGe44l1KR9nKbvjwvpol+4qgAi6oY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GcNY7uh1o1YLZloNKr0mZUJDzOsRs3Blh5k+B1KK5FhgsHZIdafAbbMs5MPAkmshi
	 /FLrw+G2+cDNuyqSq7S1X2lWNZyKKAyKhy+hg3NP0A0zhZA+ej/fmazDQfMzRKJ3R9
	 miCM8WUa97R7Qfh/8PuiDO/kgYRaToL8Vf4AF1NxjhCCWTqBhCV8VrjZcPmasDSYpI
	 9sGbSRgfWVBZsySwuNu0UwfuPipBXXygyLSYjxE3kHDM+e8zZZt5xDvC1T7hHbXzEX
	 yh5EhwLa1a/S5l7zYCycRzS7H7QRsLjcRhVYVNOhQcIH6n2nGFjSeXaj/FaGvf3tvZ
	 OqUtNKw67kx6w==
Message-ID: <1161762b-a6ce-486c-bb0d-c60c6ab400f0@kernel.org>
Date: Tue, 13 Aug 2024 11:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ARM: dts: tqma6: change copyright entry to current
 TQ Copyright style
To: Max Merchel <Max.Merchel@ew.tq-group.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
 <20240813071637.72528-5-Max.Merchel@ew.tq-group.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240813071637.72528-5-Max.Merchel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 09:16, Max Merchel wrote:
> Replace developer-specific, personal email addresses by mailing list addresses
> while retaining the author.
> 
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi    | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts    | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts    | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi  | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi  | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi     | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts     | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts     | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi   | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi   | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi  | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi  | 5 +++--
>  arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi  | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi | 5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts    | 5 +++--
>  16 files changed, 54 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
> index b749b424bbd6..9f00f92957ab 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
> @@ -2,8 +2,9 @@
>  /*
>   * Copyright 2013 Sascha Hauer, Pengutronix
>   *
> - * Copyright 2013-2021 TQ-Systems GmbH
> - * Author: Markus Niebel <Markus.Niebel@tq-group.com>
> + * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
> + * D-82229 Seefeld, Germany.
> + * Author: Markus Niebel

Same comments as before.

Best regards,
Krzysztof


