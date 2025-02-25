Return-Path: <linux-kernel+bounces-530579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A3A43549
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D83BA0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E325A32B;
	Tue, 25 Feb 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="CXzqGwHG"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590725A329
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464994; cv=none; b=Hi6CTuH4eLAgcW1y2O4OI046pdhJIugIDfomgpAX0IJe/ZA1aSYF6A93KwAFbLSkHnlzLYgdn0KJ6YKz3st1ILE+EHsQ5ZVE4Mo88mq8j6m8R+7l7AE77LQY89vCde/wneESthoFafrmLKeCIIGnhPmVxn/epRBLBgnznACt0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464994; c=relaxed/simple;
	bh=ZBHnfwZYwn4I2BQkXindYSZKHPhm1XSFyZ6IYKOObxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlHKt2BV9z5ZMsMzAnci1QEOptngsD91y2rUIaLKWpn9hd0uUpLNGlThWTu94Kf+eEdZPqOsNGpwMLQd23NBp/c+gAaO6UiU1NgRtlUh2N/gCxb23fU1l9Hqfn9CrErSrakWtDAp9NPBPebOmpAA+h3cpFh7P3vmJ1qk3qbNgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=CXzqGwHG; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id mbi3tZxbTMETlmoRztpuyl; Tue, 25 Feb 2025 06:29:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id moRytJzMrHEACmoRytU2W5; Tue, 25 Feb 2025 06:29:51 +0000
X-Authority-Analysis: v=2.4 cv=HdLfTTE8 c=1 sm=1 tr=0 ts=67bd635f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3f8LB4XS3dq57Z55X223F1fJxodVBl44Tiv5wJ1zFio=; b=CXzqGwHGCIaSV+5lewCLCbTHm8
	JFi6aaMpzIoGP3tOQ1WlfbyZdaoorP7lRK5OdKIpoDJi8v8YaeGvfV3Vqs+AudhjToXCNJjydOPoJ
	wl1FYuqffUQiK8R+FPUzE2gAVGem8/v5VRTCjYq9e6Wfl+GgNOECVdzQVoKBaI4qN1XP/r1UvWCem
	4XJ/SEN54/7WP8U3KVQZ77MKFQNu6R686SSZACSIn5x5HUYz2iOEaKVwWrUTlR7+eeG6XrMKqLKJu
	HfSOGDlpuZaCWuQKcQDEHL30BHa76BcqMhoHFhudGyVIymx9GEtXll3OrYHiv/xXaFXAOwYgYx0MD
	gcScMqMA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48638 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tmoRw-004BYc-1f;
	Mon, 24 Feb 2025 23:29:48 -0700
Message-ID: <f252d815-81e1-4711-8e2f-f362272c3d28@w6rz.net>
Date: Mon, 24 Feb 2025 22:29:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/140] 6.6.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142602.998423469@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
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
X-Exim-ID: 1tmoRw-004BYc-1f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48638
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMaXcD8AZ5Rc2d8b4LpWOcRGGY3G0gwCvP5dVLkT/7+vNDXulqZVaicFEwzcAwf0gjQ8Su3GUEzHdkdRTUoPzn87nMc0d2hPKfTAIOAUMFTJmJnKSjTN
 3sTS8i6u1q9WlWCkXdzweZGskQegZqOewe1h/KYYoz6YnahIaHuKn5UZJJDzHziqGr2JJR/ThP3IIUfx4sJMyyM6fCSnrFe5S2I=

On 2/24/25 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.80 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


