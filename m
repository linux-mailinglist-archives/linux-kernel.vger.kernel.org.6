Return-Path: <linux-kernel+bounces-303167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14396084F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FBE283EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C219EED8;
	Tue, 27 Aug 2024 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="toWeKiE4"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8F15D5B6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757452; cv=none; b=rptb3JPsv3pQ87IBOS5/4xhcj25bH7i+mrVQKABqvjv+IjtyaidGi5gXSBnj7V1r9EBDHnubvmevhpzWtFBF37JhYSIsiIt7/v2XCWhGMCNLstBXrvO0ZYW2uod3ecjE4ecbpNaQojSxaiWVUk6o/Wgj2jP0VX9FlmujgL1z/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757452; c=relaxed/simple;
	bh=8hBSVPloG6qLi64U0Rpazu5mshd0SD2BYuhwJWKhwkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI96PqZDeQEcoMY9u+xgiR6PajHsZiK5ZqYoJ01b3Z8clWHn+pZ+veXxHJCTANpPD+pgicEl3/oYyLoL4AYDZOZmGGLrmDfesmxGUFfPHYiZaPShNBOMvAF/or4qJwPq9OCpXBss3OArI0Xo1Ug+vjekbpsnX7JO5ZGZTuLPS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=toWeKiE4; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724757438;
 bh=nQ4QainTGN2Jed9JjhWBNvyI+iuWOCGmVBnaGKnvp9M=;
 b=toWeKiE4pM0pTT1816OwRfr8BIWKE8t8yxh4+jr4IM8ecRyC4pHl25Y67zFRHNAkZLEHahObq
 zdSz7w77Wkp83xX0so+uzFrl+iuy7RMz124WbGgM95EcsGXo4fYyqD/GKmd03rxyz3Y6COIEmiH
 KgHyWwiErbQlcVElQWXCtp6aWNdvn3Hz5k3LmBpN+KTAQLiVyjNVtlGY0Iiv47K8+OpipW703uK
 uiZCw0fqMBsvRkN8qRNw7KRdAfitMV8rLcKnzmjTJbsU3ULcg3DrDql4W1JpTqElg+mDwZxp7yD
 /2l3/Hu/Jps4XeoMhKXRaCuZBxWA8PNb1mfVSSNHrcXQ==
Message-ID: 7a6e6536-bcfd-4448-aa5f-25f492435e8e@kwiboo.se
Date: Tue, 27 Aug 2024 13:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for
 Hardkernel ODROID-M1
To: Krzysztof Kozlowski <krzk@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Dongjin Kim <tobetter@gmail.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240826205538.1066103-1-jonas@kwiboo.se>
 <66ccebe1.c80a0220.22579e.e8daSMTPIN_ADDED_BROKEN@mx.google.com>
 <bf6145b6-8dd7-40e8-8b33-7eacd2c20a37@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bf6145b6-8dd7-40e8-8b33-7eacd2c20a37@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 164.92.70.200
X-ForwardEmail-ID: 66cdb5bac498660ae9674ab3

Hi Krzysztof,

On 2024-08-27 08:50, Krzysztof Kozlowski wrote:
> On 26/08/2024 22:55, Jonas Karlman wrote:
>> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
>> rockchip. Use the proper hardkernel vendor prefix for this board.
>>
>> Fixes: 19cc53eb2ce6 ("dt-bindings: rockchip: Add Hardkernel ODROID-M1 board")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Your messages are broken somehow. Broken message id, rewritten by google
> but I cannot grab the thread neither by original nor by "fixed" message-id:
> b4 ... 66ccebe1.c80a0220.22579e.e8daSMTPIN_ADDED_BROKEN@mx.google.com
> Grabbing thread from
> lore.kernel.org/all/66ccebe1.c80a0220.22579e.e8daSMTPIN_ADDED_BROKEN@mx.google.com/t.mbox.gz
> That message-id is not known.
> 
> b4 ... '20240826205538.1066103-1-jonas@kwiboo.se'
> Grabbing thread from
> lore.kernel.org/all/20240826205538.1066103-1-jonas@kwiboo.se/t.mbox.gz
> CRITICAL: '20240826205538.1066103-1-jonas@kwiboo.se

Noticed that this series behaved very strange, may try to use the B4 web
endpoint for a v2.

> 
> Anyway, this was sent:
> https://lore.kernel.org/all/20240116192605.GA274661-robh@kernel.org/
> 
> it is technically ABI break, but likely without practical impact.

I can see that for the other two listed boards the compatible has been
corrected, not yet for the Hardkernel ODROID-M1, do you want me to drop
this change?

I mostly wanted to prepare/unify before adding the ODROID-M1S (rk3566)
and in a separate series add the ODROID-M2 (rk3588s) board.

Please let me know if I should drop or keep this compatible change.

Regards,
Jonas

> 
> 
> Best regards,
> Krzysztof
> 


