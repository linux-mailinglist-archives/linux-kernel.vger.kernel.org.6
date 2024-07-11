Return-Path: <linux-kernel+bounces-249665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240E92EE53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B9C1F2216B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57317BB18;
	Thu, 11 Jul 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uqj7poB1"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536817B413
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720868; cv=none; b=YkXLm4huWFNVZjbJqo7l6knMWrltmMV3RYgWzd6NyP+vf0nWQyLr7PwkAxY5gBz/ltWSufXX+C6VsHjl7+6SlSd8Lod3fFNEUHo5WaoTaM7TkojpHo86K/H36toAEE3G68HykujfdfwuaWyw4fZU9OJlN7ubKafROADVw34iWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720868; c=relaxed/simple;
	bh=YDVcdvG6ChIs2831SkpN8McPGcBVyntfj7BjjGAYi+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izymI2j20MoqSrS3IRNwMdJr+m5RL+IjOTNC8leWHwX2t9Hochq+kdkmSQUN376kQTkefsy7jlp8LVYh1w0DwY4XBxBMHray03E1oXj/xrFbDxxWup+4d5SUoDEm4OZnQEXok3rHOd85Cm7lOb4RF2HJp4wmLL4kVxtqWBAxvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=uqj7poB1; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id RcW4sVIB9umtXRy6Ls4taa; Thu, 11 Jul 2024 18:01:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Ry6KsmIqI6MrpRy6Ks3C1V; Thu, 11 Jul 2024 18:01:04 +0000
X-Authority-Analysis: v=2.4 cv=SJGJV/vH c=1 sm=1 tr=0 ts=66901de0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=uBuKx8GwAAAA:8 a=bLk-5xynAAAA:8 a=yPCof4ZbAAAA:8
 a=fcpcPwWQRFHHgP9w-NMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=wZgZ3yaTFkxMEWn-yT5t:22 a=zSyb8xVVt2t83sZkrLMb:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=myjNqVgpn2sMEdwJcp2nHGFR3UaVBht1oH1YmtP4GAM=; b=uqj7poB1AnsvJpffZWj/KCJqcd
	p8NSRuzOmCAISR7YU4eDYmnapmkhrOkHuSwJHpb5OniCEWq8bNWeMlVW7fzxkq/oUNjgU2Vzh7GPG
	q3aqhm+dZZlFHMb5Q6scfsqtJnZBV1CpSiPFZ4LMkkL/hp9CRvfW7Au7I9PgWYjDibEb3ZYvUk3Fz
	U5LyabOO6pqbHdodqPzu2U2RPEW0UOnU8AQlRTyNGUjgHYUDV2I4IRvsMTBdy7mUG/fgVJkQoVsnW
	PLxOX2bnd7+rIO/S/1dfmkJ8b2XcC0ugCK2pwjxG6y5TZq++ZEyUnu8JB7S8wg1HOl/hb8M/P5ay/
	9J21LOtQ==;
Received: from [201.172.173.139] (port=37552 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRy6J-001zKO-1V;
	Thu, 11 Jul 2024 13:01:03 -0500
Message-ID: <4e94bc51-f699-406b-9522-1386d1b8f58f@embeddedor.com>
Date: Thu, 11 Jul 2024 12:01:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: aacraid: struct aac_ciss_phys_luns_resp: Replace
 1-element array with flexible array
To: Kees Cook <kees@kernel.org>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240711175055.work.928-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711175055.work.928-kees@kernel.org>
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
X-Exim-ID: 1sRy6J-001zKO-1V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:37552
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMjppq0YQjYoZ9EUFVUZpN8i4CSVXfDuQcHktder/7hcyZXrcZ2ve/X9epoDA5KPclSRC8HtLRElTwnavS06S6mH++tHdnPNhmFBkhdiZHIfbwpY50x4
 XmmjKT8PHAxnZOtCVadTwtVBkKihd2RMH4SQ9ishj+i/ILwfYGfOYMJZO9OPIHqupGRBxXF/sXouVnTnsWD9IMyDH5zZgw8+UkH6PxFSH8aD+K+VyBRB3LRw



On 11/07/24 11:50, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct aac_ciss_phys_luns_resp with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>   drivers/scsi/aacraid/aachba.c  | 2 +-
>   drivers/scsi/aacraid/aacraid.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
> index b22857c6f3f4..497c6dd5df91 100644
> --- a/drivers/scsi/aacraid/aachba.c
> +++ b/drivers/scsi/aacraid/aachba.c
> @@ -1833,7 +1833,7 @@ static int aac_get_safw_ciss_luns(struct aac_dev *dev)
>   	struct aac_ciss_phys_luns_resp *phys_luns;
>   
>   	datasize = sizeof(struct aac_ciss_phys_luns_resp) +
> -		(AAC_MAX_TARGETS - 1) * sizeof(struct _ciss_lun);
> +		AAC_MAX_TARGETS * sizeof(struct _ciss_lun);

I think this is a good candidate for struct_size().

In any case:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

>   	phys_luns = kmalloc(datasize, GFP_KERNEL);
>   	if (phys_luns == NULL)
>   		goto out;
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 659e393c1033..6f0417f6f8a1 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -322,7 +322,7 @@ struct aac_ciss_phys_luns_resp {
>   		u8	level3[2];
>   		u8	level2[2];
>   		u8	node_ident[16];	/* phys. node identifier */
> -	} lun[1];			/* List of phys. devices */
> +	} lun[];			/* List of phys. devices */
>   };
>   
>   /*

