Return-Path: <linux-kernel+bounces-216521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4F90A081
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BA51F21A47
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1770CC8;
	Sun, 16 Jun 2024 22:26:52 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503351C2AF;
	Sun, 16 Jun 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718576811; cv=none; b=reGxsOe3MBAwqb4Z3TiJtch5bEr6yKIrJEqWG/cWmqDy7i6fQeLjNsAL/m8SeGdXw2TyKfq7BMkmsOJ+GCQIt9c3pQSVXNbWYb8pkbNYSoUc2BpfiLV9u7wtkgurxLFMGFtybTot+jN/jx8LoXRoCAIiC+lmjMYbBlcUbC89do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718576811; c=relaxed/simple;
	bh=s2Y/xE1RsCsuTh+raZUJiGfSOvxMGmdl2NTptAm7zqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ2fstT2qLfZ2hvwgr2VDojzuQQOlmr/XeudKsL40hVO91Kec0MUWsxCuNj8mPde1oGi3vCqOi29YZ57QUSqRpPgYM4jUSwZaqpDPDx0+sVyogkiEvFFe78K4UnDXB1aW2o7CrCcpSjNMLu9tWvQGJGGeEfB8jPibq/+9SU4Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 22:26:36 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] riscv: add SpacemiT SOC family Kconfig support
Message-ID: <20240616222636.GA3983622@ofsar>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_D935633C42BE1A7BF8C80553B5571C737009@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D935633C42BE1A7BF8C80553B5571C737009@qq.com>

On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
> The first SoC in the SpacemiT series is K1, which contains 8 RISC-V
> cores with RISC-V Vector v1.0 support.
> 
> Link: https://www.spacemit.com/en/spacemit-key-stone-2/
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index f51bb24bc84c..8a5775586845 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -24,6 +24,11 @@ config ARCH_SOPHGO
>  	help
>  	  This enables support for Sophgo SoC platform hardware.
>  
> +config ARCH_SPACEMIT
> +	bool "Sophgo SoCs"
              ~~~~~ is this a copy & paste typo?
> +	help
> +	  This enables support for SpacemiT SoC platform hardware.
> +
>  config ARCH_STARFIVE
>  	def_bool SOC_STARFIVE
>  
> -- 
> 2.45.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

