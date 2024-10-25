Return-Path: <linux-kernel+bounces-382170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919AA9B0A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1991C22497
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099D2036E4;
	Fri, 25 Oct 2024 16:53:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863391F7550
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875234; cv=none; b=qBknWViw6Azb9HuECanDMa3vDGt1m8NF2QUgCztd51m8WdUQCU7QC/ieRe7rOI9unkHU4sDNyTtGS76ptfqX8Z0NE/tTXW66QRKkHhspc3cXTLz83jEtdzk1mtPZMWGeUf8Kt5NZdm6CkraudEvFTvsv40mYak+zqdSa/UI11S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875234; c=relaxed/simple;
	bh=jNOciln3xYaeR6t9WCOvNKzn8Se7QV7BsB4uv2Zd5zA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYagVhW4eR6ISjC8JvP97MUWNGxbUPkjZTBNopujYAiNqjMTADAv/gD7IeASX6DdJrZrASpOs0KKta3LuAF1n5axzXQOE97na3vjo3MjdgABWoeQ3kxAtDIagkySixAZMHQHk2h4kH/PRZkYe3UNe6pnSQ2973SK4p0ypppbBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t4NZK-0002kW-LZ; Fri, 25 Oct 2024 18:53:46 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t4NZK-000Olo-0o;
	Fri, 25 Oct 2024 18:53:46 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t4NZK-000Ew6-0Z;
	Fri, 25 Oct 2024 18:53:46 +0200
Message-ID: <57793bb01e02f03e215dfa6f8783df18034ae2ea.camel@pengutronix.de>
Subject: Re: [PATCH v2] misc: Silence warning when building the LAN966x
 device tree overlay
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Herve Codina
	 <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 25 Oct 2024 18:53:46 +0200
In-Reply-To: <20241025161739.3643796-1-p.zabel@pengutronix.de>
References: <20241025161739.3643796-1-p.zabel@pengutronix.de>
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

On Fr, 2024-10-25 at 18:17 +0200, Philipp Zabel wrote:
> Silence the following warning when building the LAN966x device tree overl=
ay:
>=20
> drivers/misc/lan966x_pci.dtso:34.23-40.7: Warning (interrupts_property): =
/fragment@0/__overlay__/pci-ep-bus@0/oic@e00c0120: Missing interrupt-parent
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/all/20241025110919.64b1cffb@canb.auug.org.a=
u/
> Fixes: 185686beb464 ("misc: Add support for LAN966x PCI device")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> The referenced commit is in the reset tree.
> Changes in v2:
> - Do not handle W=3D1 warnings.
> - Link to v1: https://lore.kernel.org/all/20241025145353.1620806-1-p.zabe=
l@pengutronix.de/
> ---
>  drivers/misc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 885b22989580..196fb730817e 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+=3D nsm.o
>  obj-$(CONFIG_MARVELL_CN10K_DPI)	+=3D mrvl_cn10k_dpi.o
>  lan966x-pci-objs		:=3D lan966x_pci.o
> +DTC_FLAGS_lan966x_pci		:=3D -Wno-interrupts_property
>  lan966x-pci-objs		+=3D lan966x_pci.dtbo.o
>  obj-$(CONFIG_MCHP_LAN966X_PCI)	+=3D lan966x-pci.o
>  obj-y				+=3D keba/

Applied to reset/next to silence the warning until lan966x_pci.dtso is
fixed:

[1/1] misc: Silence warning when building the LAN966x device tree overlay
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D68152eff5240

regards
Philipp

