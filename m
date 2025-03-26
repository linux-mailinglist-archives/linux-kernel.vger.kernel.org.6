Return-Path: <linux-kernel+bounces-576561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D85A71115
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F941720C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979D119CC28;
	Wed, 26 Mar 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="hS11gAWa"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230ED195B1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972823; cv=none; b=IhfW3ZRFK9gGvlsVQ/rXJ262hmQDzsah0j7jplSyy8vMmM9DhlmgEq57hclmspDHLYgPvrFPGYNaNSoLRbuaf97VgUH4OfPHoBhlncJLvTxJLeqZTQDfpvQ1tGlFW949CC760QGx3LoYFoxvCqxZF7bv+5YzeTlNajJ+74I/rHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972823; c=relaxed/simple;
	bh=43wDT1wis9+uXBD5diH2XwPs8DcYKUXCAE571UDtSUE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BrzeW71DJsE8HorhfUApp102YyFVLRhzjPmTeyxFZAsgx88Zeb3rRNXjTQFMotv+5xGHMgizDoRfLr78pg1/CrKKh7T/GanA9Y//fRvrArnB6zuVILoM2ujDqTWzDWzp07GGBJ8wHt/ZvatMOXFWJTj06jCnL7CBZ5rKajJdeo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=hS11gAWa; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ydj8XjXk7OtlDAEPWNWByX3+n+1MkIvRWl+Tl/yKavU=;
  b=hS11gAWaixvYKpOp7RNEzXAue8Au60KWNyTSCkQre/GXe8XOGgeDSIJz
   7PE4IEm5TFSoK2K/xbWO4iwAs+E1mnj+fKqxiRMSY2Iu1h+KjitQwOZhI
   7Cs56UnQfno/SDFHSa2Fu2BMBaMv3g2YoR5RxWXpcyIVE+Q1nVprKFDFY
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,277,1736809200"; 
   d="scan'208";a="214775295"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:06:52 +0100
Date: Wed, 26 Mar 2025 08:06:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Erick Karanja <karanja99erick@gmail.com>
cc: gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: Rename variables v2
In-Reply-To: <20250326064647.8380-1-karanja99erick@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2503260805440.3488@hadrien>
References: <20250326064647.8380-1-karanja99erick@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Mar 2025, Erick Karanja wrote:

> Rename the variable `mediaStatus` to `media_status` and variable
> `lpsVal` to `lps_val` to adhere to Linux kernel coding
> standards by using snake_case instead of CamelCase.
>
> changes in v2:
>   reverted double blank line changes committed earier ensuring
>   my patch contains uniform changes.

This v2 information belongsbelow the ---.  It's not meaningful to people
who look at the gi log in the future, because they don't see the previous
version of the patch.  The part below the --- isdiscarded when the patch
is applied.

julia

>
> Fixes checkpatch.pl warning:
> 	CHECK: Avoid CamelCase: <mediaStatus>
> 	CHECK: Avoid CamelCase: <lpsVal>
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_btcoex.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> index d54095f50113..f4b19ef7b341 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> @@ -8,14 +8,14 @@
>  #include <rtw_btcoex.h>
>  #include <hal_btcoex.h>
>
> -void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
> +void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 media_status)
>  {
> -	if ((mediaStatus == RT_MEDIA_CONNECT)
> +	if ((media_status == RT_MEDIA_CONNECT)
>  		&& (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)) {
>  		rtw_hal_set_hwreg(padapter, HW_VAR_DL_RSVD_PAGE, NULL);
>  	}
>
> -	hal_btcoex_MediaStatusNotify(padapter, mediaStatus);
> +	hal_btcoex_MediaStatusNotify(padapter, media_status);
>  }
>
>  void rtw_btcoex_HaltNotify(struct adapter *padapter)
> @@ -52,14 +52,14 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
>  void rtw_btcoex_LPS_Enter(struct adapter *padapter)
>  {
>  	struct pwrctrl_priv *pwrpriv;
> -	u8 lpsVal;
> +	u8 lps_val;
>
>
>  	pwrpriv = adapter_to_pwrctl(padapter);
>
>  	pwrpriv->bpower_saving = true;
> -	lpsVal = hal_btcoex_LpsVal(padapter);
> -	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lpsVal, "BTCOEX");
> +	lps_val = hal_btcoex_LpsVal(padapter);
> +	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lps_val, "BTCOEX");
>  }
>
>  void rtw_btcoex_LPS_Leave(struct adapter *padapter)
> --
> 2.43.0
>
>
>

