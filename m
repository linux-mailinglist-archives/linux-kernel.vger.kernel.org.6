Return-Path: <linux-kernel+bounces-327504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ABD9776EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29012B2130A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FF91885A8;
	Fri, 13 Sep 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b4AL+VWQ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53FD2AEFC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194830; cv=none; b=HF35Fu8IkOw4XF8asW5wsrrP4P1vmlyO6EIk3JpWk2SuPUpvYdRqLkiDhEWvur0LCGdq91StJVYj+uAduYimuyymHHVJ3HrcCC7BgGpPlu5Cd2qDV+R4+QrfmLF74LsUZFXYcgjc0SN3FMMn45Bc8hoU0k0qf3Od0FAbAuulkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194830; c=relaxed/simple;
	bh=NdTkWnpysOIzWCxoeKLkto7GLif67/SO2119cg6rYqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMylGerHcsm3cLI3KnjXCF60OEzDmJQ9PV0Lj69U/ugy1P3fx4NYcoXdR4pGcO3XDQ/xELlFa+C4N6outl1rTo5sdvhcsfJw6jAN2pq4qXEgoD7ON+eoL1NcMRbNnTI1bITPDh6mQgktlFJIGTBLxU2eaUkLA0rJRqq+/UQSihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b4AL+VWQ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=U3C86QQWao7tuzRN4lIMwsjWiVhXXFRyJjitYGN9wdU=;
	b=b4AL+VWQp+Q+cDWfc5ADENzwYr4SRN6WKm92AiyxiizLVv9EXKAq7lLCC7BEOa
	X8MLdSU7yAoTPZf/eVsH5gR7VI0RWcmXInr5MbWBaI8C54mAPL7+g7z+I28Sh7WT
	1TOxO9MUFjkRWFc99hyIj4A/RPwFb+fawE1Er9se15Z58=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wB3_6l3pONmeXiNMg--.40278S2;
	Fri, 13 Sep 2024 10:33:27 +0800 (CST)
Date: Fri, 13 Sep 2024 10:33:27 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Remove the unnecessary 'if' statement
Message-ID: <ZuOkd8dMur08t0zo@iZbp1asjb3cy8ks0srf007Z>
References: <20240911015753.49513-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911015753.49513-1-qianqiang.liu@163.com>
X-CM-TRANSID:_____wB3_6l3pONmeXiNMg--.40278S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF13Cw45ZrWkKFy8Jr1rCrg_yoW3urX_Ga
	yjka1rK3Z8Jw1v93Z5KrWYgrWqgFW8tFsYvw13tF95CF45tFZ5Za4vq395AFsFgrZ7ZFW7
	Gwn8CFW2ka4YyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbAR67UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRJZamXAo4kDXgABs3

Hi almaz,

On Wed, Sep 11, 2024 at 09:57:54AM +0800, Qianqiang Liu wrote:
> The 'asize' was already checked to be less than SIZEOF_RESIDENT.
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  fs/ntfs3/record.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 427c71be0f08..0f400366231d 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -268,10 +268,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>  
>  	/* Check size of attribute. */
>  	if (!attr->non_res) {
> -		/* Check resident fields. */
> -		if (asize < SIZEOF_RESIDENT)
> -			return NULL;
> -
>  		t16 = le16_to_cpu(attr->res.data_off);
>  		if (t16 > asize)
>  			return NULL;
> -- 
> 2.39.2

Could you please review this patch?

-- 
Best,
Qianqiang Liu


