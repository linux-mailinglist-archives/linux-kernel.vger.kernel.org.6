Return-Path: <linux-kernel+bounces-514432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C3A356F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697737A4B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C911FF7DF;
	Fri, 14 Feb 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rOH8mDRF"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B418CC15
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513906; cv=none; b=qsX6Za2Ih5aMblrVxGMDU6j8Rlv61QCb1QHRKNqoItapeoRCOVxsI8ipLwfBLsX6tC4gLx4676Xez/CLR6CPs5/c2PE8NALmIkQ99OgO6SUoVb23pC3fbv6o/6YkZa341wDB26zmF4FSrjwg50qKZDLtM9CQoRfcahdNVb7EBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513906; c=relaxed/simple;
	bh=dhxq0fekYHtupgYL2lccwRrN7Jhx2mjWQZNWTT333HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFafadJdtPLRwuY2SWTdqw0GTqceCiYrrZeF7kp6+fenBBFU0kU7H/9kUROwrsC6zx+hM5Nl0d3BQvJtfUhE27ZWNp2i2ioft+PkkEIDa9NBTcjlkFsOpEA4/GshJ7kHvZmgDNRHkCMuqFhV0Rc8obFO+SjoFg0f2Oqbf/RksdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rOH8mDRF; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id igJat0cELAfjwip0JtBpfK; Fri, 14 Feb 2025 06:16:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ip0ItV9zqlD02ip0JtfrvU; Fri, 14 Feb 2025 06:16:47 +0000
X-Authority-Analysis: v=2.4 cv=Au7o3v9P c=1 sm=1 tr=0 ts=67aedfcf
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4041MwwcWqwrnTXoSgMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1mAj3l4wYEbu+PyuxSVHeh+ZNOD9tJiIitvX4XPW1Xg=; b=rOH8mDRFMuTtcl0+wVCrmJauEi
	oNBmsKUv8s7DDGQzmi37MZ7KY9YLuc5TXEMD2id02EcZsFaVzJHz5SeiwujHJHQSOxtN5DVqXWMVm
	1Ym7uOQqnBjqLmpZDOW6OglzskbILD+YBp4HXwteZQPX6FDFcfKWf0Hj1/8c/Jnp32OilQtTIf4nF
	AfS/Fa+/WU7YB44ceEck7QxlipapFtBBio1u+5ZIcpX3JL4W/kZ1/J8u9VZVqNDJbBBc0oJWpIBMb
	MY6y/l1r4DFjvKpq23o3Ce5bXkm5f2kzWaOjQie1o0YA7iGiRqHhZtDmdaGJF/cscTK4lEcaX0GjB
	wnITxPuw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49026 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tip0G-003hDR-24;
	Thu, 13 Feb 2025 23:16:44 -0700
Message-ID: <2176e236-4865-43bd-924a-bc6b7d94e980@w6rz.net>
Date: Thu, 13 Feb 2025 22:16:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142436.408121546@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
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
X-Exim-ID: 1tip0G-003hDR-24
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49026
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJnlRoc3NUOR0axeHvoYDm+9ILqavTIIq2H7LYF2YLT7bHVzduBS18IAp9i4TE3XhOOqlJ3MUxfROXyn4KNgTJosldRemADIfJyTwP7b36NS1SyKdtou
 sKkppqkh8rDh+K+PcOHySgV1mpi5KBoSrWx5Tm27lfXnmMWfV2+/v82NNUmyavmSoctpzRNhjJTutZI5zW+XaPxu3nO9BjAJXOs=

On 2/13/25 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


