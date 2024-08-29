Return-Path: <linux-kernel+bounces-306355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981AD963DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A09F1C24393
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9118A6A5;
	Thu, 29 Aug 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="B+xj6pxN"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADB1547C7;
	Thu, 29 Aug 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918449; cv=none; b=GZnrOqhLEdQRftGG/UK2HJL2XC/Uq9px8rFWSX6nWU3+/UBJHw9g2yCJESqq4Bw5AVr77oyVqE/UexbpD34SDPsmFl4ZAh1ehmwhrvW3awy7Of8JUuQ4T6HQIRFY5W0glY1aKpO4C/Qs4ffVeGrErxRldGRCajHRYvU6QI/wbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918449; c=relaxed/simple;
	bh=cV1SgCknw30q6JiLWZU2swrK1gPZJlUoCKcfcuCuVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXHWtE17dnJus7M/YF3YJsFEtIejr3CZd6+tyPeJiZujbThRGD2kkeGBLm7yFMYzqk4kyph//E9Wfy+4wBC+cVacOJ3LyAVg3E0E0Sc1/PKGq53M4+xdBjJrjSeP9c4azupz17MEq8OJBg4dpHXMz/0+bGmC1TlZQR6aZqePvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=B+xj6pxN; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724918393;
	bh=esyYPEiadi4pldpTpTT8zGfVCTV/T785Yik9o/TRmBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=B+xj6pxNKtV2uWo5WOLcA9NOmU9SAKaxFd4Nx7Ict4rn8I7LDqG2zEtTdeJq/iC9b
	 oPnTqyuyc36oFTwFZvUC0Bn7NCjaqYSlBs27alWq43ZtWmqRF6nknFynnDPxsHzBGD
	 72qWB2Nubt6mHbBQxQdvUUVqPMP8PBQHNdTgM/x8=
X-QQ-mid: bizesmtpsz2t1724918386tj70e3h
X-QQ-Originating-IP: Jkhi1jj8RhBwo8kHdnQbR446HNFq7QWpocEyeEYsDDs=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 15:59:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9453267234939554862
Message-ID: <F5CA4A560BF21722+cb62f98d-ab75-449b-ad11-52bc411e4f95@uniontech.com>
Date: Thu, 29 Aug 2024 15:59:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: cpus: Add Phytium FTC series cpu
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulf.hansson@linaro.org,
 shuaijiakun1288@phytium.com.cn, davidwronek@gmail.com,
 andre.przywara@arm.com, chenbaozi@phytium.com.cn, quic_rjendra@quicinc.com,
 lpieralisi@kernel.org, neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
 rafal@milecki.pl, linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>
References: <234DC989E49C885B+20240829070933.299723-1-wangyuli@uniontech.com>
 <27bcac2d-09a8-4212-9e33-748926e92ad1@kernel.org>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <27bcac2d-09a8-4212-9e33-748926e92ad1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/29 15:51, Krzysztof Kozlowski wrote:
> Quite a lot of people to add few compatibles. Are you sure they
> contributed to this exact patch?
Yes.
>
> Also, please provide lore link with the users of this binding.
Preparing. Becoming very soon.
>
> Best regards,
> Krzysztof
>
>
Thanks
-- 
WangYuli


