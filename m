Return-Path: <linux-kernel+bounces-176796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113F8C351C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084CA1F2142C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 05:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA4DF4D;
	Sun, 12 May 2024 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="HWTBo+46"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACAD51E
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715490706; cv=none; b=ubot8BU4Pt4Uiw/xpTEgcDtm0TzS92U4stE+iqQsFrO4d2HGz8Wl9mJsDrp6C8+tQTaLeuwIkvP55JhnnDR3tPtq6b7ZnBpJ3LwEOvjNTZs7MoWlXkr+B6Q0KUSXMFUEwmgDNrrkb2Mn9C3mRucfN1wsUS7IPEuqpg9BRzExJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715490706; c=relaxed/simple;
	bh=hjtKAp7QHKCtI/jrgehBPm5NVyMX3VTAVlBveXB5s6E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gXuO1651okdL4Fz5pHy05zX1S9AstuFBteXiVKXDRJQeW4EMjR8iC6IAw657TY7CYySW+x6CN+6wnKlN82OH1i8txQ1WvclnKlhg+1H17RZ1aNcaXdyurm0fBhT+Hpy8RUq5sRHT1/TcONTQa5r77Xn6JeeigGHW/8jc38xnlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=HWTBo+46; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eDGIBeLtVzLdSWFyq0jOnYuUG8IMcTzgPeUdQr6gA8g=;
  b=HWTBo+46fsDFeEf9FubPtipj+OKeiiYhhHLDRTy4pRh+3gdBA4uHiPxW
   kaSUN3omWW1Aiqxhxk6Sj+2N9Mb/EW6Kjb0oRHwWGqt+WUueRNACXBRlv
   ohqKsJxJGZF9zu1ntHLuceyKL6L5RBwnWhASrRJGIBChscHNmNzcYQfWg
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165223343"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 07:11:34 +0200
Date: Sun, 12 May 2024 07:11:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thorsten Blum <thorsten.blum@toblux.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: pm_runtime: Fix grammar in comment
In-Reply-To: <20240511213117.2710-3-thorsten.blum@toblux.com>
Message-ID: <alpine.DEB.2.22.394.2405120711250.3457@hadrien>
References: <20240511213117.2710-3-thorsten.blum@toblux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 11 May 2024, Thorsten Blum wrote:

> s/does not use unnecessary/do not unnecessarily use/

Thanks.

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index 4b9778874453..2c931e748dda 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
> +/// Make sure pm_runtime_* calls do not unnecessarily use IS_ERR_VALUE
>  ///
>  // Keywords: pm_runtime
>  // Confidence: Medium
> --
> 2.45.0
>
>

