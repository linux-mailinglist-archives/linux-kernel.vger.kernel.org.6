Return-Path: <linux-kernel+bounces-186092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5678CBFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A06283B30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4E824AF;
	Wed, 22 May 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OBaF0sEk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YidkbUz3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7617B3E5;
	Wed, 22 May 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375611; cv=none; b=KVqhPLpCno7uFGVK3R7edR11DQXiQb8B3lvsJw6jWG5QGMAzgKFfVEIcHGYVVRbCKdBBliC2aSQRlvghHm76NwPTcUuEnEg3kqbaAT7INb1YncN2QtkQ0Y0D+/UMeg3aLuUhHPVnnTGk6NLjnWEm2Hz3rJClXXIqDnwYgu19CUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375611; c=relaxed/simple;
	bh=TqD4OytzgPEadIqGGVU3qm9CXN7Qx8GAU331ohgKHbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odbogxulRSrqeiNsfhKGo6tzbG4tahk2Ts9pMg2YvYfiG5mLSTX2ATusXPZEnH6Fe/NPPxZz4za1jEKOmjb7UyYzN9wrM7rIQQXuVhHRDjBcegjA8fRxn0lOT/zLKp+9HYN2/yUtsTBAcHlhdOt8n/h4FV15gxLkZ0sWmoZ+N1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OBaF0sEk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YidkbUz3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716375607; x=1747911607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bs8t0R9bLzRft+rJOe3kI6rRBc2Mcl6G2jRlHgmUXRM=;
  b=OBaF0sEkktEgUeTwJRPH/yH+fmolOrL9g2GiwxdwzLQdKnaNTmArkgin
   ucfpqiF7Dp4yR5CYtm3lUfOhcEez+WOYdZ/K/wCqRcPBG0zdYCAkjV3zb
   IctPkywe8WmWMsG3aVrJp5BgdclXoOyvP5e2tHAC1Q5GDi2bF+8X3dfNc
   Tgi0dS+TGidY5tUKz97DfWCrSN0Eidtk7MhTOqDR6aIotMOkXqSzq8Y5v
   FpKqZ9LEFPCfp8iEd7vQJJCoUj9u08rIm/jddDdrF0gYJubgpznKq2UrA
   Dx9yLjfmCKUuCz2i3nilETiJRarB/qp3aizG4hdbo0OTxgBAPVMNbZ5ch
   Q==;
X-CSE-ConnectionGUID: 3J4gVbk6T2u3qIrKMJQgEw==
X-CSE-MsgGUID: I6l1ZvO9Q3S93d07qZTrRA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37012904"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 13:00:05 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DD9C160DAA;
	Wed, 22 May 2024 13:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716375601;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bs8t0R9bLzRft+rJOe3kI6rRBc2Mcl6G2jRlHgmUXRM=;
	b=YidkbUz3bNcBvAADcMmS9j9G2gTyetHnGore/MdBWjT0mSro8xHuuQYMVlg48vn11r9bii
	Sq5cjFxPhhGt+CSZqtQgLxtfepuz5HL8Xo3DkM2sdtyLwMwF513/KGRCJKC+kpPR7GeBZK
	eblSPPLGYV5otOL1/eSQexrVgt2HjD9MovLYBufFCholfq0V9w+wkkg8UMIl/q3q/4DJGA
	FGNigY7Mo/d+FvbwSEupT/3O4GLa1tnknzEPSY0r/YW5Cfzc23aLDlIRMDEqjy6I7AzmH6
	byJ+mRJB4Ls6lEKcFb/lF92xeHz+EuBayOR5NcZQEvePIsBlJtjXqTMCNY6kCQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, Lee Jones <lee@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file patterns in TQ SYSTEMS BOARD & DRIVER SUPPORT
Date: Wed, 22 May 2024 13:00:08 +0200
Message-ID: <2741024.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <7803640.lOV4Wx5bFT@steina-w>
References: <20231123113245.23542-1-lukas.bulwahn@gmail.com> <7803640.lOV4Wx5bFT@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Donnerstag, 29. Februar 2024, 15:50:04 CEST schrieb Alexander Stein:
> Hello,
>=20
> Am Donnerstag, 23. November 2023, 12:32:45 CET schrieb Lukas Bulwahn:
> > Commit 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees
> > and drivers") adds some file patterns for files in arch/arm/boot/dts/, =
but
> > those patterns do not match any files in the repository. Hence,
> > ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about brok=
en
> > references. The files of interest are actually in the directory
> > arch/arm/boot/dts/nxp/imx/.
> >=20
> > Adjust the file patterns to match the intended files.
> >=20
> > Fixes: 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device tree=
s and drivers")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> any feedback? Can this be merged?

Another gentle ping. Just noticed as [1] was not sent to our list.

Best regards,
Alexander

[1] https://lore.kernel.org/all/20240520060222.2980-1-zajec5@gmail.com/

> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index df7a57ac864e..1e439b08d5d4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22084,9 +22084,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
> >  L:	linux@ew.tq-group.com
> >  S:	Supported
> >  W:	https://www.tq-group.com/en/products/tq-embedded/
> > -F:	arch/arm/boot/dts/imx*mba*.dts*
> > -F:	arch/arm/boot/dts/imx*tqma*.dts*
> > -F:	arch/arm/boot/dts/mba*.dtsi
> > +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> > +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> > +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
> >  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
> >  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> >  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> >=20
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



