Return-Path: <linux-kernel+bounces-575048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87EA6ECF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3483B8BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3051EA7FD;
	Tue, 25 Mar 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="g4HCkfsF"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB91946AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895843; cv=none; b=Tz1UqrGrDLPEP9Xdi+6A+qtWwl8R0XnQPkXf/t9HSWtODqv/QmvaGt9pKY8PNFLz5gcvW94f/MrdZMr73YGYAMMS/fbjN8W07t7311/oOtdj6hnZllF+HoQXsSmyT5t4PDNDk8eEpySZuUlFVkSv0EBgi9NZj4jz53NYiHxBtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895843; c=relaxed/simple;
	bh=TYIKRFmySxjaYkrzWC6O+A1EEpgPYclffCAzpy/s7Go=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t6em6me0nxQWyXfRJx6EOQzZmFOPk7OTi3Ist05u3EIbF+fjznUK9GN42ZBSX20vQTExNTTDjf/ew9h12cdQOoZGkiM323Lyr9t+ClAG1y70y0Cnrm7TdS01iY+GRZrk25B4qHoOpwjnqWyFUmQW8qgY6qzJzB6zFNEXFvJsjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=g4HCkfsF; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v2KhdyEfE1+Z09fS//IwfD9BpZAAnrKgq8D0E/CrNbM=;
  b=g4HCkfsFWzng8WSNB72ZEPZTfkhHndqwt1nUIFglGLCdIifX2WF4Znpy
   zvOk6uyYMRkt0lHuxd6lKu0srq35qmKPkkWBhTzShY+ENb7UqqqJFIwe0
   dMFTsRAU045kdK95kwoZTcrlNp/7yR0KzQdrBp3Aowjrwo4ISGdInkcTo
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,274,1736809200"; 
   d="scan'208";a="214612573"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 10:43:58 +0100
Date: Tue, 25 Mar 2025 10:43:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Erick Karanja <karanja99erick@gmail.com>
cc: gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    philipp.g.hortmann@gmail.com, davidzalman.101@gmail.com, 
    vivek6429.ts@gmail.com, viro@zeniv.linux.org.uk, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Rename variable supportRateNum
In-Reply-To: <20250325091220.38601-1-karanja99erick@gmail.com>
Message-ID: <58c6f23e-1fb-fef6-8177-4f24ad559889@inria.fr>
References: <20250325091220.38601-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Mar 2025, Erick Karanja wrote:

> Rename the variable `supportRateNum` to `support_rate_num` to adhere to
> Linux kernel coding standards by using snake_case instead of CamelCase.

Maybe it would make sense to do supportRate at the same time, since they
seem to be closely related?

julia

>
> Fixes checkpatch.pl warning:
>     CHECK: Avoid CamelCase: <supportRateNum>
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 50022bb5911e..5124260602c8 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -370,7 +370,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  void update_bmc_sta(struct adapter *padapter)
>  {
>  	unsigned char network_type;
> -	int supportRateNum = 0;
> +	int support_rate_num = 0;
>  	unsigned int tx_ra_bitmap = 0;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -396,9 +396,9 @@ void update_bmc_sta(struct adapter *padapter)
>  		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
>
>  		/* prepare for add_RATid */
> -		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
> +		support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
>  		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
> -						      supportRateNum,
> +						      support_rate_num,
>  						      pcur_network->configuration.ds_config
>  		);
>  		if (is_supported_tx_cck(network_type)) {
> @@ -893,7 +893,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	);
>  	if (p) {
>  		memcpy(supportRate, p + 2, ie_len);
> -		supportRateNum = ie_len;
> +		support_rate_num = ie_len;
>  	}
>
>  	/* get ext_supported rates */
> @@ -904,11 +904,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		pbss_network->ie_length - _BEACON_IE_OFFSET_
>  	);
>  	if (p) {
> -		memcpy(supportRate + supportRateNum, p + 2, ie_len);
> -		supportRateNum += ie_len;
> +		memcpy(supportRate + support_rate_num, p + 2, ie_len);
> +		support_rate_num += ie_len;
>  	}
>
> -	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
> +	network_type = rtw_check_network_type(supportRate, support_rate_num,
> +					      channel);
>
>  	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
>
> --
> 2.43.0
>
>
>

