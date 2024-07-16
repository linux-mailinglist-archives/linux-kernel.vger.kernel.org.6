Return-Path: <linux-kernel+bounces-253814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1760932765
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DCA1C21278
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2419AD6A;
	Tue, 16 Jul 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM3Oev54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B5199EB0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136366; cv=none; b=jYe2H5WE2W3bHUgpRBbjD5ormwMN945E88oJAHeXbS4mMhJjDlKNLwhOfY+rFzrDSqttwO3iKY9ielbP0iZyFgKxgq2rCLTa6cSb8q+P9waTrPVeMRsDsfOkyXyZoe6HDepmW+w0tJmVidtMNoUpNU8bgsiywDkUUCV8fo3G1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136366; c=relaxed/simple;
	bh=bPVZJLWZWfdDq5CJz2bIWaWUTb6wxDi+EpVlIhFnHyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7ZyLmbfCI9UaOCfPuq9too1SCHShIxVLYV0622Vel5FQxD9dvC5PXEp01KtbG/cJaxcJtzGvFoIT45sVaIUUU7q4457ulgs+K62yiOcY6YDh+8BHOZxIUwyjmSgIkmImEZApp8o5GKWnDn1szdAwoQIJBvNiHNus0JIrLJR0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM3Oev54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85527C116B1;
	Tue, 16 Jul 2024 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136365;
	bh=bPVZJLWZWfdDq5CJz2bIWaWUTb6wxDi+EpVlIhFnHyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM3Oev54FfxAGYzqvc09ziZwnBKtpDF3ktlwlC1oCX9+oALFPXa7Gzno70S31/Iyp
	 IPb/VlsxHHHxc0IMX6zupj1/72CGTy0rtNcqNDD8FSVxHJPAjDYWe49ovPkZW1s9kF
	 hD5kIWU5YvHYmtcGK+OzG9s0BfWqJTBOQ5U/TA0+9rLO62P6f5ISU1MW7UmpEAHipO
	 YN+s/JGTho4vsYdht7gYvfJmrW1+ai5ofm8cHGPW0UjboCPhO9cQ/U2DVjbupAesJh
	 nkxBKa7Or/dwScln4xDdW7tZLRWd5I2mFfll8IZlGBHTDjum2sHEPk7e0rtWgtrxJy
	 sEjCmeO0TQx+A==
Date: Tue, 16 Jul 2024 06:26:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI
Message-ID: <20240716132603.GA3136577@thelio-3990X>
References: <20240711120115.4069401-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711120115.4069401-1-vattunuru@marvell.com>

Hi Vamsi,

On Thu, Jul 11, 2024 at 05:01:15AM -0700, Vamsi Attunuru wrote:
> DPI hardware is an on-chip PCIe device on Marvell's arm64 SoC
> platforms. As Arnd suggested, CN10K belongs to ARCH_THUNDER
> lineage.
> 
> Patch makes mrvl_cn10k_dpi driver dependent on CONFIG_ARCH_THUNDER.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  drivers/misc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 64fcca9e44d7..f3bb75384627 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -588,6 +588,7 @@ config NSM
>  config MARVELL_CN10K_DPI
>  	tristate "Octeon CN10K DPI driver"
>  	depends on PCI
> +	depends on ARCH_THUNDER || COMPILE_TEST
>  	help
>  	  Enables Octeon CN10K DMA packet interface (DPI) driver which
>  	  intializes DPI hardware's physical function (PF) device's
> -- 
> 2.25.1
> 

After this change, ARCH=arm allmodconfig fails with:

  drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
  drivers/misc/mrvl_cn10k_dpi.c:190:9: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Wimplicit-function-declaration]
    190 |         writeq(val, dpi->reg_base + offset);
        |         ^~~~~~
        |         writeb
  drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
  drivers/misc/mrvl_cn10k_dpi.c:195:16: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Wimplicit-function-declaration]
    195 |         return readq(dpi->reg_base + offset);
        |                ^~~~~
        |                readb

Including one of the io-64-nonatomic headers would resolve this but I am
not sure which one would be appropriate (or perhaps the dependency
should be tightened to requiring 64BIT, as some other drivers have
done).

Cheers,
Nathan

