Return-Path: <linux-kernel+bounces-261777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2393BBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161101F24004
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138631CA92;
	Thu, 25 Jul 2024 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="TMCTFQUd"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB32125B9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884781; cv=none; b=HJQ1f3ZbJXme+bEAchTv/d5fMkzsahyo6+KKwOQgMVaoXzuZ7eBGonlH6EtwWhjAy0NC4pgvmWjS2H1ckX7pRM/FqHEgr6CF2qfd8nmyxIw8dVXPXYIJB/JsXIHAdlt06VpG+e/eXlZ9M1OTuLt8IaPBAxPXuKnmia8PKDw9efM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884781; c=relaxed/simple;
	bh=ZHjpwkTDyz7BEoQAQ6I+4a+ZAdQUlWW45v7hAWCnCNs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=UTa6vGobRxXSWkaGO+9sR2j3JZheUfOTC1eTGa4QWKklyDnFzxtZiiSjiiMauCkuQFlNJqigAHnwYFc90j9emRcvLmcDU17SxjZUiD0wMJf2+mX/3tmGioNupoOUbSMeuZwW9Jzv38pPdwz1tYdyFfY0aDa2H+v82iIUBLRS11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=TMCTFQUd; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id Wir9sqs2TjnP5WqrasYU9B; Thu, 25 Jul 2024 05:18:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WqrZsoH6S0vWTWqrZsziZp; Thu, 25 Jul 2024 05:18:02 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=66a1e00a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=TJP467otscr4N1wxSb4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+7+8NFJBZn07NjChmXzieuGlhr6iVn598euCshwhFA8=; b=TMCTFQUdzAtzSAkiaNhJp9j1jU
	Gskh2/JkafUIWgCCbilD41hm2z0LZnib246GW2Q1VESJVc+3i9xNLMYwgJRu0MxKsbmqwq1dkieaP
	opO4pHhaKWStLBGEkjpp5oAQ0s7zjVz10Q1nUIk5ZazLsLkwCWBaSbFsIWUjXVMqy6mtQL6aTwyQt
	GZAWKEVZ1cF+9EkVMmtxNPn+ycUaLvBTwRWcmdbxrZ8mbkMAInyXws1Z2aRJYe02O5ZqpGg//duy8
	RydY2sW+5msk0tJW/+1ViJiAzgJpht4zoufOgtpSJKMatF7rDe8Lzjt/5+urEhM32ybnCzoDYOQeL
	ErL25aKg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59058 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sWqrU-002vxC-1s;
	Wed, 24 Jul 2024 23:17:56 -0600
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180143.461739294@linuxfoundation.org>
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <81d445ce-9881-414b-010e-3d2d34f75274@w6rz.net>
Date: Wed, 24 Jul 2024 22:17:50 -0700
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
X-Exim-ID: 1sWqrU-002vxC-1s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59058
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEDdKXDki2kVO5Xg6bh+v2cbZDrvZCpiNUu6IA2dgGPghCogl1xYxDBYetscQgFj3EgvD1uawv1BTZ2INz6JjE5vLSHK9+V5a8/M2aUewMXIH9ay/ZHa
 4LFEqs3N8hNwAUeBQIDqSfdLlUXfG4hAgM+iZvtQHzKUY9+zZ/d86a1wTLlxsH9yLrrvL315swG3ieDxU8XbeDnBhxfLBqNmz54=

On 7/23/24 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


