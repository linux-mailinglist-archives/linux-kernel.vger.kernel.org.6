Return-Path: <linux-kernel+bounces-306372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C928963E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19608281466
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011418A923;
	Thu, 29 Aug 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LtISs7j5"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBA1514DC;
	Thu, 29 Aug 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919143; cv=none; b=Jpescm3l9Pr/CQQUY54hPXelioO8vHi/cpSY81c3YqGjs6uTyymLo3eHOOArkXusQK2ToVfYyr0oGUZuOqBfLB918UQJts7em69tBuCO2D+7pHmImbmjD7loFH88a408rNu3jrgQlSgso2T8pMEsos7RFC3e9UDdBiBuwkdQqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919143; c=relaxed/simple;
	bh=LhoYgLyM5XbThCdf8jH7EqoUBi+LNLv/QPqiVLosQ/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heldsDQ+E2kKC9p/UP/zmBDhT3I5aI4m9jAT/+RHCb6WnLFmp7FS9psKn7IvGQb2fmSbdqsz5aRqoy/Ac9MFhEb8mbuoKUi/TMK1iNjAxfykWpWM6iVuHfJKl0X2Fm9q86BZWbYv8EVvP6J5VaFIGGC0IeIz5Qw0sB27kMT7frE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LtISs7j5; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724919094;
	bh=WwFSzJmFXuAVAq2Dg47EJ+m/DJOzfT2lSv6otDRk6eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LtISs7j52G9tCp6NT+2k8PD8TXs4Rqp94SP0zoL3k9QpTkDsEydumI6Li6Okdixxz
	 o2nze4Q2JUKjvNmNXmWhEcWZPueOjiEX4Fx3Hq4nBxR3BGB5TDuw8OdcK9G6qS98Kh
	 iZWDI+SEEkKU9bZX+5dJkgbmvioa9k5Xw8qpK/l4=
X-QQ-mid: bizesmtpsz7t1724919086tcrngrs
X-QQ-Originating-IP: Uqhxp9nOeG8PynOltPScCE3Wgq7jsIgwqFrK8mmHh3E=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 16:11:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11804081818162876023
Message-ID: <E4159A9A6FCA9018+5e1772ac-7209-4268-954c-4c06c7a0b1e4@uniontech.com>
Date: Thu, 29 Aug 2024 16:11:24 +0800
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
 <F5CA4A560BF21722+cb62f98d-ab75-449b-ad11-52bc411e4f95@uniontech.com>
 <ae3fbf97-92e6-4bc9-a8b9-e326b89eac89@kernel.org>
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
In-Reply-To: <ae3fbf97-92e6-4bc9-a8b9-e326b89eac89@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/29 16:06, Krzysztof Kozlowski wrote:
> It is supposed to be part of this patchset in general. What is the point
> of the bindings if there is no user?

Sorry about that,I'm a bit eager.

But don't worry,I'll bundle it into a patchset soon.

It's not like it doesn't have any users.

It won't keep you waiting long.

>
> Best regards,
> Krzysztof
>
>
Thanks
-- 
WangYuli

