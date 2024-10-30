Return-Path: <linux-kernel+bounces-388005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477909B5918
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6101F24079
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC8147C71;
	Wed, 30 Oct 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="U2yf1HFm"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A65171CD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251478; cv=none; b=F1osbNC3IYI5BrrmRPSyWcBkjN2hJAZdpoCshpI77U1VQTDUbwCp8yTomndK5DwdfrUs4j582yrydbxQ1XGLiCFfD28zQORKoD8ZDtuvELmPsDBU7RD6q243bGDG0CaAyRBwpiurizX1OTzZaYH8HJO0U3WGioqi+6IrNy+LFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251478; c=relaxed/simple;
	bh=jTUPt+uihQrc7O0JB8m67/38HBekqhRvsrZeeDYOcVo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=DrpJekri2lIEDw3JqRd2UOBiRkT3kyMO0AMLW61T08EYrKZZdfgicGcVb2BdwrTybaSJ4+TpeoIyGYvM+2Y2AJtlzeFo6tOgpnS0AnDLDum1YwYFLG6gSdE1WjMZeroeIS3CM6TnEkfw6lArITZRwdQJQYuGaIGcsGdLbUg0c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=U2yf1HFm; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id 5p9YtfFAbg2lz5xRktXtc0; Wed, 30 Oct 2024 01:24:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xRktNZn1WdNZ5xRktx4Ji; Wed, 30 Oct 2024 01:24:28 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=67218acc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=agS4W99utiRcsodqIHUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S7uZQ/FJJPVkNPvZKy1ittsxvNewcEVSMqf+a7g3dag=; b=U2yf1HFmfkmkmH5cH3W4Ff1nTw
	JKnj9/KPY+dJ7x4XOeMHkO3ZQFqdbFdMURPaAsN43j14NOPzVqvghQGP7w4FS6Hxlwgs6Jg171Rjd
	7PpC7GqV6MvrpFM80xphXM2grO2kG9T6iI5laHCtr6pC64FvYiPIZdCAyDZPA6GV6ABNUOZScEvyi
	Nuvk4J+PZQwrwXboGM/XuuhfTcOwRs9fmaCyxaBI+srZn11Sq/nK+AvwCrNmb2G3k3cEgN5HgX7UA
	dgrQEI9RdL1E6SFczRtY8rWM32zOrZgxlof1nn64A2INhbK8y5TRcIuSG57Xkx+RBrAol5VJH5w0Z
	ba/Ru8SA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36532 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5xRh-001Dyz-27;
	Tue, 29 Oct 2024 19:24:25 -0600
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062312.001273460@linuxfoundation.org>
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <2610d370-1162-e34f-f403-69ba9c7191f1@w6rz.net>
Date: Tue, 29 Oct 2024 18:24:23 -0700
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
X-Exim-ID: 1t5xRh-001Dyz-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:36532
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEi1y063Rdp1I+wH8EK78LLdjXt89RpZ9bTmRLg+1ZGFtw4tcjRXNCsQOVEZRhMOyk5fGw5vNbq9DTx/Pl+9blSo4QRY5RbRANE8xe9zPA75kq/VywOb
 QpR8DPB2jk/d5lCsD6Lvp3DAHu18Ags+uAiIFSsn/c4qg8aa5FYlvPJLb4Rk/WtwT4lVuaMsN3RTpQE4GxYEARHUBEng+4OkM40=

On 10/27/24 11:22 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


