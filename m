Return-Path: <linux-kernel+bounces-247630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60C92D232
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC461C237FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D019246B;
	Wed, 10 Jul 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="siMegNKZ"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B67191F8E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616632; cv=none; b=bkEAI4gOA5On8VPyVhYVQTC8ow0SL5vCoIkiI8dbHGhBsfj7GYwxl4VjiG8EgJJdyOrYEG6sju2xmaoJEgzJISnX82K9MrGjMYTpwRvr5jajLTBzjE/ajIwX6V1WM+nq+GWbe7y/+Grc5/Oqs6zVtPLDC4h6RvxRDTLIucSvzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616632; c=relaxed/simple;
	bh=PZA48+8vXR+9UlqbJr0yjffRRLrdgo1HeLb2jM00s2U=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=t1bfkerPTD3JknebMF5GF2Q1YUn/uMvEsfR+8wNvcp5uK4paStfg1GeqRkwlZhPSOJSmBRPv0ArQRPuHccm7iq39Nk+ZZ8gFAMYuk+Laq5LsXCU3pUAril8/w+nSHxR/q2JenLhKT6MzefUM3IHrLbpi3RQHIJvcNfZG4IuUezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=siMegNKZ; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id RMg2s1cFixs4FRWyzsXG7I; Wed, 10 Jul 2024 13:03:41 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id RWyzs5ghMYDozRWyzsDIIq; Wed, 10 Jul 2024 13:03:41 +0000
X-Authority-Analysis: v=2.4 cv=fIY/34ae c=1 sm=1 tr=0 ts=668e86ad
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
	bh=4bCEF7jR7U9Qu850axJuuIEXdRf+kVAmTZ1zPo7TJuA=; b=siMegNKZWM1urBQAzc7tbfcgK6
	INXktWbzEs7ODj5D4ZIN7JinNi2fLFf+1YX+P0VfIr1coF07RvD6EY79boMFEkoOmPgjjtQKvmXWK
	T7tfJhtpXcAhhp9s3ErdMPWac566prE6oVRm27ETOtmVWpz8degugfSXrmIeI54BgiD+AUtjP01RE
	2pkhWKCioPU7VWHJVDwFUDLj/MMovztfcuYp6WUWTEpECTXVN8zUUSQfee4W25IoM0jECkvYRvLz2
	3aOqDJWURYPo+NG1UJ1MGCXZ/Myzi4Sbg6i+t3euP4YI3gskqrGpRYZIL7dENxeUP/ZHBJm0nKRzD
	xIKsDGSA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47982 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sRWyx-001fQc-0A;
	Wed, 10 Jul 2024 07:03:39 -0600
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <985a10fa-26d0-22d7-aa58-686f7e5b8427@w6rz.net>
Date: Wed, 10 Jul 2024 06:03:36 -0700
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
X-Exim-ID: 1sRWyx-001fQc-0A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47982
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNX8n+oNk3jfUJ3nPVxV7DYjccr6cz4R3vDmTumFhmIvJD9yWC/Bg7sk2AyL+IUJiwjbeptNV5u/lUkVKboi0O3WPxJDAV6U6MCdFKxSH45FVx7LsEJ8
 Y8exaCv2JzsizQZ9AFuOAP1sMY3y+vBXZBtHJxcUXSv8MeT4xInkF2XvldzYyfEVQwStCOVQg9TRhYgbWtNU8v4hAgEEesjLlQE=

On 7/9/24 4:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


