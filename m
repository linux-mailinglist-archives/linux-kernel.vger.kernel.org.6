Return-Path: <linux-kernel+bounces-358029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8743997966
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA09E1C224F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E211E47BE;
	Wed,  9 Oct 2024 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wmPbI0HK"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FC149C4F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518132; cv=none; b=uAu7Bo5UxSG9APB/6ILqtMuryXrs0yfKL7/5y47RhMDSjyb96rRCLvb7KD7/iUyumxPgt0HpPhAs+deprpdACOXscDfk9It20nVXUYn/+SzjYB5FX8+UVfEjt6agqnq25doKYIn7N7FH8ZxaFxccUOf3wk6cMfWLqKuhMYe5O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518132; c=relaxed/simple;
	bh=qHOExL+m94eWa2cgVA8y4g+ufofYJ5Zq8B3r5x5ZKOo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=UQmOg8PPn+JUlbhse20nPN9LPU7xbkFMQwsaM/5qseRCdyKZVyd/jt2WF4/DtJE5WFiw0r7f/Szc5L2ZYmbBFEmCeXP/54b3JALttryHUxrH3WEU8B8YpU4RrtHJXS9MbJ9dg67HwI/hcfqfnNA/TgiFHwtfO59txlj3X6gZS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wmPbI0HK; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id yARFsmJ3niA19ygWasp6KY; Wed, 09 Oct 2024 23:55:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ygWZsvK0VGNqBygWasKg30; Wed, 09 Oct 2024 23:55:24 +0000
X-Authority-Analysis: v=2.4 cv=cqidkU4i c=1 sm=1 tr=0 ts=670717ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qz3nJ7VPPRrQ3fo9WI3Ql+6KHu0dzpOhd13Cpiv2E6Y=; b=wmPbI0HKMsBgv50f3/OIdGK500
	h4aiw1EkGQQPUuubzpnRG43qsylHFpSDnxREXGHUnid97BKjquBrt61JutCoY1mowoLLY1GMW7sbb
	ERdw/OQtds5+2c7QnOPA0OvzhpA7qW69FtFr2VgULxoG+v4x/97sh7V/S5iXaa95KNYUcshXHUTKH
	/eakGIgpbFdyibYIRlnaDPUGfBP7P4Uo23+3esj+I0AT4uy94ttUe59F0JbNxnAz2PdgURtn2H0V5
	uliVo1zXWCnyHxV4L0wDSKczyOo8aNnHOLsR2TLVa82lfewDWqZW8dGPZSlG09wZRqbQq1Vpvj7DZ
	SNkzNsOA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46218 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sygWX-002jTP-1q;
	Wed, 09 Oct 2024 17:55:21 -0600
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <20cc7325-c036-fddd-0324-7b5244a43e63@w6rz.net>
Date: Wed, 9 Oct 2024 16:55:19 -0700
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
X-Exim-ID: 1sygWX-002jTP-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46218
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI5vonbw6ygdh3lN383ZU1kSsgIHsCSlQ3QzSeiTKZX4ZBNx9QAGRVPdqhHRBihsQEfs64Ezs3cmgU+Y+9/av988uuE6xKQGH8O6KfZcYSlMj8tESJX+
 bkItDWPskM2aHRBQuM6Sy2AZ13B/rj1MiqF6+MS1ENuteG0eyrPc8gFn1mHbQCpCKHNqAfHuovbROk8KCym35fpofbUI/tgGe88=

On 10/8/24 5:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


