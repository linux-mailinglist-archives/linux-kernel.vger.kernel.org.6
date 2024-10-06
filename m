Return-Path: <linux-kernel+bounces-352527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B4992056
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9923D1F21B1B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D2189912;
	Sun,  6 Oct 2024 18:18:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82DC125
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238705; cv=none; b=p67ihcFfuacJwC3wumEHd1COf9SVTMyqGiD0w4qj+PiV6t4BbVUFwQA+Psa+8VC8fYxCWSP6YemODhGKApB0Sb0adrJPDHdj8fVfwSpKnWe7Gm4h4NSnz4s+w3Rf02smy+QBxfXGjJZaNaniFTX4u8xlLfxzjuUTItYvTXNEAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238705; c=relaxed/simple;
	bh=TAI1pJaecpFLxDi7ZZRKzHelVZOV3hf2GTNVsBgExls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3mUc8hf9w584wAXvxIaHchcznmIhvpsCNE88Ac9thaduq7xf5IRthb4Zc+kLYt/zFWVu+jGHc2RPVHFm+rh/X5HuczRg7DMuvRyeXlhY6CAE/Cfb0tAWfrtzWBEZF53mu+STRGfWNVxyWuCMkHE/ClIUx2n2O65MdbdCRvoij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48748106F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 11:18:46 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A3213F73F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 11:18:16 -0700 (PDT)
Date: Sun, 6 Oct 2024 19:18:09 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: sudeep.holla@arm.com, lpieralisi@kernel.org, linus.walleij@linaro.org,
	linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo in versatile.c
Message-ID: <ZwLUYeogos-yGrlL@e110455-lin.cambridge.arm.com>
References: <20241005085117.438715-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005085117.438715-1-cvam0000@gmail.com>

On Sat, Oct 05, 2024 at 02:21:17PM +0530, Shivam Chaudhary wrote:
> Corrected minor typo in versatile.c
> - Fixed "documentaton" to "documentation"
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  arch/arm/mach-versatile/versatile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-versatile/versatile.c b/arch/arm/mach-versatile/versatile.c
> index 7ef03d0c224d..f0c80d4663ca 100644
> --- a/arch/arm/mach-versatile/versatile.c
> +++ b/arch/arm/mach-versatile/versatile.c
> @@ -134,7 +134,7 @@ static void __init versatile_dt_pci_init(void)
>  	val = readl(versatile_sys_base + VERSATILE_SYS_PCICTL_OFFSET);
>  	if (val & 1) {
>  		/*
> -		 * Enable PCI accesses. Note that the documentaton is
> +		 * Enable PCI accesses. Note that the documentation is
>  		 * inconsistent whether or not this is needed, but the old
>  		 * driver had it so we will keep it.
>  		 */
> -- 
> 2.34.1
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

