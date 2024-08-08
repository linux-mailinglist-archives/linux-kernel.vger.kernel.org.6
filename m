Return-Path: <linux-kernel+bounces-279696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8E94C09A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE8B1F269A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD818F2D6;
	Thu,  8 Aug 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="QPOJcy0b"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEE18EFC8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129872; cv=none; b=pU9ed7qXFOOojOJLbK6kz45WVI12zQwjltJlx+0EZCCWX38Y+R2841zdAPD3czNKkbSQ/lEyu1Agr0huMfidUUYajmAShKGMz22ImWp9tEX+s8xJclnwrTievd6lXiJ+kpnLkcVP+r5iQSDhOTWIiSJAwZaR2jeVMBEAnHVapWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129872; c=relaxed/simple;
	bh=iI7j9YM9NkAwGs4tVidYT/BcH0w5Sb7CColD3m3raU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQNUpY2FqjJIyTotdgUREyUSBL+mjM+TE6gepC3ZM3t/Q3ZOomxkxphephoImu5Gzm+yCsbZHJTsyPhUaQgUoSIj4EmXp9b+67vBS0uVVRIPzcIKbawyyMHGe4oU0xV+PdtLUd7dkn/9qtfw74MmzkO68CK0W+mC5/Qp6I0a3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=QPOJcy0b; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id c2EqsdEApiA19c4nEsFnQN; Thu, 08 Aug 2024 15:11:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id c4nDsNi5scHN5c4nDsIhhF; Thu, 08 Aug 2024 15:11:07 +0000
X-Authority-Analysis: v=2.4 cv=W64+VwWk c=1 sm=1 tr=0 ts=66b4e00b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=ZI_cG6RJAAAA:8 a=VwQbUJbxAAAA:8
 a=bAOmJZEJ0AiGMNYyOQsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=CiASUvFRIoiJKylo2i9u:22 a=AjGcO6oz07-iQ99wixmX:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qMvp7AEo4WmmqjYvoT0LxSj9ZRUdxlBj+1r+x+WzKsg=; b=QPOJcy0bKYUHFKPiOS+BzJO7Zp
	hGLQy30vuBk2njANV6abwBg0NNmarHyj6+WEtgsxSWPqovSklNnH8Up9dqjkJYmLnU8NBYEwT1Okb
	YDz0jXOfqmglifhEestYNCfQFRtX4L67ElcJikhYwUQUko1sd4sBKb+EJJwy1ldxPkS+2bjldOV4O
	7qzHbSKRNluUdwogVg0sgQ0pvc8XkUzu5wFq5E+LnuigRPXy05mqYclD1B0waOlyAx8tQ01SAGuIh
	a1rdOTlrlZTJ8t2mtqWCmnvxaJPk3TMsJeVBCn0qY452n01zJvxlG6Qiua3vKFxWL3746M+hdwvSa
	zBDyjgVg==;
Received: from [201.172.173.139] (port=37952 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sc4nC-000RNY-2T;
	Thu, 08 Aug 2024 10:11:06 -0500
Message-ID: <481a0b09-2e6f-4076-8e03-6205bae31f59@embeddedor.com>
Date: Thu, 8 Aug 2024 09:11:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/select: Annotate struct poll_list with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kees@kernel.org, gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240808150023.72578-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240808150023.72578-2-thorsten.blum@toblux.com>
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
X-Exim-ID: 1sc4nC-000RNY-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:37952
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGXBNDyKUmjKCCR2yWVp8ToRkAB5UoyT865QL9A96tPKikwEpT/w+ZbHQPZVkqUBecGDImQYjZ1QVPCQlN/GnVA/NUSggxqjp8eZn4mOdzWAdmYcJTz0
 zbUziB6SHLA0XPWYSFWwr6Gr0INUkijEGd8Ti+QcR/fo/SWpZYjaNXQLuqWtpG/XJ/uIsBGIS+GqtjKWUrbc2RG6XjuiXMPggtMx+C5+HMhPvj3HwcBhUsfz



On 08/08/24 09:00, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   fs/select.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 9515c3fa1a03..1a4849e2afb9 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -840,7 +840,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
>   struct poll_list {
>   	struct poll_list *next;
>   	unsigned int len;
> -	struct pollfd entries[];
> +	struct pollfd entries[] __counted_by(len);
>   };
>   
>   #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))

