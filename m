Return-Path: <linux-kernel+bounces-399118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D799BFB34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36B71C20F54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C779DC;
	Thu,  7 Nov 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CqsV2jyj"
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6B747F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942013; cv=none; b=P4RS6yWXe3dovgMFkjFbaN3c6F8TZv1YPQwZ+Po9/TJTO5wp0I7PmZIuiiLEWOJkitQSfCYVyydbYZXu702NHWRMTo07WogYb0styGRDe7yHBI+pwU+dDPsgCJbRjwIV5qXtOnZcBnD8FFZcMEM+LgN9P7B0yn+N1yIdXcvrBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942013; c=relaxed/simple;
	bh=LZMniHjad37aI8M4+HIokqUCgv67FbeDnjc1o+KI7Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmILkIRMGqV6lseZvR7jtAzpYtZmak157ZamDdJ+osBXMNNM7HFj/E/AnyZc5BWOTDozRwX8ej7XlwNFonOplx1Jf54ukMViiRTmiSqfhioZOAPfFQdaH2NCmfO8d+tSkXHkerU6xJmKsYHAQ+Gp54UswzNwPpEGmClqFKGwvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CqsV2jyj; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730942011;
	bh=/Z8pbzoiYHHbyzDW0mAYhvoe7YxtHhV7s/+GMcuWY7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=CqsV2jyj+nlc6dsYuy6mDFmEWe9cCWEtT9eLnwYzvV/myKcWCOJHTc0onOoxjiSdX
	 Hw7AIP/8xDvUHut7VbeXo3dmKKW8i4fFRd9DTUUQs7LEJ6GX3tDkWN3rnbM59U9Jz0
	 6HIxmmb6M/Bp5JxTxdsCNYHIUZaMGOnAzCUOH6/bxXurGcbM30MT+yCQv/Bk3iUUuM
	 9bj9pWI+PEMOjI1dLM5BMtravUdcXZPXWl8s4ycOSzLYIo7u3+6+wzIa++CgkQnZXD
	 aRe7vCV6l6db7mGmOfQWsUJXo2t1gNcpsIpbhDCPqxT8L0Bf6JQdV8LIjrv1GFA2/O
	 Jsc237xCY6zuA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id AC4493A028D;
	Thu,  7 Nov 2024 01:13:27 +0000 (UTC)
Message-ID: <98b7f3d3-ca42-4acb-96f8-284f2a52e1ba@icloud.com>
Date: Thu, 7 Nov 2024 09:13:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/resource: Simplify API __devm_release_region()
 implementation
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mjpiRp24yEdEUGUydOANRzHe3bsLSmg7
X-Proofpoint-GUID: mjpiRp24yEdEUGUydOANRzHe3bsLSmg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070007

On 2024/10/17 23:34, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify __devm_release_region() implementation by dedicated
> API devres_release() which have below advantages than current
> __release_region() + devres_destroy():
> 
> It is simpler if __devm_release_region() is undoing what
> __devm_request_region() did, otherwise, it can avoid wrong and
> undesired __release_region().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> linux-next tree has similar fixes as shown below:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ee4dcafda9576910559f0471a3d6891daf9ab92
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9bd133f05b1dca5ca4399a76d04d0f6f4d454e44

gentle ping (^^) (^^)
sorry for this noise.

linux-next has one more similar fix as below:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2396eefa075a31884d3336e1e94db47a0bd2a456

> ---
>  kernel/resource.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b730bd28b422..8d619c449a73 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1673,8 +1673,7 @@ void __devm_release_region(struct device *dev, struct resource *parent,
>  {
>  	struct region_devres match_data = { parent, start, n };
>  
> -	__release_region(parent, start, n);
> -	WARN_ON(devres_destroy(dev, devm_region_release, devm_region_match,
> +	WARN_ON(devres_release(dev, devm_region_release, devm_region_match,
>  			       &match_data));
>  }
>  EXPORT_SYMBOL(__devm_release_region);
> 
> ---
> base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
> change-id: 20241017-release_region_fix-2aa7f93367e0
> 
> Best regards,


