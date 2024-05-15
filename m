Return-Path: <linux-kernel+bounces-180079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A78C69DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9591C2167E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697A156221;
	Wed, 15 May 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hI4XAogI"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DA149DEE;
	Wed, 15 May 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787475; cv=none; b=EnAWPrOvnIP+AsikC0KHEjwkW/mGD0e2AVXWSlrz0YuAqAkbxEGVoHrEneqFdyCJTrxVXjjGIknHD9sP52DgjzwxDuEJubCkrsgoX1YU9ayH423a0BDY+8SpDrM3UFAsp6/Pv6st74sz5aQMnV+fI9IJWhutZHTZDzdqETUdrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787475; c=relaxed/simple;
	bh=SIm0BSS9GgUe9wekJzIw3wuit7u9XixO8Wy0pSPRkl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzJMebWxk+/9HKUtjJsjWW4jxTRJMV+ssEyNHIVSd7duWri31VNB5QoQPQ+Eh6aqSXUVN1B7CsCXGuQgekispGJP2YPt+sKA9v1iwzECL0OAX640JUbrqHJrMeZladhHUxby6++/7zy98ygZUBnO5uemRiNegCIUcv+wV7yjbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hI4XAogI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F32A6881AA;
	Wed, 15 May 2024 17:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715787470;
	bh=QH26ByvOQZ5ZvIRm4mwmie0PurCQOytE1O9vcfqJ7k8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hI4XAogIvydq71jAdp08CBhPXS3m3P45/HoF02g4iTbrSheJNW/Zp8eGZ1oQRfKBc
	 UtmW7wklwTQ2jFCTDNB219iKjDGkt9AL6SRMznHGQPyoSRPx4pI18nAZ70KRe8+jXu
	 QZImy6IttJEy5Aaxi7YmUUpzImBYEedjfAp//N/91wuZk1W7UsYIFpmaa7FJPBtGNx
	 yrj9DHFCr5jSQagbTNXdRiJyJBTASF5v39ABuVzMZDYsbG5W2pwu0/leGos124s92o
	 O3LFifmce9U5HSDhs19+2aL8+OmYC2bfFrHUn7quk7jeEbZJda4yMyfifo2EMEEbvY
	 48SIjCeugEoTw==
Message-ID: <9de93cbb-5868-473e-8b32-a6b6f50e128e@denx.de>
Date: Wed, 15 May 2024 17:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Conor Dooley <conor@kernel.org>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Pascal Paillet <p.paillet@foss.st.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
 <20240514-entryway-idealize-fcd5ed0e1de7@spud>
 <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>
 <20240515-monsoon-starfish-0dc59707e843@spud>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240515-monsoon-starfish-0dc59707e843@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/15/24 5:35 PM, Conor Dooley wrote:
> On Wed, May 15, 2024 at 04:33:22PM +0200, Patrick DELAUNAY wrote:
>> with
>>
>>    compatible:
>>      oneOf:
>>          - items:
>>             - const: st,stm32mp1,pwr-reg
>>          - items:
>>             - const: st,stm32mp13-pwr-reg
>>             - const: st,stm32mp1,pwr-reg
> 
> Other than the extra ,s this looks okay, thanks.

I think the extra ,s are actually correct, those are the ones from the 
original compatible which had TWO ,s (it does look a bit unusual).

