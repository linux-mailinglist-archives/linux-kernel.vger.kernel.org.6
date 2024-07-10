Return-Path: <linux-kernel+bounces-247800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3192D4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221531F244E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F70194143;
	Wed, 10 Jul 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HaF2bj1n"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655D19248D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624061; cv=none; b=KHbcj+jDpN5dajZj+kAbeEm5oeH9lbnNJfXU8G1qn1Y99IvHjr2yjw0jAnTkJWLbnUjq6CNihYekGpt7E26ok8nXI/wyrDOzMojJw3bO3mjBKRttcmB6MCE+huxLCacPBORfFmzFt23uBYDqwUtirlUPtlO9/UpJwrB8VQsAwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624061; c=relaxed/simple;
	bh=zov3U6IY42vb6dVwtIZA1ZnaVsYk+czB1vpCox+RMH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI1g8Qp0qOqns4xRmHZWxa7hJFBwnbRxyTuJbJlCei6Zx37pfMa8cVmvsERDhraXn1Pg0RE+WCCqMGq0Cspyv7pgwiwDUDVJKAwUqseAjTW15apxOkcgp6N9cCb6g2L8VEopJDxM9sgjgAVRKBcE5L/hOIzjUuNOBhVHtbYNU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HaF2bj1n; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1720624050;
 bh=F6o0iKuzMpNCZryVyBnGh4a50UcOdGv/aCY80jGMdOM=;
 b=HaF2bj1nHusWbQlJTV6i4VNNUtJb3GSq5cCf4gSiArP46EH5oNE6g6O0W83FnzFgs9huAYf2M
 kQjFr1qOu3W61QAXlH+Gh18AccAn3cQrW0x02NJpqkR7GTgodNEcIxx+js7gOex/ZEvVByQCupL
 hNNdlDzXYItbVcnwuCrn7dcYdMLPiZpYOOfWx0xKpkuAGutDaAg5bMg3sS26VZI0shcEARlXwBI
 9q1rj5HsbV8pk4jjO607+s+BqXwFtBZud8qu8jw54LSqd6To/HLnfW2jvQ7MFgxqKCrPCKhnRbv
 SWKO5q64/TMp03O5MoqEeGM/w8gW8AmmPFfnrg+i3UeA==
Message-ID: <08cc4f4c-5c26-4dbd-8fbc-5686fbc06b80@kwiboo.se>
Date: Wed, 10 Jul 2024 17:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm64: dts: rockchip: use generic Ethernet PHY
 reset bindings for Lunzn Fastrhino R68S
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org
References: <caf55fe6-4674-4c89-a94e-f4ad348e2ba0@kwiboo.se>
 <20240710145010.688986-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240710145010.688986-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 668ea3aefc7608dd27c22b29

On 2024-07-10 16:50, Chukun Pan wrote:
>> Where do you find the 72ms in the datasheet?
> 
> I refer to this commit:
> https://github.com/torvalds/linux/commit/1c7412530d5d0e0a0b27f1642f5c13c8b9f36f05
> BTW I found that some boards use the RTL8211F-VD PHY,
> but I can't find the datasheet.

Thanks, I can also see in RTL8211F-VD-CG (Rev 1.0 - 08 February 2022):

  For a complete PHY reset, this pin must be asserted low for at least
  10ms for the internal regulator. Wait for at least 72ms* before
  accessing the PHY register. * Note: Not included the 0.9V rise time.

So using 80-100ms may be the best option to be on the safe side, should
probably send a fix for recently added boards where I used 50ms.

Regards,
Jonas

> 
>> In RTL8211F-CG v1.1 I see 10ms and minimum of 30ms, in v1.2 and v1.4
>> I see 10ms and minimum of 50ms.
> 
>> I have used 50ms on a few recently added boards and they seem to all
>> work fine with 50ms, wonder if the deassert delay should be changed for
>> those boards.
> 
> Thanks,
> Chukun
> 


