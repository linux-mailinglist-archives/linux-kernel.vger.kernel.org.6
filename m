Return-Path: <linux-kernel+bounces-241935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3A928183
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A71C1C227F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812CE4CB28;
	Fri,  5 Jul 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="kTSkqkyX"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006A13A88A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158642; cv=none; b=RpE1Gg2JAA1SvooOIb0p/qkexP0rvI/DLAnelqVqNAK1ZZ0HihtYIykyU0ICJGk7M3URxAhCNwVJT0YPcRgWs5vE4TRs3GPfiOy3zN5uTKDgFkd1bEkNBcJZDeZxvtuwMT2ekEAt3OGy6/IbpipRvFuzHjFq0toensuJe0Xfp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158642; c=relaxed/simple;
	bh=2wYzthuZ8kDfQUIPG5TCWw/ONYN+ILCr79+g50WweIc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=fW256sEHxDqMd26LbpV3SPMdjL9wyyHUSjkwCjBTlRGL91qpF6y5Tl4Cncu0PvoG4nppXj+thbUaxlDbDNxK4U6dezOsYkehM/FYsMmp1eEBucRzIj/Pk5NnpsmIWhQm20GkF+TB2rkCshlhjXJGeuJbHHlgl7LEfzbdThK4i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=kTSkqkyX; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id P0DksWvSUxs4FPbq5sm2PA; Fri, 05 Jul 2024 05:50:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Pbq4sQpDgDweaPbq4sVMrh; Fri, 05 Jul 2024 05:50:32 +0000
X-Authority-Analysis: v=2.4 cv=BcYT0at2 c=1 sm=1 tr=0 ts=668789a8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8BM4xLTM5nKzOUQdiIzCZ4Dp7kjQR2h1ogwZ6shdbRs=; b=kTSkqkyXfKYj59Hu3ZSjwBPVXR
	gbV1mx8qgzfjh2pkia36pSyyt8xaO0j6CG8E3TAH0YbpEXkOqBe+CezB1048RZuMv9mHB6CE7YhC1
	XgBANAYIg5V3K7Ux27u6ERkYSZv6selWowp4EDGvXjKbaCWoV/gNkt8BcbtrRShaOjmf5v80dJVV2
	Ksfyh7qblOIvX4NCkLSSg6bPj0BR0ekKDDBitWmRZwiH4ncHwoUzOWCe4lClpS5Z1dgv886487a9u
	pzXML45AHwg+7KzAue+IyF/F4aE8lmxkb/gVLN2PETuoKmUW281Rws9VZ1eQgIQ24vm23F3b46A5Q
	0okfvUsg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47186 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sPbq2-002jJs-0Q;
	Thu, 04 Jul 2024 23:50:30 -0600
Subject: Re: [PATCH 5.15 000/356] 5.15.162-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240703102913.093882413@linuxfoundation.org>
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <2f59541f-d238-5072-0e71-9b40ea1638f0@w6rz.net>
Date: Thu, 4 Jul 2024 22:50:27 -0700
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
X-Exim-ID: 1sPbq2-002jJs-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47186
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJIUA/whBFuYE19LEeybbL5OEjSRvFIwW8pOHuFa9T6+iBpA8IUBzG9eUHAXxFKHv5P6qTqYd+S+39uQ+C5puD22jBAB5/XMWqF5sjkbpyw7nmXiusRR
 ygZvraMmSucJHsnsskrDxDGiptiqsvBBkq2cexFtyb3XwHWW/AA/GJF482pVn1UqpV7Gcghs/LxFPOlEZEPqCp+owyx8aQQiR0A=

On 7/3/24 3:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.162 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.162-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


