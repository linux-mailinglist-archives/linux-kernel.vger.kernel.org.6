Return-Path: <linux-kernel+bounces-316915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11A96D6E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A51F22AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC81991CD;
	Thu,  5 Sep 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="VxUTqFwx"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB432A1BF;
	Thu,  5 Sep 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534943; cv=none; b=VdzxmhYrk5JlGaH42bea9wGzPgdaowuuvQu1W6Mztde2OC8cd9OoMy8FwMMgPSzQdliQeBm0wUcj++z5dIoOAGkkws0u2Mr00BOd7loKX1lcpUL4ra1b1TQI1P9HhD92XAB5fjsQrm+I74Ic6jffKc7H4RzdF99iXk1zwYkEJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534943; c=relaxed/simple;
	bh=JOGaZj39lzFUsnVmb+9NOSEKsjbRLstbQxPE3JMJV+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=n1jIqZVDZaITmI858nkgdy/gtTrSpOM1OrNZXjU675SClLpWk/wfHJ/VH6oYQSH76dSDT5+JW5vc6D+gWQGCrNVvLvZTnpphT5ftfL7NmVYqiiLlGGWpol1skxisiAkTJz/lqmnaly+EK2ZHYNqCQq3DUumwBSBcrghTn/g2S1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=VxUTqFwx; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 7DB03789F0;
	Thu,  5 Sep 2024 19:15:37 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 7DB03789F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725534938;
	bh=JOGaZj39lzFUsnVmb+9NOSEKsjbRLstbQxPE3JMJV+0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=VxUTqFwxyboQDUWWIUMv5fOWPIfy9DxQC8xpIlawOx6NZOtz2frHITCp6UXGLmDrA
	 te+s86iIiNUkqjG8TFna6ln51ncTWioR8I7Oygw8qbudwAh/xqdlsg7mQklbv9dqlY
	 d6QeCoVPD/EPmCX3finH+YZpNvlJ38em01XLXql0=
Message-ID: <1e189c70-e677-453d-9e31-6637196c2b5c@classfun.cn>
Date: Thu, 5 Sep 2024 19:17:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Andrew Lunn <andrew@lunn.ch>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <20240904111456.87089-4-bigfoot@classfun.cn>
 <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/5 01:25, Andrew Lunn wrote:
>> +&gmac1 {
[...]
> This has been discussed a few times. You should be using phy-mode
> rgmii-id.

After I changed phy-mode to rgmii-id, it seemed to work,
but it didn't transmit any data.
Maybe I made a mistake or should I continue to use phy-mode rgmii?

> arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi is i think also a
> YT8521SC.

According to commit message and some pictures,
rk3288-phycore-som is using TI DP83867 PHY?

Best regards,
Junhao

