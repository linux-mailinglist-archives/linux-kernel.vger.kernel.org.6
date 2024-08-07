Return-Path: <linux-kernel+bounces-278160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0694AD7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF2B23512
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD905126F02;
	Wed,  7 Aug 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oR6kY+5M"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754383A06
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044562; cv=none; b=DGTITrluw5x/Ff8vyKIewR+0qtQ/JyEmBm/3K7SCtT2Lvxk/flPV2xhpHOw+NyJOlNy0ulQm+id2uiTQwcG2Rb1uTWUnkfMbxAVPODJIyr9/06xWAi9Fq69WxdkupFDYfJ3n93apJdptFx9ft6XsHKddHVM87orHoqzbFjj7mfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044562; c=relaxed/simple;
	bh=W/j7ofAjp4lBil8BOqJhV6WZEhxedjS2h6klOSbHmqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeIc0FAKE8PHOCq4MjU06fColsiSnpsk5wY6aFBvNM8ZZ6uW3cK+D7Ov+vsKb2E8aYJf1vvuWClJjDLCgFqtd47nYXZmfrESZPGII+eBfpH2X+jtXEPzJTus5FQEbQ3JIedMmPHyf9AK+SLKlvvuvg94CkvG+S4fIVEnx691fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=oR6kY+5M; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id bfXRsG6s8VpzpbibCsb4Co; Wed, 07 Aug 2024 15:29:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id bibCsvFLsks1PbibCsc9F1; Wed, 07 Aug 2024 15:29:14 +0000
X-Authority-Analysis: v=2.4 cv=Ud+aS7SN c=1 sm=1 tr=0 ts=66b392ca
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=ZI_cG6RJAAAA:8 a=VwQbUJbxAAAA:8
 a=T5MvzxAiUVsB-E4yPXoA:9 a=QEXdDO2ut3YA:10 a=CiASUvFRIoiJKylo2i9u:22
 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=59150sAKwGxpaYJCN77m/MKm7XHRkgxuo8ao1z77FlU=; b=oR6kY+5MtJW2lfQQH8jwxz/n+p
	ld81JKyBLNDPwW+Cml04V8/YNZ+m9EbK5fYlWqkS0DRw06/eEgGGUPTtx3nWFQyZpzaojkyN1PZa9
	9q/6p2pNuzRgaxr1FKfrxYzuDnBBB1FXNnjn6AY9BaqaDoS+8awdi3FOxFb2eZWIe8u8yTNvanslK
	0+zoFCavSaelECC3pbjxZKOwO0Lwyoe3rpXYgP/FOTsELsFK6xrG8w+rraBprKCIUUaiX5pNx63jx
	eE2ASEnOyS5h8EGLvwM1SA6TMbQHbC2AoP2EG1nXMde48ypRIC0zac58hZ7JFoqf4df5RPez/EtMp
	HzQUZgyA==;
Received: from [201.172.173.139] (port=60294 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sbib9-003NZG-27;
	Wed, 07 Aug 2024 10:29:11 -0500
Message-ID: <bcb88692-a384-4da8-b2b9-a116ecb17530@embeddedor.com>
Date: Wed, 7 Aug 2024 09:29:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Annotate struct kvfree_rcu_bulk_data with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com, kees@kernel.org, gustavoars@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240807095459.1400-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240807095459.1400-2-thorsten.blum@toblux.com>
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
X-Exim-ID: 1sbib9-003NZG-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:60294
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP2dQZq44CUfsv5Yf/JriflpmlmGYnqhspR7WkAW3x7Jbrar7ZyaOM3tIrwILst/Op7Ej6COdvbmNqMK0kW4bD9LAKQBjMTzGp7lThzN0xIJ+H7DDxBo
 KBPoHgmdDDa5CMgQw4unpPQPhR2PTbnGsv3ua+Yi58ApDrQvr95+CCEWJafRGREdxHtLSRQNt33vmF7t9YLyFdNkgxznR0DAzX7WS5wyHMXFIBPAyvNaYGpG



On 07/08/24 03:55, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> records to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment nr_records before adding a new pointer to the records array.
> 

Looks good.

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   kernel/rcu/tree.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..76d8d75dd8b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3227,7 +3227,7 @@ struct kvfree_rcu_bulk_data {
>   	struct list_head list;
>   	struct rcu_gp_oldstate gp_snap;
>   	unsigned long nr_records;
> -	void *records[];
> +	void *records[] __counted_by(nr_records);
>   };
>   
>   /*
> @@ -3767,7 +3767,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>   	}
>   
>   	// Finally insert and update the GP for this page.
> -	bnode->records[bnode->nr_records++] = ptr;
> +	bnode->nr_records++;
> +	bnode->records[bnode->nr_records - 1] = ptr;
>   	get_state_synchronize_rcu_full(&bnode->gp_snap);
>   	atomic_inc(&(*krcp)->bulk_count[idx]);
>   

