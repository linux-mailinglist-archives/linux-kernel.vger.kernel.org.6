Return-Path: <linux-kernel+bounces-575479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB76A7031D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD23316A8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54782566DB;
	Tue, 25 Mar 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="J2Y4LS4z"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6911EEA4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910975; cv=none; b=ZZD1m0qNR+CQ3PWCcTOKYHysknS4l3XeLWt5KNI2okRwhN1oRXyki1kwfpOnoTN24Xpf8GP57Zu6OS0qBeDbzgYZsW0vPAullD3yfAtEbIUp3vrG4X1H0Bwc7sZZd74Kde3q6+Rdy6RAnKY7G/MFQ4sAYSRPzsTKHqVsR6OnD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910975; c=relaxed/simple;
	bh=qEMNyQ5ds/VmKFLRDJf2+qMtoc35WfaEw22SNJ59GUs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eBMr0XeXxc1XP7JM6VO/bDI60R+Sygft5SIegbPYclZAzL1PRcJNqGYFnqqJ1M/8Xfyf+mFy65qOfb/6pi2vnJkuS6lvoXWlwt7T16E88glRaJVp6tCpprYuEX3KiwIoQTeEzvt6FsK3qSk46cO86qy7lxoJIQWLRV87W4eb4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=J2Y4LS4z; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q+5awqeE5/5JpbIYKZrW0uZUXFfOxvrShRVsEromEjQ=;
  b=J2Y4LS4zbjbhorrwatNvMrgKR35paPRget3yRAD9D8IA1ew4HJ4tO/sl
   xdvZUGWOsx7sxWeKq0gWWADschgh/Khmtli8f9wXxv61DnFqRwK5pXqlp
   L0UCVbpm3AD7bDqJZpICuLkPRI2AFxMZeMv0BsQOwWKWNDOmpVaLAlgh0
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,275,1736809200"; 
   d="scan'208";a="214672165"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:56:10 +0100
Date: Tue, 25 Mar 2025 14:56:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: simplify if-else block by removing
 unnecessary braces
In-Reply-To: <Z+KraOo2DfmH5zMX@HP-650>
Message-ID: <36d38aa1-39f7-ba14-633f-d3411a863a83@inria.fr>
References: <Z+KraOo2DfmH5zMX@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Mar 2025, Abraham Samuel Adekunle wrote:

> The if-else block contained braces around single statements, which are
> unnecessary according to the Linux kernel coding style.
>
> Remove the redundant braces to improve code readability and maintain
> consistency with the rest of the codebase.
>
> Reported by checkpatch:
>
> WARNING: braces {} are not necessary for any arm of this statement
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>

> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 0ed420f3d096..53d4c113b19c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -988,11 +988,10 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>  	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
>  		addr = of_get_property(np, "local-mac-address", &len);
>
> -		if (addr && len == ETH_ALEN) {
> +		if (addr && len == ETH_ALEN)
>  			ether_addr_copy(mac_addr, addr);
> -		} else {
> +		else
>  			eth_random_addr(mac_addr);
> -		}
>  	}
>  }
>
> --
> 2.34.1
>
>

