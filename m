Return-Path: <linux-kernel+bounces-416531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFD9D4676
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D521F226E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28013BAE2;
	Thu, 21 Nov 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4ZicuOTL"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936E74068
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162035; cv=none; b=oxR9fD11jDviNtZqqs4MWizLCRUfxygWK1zwJWtanGtDOhN5q6vQLJPotm2YiD64vWnf4VaDQLpdQ6RCA7t1eGsFhTm1blDWvIMcma/gVrJ4Jcc8eHhC56aUfY/+hqBsBVNhDyNDm7bNHkcMI4IfUhUW0lumT6Z79tgVr7znfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162035; c=relaxed/simple;
	bh=ERffJn60KeZxUuTpwiuizCps0p3OfPLgk9YJ/nzt/MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJdBbKcRwQSy8MMJL12SosDeQBs+aTNwuQV+wQieUzHrTamOBnM15ynq9WK3gQXvAvoFEAyz2cpNf5YwO7IolEJ0MuDdHkABRNEAP3IW7eVTCsG0SsdTtno4iDyf8nXzdyvZ78PQYEtTK7LPx4MPYJoQVgN8h8HJHSIwmCpIEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4ZicuOTL; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id Dsk2txt4krKrbDyTCtVsp3; Thu, 21 Nov 2024 04:07:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DyTAtNwZ0cEKuDyTBtQQiZ; Thu, 21 Nov 2024 04:07:05 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=673eb1e9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=u4wymUDdFjS2QedViv0A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=klnTPdvsvSnFhe25dTAPVQHCchV9mup2zE31aItoC8U=; b=4ZicuOTLvY6/p6kq7o8jXLcRer
	cKzyWeITVmJ0jIu9MQuvgFdmDyciAyadD/WZZewCybQO2EMyO2iYDy4StlIffgKlhCoPSJQFtVLRo
	iTyk1YyRs5uEbY95N7bK+saGABLAwk/cIqBnn1kndjCRtfSWFl+vVYVRwDWFLlAp2pCT7Ivyfb8e8
	1KOIft8Rg2kwYK0On1tBad2hvDIcrU1bJWPNBDCKAfptbFo59JtF1ZL23FVDF/5PJoJAkdZHqCgSi
	ibhLdARa3WCzKeZZs0I01LPVCxERagUlPdbOaMHG9t680LH15xdjdCh98iKOjpTxvBRc78jqeqvU/
	9ZXKzI3w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36288 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDyT9-003BsK-25;
	Wed, 20 Nov 2024 21:07:03 -0700
Message-ID: <ff346263-8187-4b11-873b-193aebb51cd5@w6rz.net>
Date: Wed, 20 Nov 2024 20:07:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120124100.444648273@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
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
X-Exim-ID: 1tDyT9-003BsK-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:36288
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE+SSF8Mr9Bcf1q662B1DhKqH/it+o5VXXV11liR6JFzqVCovsdmq3e51UT9+7rob7snmICKlfBFMGMIkgBUMgwN3lAkgj37HnbKczz74+DmShRKKtGg
 L2PbhswzUU6QPrme1NfqD9biMNlswcOy6YrK3tx3Pg7dgcHXBVOEXxMGNW4UDOus0NiVAeaTc8kmeDeWuB5uNfzvdZzPEJKL4DI=

On 11/20/24 04:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


