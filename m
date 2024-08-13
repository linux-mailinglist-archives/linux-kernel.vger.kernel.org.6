Return-Path: <linux-kernel+bounces-284866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6D950628
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF321C21298
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292C19B3C4;
	Tue, 13 Aug 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="M4ApcpKO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J9mBgv2D"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAB19B3D8;
	Tue, 13 Aug 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554844; cv=none; b=MynMzEomMt8yUB8Dz6dLOGOhVIoijJMRj3r2Nq7b11dR9UzfKtfjVXeGutSAsEjc4NOlHb0bAHdJlqyVIbIsepfLldy+igV9tX/ERu5oDim9Y4o4H8uHNpqGakoCbsjlSOlgkvGAbmHETP2q2q7X/o9PmMocEg2Q+4jaaUDo7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554844; c=relaxed/simple;
	bh=/oXN3/0Kb0PwdTxOFOWP51D2uTIisIYMWG9izl4RM4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDuTrD93/Ki4D5BxjZWJKynKpDwR6OPbAm8vGuDAh9cGdeB3KnAlulrSFk2JRRF+Lsefr3N1UgH+PaCwT/HqzgXVQA/nBxy4uPr6CmtCj0JfmTkccxsN63jyFjUhYeg/9p5yaG/UX7IyR+6JQ6ertyt0kpKajVmGnZXONuTHZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=M4ApcpKO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J9mBgv2D reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723554841; x=1755090841;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yf77RZmJBkdO5ATfOLcBYjHWMlR9pScAsVtBBg/4+eY=;
  b=M4ApcpKOVrkDGfF4tkCILpxZcDYRy774TwCGDsQ+igfOT3JZe4aWqBic
   3SYQc9TEbHFshNXcs8Iiq/twwmq+l2NH3Tqo21pEzRL4eiu+Ux5pHemp1
   dPZHWIWmciuCr95X+366vpdFMjfgCSO/JNAP9P+Or+OK0N3c08Epnq7on
   7qSzitUKyNt+pWJYtDFWJvjwOJjULdkq8PUvyO2iq/ZTFR/uOVYU1azAz
   NtjwMY1RsoIMEH7YcDt9dy22UsPrjxgGiSwboxL+mZv0syqHaPAD4btFw
   HC831wXn/21hNAsziUsF8KKx01s0Gvn6rvi7wZubfATzK88DsayG/fszw
   w==;
X-CSE-ConnectionGUID: SxBRmycOQEmEVCFOwZ+QeA==
X-CSE-MsgGUID: o4MPJmH7RWuqqdLfwzOTqw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38386887"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 15:13:59 +0200
X-CheckPoint: {66BB5C17-14-751552D8-F91D2344}
X-MAIL-CPID: 60DCDD33188D7A76BC97FB9DA423ABDC_4
X-Control-Analysis: str=0001.0A782F20.66BB5C17.00B5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 184601627D0;
	Tue, 13 Aug 2024 15:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723554834;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yf77RZmJBkdO5ATfOLcBYjHWMlR9pScAsVtBBg/4+eY=;
	b=J9mBgv2DckWa665XI+yzUXQYMrTNE0YSwjUCU7Y92gkduPxSPVzTvO+Cuy/Q8k3QjDS2nH
	3OSU8TbEng0Ysig1QCuqQxcCGdJ2zD/W/taTb8EErRTfUCWcHuayrl9DkNJNrM+IwD/eVX
	orhNidgQf36FhSmFVEsQSsOZU6HtV3NBX8XUVni47xbCsENNasmzAryFL8QXU/4nwDnSm6
	UhTD9vCe0RKpJlRy9JwpMmzMtLvuskP+CYR9SYTLiaHQmppeuS/yqTUFVHz4xx460hvSq+
	qtIU8AIftGvyhUvA7m/pqEk7U8+q+wlR2Z4ng5mBlZ1Zug4YMLdJjF7f5wbK2w==
Message-ID: <45cf3d23034dcc8968d1b0fd34e624799d2fb42e.camel@ew.tq-group.com>
Subject: Re: [PATCH 5/5] ARM: dts: imx6qdl: Rename USB hub node name
From: "Niebel, Markus" <Markus.Niebel@ew.tq-group.com>
Reply-To: Markus.Niebel@ew.tq-group.com
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	 <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Krzysztof
	Kozlowski <krzk@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Date: Tue, 13 Aug 2024 15:13:53 +0200
In-Reply-To: <2621134.Lt9SDvczpP@steina-w>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
	 <1901821.CQOukoFCf9@steina-w>
	 <82ee2be2-366e-40b2-ac95-e755443032be@kernel.org>
	 <2621134.Lt9SDvczpP@steina-w>
Organization: TQ-Systems GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2024-08-13 at 13:02 +0200, Alexander Stein wrote:
> Am Dienstag, 13. August 2024, 11:44:28 CEST schrieb Krzysztof Kozlowski:
> > On 13/08/2024 11:27, Alexander Stein wrote:
> > > Am Dienstag, 13. August 2024, 11:20:08 CEST schrieb Krzysztof Kozlows=
ki:
> > > > On 12/08/2024 16:34, Markus Niebel wrote:
> > > > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > >=20
> > > > > According to microchip,usb2514.yaml the node name shall be usb-hu=
b.
> > > >=20
> > > > That's not true. The schema does not say anything like this. Old na=
me is
> > > > correct. NAK.
> > >=20
> > > So, is the schema incorrect? There is the dtbs_check warning:
> > > arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dtb: hub@1: $nodename:0: 'hub@1=
' does not match '^usb(@.*)?'
> > >         from schema $id: http://devicetree.org/schemas/usb/microchip,=
usb2514.yaml#
> >=20
> > If you have a warning, shorten it and paste it so this will be obvious.
> > If you look at several bindings, the hub is widely used name. I think
> > the schema is not correct here - I do not see any properties from
> > usb.yaml being used here (for usb2514). What's more, if you compare
> > usb2514 with any other on-board HUB representations (because that's the
> > only point why we have it in bindings, right?), none of them reference
> > usb(-hcd)?.yaml.
> >=20
> > These are not USB controllers, IMO.
>=20
> I raised that concern in [1] already, but nobody commented.
>=20

Besides that, current version of device tree specification [1], section
'2.2.2 Generic Names Recommendation' exlicitely suggests 'usb-hub' but
not 'hub'

See
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.=
4

> Best regards,
> Alexander
>=20
> [1] https://lore.kernel.org/all/3633627.mvXUDI8C0e@steina-w/

Best regards,
Markus

--=C2=A0
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/

