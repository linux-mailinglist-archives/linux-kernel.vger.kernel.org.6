Return-Path: <linux-kernel+bounces-248392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2392DC95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4781C2141B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB4154BFE;
	Wed, 10 Jul 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="E0SqGe8A"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF413DDC0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653831; cv=none; b=GurG3bioOZDdPMVa9a8WcugcVhgaC5TE8H+B3a/DjmASzQZ9l1Rv21998FEQtwEJY5xVIPqFP/FEhY8xoduv+d31wgwGa2kSAbKqkCEXHja7ruVKQs96zk4OuzoYvmRaIw+XIqea50dYmECzU5QiKrt45OKkG6+s5xfdpf9Yqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653831; c=relaxed/simple;
	bh=GL4FJgXqf9U9rkh3gw4ze5UXc17LURWHLNkByhVPGJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+Vt4PoO3j6x4wo+dwVZv9rbW8VBXIOSKv8w/HsE7TIai+ktn2IKLlpFeUXQvnoM/G7bx97h5IKkpB63a3rYPvF89Bnb3YHPUgPOKZwfqQblpBDJzwMd7gFQTTrgoohdWvGaqetSpqvsK0yvT/+3NqSEZeyx/jHRV+oHs1spTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=E0SqGe8A; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id RcXKsciIMvH7lRgf8sFqor; Wed, 10 Jul 2024 23:23:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Rgf7sXcZqks1PRgf8sSgx9; Wed, 10 Jul 2024 23:23:50 +0000
X-Authority-Analysis: v=2.4 cv=Ud+aS7SN c=1 sm=1 tr=0 ts=668f1806
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=vS7kxI9omEbEOQks6BwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l6Tr0m6UzUy390pp07xlfZA1XTmAFaUaEdm2Awdhd0Q=; b=E0SqGe8ABu1/OQKv3i82jYaxmb
	O2EmwJ60F/Kni8hn7/0b5dDKFAr89twZ7PUPG+xNRh9r7GW1/uaoZVf2GzcNuLCp1NDYMJPsZfyQy
	AKG2R1ran6+AFBYMKQPhFMywsrHUZouDtNe2dQ87aq9si0gjiY/KPWv3ayPnz8awhYqkQkk3RUUb9
	1KVTCGdAiDXE0ARp3qq6ZKrwdHhzQCzsKv8QOY/kZTK18TZOXLVO0NBeecGYzG0rmnBC4GpaeYc1Q
	4v/9RMHnu46TCZVzdaU4Y7NDHweoBUfjLkyuLlmaQ2i6liVpaYr0LjfOCz6FqdIsabARpus+F/322
	sw8SfmFQ==;
Received: from [201.172.173.139] (port=46396 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRgf7-004IUg-0x;
	Wed, 10 Jul 2024 18:23:49 -0500
Message-ID: <e694e115-482d-46e8-8b18-69c628dd1949@embeddedor.com>
Date: Wed, 10 Jul 2024 17:23:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/affs: struct slink_front: Replace 1-element array with
 flexible array
To: Kees Cook <kees@kernel.org>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225734.work.823-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225734.work.823-kees@kernel.org>
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
X-Exim-ID: 1sRgf7-004IUg-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:46396
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAtMGOwmCwcqgorEy+cFkR/kI9+7k0IuUpvwXuNb6LnuVk+5IYmuzO+SawyEyQTYIgOkdfp3lDJ4ck3oHlQIG7qHa3O+qgNvzaDjaFEHcOoi2Uqvvw1N
 GMa39U1CUN4Ny3uPzolU6YAgp8ayLZ9QvNRi9UACdwhYzKdBUg2wsRMFhkpnHuiesiFkDK2LOxlfeyhIz9NCgnC6DtKCDyUN++G/85mSyQfVWn7EVyJM3CIb



On 10/07/24 16:57, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct slink_front with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-fsdevel@vger.kernel.org

> ---
>   fs/affs/amigaffs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
> index 81fb396d4dfa..5509fbc98bc0 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -108,7 +108,7 @@ struct slink_front
>   	__be32 key;
>   	__be32 spare1[3];
>   	__be32 checksum;
> -	u8 symname[1];	/* depends on block size */
> +	u8 symname[];	/* depends on block size */
>   };
>   
>   struct affs_data_head

