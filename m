Return-Path: <linux-kernel+bounces-323192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661097392F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FDE288A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4E193071;
	Tue, 10 Sep 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gQFhDQHZ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AED192D60;
	Tue, 10 Sep 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976672; cv=none; b=Up7wQALEzcN4/rb91GThktwk3Y3nyqxMYxns31CiooZqAGXNK2u3KiBVhw/e5F5wBOog70zx3CzFHNGFeQDmbqctb8wbCgZqfWfMKbpMQU0WZCdtlfqsSVvoozwcOpgjVnpaaRVl5wAehZGJIPGVe6mQvotUAa54iowJTUv7BR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976672; c=relaxed/simple;
	bh=zZfcjLht3SGpqV3G2JGMBDdZB66dQC2a1hDt+03nhmg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=o+HxFCF05s5/Orm3AIMMg8YioDZaCPu+ee2joxEFJrA4Bfd2F6W8umPLSbGAC0NBQbHKPTG8q/oki+lXWyh82/td1ietR1nfL5eGm6y8n2SpO+qdTQt1qR08HzQJLok0jLbsjOFgkjvcEHiItVz8DHKgHXEduF/c6tOPfrqgVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gQFhDQHZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64B7A1C0002;
	Tue, 10 Sep 2024 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725976661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5qKRpXx/yX0uSjdpqTnr+3shh0+e1DrLOHMnv76MDo=;
	b=gQFhDQHZXhP2exQYhIS1YAURc1OirprONZJMYY64MBwxflZ6URRSq1uOlymHPWgauSd778
	PbJhbKbjfLdvxTZh5HLxTpf73lK/p5NLb8Cz8PuvF4qekNIEt8z64EmHvXnJ6RhF4aT10x
	KSzbElzWG+QIqFXgXegY1c8xHumzrShzzllQrDnvgH3/+5Z5ZruzmbPrQdz3MRGclyWVuZ
	kE9RyApX2I4zVX9YRGluH+XhS2rYXlw8E9BfoEC07OBdRx9kHURtZKJEjliA6r6b0+WYed
	UkicjFEWmCqsxNKv93rR9kZtCXMUNdVP7Y255EtzRHuSMK7nG9+ABDttIXSMmQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 15:57:40 +0200
Message-Id: <D42NNVGT7JLU.2CFGBTBNAP0E7@bootlin.com>
Cc: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 "Kevin Hilman" <khilman@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Roger Quadros" <rogerq@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Peter Chen" <peter.chen@kernel.org>, "Pawel Laszczak"
 <pawell@cadence.com>, "Mathias Nyman" <mathias.nyman@intel.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 07/12] usb: cdns3-ti: add J7200 support with
 reset-on-resume behavior
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-7-8664bfb032ac@bootlin.com>
 <0a634553-023c-4a46-8743-28357021c689@kernel.org>
In-Reply-To: <0a634553-023c-4a46-8743-28357021c689@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Mon Aug 5, 2024 at 3:54 PM CEST, Roger Quadros wrote:
> On 26/07/2024 21:17, Th=C3=A9o Lebrun wrote:
> > Add ti,j7200-usb compatible. Match data indicates the controller resets
> > on resume which tells that to the cdns3 core. This in turn silences a
> > xHCI warning visible in cases of unexpected resets.
> >=20
> > We also inherit the errata quirk CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE fro=
m
> > the default `cdns_ti_auxdata` configuration.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index 159814dfc856..65b8b6f4c654 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -258,7 +258,21 @@ static const struct of_dev_auxdata cdns_ti_auxdata=
[] =3D {
> >  	{},
> >  };
> > =20
> > +static struct cdns3_platform_data cdns_ti_j7200_pdata =3D {
> > +	.quirks =3D CDNS3_RESET_ON_RESUME |
>
> But you mentioned that the behavior can be different based on which
> idle state the system went into.
> Setting this flag will means Reset is required on every resume.

No, this flag's only behavior is to enable XHCI_RESET_ON_RESUME in the
lower xHCI stack. Code is in __cdns_host_init():

	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_RESET_ON_RESUME))
		cdns->xhci_plat_data->quirks |=3D XHCI_RESET_ON_RESUME;

> Instead, you just need to rely on the runtime check and set the xhci->los=
t_power flag at resume.

I argued about my view of the XHCI_RESET_ON_RESUME quirk under
[PATCH v5 09/12].
https://lore.kernel.org/lkml/D42NIH63EHZG.KKWZR2WZB68L@bootlin.com/

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


