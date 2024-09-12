Return-Path: <linux-kernel+bounces-325772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F256F975E05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE561C21AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15046BF;
	Thu, 12 Sep 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="G0A9MBNf"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008791D545
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726101292; cv=none; b=o+h4MWZMt8QbBASPKcVVzXpe9A8H2OcttqrivGbTmjCu48i+M+WB0mr4D0hIPMjdaPuxcMECPWdMU0y7bZeZhhIhvXzcG3DEp56m/l2KkpcnYj+QNXpq2Esihnk7XSB5oWpkfnO+lZlLRoTEA2srNR0qDDxdepwwOhDtLk4c+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726101292; c=relaxed/simple;
	bh=XfUOfMV5igzSU5sun/scqEAqRQy+RsiSxYiFuj8SKSI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=QYfYvxjiviOF2OGuE3mDh7e28ubyUH+lBdopARivMy72aQUbC1TGexV6wjfQmhOAdZoGmcA32PXJyj7/pv0oj8SEEJal2KvrnGdjYnxjbnFfbXpjXyVpQhahGZAI5eJ9hs9q6VcF66vgx1CZS+AL92DsYzbH6vu25C395/qvr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=G0A9MBNf; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id oPb6s8567umtXoXnOsObrb; Thu, 12 Sep 2024 00:34:50 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oXnNswxILO7CroXnOsYcfZ; Thu, 12 Sep 2024 00:34:50 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66e2372a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=YArTxWWgIjO1YVvZgRQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cYvbNQI+gpCYqzJpgX7nuTA/hukRC+DHzSBUzBcEdYQ=; b=G0A9MBNf4fdYDTrE5swOuV181J
	Kv5IQSjMWb8d2cuu/oPwrebCq3j35WxDx2AqfXY0x/z2OpMP3nqCVQjltSvZKuyOYgvmFmEAm50lu
	LLwk7/xy8XNitOL0RAlfACgpNZHQLaCw9tOMCHZJQq2yfSfOqj4akqIYcO2k6yzYjL88PyRBl2wYz
	qTqtQJVuXjjzQF2zLBFicuHJXSa6Ye0C2itv/tL778va8NU7DpLWGN2Tg9ajOA0YY68EFmMb+RmRF
	h3uctcHdZ4V8y4HsM+6rjOSdzGQ0qNOELHcwEpimUQUjCtya6Nj+pJd7zsWiTa9tY3pyJJZWiULfv
	hVcqx37Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39894 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1soXnL-0035UP-33;
	Wed, 11 Sep 2024 18:34:47 -0600
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240911130535.165892968@linuxfoundation.org>
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bf463a26-4bcb-2709-fb06-cece37b09688@w6rz.net>
Date: Wed, 11 Sep 2024 17:34:45 -0700
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
X-Exim-ID: 1soXnL-0035UP-33
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:39894
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJScAlp3/7PDkCCge1Ri1jw3yZwf8wYOFWbSmFG8c3825UA6uiTFsgJfHwHwPBHZLGYZC/9J/6QRdo9jYqZbnb2rcgCkNPmb53j2lGSNAOfIvJ12pGkv
 RjXXo91ChzECLXEQwGjgCYv67d/Rf4oEvi/5BZMGywmlusrlP/kO8MUDle/IzSxqykc2Yb64B7t9HCA+gxhQyhg5omKSwXMcIJw=

On 9/11/24 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


