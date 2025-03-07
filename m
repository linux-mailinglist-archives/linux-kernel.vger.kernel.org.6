Return-Path: <linux-kernel+bounces-550860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43BA5650C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F261703FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D8213254;
	Fri,  7 Mar 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NUxK/DRG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qoELbrT7"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA1211474;
	Fri,  7 Mar 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342772; cv=none; b=BAluM7AkdZVIi70qUMP4uSVeMIYgrADu6kzoKeVgd3ziJsxex6s/FGX2EE84Zr/x5IjAKLWq2Tqi7MbnUR0y0ooRcOCTi84HnLyhGbl+4iOOpOGkmoKTTemrKHti3pY2TT5ZIKnfaookmMdKo9TSSGg57F2zcXLP/Rys8uT/8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342772; c=relaxed/simple;
	bh=47wZE75C3ccWr+Grj15dAwgu5EKzR19KacsbqGuA9D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSQrU2sLIu3zZj7qqrFayOZe72acmqjoQrJgfpxdOHHKxBwN1H96ATbnpRP8hrYWH0glu0Gn66YqCEHHFDaX2BGh2YHwMTB0aZgGT2f41M7KgG5ZlucQnHM2LEZc+tqHY76liMIr9x7MAVEnm7aGOGDkiTtSFtzgwshl7ZNfwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NUxK/DRG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qoELbrT7 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741342768; x=1772878768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u5NnMAuoCpHi6I8onFu4kw3+wMiYKvzXi7R0wbc3Y8Y=;
  b=NUxK/DRGhlIsOwTKFux81sAxrCIBmyZEcu66kGX/ef9flxugLU+lXar2
   6GhOxaneirznIktD6UYsBj2dPDGvRbvuTAHlDVPoAQoHS8eAlt+nMFSD4
   U1nVgrXjMTLZyK+5d3r72E/Hg9Lk07a58Q6Qca1Fp5B3WMovEV/JvQ6Dz
   1F0hMgxUI0Lp7Td0RUs3YU+4rWWKbAqDoG+2KtvlySlBqrZSlWjwIJRM4
   Qqd27LeUN3kEsGwzZTp3u4ADIx8mWT1WUwFyCyzaZ1BJHpSNfR6IaAX4K
   xUiZDldXncdFU5JMMab/lhNnjZJKsrLUMKMqEUL3QqMUzP1QXtit96OxK
   g==;
X-CSE-ConnectionGUID: cwth3I3+SFm4GbrvFaS44w==
X-CSE-MsgGUID: KT/ZiaJFTAmCZXaQrXGPxg==
X-IronPort-AV: E=Sophos;i="6.14,228,1736809200"; 
   d="scan'208";a="42425425"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Mar 2025 11:19:19 +0100
X-CheckPoint: {67CAC827-10-DC4DC9A0-F4F29281}
X-MAIL-CPID: 3340A31ABDE18E85EDAED8C6EBB5AE90_0
X-Control-Analysis: str=0001.0A00639E.67CAC82B.0057,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB938171FED;
	Fri,  7 Mar 2025 11:19:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741342755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5NnMAuoCpHi6I8onFu4kw3+wMiYKvzXi7R0wbc3Y8Y=;
	b=qoELbrT7dqpxKdLBtp+15LkU3jggW0iYoWlp1nDF01+0gZva1+FyuliyvzFZ5DsiNYOLof
	AltMCxXCtqdGzpkM+azfga6QX/0CBE5/GBypvksQ8AE1juhqQW4cz5uVMDPAeWfkpfZwER
	Pchb8NZEMFFLfIsjUHgaJfMtXMLXs+JXbqslBec1iOLC5vNEPqQzO+lajV0px7IKvig9t8
	NzUuRxF0VdRIjJdcpSpVv+5hKzNrc+QbWobBYh+z0U3wHiRKgJAyAuBzy8HLu2cao1oMZ/
	K35gyL2hXJUnlSBBJf87+SD+aiKrmzGzhaVztcw3jKW+7lT/4/+DNEDimu3AWw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] arm64: dtsi: imx93: add alias id for bbnsm_rtc
Date: Fri, 07 Mar 2025 11:19:13 +0100
Message-ID: <116096172.nniJfEyVGO@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250306193014.490091-1-Frank.Li@nxp.com>
References: <20250306193014.490091-1-Frank.Li@nxp.com>
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

Am Donnerstag, 6. M=E4rz 2025, 20:30:14 CET schrieb Frank Li:
> From: Joy Zou <joy.zou@nxp.com>
>=20
> Add rtc0 alias to set bbnsm_rtc as the default rtc.
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/d=
ts/freescale/imx93.dtsi
> index 56766fdb0b1e5..7d9aa15ebf5d0 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -34,6 +34,7 @@ aliases {
>  		mmc0 =3D &usdhc1;
>  		mmc1 =3D &usdhc2;
>  		mmc2 =3D &usdhc3;
> +		rtc0 =3D &bbnsm_rtc;

IMHO this is a board property, not SoC property.

Best regards
Alexander

>  		serial0 =3D &lpuart1;
>  		serial1 =3D &lpuart2;
>  		serial2 =3D &lpuart3;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



