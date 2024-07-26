Return-Path: <linux-kernel+bounces-263024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F993CFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908F5B22E41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF845674D;
	Fri, 26 Jul 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rHfOGqne"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6336D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984002; cv=none; b=QW8mwGCQszn+B9o9bB4GQMO4StptRlinsjXu2R2Aw+YEGAn8gFjTg1J6O3H7AQ3CLowmbwLA+zENWko8ru9C39eiw4F5g6HsTR0lEIxlQfy+VE9E3SVpePRg/wlWom3AFcgjFmHj8C/NJhp85m9hGVDC742aD9vM5TFdMoXd504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984002; c=relaxed/simple;
	bh=UbHmbXTSxgUY2nzS2PmbCImabSXuVeF5fVGN80VuE/0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=TbYzyS4sJk0vJchYjrDeMnpraxUbggA7TFP7uV+gUbxSVaxQjm1SPv2J8SCsos19rQ6bxtiVmw0U8T6oulGl/WIXkVwD8ZouShHsqA4jiiHGWh4NaGo5VtpcwJmikMpF349wV3vTCJ2YGeRsiUPUTdAKLC18o5CiYwcixsQFkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rHfOGqne; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id XC7fsKkXKnNFGXGhTsUs5i; Fri, 26 Jul 2024 08:53:19 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id XGhSsMEvxpG2AXGhSszjy9; Fri, 26 Jul 2024 08:53:19 +0000
X-Authority-Analysis: v=2.4 cv=E6rLp7dl c=1 sm=1 tr=0 ts=66a363ff
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=hP_FQLMrEgTDVdh0MfgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b22YtEOfbCEVCDsNAFWQckf48VPhg8f9JwUPFgjX/oA=; b=rHfOGqnepvhwU0K1sFa6jANzyR
	6iinYJexRpWmuyomigmewEKjttcawzHSi/q/xptpvq9xSlRjN7NN+oW+Ap0Qw/bGhh9u6NLbnTn1+
	KiZBVFDOg/krlNpXaQAbG7CWfY6625fZBKtP/dSmP5FMK3jL9Htp2duUQO388WlVrIxN7OqSeuezR
	xFAK5VaavfyD3IoDEegFkPbzR5ps0VyKV8sKCJZ4M3uuUtKl4f+bGDEKXVOt4kkfFRmLHoPlQ4uiB
	Vr/D97zgJ81eOTqb13nJz8umgH/fpidN0OxKh6OYPmOmtHOv04Nx8MFXgrQ1kIy1dsuhh5LhK20by
	Rb7yNWXw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59266 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sXGhO-004CXG-0P;
	Fri, 26 Jul 2024 02:53:14 -0600
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142731.678993846@linuxfoundation.org>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <4474a6b8-7546-0037-1188-469585e22e97@w6rz.net>
Date: Fri, 26 Jul 2024 01:53:08 -0700
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
X-Exim-ID: 1sXGhO-004CXG-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59266
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCvZo4kK9q6/RPyDY4FaTo/d13WDua79tlpwL8bKT7ol5wX7fN37RRJXg9MSXqAp0FZkAz1r2Pj/H6pla53DhSmz9I13gmHscQDvgxNr7A0zsC0c02kO
 AnkfoHpN49/nTO2ygoCF0hRzR5WpOKBvqbOUaj/WVoqGgqRvKTwCJLt+3l8hnGO8FZDuy17kguQCvR76eh3lRNvBez32C0FXGEo=

On 7/25/24 7:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


