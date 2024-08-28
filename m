Return-Path: <linux-kernel+bounces-305360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40034962D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F134E28588D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932D1A3BBB;
	Wed, 28 Aug 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="gks/6HOQ"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1361A2C02;
	Wed, 28 Aug 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861775; cv=none; b=FthzIcuIdomqfyZMJNm8HhqnpMvzQEyr51/MnUwtcO6siOGwuio7coA8W9dh9n0FQPXD+Mf4EQlZ2+xHZshb4pw6qb9F+im13qz7RTLrcFfaDsRiorSieBqCUchC6dvcwmrY5B1x81N12kAQi2svzS2TeTHpvPPCdP1nAMe42U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861775; c=relaxed/simple;
	bh=c+x6oeNJa2vT47H2q/piBvTdueZtifqSkd0+5DGx8vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=TVWWAXvLwvoT08j591SfuEIdHGPdOl65np3eRh/UxKNfrDX3oAPDM0ze3rPwfPJW7dY+AuErJVD5NLpgXrAHH5n6VoLNU74R0EtW9q0lHPmG5ipbJa61Ps/qLoAypQv+4uF7/i/FRZfhq8HUpZuJvgH7wlCsDjpZgpjioEGZeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=gks/6HOQ; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.153.79.170])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 33DC8789E7;
	Thu, 29 Aug 2024 00:16:02 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 33DC8789E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724861763;
	bh=6K8wd3nD9WLSsOwW9XksbhVbocZ+D0rpe/Hdv2t4fOg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=gks/6HOQV81U32M4YIzHwfFzcxWsICyHwEYbTCylEzPt847v3Pqfo4iWNKohiF/v2
	 fg26KbTD26Y8E/bg4/i8SR9mF/0OjQjpfTJ+mUsIQciojbHfbYs30NTi1d0FAUYl6V
	 kYrJp9qTpldeIHYk8p9hluNDJt+8tvvXg8czotbk=
Message-ID: <8be71b44-403d-47e2-b148-09ef9f1cf050@classfun.cn>
Date: Thu, 29 Aug 2024 00:17:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi
 RK3566
To: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240826110300.735350-1-bigfoot@classfun.cn>
 <172485421376.1511809.16668781813371034474.b4-ty@sntech.de>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-rockchip@lists.infradead.org, Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <172485421376.1511809.16668781813371034474.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/8/28 23:14, Heiko Stuebner wrote:
> On Mon, 26 Aug 2024 19:02:26 +0800, Junhao Xie wrote:
>> Add dts for LCKFB Taishan Pi.
>> Working IO:
>> * UART
>> * RGB LED
>> * AP6212 WiFi
>> * AP6212 Bluetooth
>> * SD Card
>> * eMMC
>> * HDMI
>> * USB Type-C
>> * USB Type-A
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566
>       commit: 251e5ade9ba43f44f60713310f89e0f4495a2088
> 
> 
> It is customary to re-send the whole series when doing a v2.
> Replacing only single patches confuses both people and tooling.
> 
> But no worries for this time, I found and picked the correct version
> I hope ;-) .
> 
> I did sort some more properties and nodes [0], so maybe take a look to
> make sure I did not break anything.
> 
> 
> [0] There are sorting guidelines in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst
> 
> 
> Best regards,

Hi Heiko,

Thank you for merging the patch and sorting the details!
I will make sure to reduce mistakes in future patch submissions.

Best regards,
Junhao

