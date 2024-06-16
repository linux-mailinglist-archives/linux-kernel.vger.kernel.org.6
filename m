Return-Path: <linux-kernel+bounces-216534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085A90A0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130901C20F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 23:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96273460;
	Sun, 16 Jun 2024 23:06:47 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C817344E;
	Sun, 16 Jun 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718579206; cv=none; b=iOjo0SMEP0svrQyxA+M6F6yGQAQd+Mnt64Ue4Rv+Eb0SDp4Jn5Cnq40pro/BpJCY3rTZSHUfC377nYO7H5gYYJQmrPnuxyJx/5/UEXhGZQcOHhEkoWgDI0XDsVYrMPuE8MFmv2gyHSzd8/6I05NT2Eol0H3d/i00f+7wvE6kBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718579206; c=relaxed/simple;
	bh=h/o2TvAiUoDg/AJSZIzo+CF9lcdlDpEl0QYRkwVqvQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OikCoH9TuLHgQAYqFMIYWgBBQPiDipQVfSgVLpj5Chx8c+64dCYtHfGR5PH+ovSRWXRtuxMPVjYp47j3aifACZpCEt1WsvlTr8dv+tGwvzO3JyCWjfCkcCjsWJcpb/LegZ/1/FPUuBheITTczvpcM8ZT3f54p91szq38XLzlzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 23:06:33 +0000
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
Message-ID: <20240616230633.GB3988639@ofsar>
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

should this be SOC_SPACEMIT? as it contradict with patch [9/9]
> +	bool "Sophgo SoCs"
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

