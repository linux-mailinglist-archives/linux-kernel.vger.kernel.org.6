Return-Path: <linux-kernel+bounces-576657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637DA71295
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9B33B026F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308D1A0BCA;
	Wed, 26 Mar 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="tuiXj/gH"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394452A1B2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977603; cv=none; b=gIdXs3BwoGLlHSZJf9MeLCZOrViSg00TMZDHc3w4huHycSRtNFgBbcxILDux38OjXhh5Ex+Jn0TMGeN1Au/PJaFVlXYCf6vbg+Xl3bcm2+q/dGnTT+FG/bTjX1YLr2q6ee9rlU1qUezjg15wXZPHaaYlb3NIZHIBcK8chsyiHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977603; c=relaxed/simple;
	bh=jSYdUxL251B4lgrd/EX2MMj+JgXoikIFSh9ZUwTxupQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CHstIjUKX8jWY1zNabY1VY9hl6cwvKGhVqbg+MLY3RvB+4kV+qw4dlshyKiDmKgl0/We1SrgH0HsTKyTHlWLsO2ZezUFACCOKy2PI2omKeKn3y30gf+OkcwT5FPHz33Y27Ql1yHsLepL9WsRADLxmtaLFq4x3oMgKI1/gwRm2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=tuiXj/gH; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BriUsCVdI6tKg9yDZ7xtoChU3hkuye0o+GkygCG2cZs=;
  b=tuiXj/gHhiP+M9LgO+QCA/HB4K8LMbEMEz03y0Igx8en2s/rc1G9HnI7
   FwrXJ68ANyWpWBvH44g68NsVkv5tlwzjcDp+0qkIBMe7efb/r/37BZBLu
   4frUGqBb+Bzt64FBAG/MwVdRHTQlZTe/NfDjxl683pWP49mbaKV77Est/
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,277,1736809200"; 
   d="scan'208";a="112617095"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:26:39 +0100
Date: Wed, 26 Mar 2025 09:26:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove braces around single
 statements
In-Reply-To: <Z+Lan0xeQd3m5ejY@HP-650>
Message-ID: <aa42727-6388-cc8-c6e-b9ebc2a63591@inria.fr>
References: <Z+Lan0xeQd3m5ejY@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Mar 2025, Abraham Samuel Adekunle wrote:

> The code contains braces around single statements in the if blocks
> which are unnecessary according to the Linux kernel coding style.
>
> Remove the braces to improve readability and maintain consistency.
>
> Reported by checkpatch:
>
> WARNING: braces {} are not necessary for single statement blocks
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> index c60e179bb2e1..b17b295e8d3c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> @@ -56,9 +56,9 @@ int _ips_leave(struct adapter *padapter)
>  		pwrpriv->ips_leave_cnts++;
>
>  		result = rtw_ips_pwr_up(padapter);
> -		if (result == _SUCCESS) {
> +		if (result == _SUCCESS)
>  			pwrpriv->rf_pwrstate = rf_on;
> -		}
> +

I'm not sure you need to add a blank line here?

julia

>  		pwrpriv->bips_processing = false;
>
>  		pwrpriv->bkeepfwalive = false;
> @@ -549,9 +549,8 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
>
>  		LPS_Leave_check(Adapter);
>  	} else {
> -		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off) {
> +		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off)
>  			ips_leave(Adapter);
> -		}
>  	}
>  }
>
> --
> 2.34.1
>
>
>

