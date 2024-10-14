Return-Path: <linux-kernel+bounces-364108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0499CB43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9F5B25998
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122B1AB501;
	Mon, 14 Oct 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RsqfMZQ9"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9781A76C4;
	Mon, 14 Oct 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911507; cv=none; b=BjtK8x41Y9GPFerIN0GdQ4HbdPOi5Oi3ppDXff7Oia8/41wLKLixn9U+6K6iIRY6fzJim6BpKdtm0xwiXmbTw/FAqLSTBxN0XodRolcTFzgFKT+cqFh3oG3x0TN7XEfiWqzMAaa4CajhuDHQTN3kTrdMXC6aSopOx0pibq3E+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911507; c=relaxed/simple;
	bh=5yU4dRg8eWV7Fgu5/bN7jBjpK68MkobODeODS6fxwYM=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=J515l60RMLe8nhLrp7hSANhGnaMEK685oI/cTIM0YoJNyyMt8hYIVTsA1kpLTZWR758RPhX3uhlBFLLZtWCF6JZYdEzXZ3k0aeAvlBC/LNoAAairv7vyAJN3jLhgHiftfc4egxxIbf4kWiBHvlm5LWM30JP0AHT1lwU10Bsj01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RsqfMZQ9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728911450; x=1729516250; i=markus.elfring@web.de;
	bh=TfCLl53lB42+HRnDMfXfFuOecGZa7W9eJj72/YGIQ90=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RsqfMZQ9Q+piDeHZsRcFUz3vDcgukjqoWXoDiTWFgKUxTOc9IPe2aCGni6qXn7sp
	 cWrWorf72z2G6j8w2Tb4TUOIB4mjb13kkPjpGGcQreoyMbHBe0gldDx8qm+J2d2fX
	 if4LMXB2Q1UeFTSnlBQ8hxMq9sc03DBN9jFRiYvYa8/2bA9rSkL3qzPeGGgr941bq
	 eAxgsqZGQDpmYGKSLCCCVEGJfxVfA3vTLVUbGWTGpamLNUau6zGj3hBIXji0aq4TR
	 ebvHDjkaUsvf1+JsHWeAmltdZcS4bcVAiv8KnleMRXbGfrdgJYQd979y7eS7t91RX
	 soazwx1zCzQFXrVzjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.82.95] ([94.31.82.95]) by web-mail.web.de
 (3c-app-webde-bs22.server.lan [172.19.170.22]) (via HTTP); Mon, 14 Oct 2024
 15:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
From: Markus Elfring <Markus.Elfring@web.de>
To: Kevin Chen <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, kernel-janitors@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX
 INTC
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Oct 2024 15:10:50 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ovMgIH1q08E5i7Y9d9W6SUygzJNgl2aH+f4oZ4d1KfDWxtS1ZMfItM3wjo2ZYndBhaV9q
 sVsLTIFgAYVRuSGipm1FsubPyMzqvHvSteb4G59YcNgWaH80fuZ+UuXRhPLk821rLkBWIHkW30Ba
 VuUDtM44h0UWnxTNZYXbFpGTgDzjWiAqxxZewwynGk07TGaZ4vBcMMMseNsjk6+009ifsSk1T9Ls
 iLk4yLDwTV9z52eLXfrkRI8yHmF15qSC360cl5/tXmjX9eSQZSPkWuhDfWfFwGqJltTJCXY+R1n6
 Lg=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8QIWZabSQls=;BMNnAN1dJoT/6h4uy684oy1oyg8
 jrr4wBj+qthZ8l5y3dGE0as9BdePavt6FDWiZKGS3Yr049y/u0M/KiuShJ0T2cDVVKUbEU+zi
 Xl5t6BmSc61xxFU9MdSfNICci4xBwBccugddklaAsddcr2R3CaPDxnBIpwjEWt5IfsippsbXo
 XMQaT2aeUTUeH2NJ5ahSYKQX1XzAFtPT0DyrpMFZAjD8NFCi+sCScDnS0oML6SJTWh16r3N2a
 lQCcJ4e64lhGQl6xQqMsgOjXMwKNzw9+LfRRKWICv5jIIjTGFFqGhqd9rDxGnzAkM9h92Z3QY
 h4VyosDzY+iyf62bvzV266k7Bkor4XhdmG4dZcQ8gACuyDklooc/yxqrASQHtxvNzRhkwu13G
 ysI0HF4gNIOlqkpZNj5S1PwDPHh4MvNPnASCcbC2PhdZ0uuN1W/pdlCyzVZYGTkGLHroGyX4X
 uZ4z5OOD+0sJBjzda777h/6WDufB+Bn9wLlSt9mdaEFpZEgh/mo6L3G42b3hGW6V/t+7i9PiK
 XKPA6/hyqPvPB6nzz4/zsXGBfl/Vf1AGY73RIL9/qBTKRL14OCkz3CZ2tQg+llzPA29N+jzBt
 0wFLFE2HXPBjU7gi4SxYZuvg/HhrprBjX1rKExITz/nYgz2FUw9Q+1KrsbdzWNdudmOy/Nsy9
 fcK81NPE/cadP3hS6Ihiu0Md3pwMkaexbVlfkxeHmA==

> > I propose to move selected variable definitions into corresponding comp=
ound
> > statements (by using extra curly brackets)=2E
> > https://refactoring=2Ecom/catalog/reduceScopeOfVariable=2Ehtml
> OK=2E I moved these two local variables into scoped_guard=2E

Will development interests grow for further refactorings?


> +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
> +{
> +       struct aspeed_intc_ic *intc_ic =3D irq_desc_get_handler_data(des=
c);

Another update candidate (for scope reduction)?


> +
> +       guard(chained_irq)(desc);

Using another macro call =E2=80=9Cscoped_guard(=E2=80=A6) { =E2=80=A6 }=E2=
=80=9D?


> +       scoped_guard(raw_spinlock, &intc_ic->gic_lock) {

Would you like to reconsider the proposed macro mixture once more?


> +               unsigned long bit, status;
=E2=80=A6

=E2=80=A6
> +++ b/include/linux/irqchip/chained_irq=2Eh
> @@ -38,4 +38,6 @@ static inline void chained_irq_exit(struct irq_chip *c=
hip,
>                 chip->irq_unmask(&desc->irq_data);
>  }
>=20
> +DEFINE_GUARD(chained_irq, struct irq_desc *, chained_irq_exit((_T->irq_=
data=2Echip), (_T)),
> +            chained_irq_enter((_T->irq_data=2Echip), (_T)))

Would you like to add a #include directive in this header file accordingly=
?

Regards,
Markus

