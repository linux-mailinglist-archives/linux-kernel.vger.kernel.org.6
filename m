Return-Path: <linux-kernel+bounces-323199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660097394E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6311C23BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DB19597F;
	Tue, 10 Sep 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DRd8C1mA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6128389;
	Tue, 10 Sep 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977062; cv=none; b=ad5TSQYmPKH8WcYPY20eE8Jc0Frxve97wmvHG/plwnyYuhJsRRhi7nyHdZSXb8xCsrGRKWem3SyS9k025KjA15rJlns4jrFFhutRkev9Yz0Hsq4/IXqYHPNeUKhcBII2q0n6gMpbPc2fsJF+h4s1f1LLdtM9vYmzG0HpO2RsjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977062; c=relaxed/simple;
	bh=HO9jMzugqdGriCjZTDUoRxmWP1kjr0j4Rz0Nt3ecBGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ZdkbUsyEeHWqzjAjGeMWFeaaIMiNqm2Ju9d1LUG0CPGvl8HFnOHJ22dLjNeRI197P91/C+P+uopjyITUcocmjqVhgP3N+BVolyJQkz+sLzSHL/18m2ONPJEudu+53niLQ+UeUAPgmoAqkGIa/wXQVqPyyJkT0Ge1V4QHo9lqats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DRd8C1mA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03BD91C000D;
	Tue, 10 Sep 2024 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725977058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbvz3JQ6Dzafg8NgXNOuBniHfq+3yKtYClfjYxdImOM=;
	b=DRd8C1mAQDBaTQOrfuyjMKW5d7pmqbS8bcV6C60uk/1Q179nX5Ynppjikh9xA5ewgkHzo5
	E6Xjsco+6DLttCCCXyP00KjhoMMKwXmMPS3Q/Q7nv2ekxcZdGzpb62Zm6DNdwETyHJ2ckk
	+PNf14dUjc4mCWW4KOhKTr50mj11WNObCtKvMbaYTmWfhz2kWo+m+jbREPwklbnpr3B29U
	SB/uSJoYjYcJWa2/6B/EijKgto+Ci8glIkhFCorL4wLuKUUV1LCotxK0SA8+hTZN9XJK+E
	/OiFRpyvwph2mjVEEctN4XUq9uE5zGKotvLL+gNZBc1ubLbpb22QoKm3jSEw+Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 16:04:17 +0200
Message-Id: <D42NSY6SFTBG.2EEB1S4CB54QN@bootlin.com>
To: "Peter Chen" <peter.chen@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 00/12] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Roger Quadros" <rogerq@kernel.org>, "Pawel
 Laszczak" <pawell@cadence.com>, "Mathias Nyman" <mathias.nyman@intel.com>,
 "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>, <linux-usb@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Kevin Hilman"
 <khilman@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Conor Dooley" <conor.dooley@microchip.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240809011921.GA2673490@nchen-desktop>
In-Reply-To: <20240809011921.GA2673490@nchen-desktop>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Peter,

On Fri Aug 9, 2024 at 3:19 AM CEST, Peter Chen wrote:
> On 24-07-26 20:17:48, Th=C3=A9o Lebrun wrote:
> > Currently, system-wide suspend is broken on J7200 because of a
> > controller reset. The TI wrapper does not get re-initialised at resume
> > and the first register access from cdns core fails.
> >=20
> > We address that in a few ways:
> >  - In cdns3-ti, if a reset has occured at resume, we reconfigure the HW=
.
> >  - We pass the XHCI_RESET_ON_RESUME quirk, meaning the XHCI core expect=
s
> >    a resume.
> >  - We add a xhci->lost_power flag.
> >=20
> > The previous revision had one big issue: we had to know if
> > reset-on-resume was true, at probe-time. This is where the main
> > difference with previous revisions is. We now pass the information from
> > wrapper devices back up into XHCI. The xhci->lost_power flag gets its
> > default value from the XHCI_RESET_ON_RESUME quirk. It however allows
> > wrappers to signal *at resume* if they still expect a reset.
> >=20
> > That means wrappers that are unsure if they will reset should:
> >  - (1) set the quirk at probe and,
> >  - (2) potentially set xhci->lost_power to false at resume.
>
> Judge if controller is power lost has implemented at cdns_power_is_lost
> Please check if you could use that.

That function is being used! Its return value is passed as second
argument to the resume() callback in struct cdns_role_driver. We set
xhci->lost_power using that exact value.

My cover letter explanation was slightly off, as it is not wrappers that
set xhci->lost_power, but instead role drivers. Wrappers don't have any
reason to touch the xhci struct directly, they are one layer above.

Related: [PATCH v5 08/15] commit message looks like this:

------------------------------------------------------------------------

The cdns_role_driver->resume() callback takes a second boolean argument
named `hibernated` in its implementations. This is mistaken; the only
potential caller is:

int cdns_resume(struct cdns *cdns)
{
	/* ... */

	if (cdns->roles[cdns->role]->resume)
		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));

	return 0;
}

The argument can be true in cases outside of return from hibernation.
Reflect the true meaning by renaming both arguments to `lost_power`.

------------------------------------------------------------------------

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


