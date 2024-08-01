Return-Path: <linux-kernel+bounces-271043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3E9448CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC002825E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0F176AA4;
	Thu,  1 Aug 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aTAXlb+V"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23D16EBED;
	Thu,  1 Aug 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505875; cv=none; b=bWgTScH+pB1w8h0GLBzwLp2ncV7/9aeD5wcGGWHDLGRxvhXpv2crHr8v3sz71qj+XQi4rfpwj7R/78vcR2NJVIqbtR8yW4lerZTdmhZiSqPSq01oTJo+Zv2Ai7irV8G8SmrI1VU6VRhCpBqLIhH9UBcMYSLN4Ia5fqgb6oirY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505875; c=relaxed/simple;
	bh=EFFvQxWL9UNPrZdUueU7uIPciWCNAv23KL3vjaoAAf4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aYSFG3/Vh9I0qUBPwgeSFyoc6pmpuXtMLNZllgbdCvlJnpDTE+clbYOnWzLXCfed+k/irFaJDdMvjAxXF8HH/t2aFwXrnqPhgaJqCca48E8wVywDEaAs+puAtqyh2szaGUEJm6WGhRUXLL5B2pQugT/2CTINm7pczn8/pygDfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aTAXlb+V; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722505850; x=1723110650; i=markus.elfring@web.de;
	bh=EFFvQxWL9UNPrZdUueU7uIPciWCNAv23KL3vjaoAAf4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aTAXlb+VTk8ZdINVugmOnqa27Adn01TFqCyDyWKJ+OtVvTTteYJ1OPU0pzIZFx2+
	 P2zqneB5xL54ueDlDc83gQWJk/IStBH4uSnHw8LjmJ+Qo9Yj05r2RwlCpsB0QlBdu
	 qyruFfHmX/EcNDjy3O1OG3U+73qc30p+SFuKNuxphAbN/4d5oguBqPcP2pAHWcVDu
	 AnIRLRnnUdjBONwXmN3NduacPB1s9sA8XwJk03nCgQPFme+N5/rGB04yjLklArX1k
	 jVQXRRaYYkTISA0n4xdAw7efCBrB85kFTsCrjTrbFlXL0ZNWs/uxeKJqeul3qGudt
	 AD3cdzH1+7/fic6/iA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1sbdFC2gxs-006BAr; Thu, 01
 Aug 2024 11:50:50 +0200
Message-ID: <9cca717a-c7e9-4bf7-8cde-3a90fcfb1df5@web.de>
Date: Thu, 1 Aug 2024 11:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hui-Ping Chen <hpchen0nvt@gmail.com>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240801053744.807884-3-hpchen0nvt@gmail.com>
Subject: Re: [PATCH v3 2/2] phy: nuvoton: add new driver for the Nuvoton MA35
 SoC USB 2.0 PHY
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240801053744.807884-3-hpchen0nvt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NL4YA0BqmCCKVmCStnA88TsGOKJr0NvMWCWg9dMsDE+euFc6uye
 Vwb/9EDvPhIZfs2jFv7kQRlziw8MpwPLagO/rEfeZ+9UqYs9uROp0Q8piUyDc2f5cvBcOr6
 oGM8ElBBQZTcVL9AvIIaq60dPxOkmjq4Kjur74wKP8gNr44F4zy8oCTvRpbfbCXjcFYS48y
 m27ZMjf8TqlLatBS+NSrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0kpx8SitMVQ=;MY7MjGHQ2O0KQx0HM5VwKw19C52
 BqICda3DxB9yEOhGRif8D1Js4d3DXe2/cZgiy/8MlzVdgPOgXBbBD13bC3O5cXWCl5eX+/pQz
 z4lVUtXJrrxDGBPWe7xAXOdZ3Q1myOWxPss+pOXMhOP22Q5xyyEg+n5armDq+7QheW0L7QF9h
 qH48z85a+QKPSCabyRbkOZkmlsLDOZpyN4ZToaApCwN66YSka3X8WHk9qc9nsfMPtbmYvDw88
 ESQ/1HSAl/LY5uhXZimEGbvDzzjqd6To2HS6AUerwDCQ2nOFMwVGBkeOy/fASl3+3EZKrH2Oo
 ssgXnRkJb7r8VIvq1xKW4y6v1GYJTsWop/t+BtjbEJ/Okx9fuClPU3uzNDWNKLG1vBldteTAZ
 xxoPjdse0s82czOx6KmsZjB12fnte3xggnhum6H5+1yvUkLB0mYBWI11UCfqrhFuIb4XNHIgm
 qoyutw95ncdRYu2t71q/2UVeyaZhooMQ2a8DTDjzMLxpZcADdH5UPQFaSME1V+pFKAgJZla0O
 QvdgoPh1nQZIs7h2fyrpP6Rm82jE8Q0AgPrT5XqmFdOwFcfO3TbsnNYJT2338etivGQqjhJcE
 eDg4ypcEfdNUTgnGMHWLpvSzgCQKKPL4hHoe7qTOrUfp5JC31eK7LuHprwCNHOMCH5ge1Bphf
 PrzOP3B5S2KFyWoyp7SyBO44DwirtkSMHYALgiKhbrOyDdO7+MmgwsYz+6rlh8QQmkx0uBaQH
 vkm5GQegyM8719ncMBzYhRur7MLx9G0QDceDJ4t3rQ4YGurn5HP43mvsryqpbCrAG/GVLK5pw
 /k7NrgtUScs0b/2iV2obGepQ==

=E2=80=A6
> +++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
> @@ -0,0 +1,146 @@
=E2=80=A6
> +MODULE_DESCRIPTION("Nuvoton ma35d1 USB2.0 PHY driver");
> +MODULE_AUTHOR("hpchen0nvt@gmail.com");
=E2=80=A6

How do you think about to add a personal name to such an email address?

Regards,
Markus

