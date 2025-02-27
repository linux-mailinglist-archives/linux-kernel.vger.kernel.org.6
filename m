Return-Path: <linux-kernel+bounces-535995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C474BA47A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAE7A82B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1F22A1CD;
	Thu, 27 Feb 2025 10:25:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA908229B0D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651926; cv=none; b=t+XdxnQ6oAoTcoQHZRGruQ1OMaWb1LvAMLkbIr6WKlLOtE1fDPQdIU7tWla+/PoBq/ZJUfKzB2F9yR9zQ3y/8licc/1grVIi6p/GzUZBsiqSajtskVa+u5M/dEMcxiCc9YQPI5iu4tYCbP3zSPaIq9m+UmWLGlPt2hWKsg9YDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651926; c=relaxed/simple;
	bh=BkDluYegP9fz6ZGoo2X9sZIE1EvxSRLVt+l7d1VddSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m488GQmHnc519EQQ0GoN2Y06Mj5rNjb5TL48wmpQxOYBPb8g060rJ8fzRX3NPFEXMmbxYQI2h2U6jeXUwUBoKRvb/8LF3EknlETZAUz7aQoyz7MrmcGSjdV8mPgZLDEeJRATauew/yM5Iz6wnsExiiKxHDqTG14QGVZ6ZBbzfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnb4q-0004Ph-2F; Thu, 27 Feb 2025 11:25:12 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnb4p-0036me-2a;
	Thu, 27 Feb 2025 11:25:11 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnb4p-000526-2K;
	Thu, 27 Feb 2025 11:25:11 +0100
Message-ID: <e243ca952b3aaf7e1331dee4da14ac06d878cf61.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: mchp: sparx5: Fix for lan966x
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Herve Codina <herve.codina@bootlin.com>, Horatiu Vultur
	 <horatiu.vultur@microchip.com>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2025 11:25:11 +0100
In-Reply-To: <20250226182449.61a126ea@bootlin.com>
References: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
	 <5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>
	 <20250226182449.61a126ea@bootlin.com>
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

On Mi, 2025-02-26 at 18:24 +0100, Herve Codina wrote:
> Hi Philipp, Horatiu,
>=20
> On Wed, 26 Feb 2025 17:32:22 +0100
> Philipp Zabel <p.zabel@pengutronix.de> wrote:
>=20
> ...
>=20
> > > Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally i=
n case of LAN966x")
> > > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> > > Tested-by: Herve Codina <herve.codina@bootlin.com> =20
> >=20
> > Is this still correct?
>=20
> Yes, it is correct.
>=20
> Reviewed this v3, saw Philipp's comments and I have nothing more to add.
>=20
> Also tested this v3 and no regression were detected.

Excellent, thank you.

regards
Philipp

