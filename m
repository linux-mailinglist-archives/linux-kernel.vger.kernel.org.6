Return-Path: <linux-kernel+bounces-536678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A6A482EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1A11889A04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0926B944;
	Thu, 27 Feb 2025 15:27:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AE26B2C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670055; cv=none; b=B6bL41+2h+WI8CxKuhvQxfZBnprPmpopZ7XO2SoZ6O3uvPRtF9FRKaNa2E1ir76xCJDgy+S2vgcJuVkyxtMt8/AB1FM08LADm9budGMLwCemkOlQ4Ii9lx4+sQia4Bzw2LA3Tp9M0z65UMpkH2rsE1nvwfeq9FJYDCXPYsLVCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670055; c=relaxed/simple;
	bh=gum4d8B8kIo09pq7rNh7RAZp5aA8pmQJmAwMW1ddnTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEh220k1MG9hUHzePwxsgHyLxjQZoNUF8sWhFnddHcHRWu1oKCflYHlMQgEzhQEpYd+7dXtOp8p1wtaNBDQJLBhscs55OlWQCv9k0AlMOj/I2tTMT6J4C+Nww4grXMidMhyQWPbcUHBD6JUrsOMJPeE8LeUdfRnHdreg7yj+VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0278C2BCC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:27:49 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C34A3F5A1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:27:33 -0800 (PST)
Date: Thu, 27 Feb 2025 15:27:30 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 01/10] arm64: Kconfig: Update description for
 CONFIG_ARCH_VEXPRESS
Message-ID: <Z8CEYheKAr3VJ8k5@e110455-lin.cambridge.arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-2-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221180349.1413089-2-vincenzo.frascino@arm.com>

On Fri, Feb 21, 2025 at 06:03:40PM +0000, Vincenzo Frascino wrote:
> Update the description and contextually the help text of
> CONFIG_ARCH_VEXPRESS to reflect the inclusion of all ARM Ltd Platforms.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm64/Kconfig.platforms | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 02f9248f7c84..c468c23b2bba 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -374,13 +374,12 @@ config ARCH_UNIPHIER
>  	  This enables support for Socionext UniPhier SoC family.
>  
>  config ARCH_VEXPRESS
> -	bool "ARMv8 software model (Versatile Express)"
> +	bool "ARM Ltd Platforms"
>  	select GPIOLIB
>  	select PM
>  	select PM_GENERIC_DOMAINS
>  	help
> -	  This enables support for the ARMv8 software model (Versatile
> -	  Express).
> +	  This enables support for the ARM Ltd Platforms.
>  
>  config ARCH_VISCONTI
>  	bool "Toshiba Visconti SoC Family"
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

