Return-Path: <linux-kernel+bounces-251182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EE9301B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0141F2341C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596E4F615;
	Fri, 12 Jul 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="b7pXbGaj"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22811BDD5;
	Fri, 12 Jul 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820605; cv=none; b=kbOcbaUHmcaVCInVN1tyzw05hdWktX9lYAMWlzo2At6WQHfOIv83voETB+SWAV4GACNnMYQ9rkKLr1n291kOlUT7kKz003g5NaJNRtx2sd25++Geiqbcv2EIA6KMo5gTw07ViYZoLcmxBO9/JWnkOwFnoYbfcnz0xq+JfND+/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820605; c=relaxed/simple;
	bh=RCeeKzAJg1FvECKSGKgaBOog4B19VvIg+G5oSHPL7IY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej45Gj3/yreNiPtFgWLkSHTr1vIqJ0iiXveyWzaQZN/GHXzhLj0TSmOHg8iggTABlcVVvmoGN6BWZtDvo3W0KnwRZinPcQfS8L0wSj+bcyLBYLGLJID6ebkfQTzLxiBsFZ9a+vUNkGZ2OKxaLtrqzFVUTCsf3Cr2cqLVmFG/+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=b7pXbGaj; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 995EE120003;
	Sat, 13 Jul 2024 00:43:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 995EE120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720820600;
	bh=4GV4tjJmQbTX60W5dCR9+m+1x/R7EQCeDhyXEOX7UtQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=b7pXbGajgcvb3qHIVTjjy6+Tti1SD4bda1gHdtylQEv7LLJ4zFn/U9jTyMh9kLy6z
	 ecUf0tMO5L/Aq5lVX1Bo01PHIGU1kSZ6U0nNXsQVFvX/VFzSMMBaY8Udx8my+6V3az
	 jhwCsBEBYQVJgDppSj+v5HSZW9UkY3p/Q9RLuoUfmrJNEWI48T49uKew8c7JeGMHwr
	 yBhianNDNZKLr7Fn3K5Ts3PataNV0AO6+LVxCbB+dIUZXDdo6NTQ/E4EnCY5H1VVCD
	 JnUElWPzHfYfix7BBpLNsT3Ik142FfUL9u8olwekEk1ESK7XuXkRuSsCqXtofcfDAQ
	 q5JJt8BQn1/eQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 13 Jul 2024 00:43:20 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 13 Jul
 2024 00:43:19 +0300
Date: Sat, 13 Jul 2024 00:43:19 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Rob Herring <robh@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, <prusovigor@gmail.com>,
	<kernel@salutedevices.com>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] ASoC: Add NTP8918 and NTP8835 codecs support
Message-ID: <20240712214319.7ku2oefkezawoido@pc>
References: <20240709221203.92167-1-ivprusov@salutedevices.com>
 <20240711211014.GA3008651-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711211014.GA3008651-robh@kernel.org>
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186497 [Jul 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/12 21:05:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/12 21:05:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/12 20:31:00 #25975503
X-KSMG-AntiVirus-Status: Clean, skipped

On Thu, Jul 11, 2024 at 03:10:14PM -0600, Rob Herring wrote:
> On Wed, Jul 10, 2024 at 01:11:57AM +0300, Igor Prusov wrote:
> > This series adds support for two NeoFidelity amplifiers. For both
> > amplifiers vendor provides software for equalizer and filters
> > configuration, which generates firmware files with registers values.
> > Since in both cases those files have same encoding, a common helper
> > module is added to get firmware via request_firmware() API and set
> > registers values.
> > 
> > V1: https://lore.kernel.org/all/20240709172834.9785-1-ivprusov@salutedevices.com/
> > 
> > V1 -> V2:
> >  - Fix dt_binding_check errors
> 
> Please implement the comments on v1. Please don't send new versions 
> right away and give people time to review. We're not all on the same 
> timezone, get busy on other tasks, take vacation, etc.
Hello, Rob,

Sorry, I' ve sent v2 before getting all comments on v1, I'll make sure
not to rush with new versions in the future.

> 
> Rob

-- 
Best Regards,
Igor Prusov

