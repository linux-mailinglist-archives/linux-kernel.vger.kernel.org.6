Return-Path: <linux-kernel+bounces-575484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1215A70324
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199F816F72A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC270256C8A;
	Tue, 25 Mar 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="A/HONrhz"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCC2566FF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911050; cv=none; b=lPS1OXK0aqjRMFwsiUqQf6L3ot6NswOYE4orPv1InY/U8/FHxxihEpyV6RX1GK0fqSF8cWDnO/SBA8bnUQswWTSoy4IJ2DWICXf0i/C24IutiyVWG1xsk5PJ/VA9tY2bnSjlweAHObGDSae3xE3+GErZuZfpvDCkE7WZdsUieOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911050; c=relaxed/simple;
	bh=5vmsaVmY7RCeBltG3oaYsLyhH00UvyfSdKrADtgNQsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kW7rBpJJLJUBQQ0ztAyhB+WP9f+4xjT7IBeIFvyQz+YsSHrGdbH/J//RLg0Zl4xtaM3dGwjHMfvJDMYOz+FqSA8Ay0o+Ooo1Cu8RhDkj+6px0V58rtoLnwURkwMvrlKcPBsVJzKwO/EZlCPiMx1QLZmbdPY3tdj97yuhmntU/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=A/HONrhz; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=39LmuDI9bOxMy0VVpRTL66OIPOopihwRPhpHSWSa6GI=;
  b=A/HONrhz8qXm5ONveFdISU4jX4UvXz/Gc1mUpyPQl+RjDg0O2v1DPKo4
   K7nFJQyFxe4L0cO8YTlvjSWcqvEBVlL0q+bWsecPqJGbgboyH+rW6vxuy
   7WsituMwgC2QJUys0Ro95r2IDbIbbBswpVUdj0wiI/xMIdyKtRye6zjmn
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,275,1736809200"; 
   d="scan'208";a="214672416"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:57:26 +0100
Date: Tue, 25 Mar 2025 14:57:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Erick Karanja <karanja99erick@gmail.com>
cc: gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    philipp.g.hortmann@gmail.com, davidzalman.101@gmail.com, 
    vivek6429.ts@gmail.com, viro@zeniv.linux.org.uk, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Rename variables
In-Reply-To: <20250325124712.47577-1-karanja99erick@gmail.com>
Message-ID: <36f86d43-9c0-56fd-372a-87d8637e9377@inria.fr>
References: <20250325124712.47577-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Mar 2025, Erick Karanja wrote:

> Rename the variable `mediaStatus` to `media_status` and variable
> `lpsVal` to `lps_val` to adhere to Linux kernel coding
> standards by using snake_case instead of CamelCase.
>
> Fixes checkpatch.pl warning:
> 	CHECK: Avoid CamelCase: <mediaStatus>
> 	CHECK: Avoid CamelCase: <lpsVal>
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_btcoex.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> index d54095f50113..27dfd00b4249 100644
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
> @@ -52,21 +52,19 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
>  void rtw_btcoex_LPS_Enter(struct adapter *padapter)
>  {
>  	struct pwrctrl_priv *pwrpriv;
> -	u8 lpsVal;
> -
> +	u8 lps_val;
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
>  {
>  	struct pwrctrl_priv *pwrpriv;
>
> -

You seem to have done something else here.

Were there two blank lines in the original code?

julia

>  	pwrpriv = adapter_to_pwrctl(padapter);
>
>  	if (pwrpriv->pwr_mode != PS_MODE_ACTIVE) {
> --
> 2.43.0
>
>
>

