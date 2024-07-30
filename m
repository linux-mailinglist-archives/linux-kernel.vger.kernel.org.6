Return-Path: <linux-kernel+bounces-268008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCEC941F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1CCB26F55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F618A6B7;
	Tue, 30 Jul 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DR6/9FRx"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139D189539
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363145; cv=none; b=sLWibRa0sgT97tTYlQuXs4dwpB1C8cjrVNMHQJpTiBQRvhdEswHCZ8wgA/lrFYRPJj+wTCbIShqyg/saoUwgJZKLSrYAP91oyZeOLnsDhOpX1htg0y9ko7DE0aP9Z0OX8FEnxxXHSdp5jfXN/Kn48oxFn5eFtLPA9rovUH7HbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363145; c=relaxed/simple;
	bh=kcvDJmx+C47meXpz+wUXe1vMZqDkU7qreGG8KGLE9iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbTmwZamgLX97cAYPm5hgR7GxInCweexRaEkeyAAClDu24NhC3Sx5uvLdR62NrfM8MbULWCyUwSgFDO4Hps5vY7vGKIv8hNH4cclTCoANzCWvWtDV5+NkHag33dHST6eeAyPWBt+MY+2mcF/viDJvAT3Zon6iB4YdN56fGrd/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DR6/9FRx; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id Yr8AsH9NDjnP5YrKbsN9XP; Tue, 30 Jul 2024 18:12:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YrKasiV1ZV2ivYrKasaUWT; Tue, 30 Jul 2024 18:12:16 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66a92d00
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=ZI_cG6RJAAAA:8 a=VwQbUJbxAAAA:8
 a=XKjV9n0moFAzRToWf84A:9 a=QEXdDO2ut3YA:10 a=CiASUvFRIoiJKylo2i9u:22
 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C7yj6HZoiynA1VQrhCm4ZNKd8a/Pzm79loFKlcCi4d4=; b=DR6/9FRxYztGwP/fEwwHPEFTc9
	ZbAarS55FHFLWKM698dsi/Z//C9qEfOoKd2RN5LWXU3gjk3W1Gm/d/em31XY1Lq1D9sRyDdzl1Ho5
	chMPSoV+QPUGFIV+UxLqiE6Ifgj5r7kADQghMkcqnQYC4z+a033OkaFYVDboeA59rDpE4k0Z5aL6m
	QTEazEPX5BbZqAcZs6347jM7eFgjSYz9YRUrv/AjVM0kLpm1bP8DuJnzIHaeSztuF4FCnh3xs1G7x
	l4AH/3hmiHtefzwUm1Rq4FY4KMdEuPmpFH92t1zrPo0Q8RD8Vw30ceK2emMVlG18qDxiFdz+9bfv5
	f19xz9VQ==;
Received: from [201.172.173.139] (port=44630 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sYrKZ-000mdF-02;
	Tue, 30 Jul 2024 13:12:15 -0500
Message-ID: <d4362976-ac3d-4236-a213-666a42560dfe@embeddedor.com>
Date: Tue, 30 Jul 2024 12:12:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, kees@kernel.org, gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240730172301.231867-4-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240730172301.231867-4-thorsten.blum@toblux.com>
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
X-Exim-ID: 1sYrKZ-000mdF-02
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:44630
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJZeg6E1lNAVoZhH7ltdMPSCWFMRtBVzIj8wQsFYVB4qdfC37vaL3idofZr7hxeXD4H1+/KT9Kh4FCCwH/h4lKZhYFaKl2SVZ6J3mt25YHD6FtumXFVj
 oQMYmP9v9HTmb/7qrK1ezkNEONkUAQ96x4lUnAgJoESmRcRAs2F4gXyeblTBqHMBxDhjgzv841Un0j2zOu/Yg5JXFXY0xQsxDzOoszvtjiXBp6fjq7MNet6Y



On 30/07/24 11:23, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Remove the now obsolete comment on the count field.
> 
> Refactor ext4_expand_inode_array() by assigning count before copying any
> data using memcpy(). Copy only the inodes array instead of the whole
> struct because count has been set explicitly.
> 
> Use struct_size() and struct_size_t() instead of offsetof().
> 
> Change the data type of the local variable count to unsigned int to
> match the struct's count data type.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
> - Use struct_size() and struct_size_t() instead of offsetof()
> - Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/
> ---
>   fs/ext4/xattr.c | 20 +++++++++-----------
>   fs/ext4/xattr.h |  4 ++--
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..b27543587103 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2879,11 +2879,10 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
>   	if (*ea_inode_array == NULL) {
>   		/*
>   		 * Start with 15 inodes, so it fits into a power-of-two size.
> -		 * If *ea_inode_array is NULL, this is essentially offsetof()
>   		 */
>   		(*ea_inode_array) =
> -			kmalloc(offsetof(struct ext4_xattr_inode_array,
> -					 inodes[EIA_MASK]),
> +			kmalloc(struct_size_t(struct ext4_xattr_inode_array,
> +					      inodes, EIA_MASK),

As Kees previously commented, you can use struct_size() here.

>   				GFP_NOFS);
>   		if (*ea_inode_array == NULL)
>   			return -ENOMEM;
> @@ -2891,17 +2890,16 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
>   	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
>   		/* expand the array once all 15 + n * 16 slots are full */
>   		struct ext4_xattr_inode_array *new_array = NULL;
> -		int count = (*ea_inode_array)->count;
> +		unsigned int count = (*ea_inode_array)->count;

It seems `count` is not actually needed anymore.

If you remove it and directly use `(*ea_inode_array)->count` in the following
call to `kmalloc()`, you could use `struct_size()` in the call to `memcpy()`
below, and copy the whole thing in one line. See below.

>   
> -		/* if new_array is NULL, this is essentially offsetof() */
> -		new_array = kmalloc(
> -				offsetof(struct ext4_xattr_inode_array,
> -					 inodes[count + EIA_INCR]),
> -				GFP_NOFS);
> +		new_array = kmalloc(struct_size(*ea_inode_array, inodes,
> +						count + EIA_INCR),
> +				    GFP_NOFS);
>   		if (new_array == NULL)
>   			return -ENOMEM;
> -		memcpy(new_array, *ea_inode_array,
> -		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
> +		new_array->count = count;
> +		memcpy(new_array->inodes, (*ea_inode_array)->inodes,
> +		       count * sizeof(struct inode *));

memcpy(new_array, *ea_inode_array, struct_size(new_array, inodes, (*ea_inode_array)->count));

>   		kfree(*ea_inode_array);
>   		*ea_inode_array = new_array;
>   	}

Also, you are missing one more like just below this one, where `(*ea_inode_array)->count`
is currently being used to directly index `inodes`:

(*ea_inode_array)->inodes[(*ea_inode_array)->count++] = inode;

Thanks
--
Gustavo

> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index bd97c4aa8177..e14fb19dc912 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
>   };
>   
>   struct ext4_xattr_inode_array {
> -	unsigned int count;		/* # of used items in the array */
> -	struct inode *inodes[];
> +	unsigned int count;
> +	struct inode *inodes[] __counted_by(count);
>   };
>   
>   extern const struct xattr_handler ext4_xattr_user_handler;

