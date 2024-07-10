Return-Path: <linux-kernel+bounces-248391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0892DC91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B601C226F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BA0154BE7;
	Wed, 10 Jul 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tlnia+Zi"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D21527BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653719; cv=none; b=js/s3fZL2FoSP66VjkInkO9OfBguMWD6TlTwalZTaWIwDGC7/KqxdqE/L0TaYRBFAj49e0hE4uz0gNHCOGOfh4j9xtvh2JChZoXYwxMHMhJAcOHuzwWBHYfa2dIqDPTbxzIbD4bobvHdpV3LY4pkZHX+Cjt2TxmD7Dne/0hI9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653719; c=relaxed/simple;
	bh=oCGAvK3PZiI/AC165cWnvu4uU23oUzwMe4D75+lWw1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT879TCclyBx46hp9Ktz2Q0DB+hiUUxziKCRkcg8qHTU0M/ItqKb1/cmkuAuXTCAJPc2kSECqG5NGrUIAxga0JZZbar2br2YOKR34T2pFVYDm032Qx87LUfrbUJQlFTN/ZHrc5DIVMemAuW1T48M5XCUTt4qFlE0CcD4ZZLiVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=tlnia+Zi; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id RcXRsVJ8z1zuHRgdIsHt7F; Wed, 10 Jul 2024 23:21:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RgdIsw1iHRn6WRgdIs5s2o; Wed, 10 Jul 2024 23:21:56 +0000
X-Authority-Analysis: v=2.4 cv=KbTUsxYD c=1 sm=1 tr=0 ts=668f1794
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=VGBkq3WTX9eaKrocn38A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HqsAgN3oKmQVRcsZ7vxY/TwilwfwNpnctqPwoZ35s7Y=; b=tlnia+Zi7v/smfcHhk4sgBOOAw
	GnQ6W5N8mTiq1aaWGhl95O8t9KAEqg4Qa65k5OvpGlPngx2Jzb2Yue+V/ZPPpk9XOma7d+oNJNuYf
	jbFNsI96lyvYrpPGQQz5qJVjZkpgkDrViLM6kAqS5ly/owq7ibb2CzjZ+MXhQx4UebULTGmIynnUj
	QfOk0P8u+IKia3pG2lBXQU7qQRQh1J5omLIDm+3H6yVubLwKfvftKn2nK8xcW0rtdAXvcBCBt4RsW
	p//xA5B0nElCiizv65/+uz/4XYXs5s6eMUMZbhodnTCZqCA7Okex7UX3dxrAK0fud1+Exij1WIgf7
	FxhecnjA==;
Received: from [201.172.173.139] (port=44848 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRgdH-004H8M-0w;
	Wed, 10 Jul 2024 18:21:55 -0500
Message-ID: <29e58a99-560a-4922-85b2-9ce71bc43ec4@embeddedor.com>
Date: Wed, 10 Jul 2024 17:21:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: vbox: struct vmmdev_hgcm_pagelist: Replace
 1-element array with flexible array
To: Kees Cook <kees@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240710231555.work.406-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710231555.work.406-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRgdH-004H8M-0w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:44848
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO4y2R7S7hD3S+hzZ4SSitoI1QrOeWlALC6vxzVba6y20jNGAngTw8Xbc9RrT/99XRcENxHP9417WTeDC4PVBozMTgyImr9lDdGz3d6kLJxANqgADtaY
 pqcsagrAHs+MrbMBkFwAhr+oJsYqB0m9mXpiD/uAXKSY5Ufk5bf7RZjYZhTVhieNFuBqsNOjzmj5qkuXZyMWfKV4DYr0x5fqYjpo7JIZJee78F79sbvm1OnJ



On 10/07/24 17:15, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct vmmdev_hgcm_pagelist with a modern flexible array. As this is
> UAPI, we cannot trivially change the size of the struct, so use a union
> to retain the old first element's size, but switch "pages" to a flexible
> array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/uapi/linux/vbox_vmmdev_types.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
> index f8a8d6b3c521..6073858d52a2 100644
> --- a/include/uapi/linux/vbox_vmmdev_types.h
> +++ b/include/uapi/linux/vbox_vmmdev_types.h
> @@ -282,7 +282,10 @@ struct vmmdev_hgcm_pagelist {
>   	__u32 flags;             /** VMMDEV_HGCM_F_PARM_*. */
>   	__u16 offset_first_page; /** Data offset in the first page. */
>   	__u16 page_count;        /** Number of pages. */
> -	__u64 pages[1];          /** Page addresses. */
> +	union {
> +		__u64 unused;	/** Deprecated place-holder for first "pages" entry. */
> +		__DECLARE_FLEX_ARRAY(__u64, pages); /** Page addresses. */
> +	};
>   };
>   VMMDEV_ASSERT_SIZE(vmmdev_hgcm_pagelist, 4 + 2 + 2 + 8);
>   

