Return-Path: <linux-kernel+bounces-515467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8315A3652C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9374188E01E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E382686A1;
	Fri, 14 Feb 2025 18:03:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD78186E54
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556205; cv=none; b=oM2lBqGPyr69aatq3AY0bYgxq6t2Rr0UtP1Ul9xBEM9xY6upAJ3+gnMZNYEWTx0Xwq1zlnNu7vT+CRbIK20mowUGBn+w/GFTyHCXECmLGT01S1AAjsamNe2ekxmnEY+ldqMYtnXMFym83H8XV0ST23GzUld7vR+fHqC0ObFCf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556205; c=relaxed/simple;
	bh=k8MEGxuiLlmPuqpoYOTE5EbOg9Iz3g5ldM672B1/FXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrLzcrTyr6gMXm5h0ONucGFmb5yJLfnoGxoxA2gc4SkQxBIPNGN/ZadlaY7egq0l/0FRjnFUh/j9saj5XXyn3jFnVqUigxzDeVeWDThqV74rq/NctwqXLyiOoHd1O64oKEAbWFi4D3pIJmOT4WYyQBaQISoH6C83oSAGY3GU24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tj025-0000CI-3a; Fri, 14 Feb 2025 19:03:21 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tj021-000xHw-2A;
	Fri, 14 Feb 2025 19:03:17 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tj021-000BqJ-1u;
	Fri, 14 Feb 2025 19:03:17 +0100
Message-ID: <8a9518fdfda805f52b96e93649c9ee39274f5844.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device
 compatible
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wilson Ding <dingwei@marvell.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "gregory.clement@bootlin.com"
 <gregory.clement@bootlin.com>, "sebastian.hesselbarth@gmail.com"
 <sebastian.hesselbarth@gmail.com>, "robh@kernel.org" <robh@kernel.org>, 
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, Sanghoon Lee <salee@marvell.com>, Geethasowjanya
 Akula <gakula@marvell.com>
Date: Fri, 14 Feb 2025 19:03:17 +0100
In-Reply-To: <BY3PR18MB4673C5C5CA684C64B2C218AAA7FE2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
	 <20250214065833.530276-3-dingwei@marvell.com>
	 <6dd9ed2750abe1f5174805673411ccb919ee5461.camel@pengutronix.de>
	 <BY3PR18MB4673C5C5CA684C64B2C218AAA7FE2@BY3PR18MB4673.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2025-02-14 at 17:13 +0000, Wilson Ding wrote:
>=20
> > -----Original Message-----
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > Sent: Friday, February 14, 2025 3:54 AM
> > To: Wilson Ding <dingwei@marvell.com>; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: andrew@lunn.ch; gregory.clement@bootlin.com;
> > sebastian.hesselbarth@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Sanghoon Lee <salee@marvell.com>; Geethasowjanya
> > Akula <gakula@marvell.com>
> > Subject: [EXTERNAL] Re: [PATCH 1/4] [PATCH 1/4] reset: simple: Add sysc=
on
> > device compatible
> >=20
> > On Do, 2025-02-13 at 22:58 -0800, Wilson Ding wrote:
> > > Introduce the new ops for updating reset line and getting status.
> > > Thus, the reset controller can be accessed through either direct I/O
> > > or regmap interfaces.
> >=20
> > Please don't add a new layer of function pointer indirection, just add =
a new
> > struct reset_control_ops for the regmap variant.
> >=20
>=20
> If just adding a new struct reset_control_ops for the regmap variant, alm=
ost
> all the functions will be duplicated for regmap variant.=20
> Besides reset_simple_regmap_assert/deassert(), we also need to have the
> regmap version of reset_simple_update().

Yes. You could also duplicate/fold update() into assert/deassert().
It is trivial enough and the compiler will do that anyway.

> Since reset_simple_reset() invokes
> reset_simple_regmap_assert/deassert(), it also needs to be
> duplicated.

That one could go through the data->rcdev.ops->assert/deassert function
pointers and be reused. But I wonder if that one function is worth the
added complexity.

> In this case, there will be too many redundant codes in this file. I doub=
t if
> it is worth to use the reset simple code. Maybe it's better to fork a new=
 file
> for the syscon device, such as 'reset-simple-syscon.c'. What do you say?

That sounds sensible to me.

regards
Philipp

