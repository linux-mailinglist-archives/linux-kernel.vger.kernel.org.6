Return-Path: <linux-kernel+bounces-242984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B2928FDF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55F31C2223C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABE6AC0;
	Sat,  6 Jul 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1kTf4oz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB754A18
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227862; cv=none; b=HjDjzyZ5ynDnCZvK+Jx6VwupzEi7dVo5Z8vu7vOmeN3Zxw3LSph7P2nvIDMhBPq2HLlA1Nbb3cwM7nPDPHVTVpdhDR9GK8pCHUzP4GY0mBOAm7dn2V5JSVF+fITwoMshe5GQ12jkP8yOh/2VgTReeAYJB7dwyIgiz41B3fv5MSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227862; c=relaxed/simple;
	bh=1VaEWo6PugNMlQB4WbArRAI3mDoDE2X6SITcDlMPHWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+ZOBXdslicGhFOcmsinVif5EweFY47dkGGmJgTFUOdW2IGhtKfQlZarBUhchFcvMFA08O7gL2hAtFOK96K8oDVV7YAwDyEkTmwMaaSlcNX68vMYomG53DoR3dWUFUDwtgwRJr7ctAkw6ZNsAzqDSB7NbdTnObWr6ndRqAoCh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1kTf4oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA81FC116B1;
	Sat,  6 Jul 2024 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227862;
	bh=1VaEWo6PugNMlQB4WbArRAI3mDoDE2X6SITcDlMPHWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1kTf4ozGXtICJCRVaBLk/EyqTLd0Q//xdIFcpcTRcr3NVYfnUvx3LEs5nV23GN+H
	 k2bUsyJuCZ+l4l8y0zvDRMLycQ9+hvgiJ/RC8qQKv6k+wsJ9OsghvhGCX9CCJtrUKV
	 Gv7/bIJVSIQ0admoUICk7sA+h5p63S4s5k85YznjJgbWDYkKM6KWyPl17Frv8YbWvs
	 +90zyL+TKyqjB8621uMpbewxlKx91wbMkVWJItovKH0VDUfHJC5t+teiL4MY90YSeu
	 ZEPxIK/gS1hmIissh/wsFVf1fuUZgbJkyPLJlvJITM/jh2dnozlTnocgcugnpAatnQ
	 IXalWU/hdvCuA==
Date: Sat, 6 Jul 2024 08:50:10 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: define ILLEGAL_POINTER_VALUE for 64bit
Message-ID: <ZoiUwsFIHcteBSms@xhacker>
References: <20240705170210.3236-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705170210.3236-1-jszhang@kernel.org>

On Sat, Jul 06, 2024 at 01:02:10AM +0800, Jisheng Zhang wrote:
> This is used in poison.h for poison pointer offset. Based on current
> SV39, SV48 and SV57 vm layout, 0xdead000000000000 is a proper value
> that is not mappable, this can avoid potentially turning an oops to
> an expolit.

Maybe I also need to cc stable? This is a secure hole fix patch.

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> Since v1:
>  - fix typo:s/SV59/SV57
> 
>  arch/riscv/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c51b32a8ddff..c992eabbd002 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -313,6 +313,11 @@ config GENERIC_HWEIGHT
>  config FIX_EARLYCON_MEM
>  	def_bool MMU
>  
> +config ILLEGAL_POINTER_VALUE
> +	hex
> +	default 0 if 32BIT
> +	default 0xdead000000000000 if 64BIT
> +
>  config PGTABLE_LEVELS
>  	int
>  	default 5 if 64BIT
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

