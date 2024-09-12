Return-Path: <linux-kernel+bounces-325767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF981975DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA290B23CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D652119;
	Thu, 12 Sep 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ohydCrMz"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589E10E4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100498; cv=none; b=XMvQowkme7YC6IAhsWChyDRTL2IyC83M6Xr3zlD3d/U7G+0mcTF7y1qpuRgeyqtq6hJtMET91X4RUug6gsi6tsA4h75wUW4EX57A3r6GhATx16snMJcnc79N64TRkeEfma5YQS6wWwbF4bNrqN+vErEGurflDJFGxGaZdNEORVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100498; c=relaxed/simple;
	bh=cQ2PPy6BQnHSzXL9cvH2YXAics40KwvcEdAvbsl22DM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=vE5j4448AIr00m1wP77PSSUBE5QQtWXbZApNQPbeVi11zmPCFOp8TbvKkXMGFm6/nXxV+UYS5L2EJn/Yj4MtaE/TPUkJy5W5xnBqo7isx1YF/FLoh1ZbC7Rgfa76z655j1lZGB49IgmfNKvLvh6dulN1/5KT+6WSqI2hLYk9aiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ohydCrMz; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id oUdCscob0nNFGoXZ0sbP9c; Thu, 12 Sep 2024 00:19:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oXYzsJawbP7VfoXYzshBYu; Thu, 12 Sep 2024 00:19:58 +0000
X-Authority-Analysis: v=2.4 cv=XpL8O0F9 c=1 sm=1 tr=0 ts=66e233ae
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BU-0VEHJLDsOG5B_DZEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hSHHOq2isCL+OJlpXZ5Mep1uuVHPo4DMKeYf7OHXLUo=; b=ohydCrMzBUF7HUw4rMcp9E7dUp
	17yDNJEsVVQcS2H3vPW5D/nDLsgnLAO/u9lFPnR1tF5kEH7CyPkQfWlJ6FMmbwnUKv0qkOf8V6KEY
	pP+mJbKvDaLgYF7SRAkVG4EZYVDX2+tzY2JbN6QT8tfGdbOGUkq0ByOjw+AYRNRSF5n44jLOKSabw
	wQiMkas/aYlrOZ6B4o0/uneJA69Rx1qL5c7tRV7bESQtosHlAWRmdcyqQ1pzu4G846g5tUlpSjTzX
	adK44chLDvQuouzzBxWeXcOiMD8ODsL1WU57KUZGy7S01bQhn5X98JF2MybfOWhBl3+31zPo68Akm
	f7mDHcxQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39872 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1soXYx-0030AM-1W;
	Wed, 11 Sep 2024 18:19:55 -0600
Subject: Re: [PATCH 6.6 000/269] 6.6.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240910092608.225137854@linuxfoundation.org>
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <c1abc9e5-5e04-028a-b1f0-f6caca4b0793@w6rz.net>
Date: Wed, 11 Sep 2024 17:19:53 -0700
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
X-Exim-ID: 1soXYx-0030AM-1W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:39872
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHkUK+YPKrW/4hlSc85QcGZ2LxLjGYvb4f6R/faPKy1OsQmKK2ER9gSy0p0AsAo4TgG9nzegU4GqFzSva8KmGFxtLvgucFGyCqTncqwxYYnr2NQ8nEOG
 VYZa57/D5BDfRabdvo8qtziccH0vocNxHk66bMtWDB3AADw1RpQcu66I49RGZ1n6oFA8Tfxr/wU4oTFRGkUuIaHp+MDZxGx8kCI=

On 9/10/24 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.51 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


