Return-Path: <linux-kernel+bounces-265888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F134D93F74D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF2C1C2191C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E8154444;
	Mon, 29 Jul 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="s+6iJJKk"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2331E515
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262191; cv=none; b=IVYKuPES3x8NQ0ik9AvG86WoWu6JPi1kYyv3W3oLy8j+/AVidP8rEgMwS6vhxXEXMt+v2Q0zovLWkFmUQB19g+WlLWP3DcLM1xQwOslA1VkY8w43qcUwW5GncFG1uhOSjdT9pZZjvIrTb8XwRMKkvO56dkntn5YwquSvRxGnXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262191; c=relaxed/simple;
	bh=ifgLZ0PzJ/ZI+VJ9aYOuK8xc2eVrIVHSZOIk3TfWzHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvxgPX/VQz6tGrw7xp9k4Bedey4Ah2HMi5QjvbrtH+NRmv7duOKBDL0Bbedt//AGbOOwZT7xqgSPuZZ3R0YLXkSnCEreFQYjLWO5x56ZTrN2jxB+EFVhme86jWeNSucXg05qUL9obpr/wRM1Iquswg9zTZu+q2WFWnFgPu4VonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=s+6iJJKk; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id YKVDs4FQ0vH7lYR4JszjoR; Mon, 29 Jul 2024 14:09:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YR4IsgksWTQU3YR4Ish3zo; Mon, 29 Jul 2024 14:09:43 +0000
X-Authority-Analysis: v=2.4 cv=JNE9sdKb c=1 sm=1 tr=0 ts=66a7a2a7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=_Wotqz80AAAA:8 a=ZI_cG6RJAAAA:8
 a=xQj0uljQS4amkuhxxZMA:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=CiASUvFRIoiJKylo2i9u:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VPKKq3PNa9jQreVx/gIARXvVUy/hbrqC3/314QEmFsA=; b=s+6iJJKkR2XGxcmFFm9xLPIA4s
	dNNHYcGTnnVHWDjut7CtsJeJkvIVzz/4IZ04HTQhgVguwVgiI1ihVKdZ7a0hDma6e2ijzd20u7Pc9
	hoJnxQCf+zUQVVxP7T8UD130Dlkd1c/0fPYPnJS9UbnrIWBWoM2iplX55jSVEx1bDJ46LFhm37D4J
	QFWz7G2pNhkKtxiu4Gck8RxXpkBARvG/icBWYZDmroQdwJoOvjPVLnNnvEeujWXHacTU8G9IIMCVI
	++8JrQR4KzeN1voHCOygypM0za1WmDMxWIT4j5bIe8BvyiS65W2sxFyxR6FE4XtQ0/+Hj9BKin086
	exeRPr/w==;
Received: from [201.172.173.139] (port=49560 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sYR4I-003bgT-0Z;
	Mon, 29 Jul 2024 09:09:42 -0500
Message-ID: <db367563-e144-4a2f-8d67-d1b4e879397e@embeddedor.com>
Date: Mon, 29 Jul 2024 08:09:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, kees@kernel.org, gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240729110454.346918-3-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240729110454.346918-3-thorsten.blum@toblux.com>
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
X-Exim-ID: 1sYR4I-003bgT-0Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:49560
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLkFA+dP38NhihlVX91BPURArEjse/g+9VNOvnD3WVwiebPG6pVwz8A/LBMwK3Ipp348wILfuaSW21BmJHt0jaob7d6UNppMbCCKTAV6MxYLQHdxeecA
 65AKl6+BofPkXrqa5soJJZfJxS17MgNoPNaDChEz4NQc1zYuztVnARhixA0RGGkneH6sBr9gAqurg6yJ5GoC4c6CxLuO6ukpP0reMt0ouvuRxLIBYSOCrKDy



On 29/07/24 05:04, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.

This change seems to be incomplete. The relationship between `count` and
accesses to `inodes` should be adjusted at least in `ext4_expand_inode_array()`

See this for more details:

https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attribute-in-c-and-linux/

Thanks
--
Gustavo

> 
> Remove the now obsolete comment on the count field.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   fs/ext4/xattr.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
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

