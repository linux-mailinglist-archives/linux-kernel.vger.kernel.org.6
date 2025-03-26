Return-Path: <linux-kernel+bounces-576674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB89A712EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EC83B5AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119A1A3148;
	Wed, 26 Mar 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="NQdFZFBB"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21381A23A9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978569; cv=none; b=gRdeaLj9XtPsSs4Ha06mSMPJDlr18XlksJz7EwezjSFPxQm7kR/aO6Y9aIGai84CXKBP5XZsMs88hyktR4uQAFAcHyxzTL1jano+hyeupWrkENVMibBcnSWf+aIwhsCQP+ROWGPPvW00cd+0RD3RhJBWNgrtXBcf8K8uSc04hJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978569; c=relaxed/simple;
	bh=Qc90giQ3e2ocUzKlkRBnMZaZvxNaHfr/yC1qO2XaQyo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ahL4zJcLTx/6oUzmnsD+tmNG5cTxewHw5ulUcMip3padSoKBjXfccv1adF1wUi4qqLF364BhGHJrsAN8ODQCjeNCdbQBIWa/wF6LSo0wL8Wb06uiDmkWy5gDbT4ElDscerU7xYpRK2o12t0zn5lUnazl/OEcrX8Fzblt/eYUTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=NQdFZFBB; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Iou+YOMY3B0VmyRSo9N3Los9Mpl9TkUqQwOVItnL4PQ=;
  b=NQdFZFBBbC9+LDGfXl441ogJ3P0OEFOgr8oEs6mlJWIKB50d7Afa+PuO
   QXCaGR3xGaCj0ZXPx8R6W3VBhzS8ZCUs5NHqlL0EtIwUH82P0KpDv+591
   oW72qOq9nMZuP4RgLgrrlaBLituEoNqbj6IIKnhAWQMjjUI23ZcgVeB4G
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,277,1736809200"; 
   d="scan'208";a="112619704"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:42:45 +0100
Date: Wed, 26 Mar 2025 09:42:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Erick Karanja <karanja99erick@gmail.com>
cc: gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: Rename variables
In-Reply-To: <20250326083334.13030-1-karanja99erick@gmail.com>
Message-ID: <a43a6053-376b-f75e-925a-e79f23adaddc@inria.fr>
References: <20250326083334.13030-1-karanja99erick@gmail.com>
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
> Fixes checkpatch.pl warning:
> 	CHECK: Avoid CamelCase: <mediaStatus>
> 	CHECK: Avoid CamelCase: <lpsVal>
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
>
> changes in v4:
>   reverted double blank line changes committed earier ensuring
>   my patch contains uniform changes.

This is still the wrong place.  It should go under the --- not above it.
It is the text that is under the --- and before the diff that is dropped.

Also you should include the complete history.

julia

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

