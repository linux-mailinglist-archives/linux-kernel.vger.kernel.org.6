Return-Path: <linux-kernel+bounces-366141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AC99F153
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43EA284831
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CAD1DD0FD;
	Tue, 15 Oct 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mMuuWCL0"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F711DD0FC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006494; cv=none; b=b451DFTJOgwqGmsulmS8n5wqTM9uq1bIez1D3UHv96U7u95pkIn54AS04syXif8jZtIA6jtxgHSvRAD1ZgTf6Rljt5mpo9HhYHUHwu5FzolKMuWzzoenZL4HWFE/jYukbzWYFgttt26JO/wBiYRiIS2+Ady3XBi8Cvhj49CGqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006494; c=relaxed/simple;
	bh=K1RESBe6hiSI7jwJi8+1u9FQn/ETWoA9W0x4oO+1hmo=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=gA6hPHOpmsYaBzwpjkG38dqPo+/ACwWLQWgzMPOiG6JOFKwHhj3d1iTY3IiEQnP2jua624h6uE2uWzyMPYjnAoAlP1WFpI6f2uaVORxOMen5uzP0cNXO0YrFFDr9m0g7+5anQzkdaXCpWp75nu2rMUAIee9IfA06set+s9cSnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mMuuWCL0; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 0ZJztWKYDvH7l0jZNtmpak; Tue, 15 Oct 2024 15:34:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0jZMte2CASAO30jZMty3iF; Tue, 15 Oct 2024 15:34:45 +0000
X-Authority-Analysis: v=2.4 cv=L7obQfT8 c=1 sm=1 tr=0 ts=670e8b95
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UiXv1XNBzq_yEhrWseEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i112Fm/NfDMeEx0S6/m50EZwebHt+8R5XKl+GAMpj2g=; b=mMuuWCL0Ovs2lIwbEvgLhgIOjl
	TIRZuwZZRdukFoY3no5dLJ8qeTTAh5Myb/bL4Liraj+1sWKNTrnha3+CBlsc15N25ir+8piEq93MC
	0kp00CFs9LhKs7vJqQJMk7exSxet1iXyph3oWxaNLQn+8pdftZ6Bi8JLjrBOLQR51GmWcusQsY0B1
	0KrSDjMfSaAXZ4lnUMUvI4vvPexeTObxgJdmOk9ECEg2RdkqyOZZNmJKXBNZktbpEJz6eo5hAbO5x
	TZF3t3uswfvIYp/ROLCj4Gwu1FPEnILo9nIJ0pdyzh58P1tzTQhAg7Iluf6Suw21vfmbR/yNlHExQ
	U+eEfiEA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47890 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t0jZK-00272E-26;
	Tue, 15 Oct 2024 09:34:42 -0600
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015112501.498328041@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>
Message-ID: <62f2d2cb-99a4-dbc1-0f5e-ebef70386446@w6rz.net>
Date: Tue, 15 Oct 2024 08:34:40 -0700
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
X-Exim-ID: 1t0jZK-00272E-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47890
X-Source-Auth: re@w6rz.net
X-Email-Count: 43
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEbQjqKcbAqsU9RZYJFjERf6/MpfwyKMfod1oZPv7BZpmDWZ1fbWaaoLqywPjC/32EOp1YVpNF+uFcWSMAHfl8AcUNQK31cqPocCsZRBhXS9+9wbOkJW
 oIxKDU55VHgyGBqPleBTtDeS6K94Eq3SlWVVfPWiCN5t1nuuUu+Rs1tDiHX0nr33QcajrLqkuvSoiz+ui5KC16svD8Ikaa+8/LI=

On 10/15/24 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


