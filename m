Return-Path: <linux-kernel+bounces-361415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E499A7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700DC282A36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BB195B18;
	Fri, 11 Oct 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VkXuS6e4"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8E129E9C;
	Fri, 11 Oct 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660910; cv=none; b=cLxgz/EpTIyPY1b4ABqsUqWBTwKvC+1MV/7ivYDA1Gh6sOlpkv/40pcNGos8/dVUUPHc+YOklcvcLC2V48PVmhDaVKyMrody36DpM3pgi9/YHCG8wtn6WKHwjdU0/QpVFHVUjr/ppyxYIm4tvywvQbco2MG+M5gnAn+bZjKdVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660910; c=relaxed/simple;
	bh=5q2pxOJGhjxRkV6Sh/y1SW2FUUkTvUWxmQfriDkZaYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwwU5xub2PFdteDnEopjgXbtlraXol/iHfZzpSztvmSsokX5HHKNBc6eTe1YENCXFArPsVfeXejn0r3uj4HKZfAQsUlA6SeTfMxWVKWsgWa8HT6KRyKWXf+AFcg1BfbZmzBbU1DQCkNvSU+rgoH0EJBJyEcBTS9xwy90YxfrHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VkXuS6e4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728660863; x=1729265663; i=markus.elfring@web.de;
	bh=JEMAcjbF3FPvsYIlnj1lZs9kGTRyH0qqeK3Whe3Jzxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VkXuS6e4vEcm7FBmcLsmecktpuZBhodcmhtcG1MjoaQlMBpWGSZWppe66/lzmU+P
	 6Mj+mOW7QVD5gA/1zDDbo/QS49wuWb1RZz49iYkQiJiq5VC5Jak9yDI7IPvyZuwtk
	 YoVeho66f1YQ5bikxqChGGrqvqwO9V43m7m6UbRL1VeyuOKeJraNwna4xuY+uEDRh
	 dkCeC5Nn6e/bJ+gq208jUqAwWd8gKp7fZm2oggn8kJXR0HiKeBCPvK1pAjKAsZ/b3
	 fHxHr/RvPGMa1718rQnRFmkKWQI5Y34RP7cLE1ARuYXmWU7cvYxEVAhdlOXHOwwvL
	 Ngbs1I+SME2uAnHaAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1tA4DG3Kzx-00F9Oq; Fri, 11
 Oct 2024 17:34:23 +0200
Message-ID: <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
Date: Fri, 11 Oct 2024 17:34:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
To: Kevin Chen <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, BMC-SW <BMC-SW@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i9rIChLNyWYHyUTxDAbalAUCtiWIR3TehRTXM4XO7QD22dAeIcU
 2Je5blRBlhhl0Zu8Fe4xt31/nZvF0LqZnWssAuOLPnytex7FWgro8OETzQRTGPAkWKFWErq
 PduH+/NIVn9OhZGSWl2zSSFzMW5gROLqxdQVoDFwdulPU9K6gtHPo14dUC3u1+rChTDKJtL
 DUB9dP0zI/qwHYP6d/BnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qREi+IcNmIk=;6u/CF+JhpeuSNi2B8eBr9G1Gnsx
 CvZzyNmfatpqrkh36kagQPFRZ8MJvhp3MxDk1VnrpA3lJsSYOjvVkwfNvvs/La6WoBezcNFE2
 awRiKpI1MJOmtzOlnUMz/SwJ4TInqHpj7he0Aczhkx/o2mHpyzk1vDib1gXpSyJlJt7c15M/u
 Q1arjIfzyRzFUB50BywjGO+sSy4VOVImWPVYYBKtT6rhDUuh5AonDVqrABkeLICYpJrMIX8ay
 tSlx9Wmc++Vv499RKLX2++QWnRuhEEDPqZ3CmzMwXgIyP+1SgTmB7U8H6eVptaOkxBS9b9INH
 llkyCmpV5u5igXtlpaWE+AYVWEQbghrShNO1KDcT4aGbZImSJPDUOP0vMwlMIk4SddF3QwpwN
 0Jg+V/VGv3tCBH2dZRzS5If2IdO/Io52ow2XxuP+atJ1otphVPnFoCSRYcxUUjrIIBE3hf4+N
 StoKVjbQNTTvYtc40XP4yGwK5opBqM5skP3HRs4Z/3dzBBMrxdKiHb/Jw+TWjSsJNXrxP9fmC
 AyOtI3obcyOyiTyEG6jCpZd5srzeDbMKCJzN5T+wDJ3Xg5G3Gr8t+9Cm5nxcyYSYMFV7LQvMW
 YGNNjng/vKrwI6gDZDZBGsnPLhrd3djXTOVA/Qr6vzmcE17UUhCTEfxPRuvHSbkGsXtc3CVwb
 MZWc7oDxYyI6olMudjvl+weL3q0qUxj17d2w59buC3MAq1YUSYkLeanmA8ZiH25QluLCcPw/a
 zud8Zi5+ecyXltL/rADHaWGpKXxfB45pAND3MBEZsfraK8YM1Y0DlEXzfGEvvGXarxMLURVcn
 eH3D6/Kh11MU8Z98HRyb43kw==

>> =E2=80=A6
>>> +++ b/drivers/irqchip/irq-aspeed-intc.c
>>> @@ -0,0 +1,139 @@
>> =E2=80=A6
>>> +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
>> +{
>>> +	struct aspeed_intc_ic *intc_ic =3D irq_desc_get_handler_data(desc);
>>> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>>> +	unsigned long bit, status;
>>
>> I suggest to reduce the scopes for three local variables.
> May I check the scopes of bit and status usage?
> Variables of bit and status are used in for_each_set_bit.
> How could I reduce the scopes?

I propose to move selected variable definitions into corresponding compoun=
d statements
(by using extra curly brackets).
https://refactoring.com/catalog/reduceScopeOfVariable.html


>> Would you become interested to collaborate with another scoped guard fo=
r
>> this programming interface?
>> https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip=
/chained
>> _irq.h#L13
>
> Maybe like the change in the following?
>
> diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-asp=
eed-intc.c
> index ef1c095ad09e..54d1881c56c6 100644
> --- a/drivers/irqchip/irq-aspeed-intc.c
> +++ b/drivers/irqchip/irq-aspeed-intc.c
> @@ -32,7 +32,7 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc=
 *desc)
>         struct irq_chip *chip =3D irq_desc_get_chip(desc);
>         unsigned long bit, status;
>
> -       chained_irq_enter(chip, desc);
> +       guard(chained_irq)(desc);
>
>         scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
>                 status =3D readl(intc_ic->base + INTC_INT_STATUS_REG);

Perhaps.


> @@ -41,8 +41,6 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc=
 *desc)
>                         writel(BIT(bit), intc_ic->base + INTC_INT_STATUS=
_REG);
>                 }
>         }
> -
> -       chained_irq_exit(chip, desc);
>  }
=E2=80=A6

Probably, yes.


=E2=80=A6
> +++ b/include/linux/irqchip/chained_irq.h
> @@ -38,4 +38,5 @@ static inline void chained_irq_exit(struct irq_chip *c=
hip,
>                 chip->irq_unmask(&desc->irq_data);
>  }
>
> +DEFINE_GUARD (chained_irq, struct irq_desc * , chained_irq_exit ( _T ->=
irq_data.chip, _T ), chained_irq_enter (_T->irq_data.chip, _T))
=E2=80=A6

* Such a macro call looks promising.
  Would you like to omit any space characters before open parentheses?

* Would you like to support scoped guard variants accordingly?


Regards,
Markus

