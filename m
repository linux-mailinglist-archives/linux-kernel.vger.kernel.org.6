Return-Path: <linux-kernel+bounces-406929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F69C663D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F891B27C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A53DF71;
	Wed, 13 Nov 2024 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="F+PCQyLv"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C371AD5A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458714; cv=none; b=P9g7i5N6T+FCRiL+6+vroHCPsJnF918E5JuNVS7kITOKUgTwa3XdMyCbV8woDWw2hSBAEfBiwGKFuJN0Wbugs1ehf+n5kymgbdRa2LcjkETl2gm2fqiGbiriQk8goTLZsYzSECyfzXFjP2jsh8qi4t4IdUVRBaLGPspAZSEvwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458714; c=relaxed/simple;
	bh=Za/n86KGJzHv8CV/HWsYmcN0pm3FBSS0dkUbihK4G84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkP2thl7OQ7C6h1GLgEMDYKq8QYbM05ADYaiZwprp+/RgU7lRcDTXAJIG7RUfmIl9Pz8MKWVfwG3tvWLxQl59B4oa+zW+m2H9AqOZYvfolgAnyV6hb41qXVsdpCz22Mqr5LGeYMqniZHmi+9otXNKq8bGep6WJtnvkmX9QAHJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=F+PCQyLv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id AxSbtJ78ViA19B1VPtK3Ps; Wed, 13 Nov 2024 00:45:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id B1VOtzcfsj0v4B1VOtcHAo; Wed, 13 Nov 2024 00:45:11 +0000
X-Authority-Analysis: v=2.4 cv=MbJquY/f c=1 sm=1 tr=0 ts=6733f697
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
	bh=UyZ6NhO6KwjaejbfgDoQwG+suVd2I5spH6TWGj+UIhQ=; b=F+PCQyLvVYgi9DFR2MktLXD7ri
	pUo6HXNKd6zoTNcQD0PrbG6a8oruxJp4hNfoI9XrprrwBLC3VQnTf4qQz8k13A0lm50TahIqBTjMO
	nevNke32/n57uQlHahkqWbtgSBmSmh5EczlESPJCEph8uViy43+zcF9MBkMwop9jPnczmvmQqD4TA
	xae1uYeBOuJAm0oG8mbC6ZMvWf/b32xJFfrt2Do6Et691srjlRIFsLU60bvs8vATqjqZvdgvjegjH
	sU1xA+nEIReCyDaON1DRsHmLcu5a8qFqfqNsJM0G9UpSOfhBOPXqVlPPJEVGmjlrZHjB5gLth71K6
	IRBczRrA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53218 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tB1VN-0046jJ-1I;
	Tue, 12 Nov 2024 17:45:09 -0700
Message-ID: <1160c65e-7106-4cec-8b16-61a9336fb826@w6rz.net>
Date: Tue, 12 Nov 2024 16:45:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.172-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101839.777512218@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
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
X-Exim-ID: 1tB1VN-0046jJ-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:53218
X-Source-Auth: re@w6rz.net
X-Email-Count: 73
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBYzTuJzmeAi7sytNsxPEjFpRbCIBDJGe+D+X4vgXqdlcNwE2OPEvA3KrmKYjrB8WI+KC5ty2sWUxHSJLE4vm7ASPmcmrvQJeZNHDahrajOFGht5vTqX
 cdKz+OdGed+kmjvf3GpYB/3od3UPLUUAUssebhA/5p+Q/+Jk7IGbhjEhvo/naQOMqQSUTt0W/Gv3bB29ngr7eyke6nekjNAMkS8=

On 11/12/24 02:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.172 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.172-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


