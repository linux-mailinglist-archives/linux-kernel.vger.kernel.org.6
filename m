Return-Path: <linux-kernel+bounces-575228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35EA6F675
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C337A5E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6C256C74;
	Tue, 25 Mar 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="J7x/y2LU"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F83255E3D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903105; cv=none; b=aA0rpL0s3PgYjCUSJ6v2fAco0Yu7EeU4os4TkmmloaezCEGhL8MRji9bTI/sxIxpYOtUPIDH5pgt7E8EFM94i/uAWmg574nG1kgDWdWUW4+zD+jTsG1utpTV6vvIob+s1I4Xmx4HtMPvvr4ciKsTBiQexJd4BGJXI8RERjTALrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903105; c=relaxed/simple;
	bh=kGviRIRkVJVYJRwzPINRkJ4/aNLR/55d1zS6iwo79iU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WShsTzRrcRJ/1VDqCjZJyqEqXgs50b3c8C7uPhra6lnSR9RIO1Qv/hWfcxII4Btl/UylEs4W+QVxetJvWcHnlae8l2Cda5AybhFNss7DMc7/iFTuEElv2v6hyKbO8qBqm1Q40n5xRJE6QxRUFyoa+ucPqJe8fv2BjmjAsqoD6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=J7x/y2LU; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/zxSpOMiJDOZ4qtsEq4rxPWz7PgHqNikQtoZmF/uPIo=;
  b=J7x/y2LUIJijZ9hZPSjvNQ4mKkGxzDhQzbIEqoLQI2rNazr6/vWzTtdX
   IBoN1YvpV8M3Ww19dUkab5jR78ca81Gjb2enQm9HPjJj2LVjkV3m1XXcM
   xZ7m0F91m2O0i/FNQnc4PALCDdITlGUIl4BbN0YUnjsBIs6tMZ+WUDcNw
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,274,1736809200"; 
   d="scan'208";a="112539116"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 12:44:58 +0100
Date: Tue, 25 Mar 2025 12:44:58 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: nancyenos <nicymimz@gmail.com>
cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: octeon: Fix unused macro Argument 'x'
In-Reply-To: <20250325100952.2956-1-nicymimz@gmail.com>
Message-ID: <1fe6ca57-c879-2459-1a1f-24b21bd19b@inria.fr>
References: <20250325100952.2956-1-nicymimz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Mar 2025, nancyenos wrote:

> warning found by checkpath.pl
>
> Signed-off-by: nancyenos <nicymimz@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 44cced319c11..0155f3c41657 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -8,8 +8,8 @@
>  #define OCTEON_IRQ_WORKQ0 0
>  #define OCTEON_IRQ_RML 0
>  #define OCTEON_IRQ_TIMER1 0
> -#define OCTEON_IS_MODEL(x) 0
> -#define octeon_has_feature(x)	0
> +#define OCTEON_IS_MODEL(x) ((void)(x), 0)
> +#define octeon_has_feature(x) ((void)(x), 0)

I'm not sure that this is useful.  It seems that there may be multiple
definitions; one that has an argument and a default one that doesn't need
anything.  It's true that this change will ensure that x is checked by the
compiler, which may help find some bugs.  Have you seen other code that
makes this kind of change?

thanks,
julia

>  #define octeon_get_clock_rate()	0
>
>  #define CVMX_SYNCIOBDMA		do { } while (0)
> --
> 2.25.1
>
>
>

