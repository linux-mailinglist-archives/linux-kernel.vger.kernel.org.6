Return-Path: <linux-kernel+bounces-530552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546EA43506
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A70C174E25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86232256C95;
	Tue, 25 Feb 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="LeRyD6bX"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59206256C79
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464215; cv=none; b=bTr60yIDM06QDobsgD/82FKnEJZGUIOyau2l90LLUmxt/7pQZo51I2eJPYszxSZryucMj7+H4sNr6k32hRqWLGiUuYfCuBSljbK6N71Er/lFYLqZ5Z+gZPJP1VdduMy4b7J2EiTEh6ioo1meK30xz2iPPaFvrINHP/mk+Jo3Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464215; c=relaxed/simple;
	bh=8NwQDY2F97vhtGE7PY7aQgTZGVkz2b9kWAbvKNyu54I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+ttJUYMsnKLtdFm/ynUbdjdA0yjPLrntHA6NwNLCaAmpP0eb5rhXz5/bhUvYxwMyPrPB67zAcwRloJ0KqNEwm7o6jEsEC6bGf0e2nonOn4dAvS959fVuvJ4YryxPDE2Y5yc/g6lKKCxovGlXQkszxQBT1dVnjfZUayEwEaqQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=LeRyD6bX; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id mblDt4oXbWuHKmoFLtzTfv; Tue, 25 Feb 2025 06:16:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id moFKtbIwCb7c4moFKtmL0Y; Tue, 25 Feb 2025 06:16:46 +0000
X-Authority-Analysis: v=2.4 cv=KvSG2nWN c=1 sm=1 tr=0 ts=67bd604e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gfm3JkRl8laNhj+DRjuc1ZLST9I1cqiWY2d1jYJrjAk=; b=LeRyD6bXytPD/ZUN6Yi/oDugbK
	aVeq82FzMP9FhVE64d2yp2EP4JvutW5ggesKuDwIeUVj3mssRgaVz8D3RqHn7FUk7bDzRt3xi3C7f
	iX5LFRWWnk7dDRW2EKpvsavwDoaHQjPjxhd5eBYXJ+2GZuLCUrvyLpN5lhMXIjeeLkq0L3UbtQaMk
	GnjIprhl20GSEQWWzBQ1ddqeWkFk+KTzrpuDmrzngpRv68CmGBq6T9/L2yqDoFOfc+IMs3QyhDglH
	9rlonBe52dWqx88yfkvrGG9GZjfAs0nnK5Q3z/fIjKnoM2FU5SCJ9EJ1fKk6u5H27hduJkMO8w3UE
	PhAsdBfw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56598 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tmoFI-0044IT-0P;
	Mon, 24 Feb 2025 23:16:44 -0700
Message-ID: <75134cd2-1d0b-4dd4-b15b-5a9d2ee573d1@w6rz.net>
Date: Mon, 24 Feb 2025 22:16:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142604.442289573@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tmoFI-0044IT-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:56598
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfArWWW5pznvinlC8WmRxb4SYrE4Gc3mewtuRyBjHDS+53sKSEglLvPhg09FJUzs7XVRlF9BdltZfrXp2WRiSVRtJI8kUTd5QlYhah5d29GLR9vtcTfRh
 iq76UE4P/3D4l+RbbYTdwIytgr6fz8dGk66c5l6kUXwjF1tQteXtPq2yOpNZbbfDM1upGvxIFuVsAzPXJShUw1ZJv+oUlmQ6Zfo=

On 2/24/25 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


