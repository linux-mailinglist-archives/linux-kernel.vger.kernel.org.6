Return-Path: <linux-kernel+bounces-268240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D88942215
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB21285DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930818DF97;
	Tue, 30 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TR+Xe2lS"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DA1422D2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374188; cv=none; b=qVsNdPy9VCfPFYEg6mWqFERPGpUp7WhobuimPwAdtaMGcr87oUymPAVxUmAHIdtEtmIohYYjYxNuc4Src5uPu3dEbrhQFaenQqie0UJcqpU/IvLUit+lHpYhhYEfWe1h5h/4s+yu7EecvX5Z7S6jzlkj+Hfha+DmGQWDKfj+bVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374188; c=relaxed/simple;
	bh=yQROK7TOy6F4YHHi7UFYQ667ySciMZe3bS9vVGssi0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW7qS84CvE2ymRGzP6HvGCqqllzc/jtMh1widcm2D4i1N1qTFdQlTl3v8XLAVeM7BgDHSPbqCN8PgCMss7bu7IsE4XUuBKEngvgspiIQfMpn+idO/d5q/fnBwnL/Ufcha9W2hioWuBO+rjSPrknVVfi1frKUIySu8uIgGZNsdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TR+Xe2lS; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id YqJAsvVxtiA19YuCmsvttt; Tue, 30 Jul 2024 21:16:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YuCksXpi8bFeFYuClstrxN; Tue, 30 Jul 2024 21:16:23 +0000
X-Authority-Analysis: v=2.4 cv=dJKgmvZb c=1 sm=1 tr=0 ts=66a95827
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=ZI_cG6RJAAAA:8 a=VwQbUJbxAAAA:8
 a=opMxIaHlLsu84nJWUF0A:9 a=QEXdDO2ut3YA:10 a=CiASUvFRIoiJKylo2i9u:22
 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FVJ8Gd6JLwpKI78ipVUAxRuLxc0kJAq7kaVQNmDHTfk=; b=TR+Xe2lSuvxlRLW916iXcbECJ6
	1wZ3HQGxRf1oPt35/s4JSgL/u0CKwVPOal1mzXrzjOOkBlNyMqnzySxoq814w92L4ts3tN+BjvNxe
	3DSvAlJEEKrqtCYm1m0EYWTCUZoPRSLI/VbvG14w4hSZNXznLiv8w8Tuwxj3i+rhnayLP7vw2UWjs
	jYNfAbRjzyq9DQx+hNr41Yd4TGdCDb+gryweqQgmDnsK36DODqCN3U15h1MXZ8UBbiSsR5Zn/hKHL
	wE2zYGS20BBoj3YoJTEyxItFx4U10RwfXVVJ73XTjm9FIm+nf34ZmJp3J5lkR2vlW+aNuZM1MTJ9F
	rOlO+RJQ==;
Received: from [201.172.173.139] (port=44832 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sYuCk-004E3d-1K;
	Tue, 30 Jul 2024 16:16:22 -0500
Message-ID: <66267271-85a1-4ac6-99c5-6ea9b8d19287@embeddedor.com>
Date: Tue, 30 Jul 2024 15:16:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, kees@kernel.org, gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240730205509.323320-3-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240730205509.323320-3-thorsten.blum@toblux.com>
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
X-Exim-ID: 1sYuCk-004E3d-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:44832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDzpAFUaalw6NU4ZbkPNKNROCBRNL/jomxjDW4q5PgSZ/AxBnF8tY3bZ2c2GHGQNa8wWTuSkJ5H56+yfybxSzErmdsqoTvKezle27oVe/xY3w7Yp44mW
 +zwaJFNffFByebCruXnrnQK33lLqfwV/CXgu8a52FSoBgwgCTDSukLRo+CcxcLR5D+3YVJVgb6y0YE7uazq3zQx6Tid0/stxle0ONnD8Wu6JGHAFkeOvQyK0



On 30/07/24 14:55, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Remove the now obsolete comment on the count field.
> 
> Refactor ext4_expand_inode_array() by assigning count before copying any
> data using memcpy().
> 
> Use struct_size() instead of offsetof() and remove the local variable
> count.
> 
> Increment count before adding a new inode to the inodes array.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
> - Use struct_size() and struct_size_t() instead of offsetof()
> - Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/
> 
> Changes in v3:
> - Use struct_size() instead of struct_size_t() as suggested by Kees Cook
> - Remove the local variable count as suggested by Gustavo A. R. Silva
> - Increment count before adding a new inode as suggested by Gustavo
> - Link to v2: https://lore.kernel.org/linux-kernel/20240730172301.231867-4-thorsten.blum@toblux.com/
> ---
>   fs/ext4/xattr.c | 24 +++++++++++-------------
>   fs/ext4/xattr.h |  4 ++--
>   2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..4e20ef7cc502 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2879,33 +2879,31 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
>   	if (*ea_inode_array == NULL) {
>   		/*
>   		 * Start with 15 inodes, so it fits into a power-of-two size.
> -		 * If *ea_inode_array is NULL, this is essentially offsetof()
>   		 */
> -		(*ea_inode_array) =
> -			kmalloc(offsetof(struct ext4_xattr_inode_array,
> -					 inodes[EIA_MASK]),
> -				GFP_NOFS);
> +		(*ea_inode_array) = kmalloc(
> +			struct_size(*ea_inode_array, inodes, EIA_MASK),
> +			GFP_NOFS);
>   		if (*ea_inode_array == NULL)
>   			return -ENOMEM;
>   		(*ea_inode_array)->count = 0;
>   	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
>   		/* expand the array once all 15 + n * 16 slots are full */
>   		struct ext4_xattr_inode_array *new_array = NULL;
> -		int count = (*ea_inode_array)->count;
>   
> -		/* if new_array is NULL, this is essentially offsetof() */
>   		new_array = kmalloc(
> -				offsetof(struct ext4_xattr_inode_array,
> -					 inodes[count + EIA_INCR]),
> -				GFP_NOFS);
> +			struct_size(*ea_inode_array, inodes,
> +				    (*ea_inode_array)->count + EIA_INCR),
> +			GFP_NOFS);
>   		if (new_array == NULL)
>   			return -ENOMEM;
> -		memcpy(new_array, *ea_inode_array,
> -		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
> +		new_array->count = (*ea_inode_array)->count;

The line above is not really necessary if you copy `*ea_inode_array` at once like

memcpy(... , struct_size(new_array, inodes, (*ea_inode_array)->count));

or like

memcpy(... , struct_size(*ea_inode_array, inodes, (*ea_inode_array)->count));

whichever works.

> +		memcpy(new_array, *ea_inode_array,
> +		       struct_size(new_array, inodes, new_array->count));
>   		kfree(*ea_inode_array);
>   		*ea_inode_array = new_array;
>   	}
> -	(*ea_inode_array)->inodes[(*ea_inode_array)->count++] = inode;
> +	(*ea_inode_array)->count++;
> +	(*ea_inode_array)->inodes[(*ea_inode_array)->count - 1] = inode;

This looks good, thanks!

>   	return 0;
>   }
>   
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

--
Gustavo

