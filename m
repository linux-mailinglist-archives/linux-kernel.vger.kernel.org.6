Return-Path: <linux-kernel+bounces-325770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF2975DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AF8B21753
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E75684;
	Thu, 12 Sep 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ckLE5hWj"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA25227
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100815; cv=none; b=ascN3R1q3EWqSdRmwktjsc12tl8+JImePNvJXWWbyZuIiMR8DGm+pc1Rary/kRuVwtoEpPH8zrljBz3IWmGD+aPSBO658Q1b4BHrsutGfc3exWckv7FnS/Dk4jfUDZECCA2w4VxzQIHZBH5rw8f/ExmXVszXhe04l94usJKeSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100815; c=relaxed/simple;
	bh=XMTB1XLUsoXSg1dt23+yTkz34qtAreCymRiIQF7VHjs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jMxvSt2zspLkNfkDmGxY983EFiSBgPzc4qnRld93Csu132zNHWcwjSC6Kwv4GUKqY7ZgU0b3bnrY2lJkv8stEby2X6F22ArtqOWLpBjdulR0YtIs9dyVcrFuB6n1GqgM0EdCLLBNceTMDnSC/4+9Fesx0L8uA8RYnJH6HZp5Wew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ckLE5hWj; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id oKtqsScCzqvuooXfbsMXcx; Thu, 12 Sep 2024 00:26:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oXfas6eNPeieBoXfbsx9IM; Thu, 12 Sep 2024 00:26:47 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=66e23547
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=YArTxWWgIjO1YVvZgRQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KovrM432fvZQJr1UINgNndwcxcuS609IiiXHVf6iwhc=; b=ckLE5hWjvOwFeE4bkq2w7KEY1+
	+OKS56Qgbi7pj5WcKJFSKzOErUdI2uNAniVffZWWvsUjeA8wEeqlbLiEAxy5bvQa3j6ZepouaPbO+
	zE+uE/ZYNZYWGpBqRX2CCdzm92qim8mf/757zV9LyDEj7t+NjPhef73mv9pkwmaHsgd/qZ3Be9O4e
	mvUugxDHoPw0+mwoutXy8ICc0Tc6YaMns9KroKAycGjmvO6+POFbywbOWFfQ8euEtiIg5bWchT3w/
	ck1rHhnQJgCzsCc4+Ss+/cWiNiqrD/h7HmJVKQv1X0JQWcrIMQqYZ5xAkRTgYLb33QF8aPgk29uXc
	lKs5rrbg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39884 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1soXfY-0032CT-2P;
	Wed, 11 Sep 2024 18:26:44 -0600
Subject: Re: [PATCH 6.1 000/186] 6.1.110-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240911130536.697107864@linuxfoundation.org>
In-Reply-To: <20240911130536.697107864@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <1859c7f9-f8fb-aeb0-fe81-36538fa1190f@w6rz.net>
Date: Wed, 11 Sep 2024 17:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1soXfY-0032CT-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:39884
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIyRiF4dAnIZ8sGfGdAMi5ShGwW512ouAkk7m0eX3jlzQi98aRJSARObGl7XavZHleBazsXLHAAo29i/obGNOt9X1r0ENGjoRrRf8eIWaAuQK9VOVPo3
 WGZ7cUCDHnbUBjyoARpuWqmz2MJWXBSGHBbXyH9xSdFQ3OQsZzaeLqct/n6WmGWElV5+Vvw2Swo7ID9F5hWPkYX4oXVSgaDqGb4=

On 9/11/24 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.110 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


