Return-Path: <linux-kernel+bounces-416538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2249D4686
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDA8B22F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0176136671;
	Thu, 21 Nov 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nPWpUXwz"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEA230983
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162420; cv=none; b=By0SfTQTuakIdfPxf1WzeX32PkfB1U5dFL0i1x/6RcJjiGgLFN+AbSu87lSPVNwFVRvaL9FY1lqy4kU8hmFWGBZ4rkBXJqPcyxUjWL4tNnmhRl7/Dfs7B5+IcObDROKSSSlNvC+M6Ei5nWcXGE7kUhDBzKu9FHm0lGUSldGwGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162420; c=relaxed/simple;
	bh=rsgcDDpuonVLuevU8p+YsVl9GKVNmkAo9l7A4aM06qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5of5JImtjH2tx/Q94ze01nbK65SPYwfkzPyQ62dJwR4WtoDF+19gGoPl+1XIyZSh3T1F9i4XIAcv82xfheg+OMH22enzhcRKdT2gwsfTcEhzgZnOXYcEoiG8LIrtRAiOaWL3fhqnjQyNYhQ5Vzz5TMg0tZXaePDKaJaj/PBaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nPWpUXwz; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id DmrhtwbPhrKrbDyZTtVuIl; Thu, 21 Nov 2024 04:13:36 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DyZTtpqDlCgT6DyZTtMA8i; Thu, 21 Nov 2024 04:13:35 +0000
X-Authority-Analysis: v=2.4 cv=XvwxOkF9 c=1 sm=1 tr=0 ts=673eb36f
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
	bh=yMNNEdoktASNnB092jEUhXeJVO1jccuHG1TKJjyMy7U=; b=nPWpUXwzBZvdclOqiDyT1rwdtZ
	uGXs0Xm5qrfEG/zwIjbI5x+xMspg5+FPtwutloYy4YPfpOR2oAXpvBxRgBtySX0gX+vYMRhZB3mfA
	wA8TijR5TE+Q7k3CnwIxxlkjY6qQ0HukJ5hBfDQZ8XdLnlLwV+eceheEHNgB7L/hJ+g149qUkOJFa
	ZJ5320Vreb5o++E/9tbAMLl2cB7Okye3HdrPJaNYeGYY7S1sq1DAMUSL73T0Oee0WftnFF9nucKx6
	uWKXej6EQ6RE5yZe2FDBk26AMgQVgxpE+M3JqfCc3+/LxrzZ7vR7ozRXZO1xFcSPy7y8GKMAqmSBE
	cFOSP00A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43124 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDyZS-003Ejf-0u;
	Wed, 20 Nov 2024 21:13:34 -0700
Message-ID: <52d9eb66-e5c8-4d70-a0f5-58fa9cab3eb0@w6rz.net>
Date: Wed, 20 Nov 2024 20:13:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125629.681745345@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
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
X-Exim-ID: 1tDyZS-003Ejf-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:43124
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFs+fOoSdPO+Y9QA4Ec/5Ey/Tg2JMZj9zLrCIR2oRFgM9AmZVCnfDwntKwks+uVkF/HXMVfdBmpHFQx2/BxXt4AcoWUeHBTvWa04Nn0VHvMzs2K9xy6h
 fduxp8qM/cUsMuIl89CMjItosl/JpkdU3TcwOV0hdG/1Fp2EFFbkBk0D46n++4UZCEwSPZqFE2zHG0YkOMB3T1fnMu/YU/YfJlc=

On 11/20/24 04:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


