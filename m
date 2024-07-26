Return-Path: <linux-kernel+bounces-263166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2993D1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84F11F2219E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E01179972;
	Fri, 26 Jul 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVOd0AQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19713A40C;
	Fri, 26 Jul 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992584; cv=none; b=YLsxea+yCF+ZS768tONT/8gybmLyjfOhTf7CyW8oACus87DhY047gr9KwU7rnV0tp4dI9li5hw8l8bwd83xR9DTOUC0rQzvHto2fclrELuRTYuwkKk2cCZj1GjimsYdY/AcvwK5VbkdkNV8h66YdriIvLmI3eeZXS0SpC5ZI4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992584; c=relaxed/simple;
	bh=4PCK2sWpDnQVujtjG0OroqQcADHR9De9HxDlVfiJmqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pTNLZGFQ/0G+8VtemK1qaAygEJHcKNRYij7PO+HPHH205Xj7jptW3IUNKuvhp6xcWjRWj2DJlcp9tdIwvvHKDRzMXkwso8na6TNjzUH3tfDHoruzM4VKblx0WwRcIXxj2jUeJLRe7fO9QXHoEWG7wn0pdRTnUsZrskMUhlmpL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVOd0AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9518C32782;
	Fri, 26 Jul 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992583;
	bh=4PCK2sWpDnQVujtjG0OroqQcADHR9De9HxDlVfiJmqw=;
	h=Date:Subject:List-Id:To:References:From:In-Reply-To:From;
	b=XzVOd0AQYRlKKur8YEeM0seW5HU6gSy2k8Xph54Lt8lP4jH4wuWE4z5ncL6kueATO
	 9f0OUG4pEE8yIDnCElGn4Xs7Xts+4TaOPRq7+s8AQMJWsTCYMcZI8F8yIvwNDMWyPZ
	 u0pqygxBUsAJ65j+Z/vgOoOdj4eiTGqJIwY3Ons2al8NnfTxiw1skFHP+kLmXp0eqz
	 C6U1Cu52K9SZqZmbwt0bnDGvTKhyut9zkiA8R5ReKbLnOqoUEtmdNkdlbT5GAWmQAq
	 p/cZQv00x+aIG8KfS6I8n0TcWd9MYkcfl8XzJvdh/kkwHWnBAAF7EAgagY1eHfCabo
	 2hZyZ6Vv+txYA==
Message-ID: <b7b3cbc2-5f20-4a78-b189-b509acfee3ac@kernel.org>
Date: Fri, 26 Jul 2024 13:16:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] arm64: aspeed: Add support for ASPEED AST2700
 BMC SoC
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, lee@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, shawnguo@kernel.org, neil.armstrong@linaro.org,
 m.szyprowski@samsung.com, nfraprado@collabora.com, u-kumar1@ti.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-8-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726110355.2181563-8-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> ---
>  MAINTAINERS                  |  3 +++
>  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0a3d9e93689..08609430cfe0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2121,7 +2121,10 @@ Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
>  F:	Documentation/devicetree/bindings/arm/aspeed/
>  F:	arch/arm/boot/dts/aspeed/
> +F:	arch/arm64/boot/dts/aspeed/
>  F:	arch/arm/mach-aspeed/
> +F:	include/dt-bindings/clock/aspeed,ast2700-clk.h
> +F:	include/dt-bindings/reset/aspeed,ast2700-reset.h
>  N:	aspeed
>  
>  ARM/AXM LSI SOC
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6c6d11536b42..1db7b6f1ee0a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -40,6 +40,20 @@ config ARCH_APPLE
>  	  This enables support for Apple's in-house ARM SoC family, starting
>  	  with the Apple M1.
>  
> +config ARCH_ASPEED
> +	bool "Aspeed SoC family"
> +	select MACH_ASPEED_G7
> +	help
> +	  Say yes if you intend to run on an Aspeed ast2700 or similar
> +	  seventh generation Aspeed BMCs.
> +
> +config MACH_ASPEED_G7
> +	bool "Aspeed SoC AST2700"

There are no MACHines for arm64. Look at this code. Do you see MACH
anywhere else? No. Then why Aspeed must be different?

No. Drop.

Best regards,
Krzysztof


