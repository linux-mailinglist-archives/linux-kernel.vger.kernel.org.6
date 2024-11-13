Return-Path: <linux-kernel+bounces-407747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C609C72CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE223282626
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5F201254;
	Wed, 13 Nov 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HNA470DB"
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD021DF272
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506852; cv=none; b=WmuSC98YHboz7jxJJlu1hrTho4pYx68etNMrg46Rr8+sJv3IFqxTDovoK9sob0TeqgMWcTDEDaIGfgVxa0rA9a/2Mtsn/3cuUdRVor+TLxEYc86QjtBleOJwU+8tPv7FWL8gH6/IZ7+/5UsZyestOdaPWghhLDhY8Whqk0ezAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506852; c=relaxed/simple;
	bh=stbjx1OqrDDsatYoJ9pZlLu6qgH1KqQ3f80ZqrV4Zbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOgqVrKNI1kNiimFP3X8bX0UuYqqMnu5u76nzVVmTtKU+uSW/VymmE7XWH7z/Ras/pGreEAZ6Xx03nsQgPSlWck64JylLse4u1Uyeg4DdM1U20fowwrs07xiFzHNAUKrM7Y5rfRNa2pM3JN7G4mVm9Cu6T4XiV+xBmAOWay34sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HNA470DB; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731506850;
	bh=qVTlSyyjtvQdM64Zmm10e/DxGtBRJlNHmSajdSWe2lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=HNA470DBfzz4N5AHrnQMa61v3cSoeFwhC2ag3WFKPR8QArwpmrsW+VGzZsV3G3kIF
	 PtdoD5M4CF7rmiavulR0BatATR9c/nPZpJtpw66uYbCfGWiyLmMLVgL3SsZ8ZgxjsX
	 ABo0r3UEXPsBu1yQN/BiawlDu+3ZJ2nfb9CbOrUQbdvT3OAORKHzashJa6bEfmuE0A
	 uN5AYZEIHLm+/Wm1mJOwsbxCmrh5Rb7O07dKRds8CxJBCOSVnm0Hzf4Rc48pm7VL5N
	 Q0ms4RA36mjdF312jNniNok25ejsMKTLbG4w87eh/ZzMRBuBIPWMlirTHgWKNM0Cb6
	 wRpVGVOhlCooA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 70DB2357AEEB;
	Wed, 13 Nov 2024 14:07:27 +0000 (UTC)
Message-ID: <e69c7536-f184-4588-bdec-62b79d39c411@icloud.com>
Date: Wed, 13 Nov 2024 22:07:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/resource: Simplify API __devm_release_region()
 implementation
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 ",Mika Westerberg" <mika.westerberg@linux.intel.com>,
 ",Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N5buc-DrvC8-TQnn4bUTJ7H0UX7w60aX
X-Proofpoint-ORIG-GUID: N5buc-DrvC8-TQnn4bUTJ7H0UX7w60aX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411130120

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
> ---
>  kernel/resource.c | 3 +--

Hi Andrew,

There are no maintainer or supporter for kernel/resource.c according to
get_maintainer.pl.

could you please code review for this patch?

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


