Return-Path: <linux-kernel+bounces-251179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9699301A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490B5285083
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858F4D5AA;
	Fri, 12 Jul 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Tgo1ogS2"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D21BDD5;
	Fri, 12 Jul 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819835; cv=none; b=kOStfGXUOfgbKW04CWROadtNdvLy4bar6hrfgwuz2IObO8IiWfZ8nt+k+1SGobvA2ghqPQ3o2TPMnJzH1yaiaYXQ6qQxY6jFnOiZ/xC1cIxpxFL5UBW8DtO4o1P8hyCQoDyR8m0/hUIdbK+pEsKQPTyOd435FluH3NaT/aF+DOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819835; c=relaxed/simple;
	bh=NzRkn/29Wj6nv+39Cr7Y+df+r0V60+dHb8zRmS+u6JA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOMvMKjiOLwDdab9gx73oIilvl1g3O+rbKZMAyPjaKhbVaKNkRpxKi8uMKtUKLDlTPxOR3yXyI8WBQ4Qhskig9hY9Xtat8p8LJeP5Rzz3T4roI3SaWW/vI/Xu6SK5d/P/Ynvwt5C8RMu13z3199pvAU+JYR2ax5XtkwfCKv1tWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Tgo1ogS2; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 297AC120003;
	Sat, 13 Jul 2024 00:30:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 297AC120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720819821;
	bh=ra6Rb9PMS8Llilt6imdK07tpVm8s3Fl+HA/RmvYV5V4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Tgo1ogS2Znu5Ad5RjPIiKkjtk3XGjKEK0PGh62+KcC2Fi/GldeD12Ur7NBtL2moFd
	 VihaVgB5VFXMIwTqDi8RalopqOnkqXSvXjzys5HkTL2hJn+7kJ4B856rUsFX7DdVIt
	 9R1KhNesppbmPF+bsDBqG+k75BtvBiFj7s4O24H0jpzcYS/450hHshj2109vOw4fkw
	 qJH8VM+TfqJ+D4wHY4nHnHhqVBh1Add0z7L9uqQWoKfN//cdFcug2lBEtTDbtjKLMT
	 OwgwNc6gX1niVjh6HneMnsfr7A8GdXwGvVWxto24n2B0R/vdCh384eZIBqos/AClQl
	 kFcbSM0UaQmlA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 13 Jul 2024 00:30:20 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 13 Jul
 2024 00:30:20 +0300
Date: Sat, 13 Jul 2024 00:30:20 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
Message-ID: <20240712213020.a5n3x677bp4sxseh@pc>
References: <20240709221203.92167-1-ivprusov@salutedevices.com>
 <20240709221203.92167-2-ivprusov@salutedevices.com>
 <c59fc09d-e178-4acd-a825-4f00978c167e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c59fc09d-e178-4acd-a825-4f00978c167e@kernel.org>
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
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
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;elixir.bootlin.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/12 20:10:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/12 20:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/12 20:31:00 #25975503
X-KSMG-AntiVirus-Status: Clean, skipped

On Fri, Jul 12, 2024 at 09:55:47AM +0200, Krzysztof Kozlowski wrote:
> On 10/07/2024 00:11, Igor Prusov wrote:
> > Add vendor prefix for NeoFidelity, Inc
> > 
> > Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> 
> Did you just ignored every response?
> 
Hello, Krzysztof,

Sorry about that, I sent v2 right away after Rob's bot comment. I'll
make sure to wait for more replies in the future and will address all
comments in v3.
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Igor Prusov

