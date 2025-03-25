Return-Path: <linux-kernel+bounces-575566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59AA70433
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF3F171264
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E825A350;
	Tue, 25 Mar 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="l39UYrJ9"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2225A355
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914119; cv=none; b=WCIZcf/J6xLyKMhw7RkZpROqvG7hNUm3/9Nc8Q8OyzgW9Z02jYJ6twAij3RNurB21fYAj11QiDfE1UPy4glx/Tx5Nw3POAvIa8aaDcn25qk5o1Nvpnp7R+1jQwt49gJRPD6IjIzLrw+5XEnHp1f6v7OoFIOLXCgozV8wvjBJvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914119; c=relaxed/simple;
	bh=UZFUKqD7TvXqs1PjEvK5UH6b4H3mZeamy4ovhKEe7Ok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=arHWNKV/jyvwA4IvoZ9TNluMGB2Bl4GWtirqWMDIDEJ0NufhDVTxIRUD5RgpSlmCXYD6HvnpqNypUARUzuEE5VvX7CwASXOZS4gX6Rha6iLMdw2BmyEzGG1rXeih+SikFWgKyl9+z5gGqRMFatYoI2OanjS6RkP7LcoOTwtE1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=l39UYrJ9; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=41soCjDrG3FSVv9OmKfvp+WD+OsDqWFbQpmc7iB5Js4=;
  b=l39UYrJ9JpZOLN7BxZgx96VdrOwT2Tt2AoTcgLcngIaKdJhmWWczSTbD
   IDkY9JlMH2/YhakS//gO/uiLDFcZCmSIs/a8sAkuZ7MfKkE8KKppNREZT
   kS7isg+riEWRZPdm8QAttuLXCeyiC1CiviexbQRpt5jNfIHd7yOIujV1n
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,275,1736809200"; 
   d="scan'208";a="112560809"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 15:48:29 +0100
Date: Tue, 25 Mar 2025 15:48:28 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove unnecessary else block after
 return
In-Reply-To: <Z+LA2eeFRL+K0KCy@HP-650>
Message-ID: <4661d7d1-323b-c121-93cc-77f462a54bb5@inria.fr>
References: <Z+LA2eeFRL+K0KCy@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Mar 2025, Abraham Samuel Adekunle wrote:

> The else block after the return statement is unnecessary since
> execution does not continue past the return statement.
>
> Remove the else block while preserving logic making the code cleaner
> and more readable.
>
> reported by checkpatch:
>
> WARNING: else is not generally useful after a break or return
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>,

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 5ded183aa08c..91c6a962f7e8 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2022,12 +2022,12 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
>  	}
>
>  	iEntry = SecIsInPMKIDList(adapter, pmlmepriv->assoc_bssid);
> -	if (iEntry < 0) {
> +	if (iEntry < 0)
>  		return ielength;
> -	} else {
> -		if (authmode == WLAN_EID_RSN)
> -			ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
> -	}
> +
> +	if (authmode == WLAN_EID_RSN)
> +		ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
> +
>  	return ielength;
>  }
>
> --
> 2.34.1
>
>

