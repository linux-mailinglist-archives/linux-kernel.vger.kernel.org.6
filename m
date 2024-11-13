Return-Path: <linux-kernel+bounces-406918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8C9C660F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E027B2819C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC15B665;
	Wed, 13 Nov 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="uvKzD8hg"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE796FD5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457902; cv=none; b=B91Dr6xJpW9v5V9xEUWf10SIHXQ15Y+Kl5ciJPKA2uAWc4EzvowSVbS39XCo9v1qrYRBuYJUFKY+j/KbzeQO/n5M8rKV8Pd8A6QtPm1Ul5sFJAHryK39IxYvUwTIAZ4ct00SH4M1nskRqw7ALS4iqGQFPJ58sYZpHub/TUy5VSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457902; c=relaxed/simple;
	bh=BXYnbyD5Pa9/PcgnAk2NFGYl1EcVhZ+i4oG4geqloM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnhMjRn6pc5LnAfKDpAfUutiwuE+DzZYOorOQB04ybwt29+cjw1+sS/DtKBLlRmk+8uI0KyM8DbvH/ISMVVsElWOoMCCpDVcY36ct/O2Rf03sqySQ4Ts1Z1e2xiU4cGsyGtifmZn9JvoaRO8g/aaGFdOyqi/lKCVwu7C1cPlAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=uvKzD8hg; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id Ald3txnlCqvuoB1IEtwywz; Wed, 13 Nov 2024 00:31:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id B1IDtdTKyNc5lB1IEtKeXg; Wed, 13 Nov 2024 00:31:34 +0000
X-Authority-Analysis: v=2.4 cv=aPb2q69m c=1 sm=1 tr=0 ts=6733f366
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
	bh=2v3PU0kAByrpk1fKvhdLL2XQ7WWMq+VQ2i357XT9vTg=; b=uvKzD8hgKyNoVCX5EJPtobNmCp
	I4Ocqz6KbzC4GAyoWCIH6uycAYGvNXJQGmfYQdi4lCOPpI4BRY4q9ULHYaYlkpVKz24vQ6gRI81nM
	8MkZnYLfhZ2WiPA5oZpSu7ByzTDUOpdnPUkf7zx1ST1foeW1r+tfuWXHWFhScw97ge0COCIONJPlS
	b3Bggh2BK+LWvWPCPg/MX1wqhVuUjlLFU/NA+2y4hfX/ATSUNz/MWc03I/SaxSDj/mIKQb6Gn7jvm
	P/uJHtwl1f1iV1drcm5XTVy2t+mcp5ouLDooRQ+nz87/sZte9K4M7YedRO83silfF+/EYD4RgI/ox
	hS01UaFQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38924 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tB1IC-0042OK-1g;
	Tue, 12 Nov 2024 17:31:32 -0700
Message-ID: <12c23f81-df78-48f7-b923-a31a5b3d75a0@w6rz.net>
Date: Tue, 12 Nov 2024 16:31:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101848.708153352@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
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
X-Exim-ID: 1tB1IC-0042OK-1g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:38924
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMmc+y5TxbJ4JtWLYH0KXrYk+smwfUp8qalTxBd/9BiI5U9oYQnDLMoKGVFMsADbaMhLTtJwTQa7gl37F4eD3Z0YJxxzykNCol/TovSTBArt3TQp2wfw
 tcKvgxccS2mxJxwlMr6+2OwUyI6IUFVJn8q8RquEu/rJyQUtbKqmXJg6Bj5XSmhLIwhGeED1j8Po8CwFB4KQku70bhb6oKxSm0w=

On 11/12/24 02:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.61-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


