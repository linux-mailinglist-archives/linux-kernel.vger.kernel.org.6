Return-Path: <linux-kernel+bounces-388010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B429B5928
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB421F23AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209812F5A5;
	Wed, 30 Oct 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FVSjLAYv"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4D1799F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251902; cv=none; b=ncAyro338nLHmNB0v5/xYOC9YghtKEgVF7fuBq9ty65xvjeTKFBmqORMp2ww4nw36fzH/vik8DglQ5haXbtsHpawroO+7qI1tUFyeY0V5y2pD8+/662NBpfvyvfHEAixU/WYdwYFtXIRtoiaXeT7O5NoWIjGsOiW4xa3zBYVgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251902; c=relaxed/simple;
	bh=R3q0dPELC599uJtphGcY6pZKLHS42kH0SLJYtP6cdEQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=rexiFJ7oVxTXeuSuWbBriJQ2f3hLsHTXfDJGPz1ZQaM9Fo29932748XJhb662WE0gVXFt2R3bOPgz69k1ZVljP4yD3tb8QtybbsXdw23M2yiiqMsinws1qJDQCn7wogD8YCIHiLEQE7ivn1iWEGh0x33/GOTuD6AosWLgwGlYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FVSjLAYv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id 5SdDtBpuCiA195xYbtHxpC; Wed, 30 Oct 2024 01:31:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xYatNekOWdNZ5xYatx8zD; Wed, 30 Oct 2024 01:31:32 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=67218c74
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4Na9fpYnh4hjKbwFJnwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NFJKSAGjASlvJI0n+bDCAkzsVkHO6HlGZfLxudFBndE=; b=FVSjLAYvauQbPF2bHU6+83CtW+
	A+tdjMmI5xW2BbkPxogoLTHjQcm8VVcho8wD5gNDVUcbJhKQ8VeMDJqkr+hWYXwiC41gwsOMCFjgE
	hj/3pM04iLjoLDrtxTmEJ2DPv1cSguYzTPoIYD9FCu2Cv4Wnr3/AOzY9S97u/Zxf9c0BKuI3/WCTp
	JlwIFxYKBz8yRkUOJ9CKdDl1ayypAAbU32bpZ35ZsjuZl2aNQs1Yt7C/aj4r+HodC/T+bB5w+m5j3
	mGF8c8byDbd90cbX7cP3C4TK1s4Ng5mwg/Ruj2obEwUFE0BPUiTJJd4LXysVEEwRn60rZ18AgxvGD
	hsSHO+1g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36540 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5xYY-001H46-1P;
	Tue, 29 Oct 2024 19:31:30 -0600
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062306.649733554@linuxfoundation.org>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <6e9e2d08-338c-ae6b-977a-160c13081a41@w6rz.net>
Date: Tue, 29 Oct 2024 18:31:28 -0700
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
X-Exim-ID: 1t5xYY-001H46-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:36540
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKIprNDN2/fx0Ph/8BtcXmRYK8mnObNfGD/u+QzoNX+JWrBdl+uB20j3Qz12q/OdFCAj7jcjHrqb2c5iNMG/yldIERX4VgjzRsrzWMOwOhHmemllPQn0
 6v6oHLaIy6nCHMNaT1aQ9z26VALpdT3HE7tgH2Tp8oHaAHH9t0X4gMr4ptsjjXD0GXqwjqNGTyka031jnMdp0OtcUR/ES7tpoI4=

On 10/27/24 11:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


