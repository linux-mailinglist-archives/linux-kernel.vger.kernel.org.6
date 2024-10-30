Return-Path: <linux-kernel+bounces-388033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92029B598A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EA285041
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E2194A7C;
	Wed, 30 Oct 2024 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rC4A7Mfk"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C2194AF6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252820; cv=none; b=f8Wn71XrK75TiIF6PUipRV2/68bJTOyCIMEL78u2d7n1sHUAAt3AdDX38L0bFeYvTFiz1Sh49RYf7aq3QFo8F7vQDyUojan7CvplD5zqz4SmL/pWNlaiHT9CuU5FPYZgA8PGRKrZgDK6bUomQjKRtTTTQfXRAmtqEUzrFSfGDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252820; c=relaxed/simple;
	bh=oObshbt1qkXuKG1U4M6y64p1E1ZQLclej2sD1aCjK1U=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=U6SrO8MrcXupGR2EAjfmd7LBlT+R5WDxFayAQ0JbswzISih3iCDkgiRnYuHTNmpujCYGAdR9q5c5nwVKdCZPivWrlkPAv6fCVFjHzzy7kNvOaZ56jF8DkvOVkTMKWcMJvfNlu6/SWJ7cX2z3pn4UyrIVSwKt7RBH3KvUch7kTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rC4A7Mfk; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id 5eC5t1SnOVpzp5xnVtnLr3; Wed, 30 Oct 2024 01:46:57 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xnUtMUiBib8Q5xnVtF9Rn; Wed, 30 Oct 2024 01:46:57 +0000
X-Authority-Analysis: v=2.4 cv=T4qKTeKQ c=1 sm=1 tr=0 ts=67219011
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=sWTCEjoW0PaFb5V99poA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KVzQnrY4wTUwbzURtByjRl3jasMwB1tF7757AlHhlmg=; b=rC4A7MfkVNeGicpSHPRI3a+Uyv
	b1jCCXIgtkW8XEYixqZAJDlAJC6mZT3D/l+33/XNsV3+LwX3yfPqpgQJcmrwAsKicIS+xo362na4j
	h5bI0xpsMmarSyDWsk60S0kHxkMw8I1Z/1x/4i0fvMXiEqOE0QiMgo16jAfU3GzvJwy/62y7pdiVZ
	eLc8xeSKsViCLdKzEfPYM38SwotDZ8q/X0J0ADMhvjQs7PMwOsTOjxS7XuKhRvI//u6Fjc+LsFUXt
	SKulO7q2HEdOe8gs5fW5PY0uLWGVZ386A4XrTJ85A1A8PfMTgbopRshBg8PLXAZKYtCnqOJOvHYCY
	uuiSQsww==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36552 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5xnS-001M3g-2W;
	Tue, 29 Oct 2024 19:46:54 -0600
Subject: Re: [PATCH 5.15 00/80] 5.15.170-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062252.611837461@linuxfoundation.org>
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <246d5cc8-fccc-c751-ed9f-401ba6ed5353@w6rz.net>
Date: Tue, 29 Oct 2024 18:46:52 -0700
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
X-Exim-ID: 1t5xnS-001M3g-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:36552
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBiODlwrL8VMS2aXu/EBeTaDeR9BV6UQFjFDUR6nMwhiJ1IxSkXnnLFZYSY+1xff+gBPnQ7f+VxNM9QlL87KtuIinwSdZkWIvQ+8rPFtaVt965SdTd8l
 HR7EVRbrOILhX7dscnM0kEeba0O3IiO+Xs0/cYCzMyvAcuewdYfYXUYbjZ5FWPUkOXPzO10K6hzBbNS4z8+3Kfdc4oNMm2bsi7A=

On 10/27/24 11:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.170 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.170-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


