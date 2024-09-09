Return-Path: <linux-kernel+bounces-321574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEFA971C28
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826AE1F22FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34131B3F23;
	Mon,  9 Sep 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AGKcNBv5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gU3UY3c8"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA59178CDE;
	Mon,  9 Sep 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891092; cv=none; b=VgOCdr1/Pdn52j0wGQWNWebNLfI55GoW5Dpv/f0ACnUsicW54Ah/nCDZdpzC6F9JIfU0pZVtCa2AK3FGMHieEj55kXCyhTeBP2jBzMs59WvAhvGljtKPlSNeCgcUd9ecEqxrP/dnJEni27WgNgNinTrHuomsGakkB8AATmkMBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891092; c=relaxed/simple;
	bh=SGvdbxphfmspCsY8b2qTpepEdJjJLbN0XnZ1znF8qbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcprsoPkkOxJMdto9eoE+1FlZxXcFZUUlWL+J0hRhJllOqHspvSua2l8TsXMs+3SjTEwo2ZP3lxrEwjsTArmsJOuI1qc2iDB9q1uBQZiDGVaWRpSpAHWGv6hGwpY5Wn+XN/9MRZIs7u4JXVl7SEnQ8y5zjpmO30VtzQqOWoBqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AGKcNBv5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gU3UY3c8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725891089; x=1757427089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+j8lFlBsaShntDOrjXrB7TyHBj/n+3DZD/tr32Okp7U=;
  b=AGKcNBv5enSXQsTQeLr0O311uF3FTISfsKbWFePy5UzAJqDgFKoF2kwb
   hW/Z/EXb9/WOuLnGN0fFQ3vcFwxjDD5Oi0YGKHZdA+Il3K3vIjSErmRkL
   7+VK8icderA0Y2ui84+mHbS5y6hQXH7ykrl3oZPOBoHzgWIksR/eaXT+a
   iEF0ygBjPACk5v3k5Lwi03yHXM3TuuaiMAErUeEng7zv0sSU2LKFEMdXK
   FfzAaQjjoHCewPMa7sKqwGbsKWDq7I1zCm7t3EuLoCWodjAQTB8BCn/cY
   3WNENtFmlnf6drIu8YEJLwozzx0CXqx/MdbSPM1tPPntTz7fCztmSUTLE
   Q==;
X-CSE-ConnectionGUID: BtBnGZZPSTuxoFlUYT7eyw==
X-CSE-MsgGUID: 0U/4v52iRB6ESHNAmYGWBw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719871200"; 
   d="scan'208";a="38842554"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Sep 2024 16:11:20 +0200
X-CheckPoint: {66DF0208-1B-C661815F-E221238E}
X-MAIL-CPID: 4EDA6A5EC0D98CBAA8C4679C54659C20_1
X-Control-Analysis: str=0001.0A782F19.66DF0208.0146,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAF8316B1F7;
	Mon,  9 Sep 2024 16:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725891076;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+j8lFlBsaShntDOrjXrB7TyHBj/n+3DZD/tr32Okp7U=;
	b=gU3UY3c8fc3pjvMMkD+CA5fwJ8eblBb2Dk8INfDUgI4H5o7mCgP5kx0LsW/Iut0D59/R0e
	+fc2kFwgWudLNqMWTzC+43T8ANYWbl2CkW3DWmUjFLpfcJ2rpYRZFl1Jjsy+vdeoxxaqmk
	egSO6fC88/l1bkRpw8ObfleTppkWUg45w9/s7GJD21zeRQ+3Sk6IM9U6sWeSCkekliJQDm
	/c3dK+r+aQs68pZm+ToYfhwMWT6lSIVxOl9cQ8fOvi8UYCAJOYPAIYIHkey0rnTCajnLcv
	nC1Zr3t+7FOqpGwrFM+fZPrjMvm3/y/jNzSW7aFgcS3TkX+ThcEffQMo0cvLKw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA memory
Date: Mon, 09 Sep 2024 16:11:14 +0200
Message-ID: <2751338.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <10526262.nUPlyArG6x@steina-w>
References: <20240827142458.265558-1-alexander.stein@ew.tq-group.com> <10526262.nUPlyArG6x@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 28. August 2024, 09:49:36 CEST schrieb Alexander Stein:
> Am Dienstag, 27. August 2024, 16:24:58 CEST schrieb Alexander Stein:
> > Default CMA size is too small for HDMI output and VPU usage. Increase t=
he
> > default size by providing a CMA memory area.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Smallest RAM variant has 512MiB.
> >=20
> >  arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boo=
t/dts/nxp/imx/imx6qdl-mba6.dtsi
> > index d03f7065ddfd7..8ba3ec27bee07 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
> > @@ -106,6 +106,20 @@ reg_vcc3v3_audio: regulator-vcc3v3-audio {
> >  		vin-supply =3D <&reg_mba6_3p3v>;
> >  	};
> > =20
> > +	reserved-memory {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges;
> > +
> > +		linux,cma {
> > +			compatible =3D "shared-dma-pool";
> > +			reusable;
> > +			size =3D <0x14000000>;
> > +			alloc-ranges =3D <0x10000000 0x20000000>;
> > +			linux,cma-default;
> > +		};
> > +	};
> > +
>=20
> Please do not merge yet.
> I just noticed that this breaks mmap'ed fbdev usage. It only works when C=
MA
> area is in HighMem.

Okay, now that commit 5a498d4d06d6d ("drm/fbdev-dma: Only install deferred
I/O if necessary") has been applied, the mentioned problem is gone.
This patch can be applied if there are no concerns.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



