Return-Path: <linux-kernel+bounces-356999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6E996A16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0CF2874B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E22194AE6;
	Wed,  9 Oct 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l+f1fp4o"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D06192580;
	Wed,  9 Oct 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477173; cv=none; b=BGPI8JEjeN7ifYYYbQxQmVFrpiLIMVulxT5wjAIWKS6eRNlr5WQhZrgv3/C3G5CSZ0lnjZiae/3UbB2ZVarOtH2vxfydKck/SxsksziRDCoTT5q7W1Yf62upiH9juX4kRtwbQ4NqpKCmkSEcfsBuBxIta9vlNiGxL1Z3WgexjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477173; c=relaxed/simple;
	bh=10VIf3xpcfjl+spQkS0THT6kkcTMVh9YE+Vbqol6Nko=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Jov1R1hk+qtQ67NmQ6yyosts0RN4urriGEa2WvqoFNUf5UKAr/MhH8quPULyvibR5nWKf99d8ifFtC6/tq9YIyRsJMSj1AH+/SUhQPyPxRCwRc1f8RFQiIonMgFTjjVU6AMvt6KPHRRwOkr7dyt5/pcMvOErZ1sxPlcSmRD+fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l+f1fp4o; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728477135; x=1729081935; i=markus.elfring@web.de;
	bh=fTLC63/37zNTLhxxSZfbfT1jlj/UPeR+t+SxAKcPCzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l+f1fp4oIaruTt2PE9/Wusn9XmYNhl7ZVYHkMV5Ov6lcdKLFXRnoiuzUgQBKCOEC
	 yRyUfvnxnUJbZAMFT4HURkufzv9b+B7AG79YDHkvDmmtPVvPZp54yMf3F6f/GoxSm
	 54iPbD644GNAmKAqPXyXTnorclpxChT9Q7oFJ2i5UmCh1XlOGTMIMV56fSvV3wCG/
	 G/pOOJ0QXk5mNXTmEOH5CJOMMzRqh5ZakiZQLJGgOjlydtNVQihM8Mtjfjn/Eb5sA
	 1K9m4M89/1EpoW/bv9yBjvr1jG1p2zEaZthwenXCgn3uU4mjxGaNTOpwPMh84Plna
	 KjbqwvzqNWkgvzvXgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1tSde13LgA-00Vu41; Wed, 09
 Oct 2024 14:32:15 +0200
Message-ID: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
Date: Wed, 9 Oct 2024 14:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Chen <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PCpmLz+Zi0O7z1Jgav1HZtP81S2dqF8GZsxRQVqHNWM4Mor8A4k
 /EEuB9727FeHAmnW7fxJoJePoxEYlN9j9IYWCGumLgQOwzkHTXiTWxdI3xHyO36MQFrr+ax
 pqY0vQPOReTPPYQcsQqIbZLzEmqB7p5WbvOh/MrlpSwh7VfFyUIthzeK0HTOZzFeQ1I1bxX
 nnK5zBJYtsUNLnhNRNUOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6uWhpcX/AM=;nfw5uX1xIx/2R7OZUSmWukyicJz
 JPVM4iY0jkfFi7NTB+ffaU3MIOo9rbEdX2OQlpL5kOma4+zXMk2MxdQLnTb/GlYmIG9AI5UYy
 NmDbMJaRbTKb+TtCx0DrJLsfdDbn76/6QT7JdyWhI//2f6BODmOihge2iKNyvzH6ZzLkWf9iq
 CdiJ4nPoDNHOtWiyLm2CsYWcUw+mSB0zctWA5eqdrWnck3t1KSt++Qb2m+IY20mabNnpAfqV7
 67gHTnYFwzwn7S3MJxj8U1zgzqZ/K5TwkRg09Wo9lMljIW+Wk0/21+VDOf4gwDx9oUAfj/WdH
 udrLmwt6Fl77ijgNvQkVowWCxc9ja8jB1XPLxVIhZIt2+pKxSPh5ITxHN7sGmJmI1IGj7P5Zz
 pQr/YwviytLZf0DDfXJcgHmMhZCz0fRpRctjHcH9WixsaN11mg4Mn29lLyXv6pIJnHcG1f9Rf
 1t0hH6KaVPJUMAR2M92cghxT8t0O4JnXvfaA9RMcbO0AM7oBlqIj0PSsnU0zkQqCXPbzTqnX/
 WHhm+cSlNZK++yqAqhWMmAmWplRPOcKnxAsxbKrnZ6/sBV7vXOMATEhQZeO9lYvcwzoAoTNbP
 tVf2yOv27TAPRBOkCa8hqmJvKhoB6oHDZ3F0uS9GYrJY8eKUbrUtFjAda9y6J1rhvJ+8s32P4
 vFDX8tyhRoXRg5M+k2p3IiC1wOWV0JA21PWN1DpsZVISRphpwTEab/fP3BsKo6DhucIAuuum1
 5iVvvc8Y6aybJd9bZFsfZ4yp0LTGIwmB3HXJ/Aaa8+ANCOl2ocbo1BQeq+aJ60ZG+Ts78cEzN
 j7OLmG3f/qMLc7krAHa5HKGA==

=E2=80=A6
> To support ASPEED interrupt controller(INTC) maps the internal interrupt
> sources of the AST27XX device to an parent interrupt controller.
> ---

* I miss your tag =E2=80=9CSigned-off-by=E2=80=9D.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n396

* How do you think about to choose an additional imperative wording
  for an improved change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n94


=E2=80=A6
> +++ b/drivers/irqchip/irq-aspeed-intc.c
> @@ -0,0 +1,139 @@
=E2=80=A6
> +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
> +	struct aspeed_intc_ic *intc_ic =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long bit, status;

I suggest to reduce the scopes for three local variables.


> +
> +	chained_irq_enter(chip, desc);

Would you become interested to collaborate with another scoped guard
for this programming interface?
https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip/ch=
ained_irq.h#L13


> +
> +	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> +		status =3D readl(intc_ic->base + INTC_INT_STATUS_REG);
> +		for_each_set_bit(bit, &status, IRQS_PER_WORD) {
> +			generic_handle_domain_irq(intc_ic->irq_domain, bit);
> +			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}


Regards,
Markus

