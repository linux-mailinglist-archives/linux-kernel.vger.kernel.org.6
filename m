Return-Path: <linux-kernel+bounces-366086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B399F0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8445828284D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1A1BF2B;
	Tue, 15 Oct 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JkWSKLCH"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16411CB9E4;
	Tue, 15 Oct 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004897; cv=none; b=YKLcke6rg6S885orKjavy85TOaGBbNcOXvw/9CvRO9C+I3bhc4LdnSw+x5iV0IGzbz0rQ3U5R1Zc5B9U04HPy8sIE8FcXf+xL7UW97woTWvcaYU6jDjk8KT8vTJC/nf3inCeYVhaZNlYR8rIGmD8U/ccqjfJ28sxwOyJhXfpnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004897; c=relaxed/simple;
	bh=gdlIJel0Ab3zWpaPit2XyOzQkLrTxP7jMksrMJtCHWY=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=A4y/P13dZJozQm6naLYvsBXxWRWMtGxVyOzc/MYaJH/2uVVa0fKy1VzzJIno1szpaOI9+0LFb6Sqv8ViML4TfXZbrykU8qKKveJo/45nvdxAJ6wm0jgophrq2sza7JzHQkFHnwN4g8dLrbUCZl4LbkDj02niPFVePm4x5McijIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JkWSKLCH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729004844; x=1729609644; i=markus.elfring@web.de;
	bh=MaPDtsAu0VZDFqGSAskos6W/UUdZXWKX1E7T5Bfhlow=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JkWSKLCHNB8kaCB9g1M8JfiGz1Gc0l/VhPaxS0LQyKyNL/hgDWVKNb3srRuEKEV1
	 OSdGLy/YNoAZux0fmVRS3T2XdOaX6I3IPylYFKFqxx04UJCMnEF8CP3AvdQFxKxvQ
	 QELr7IBxX6mXLCRqW80dxQOcHQoapzDhuSZpEt/qN2ZHxaN2DaQKZA5ufDHVEJ0rt
	 15BKgS/qTaIxHvWTFhjOK7WENeRRsD3e9c/h26tNeLzithewjXBEDGRsw4hjK9ef2
	 2Spz92VNA2FajUcCL4rVaC5p5ZLd+EhLpj8uVEDjS+5QY0MaLg7TR1XWcJ3SdunEM
	 G8vDReVBL52VFyrYPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.89.95] ([94.31.89.95]) by web-mail.web.de
 (3c-app-webde-bap19.server.lan [172.19.172.19]) (via HTTP); Tue, 15 Oct
 2024 17:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-8fef4ba2-f5ab-4b78-b3de-aa1dc7d2fa33-1729004844102@3c-app-webde-bap19>
From: Markus Elfring <Markus.Elfring@web.de>
To: Kevin Chen <kevin_chen@aspeedtech.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>, kernel-janitors@vger.kernel.org
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX
 INTC
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 17:07:24 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
 <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:F3RU5HNCdI/jhBQpl+toJRa3DuBoVXM/3J7YtGQP8UK7HGzSQbDWkPV1QXbhmYa1fJYWS
 OT3rKdiRCJX+9hUs/QEWqw7bYCjq5DB6X9H1nPG5sBtFSjbelw9+KJRI6BrjJvEzHmSWCDSYYuVF
 MhqAxLP9hbrZtcjr58Pyok9idl9H8LpMsJCOMB8mAfnUL/YivF3D6ymuyUXT0cuW8g7l1JB65aXy
 vmPBcROpJgZfpg24+QtdQlF6FlL4XVIdNgFDbTIU1ei0HczxdoqplmDaAViogKxnqCdBRkVWF7e4
 mM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dD4MnKQdevg=;PGRHMRrbx68AQKUlksNjQBeq6CZ
 0U6ABRx88Ioju0X2E5N/+H0j2oCYnZ1Q99BM9ThJXW6seOOSEj7zeRqoDzfJlqx8nnMQyQ688
 ZuQgWhBKfNB0jgNSvqi1qIX19OD18UjPzLPm001jOmf9CRu5CFX9K+7d+pUrWYlEsGN2TM6tV
 YfM3FshPbU68Z/Bk8Lli5C4pF7abi06j0/UgKE1rjG1IzvuecELoUxx6j8aoMtpdwhvoXfZW7
 LyLmWmZEFUmLvGPyOuif9XN55EK7aDJJaTTwIMKlBz/1V0a0wE/9rMNp/ZFzKqWA3xLXvEVmZ
 PRSMC5apha1Y7Epxf2JKIAnoiS1u8SZFgxp67tH6Pf1ED1AJJFgoiNP9XhDctNnuT30RD69Td
 Z52BDQgTxEVPeK6XYKgCtFAlptWh5VpSEXKsrySIO+YDGC1dJKLDQSvdwj6EF7hbBnBuCBB/S
 GgI+K/Bb3272qz30qxXj8dzKh3LcM7gaIdwfLnLw4J9x1VXi3y4qVVUIiSh37g9e4OVh//QWs
 yockuvjNsyTIg/bWkzOmV3S6U8GFRbRMW76jf/k9/Mq8acx9IhzsZk3Yv0/vuBZJWNrT+9wos
 ULhFGGq9+IeR8SA4waEHtPk1JDQDyN624qb2M2yTtQcSYcf7o1JHBzewZShncbE/xdtmGlQgk
 qTuldRrUkZoo2g27bf9qhhWTL+KSeyUWRjp0Uwnpbw==

=E2=80=A6
> > > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc) {
=E2=80=A6
> > > +       guard(chained_irq)(desc);
> >=20
> > Using another macro call =E2=80=9Cscoped_guard(=E2=80=A6) { =E2=80=A6 =
}=E2=80=9D?
> Is it necessary to use scoped_guard(=2E=2E=2E) {=2E=2E=2E}?

It depends on corresponding case disintions=2E


> > > +       scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> >=20
> > Would you like to reconsider the proposed macro mixture once more?
> Could I check the reason for once more?

Coding style concerns =E2=80=A6?


> > > +++ b/include/linux/irqchip/chained_irq=2Eh
> > > @@ -38,4 +38,6 @@ static inline void chained_irq_exit(struct irq_chi=
p *chip,
> > >                 chip->irq_unmask(&desc->irq_data);
> > >  }
> > >
> > > +DEFINE_GUARD(chained_irq, struct irq_desc *,
> > chained_irq_exit((_T->irq_data=2Echip), (_T)),
> > > +            chained_irq_enter((_T->irq_data=2Echip), (_T)))
> >=20
> > Would you like to add a #include directive in this header file accordi=
ngly?
> Can you give me an example?

See also:
https://elixir=2Ebootlin=2Ecom/linux/v6=2E12-rc3/source/include/linux/devi=
ce=2Eh#L33

Regards,
Markus

