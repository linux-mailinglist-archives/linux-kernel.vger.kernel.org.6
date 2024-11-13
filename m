Return-Path: <linux-kernel+bounces-406904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EF9C6622
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D669B32269
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30488BEE;
	Wed, 13 Nov 2024 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="1wyOMHs9"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339193C2F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457479; cv=none; b=qgsfu6PnCUmWl+RzHm5pjzlEW9GctbakmuxFvpGNGne2l4DTIl4GZCf1lbwrRO9z4fQXs+jpqwHT+ljGfuR8EEMLeU6gJMdiWHeG1WwC/qT9eA2eWAqJNOuWWvcSMOyUIOkOQbj5hCyp2aK4BrgBapQC6hvM/3RU/sdmZAiDSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457479; c=relaxed/simple;
	bh=fuVcME5BsYF/KDmWaecJg6j3aQXYbUoEbKBzj/5I31g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6pR+sZPd0s/7PMXNHTgXcg7XI2XyFtUbmyjtZCWdqyzWA4u0MMQdxuVEodxetciBpiTygviDW3bmAY91yDbUNZMnANQrqtoy9teTXfAMaPChHwuC/xYl8DpNgkZTWn+jZC9hIAxGNlD3b/3RlpLF4JXRjcX3RJFweroArbJx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=1wyOMHs9; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id AXIJtyS7bnNFGB1BOtWNgY; Wed, 13 Nov 2024 00:24:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id B1BNtES7K827nB1BNtBN9d; Wed, 13 Nov 2024 00:24:29 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=6733f1bd
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Xg3r5l62jPq6txtoRjwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K+fIiBWt3QFvo0A/lr0YOtxvjEv8y0POVh9URifPW0s=; b=1wyOMHs9YO8LVEQwXAXuHF3oRU
	QdEii+Wv5f3WfBYi+yWlZSCbtpprVXAxNzx9CyJiufqaoeP1xeqxVmIXXTtBgika0xbPRrm7yaWF7
	R85TOJTKveDX549WXKf83FCYty1vqVmFkcet5WlA2SCMW7YV5YlTV/ITILE0WJczmkQ6LM8NO2TvJ
	MGQJAg2BkSTZuhDhVOaO1ogLN/9blBiTCyn80uel5bO9bisrCpMtox4G3hXHwVBizn48JnAQFIRUK
	+ofPodWm6u/7zgjHYxPH6QkjXAoYPAqXrV2OnzjsKlBGCvbtdM6GJnJke4TRh4aWmzr0ksO/EZQcK
	elAwVf1Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38588 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tB1BM-003zln-0M;
	Tue, 12 Nov 2024 17:24:28 -0700
Message-ID: <a604f668-b22a-497f-89f7-a2f84d07de58@w6rz.net>
Date: Tue, 12 Nov 2024 16:24:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101900.865487674@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
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
X-Exim-ID: 1tB1BM-003zln-0M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:38588
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCRty/kEXlylI0e0DU3j+69Dge/gjR/y8Q0fDppzGhfQOyI5CJAZgUgrPh8LNOBk4uArgphua+BEDyfWbz4vCiNH7RaJQiWCFD9btKT6mXtgOz06f99I
 gkzZHv+YZbC2btegXl3qdFgHRgLZT1d8n5nxE9WrJexoanimUqbzZ/UihDa31ZDVuUWI+RDQusa2Vm40H7QWbilvPzHYs+wXDyc=

On 11/12/24 02:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


