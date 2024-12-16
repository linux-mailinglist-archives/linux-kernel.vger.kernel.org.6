Return-Path: <linux-kernel+bounces-447437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 374FE9F324D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64571885BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2A205E16;
	Mon, 16 Dec 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JXyJASOx"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E619450F2;
	Mon, 16 Dec 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358146; cv=none; b=SvQMU1kX74yOWUIMgFyf7tIZJ2Osfa3VKwkrLUiWiLoPzKJxlIrk/OCDHn/wSohy2H1KIYTj+sn2s7Bxng/rF6PYjKm2D2Hu+eRMeVp/F2a3k9GU8/r4Dkj6aLWZzMhDflAB/EVBlhm91pbeo/AfonB45EiK/NTt0DKjM9TsuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358146; c=relaxed/simple;
	bh=paLbp9RfBbKkCSoXP3vDG8K4zoqyW2jvOQTbgUcQ4YA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=pw3WIW1qBwGWl2NZpYJt0Efx8Np7RKdO6WEF+MJZB54+RlG4EUxFAXEHh6Hdb2axkDfpwqtMWw/mTKkCuc87oJB5Fn3wM2+Ohf1KqBANxCfd8781w8F1on+5kCUN81j+j2jTFp94IUIeyO6TVZf7fQg50OPgCb06lT3GF8TShXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JXyJASOx; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3103B240006;
	Mon, 16 Dec 2024 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734358141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S333XljZz3m69lQgQE3vRV7nPUXa4XWgNintvZWfBmM=;
	b=JXyJASOxOBa6VISM4fv/8IEJSPiGQzRJWw4G8SzTfKuyzBDTmLv5wn6jiXgS3hHc7GjLBT
	kPw6XLPmm/0/WB/o02TRdB36N2pfoWQq/xRUuaQ2eVX6aAKVYk6DykXPXay/lxbmhvYb7Z
	Tv5uw4zKdZasalFL5/a13xsZFs1+UofXEoaiaf/JSZG5zylH/XV2ePGWVuFegW+L9/7NqY
	+JIPB6o7ExwXM+X2jw56RMIZF3r9NhycT8XCDae9mMEEBasbNle6G38aWhh++Dmcf3guvV
	P6gArbBQsZFUYob09rrYdOuhiR3thW89CUqIViN4PiDpRE9VmV881i9quyt6Dg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Dec 2024 15:09:00 +0100
Message-Id: <D6D6NEMYVOBV.3OVBJ77E11A2@bootlin.com>
Cc: "Pawel Laszczak" <pawell@cadence.com>, "Roger Quadros"
 <rogerq@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Mathias Nyman" <mathias.nyman@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Peter Chen" <peter.chen@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 0/5] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241214090604.GC4102926@nchen-desktop>
In-Reply-To: <20241214090604.GC4102926@nchen-desktop>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Peter,

On Sat Dec 14, 2024 at 10:06 AM CET, Peter Chen wrote:
> On 24-12-10 18:13:34, Th=C3=A9o Lebrun wrote:
> > Currently, system-wide suspend is broken on J7200 because of a
> > controller reset. The TI wrapper does not get re-initialised at resume
> > and the first register access from cdns core fails.
> >=20
> > We address that in two ways:
> >=20
> >  - In the cdns3-ti wrapper, if a reset has occured at resume,
> >    we reconfigure the hardware.
> >=20
> >  - We add a xhci->lost_power flag. Identical to the XHCI_RESET_ON_RESUM=
E
> >    quirk, expect that it can be set at runtime.
> >=20
> >    At resume, to summarise, we do:
> >       xhci->lost_power =3D cdns_power_is_lost(cdns);
>
> Is it possible you go to change xhci quirks runtime?

I always assumed quirks were read-only once probe was finished.
If I was wrong then we can remove xhci->lost_power and edit
xhci->quirks instead.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


