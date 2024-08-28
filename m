Return-Path: <linux-kernel+bounces-304374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14334961F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDD81F256C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8BB155CBD;
	Wed, 28 Aug 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Qy5yZG5C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Dvq12mdy"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920F1552FA;
	Wed, 28 Aug 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825551; cv=none; b=sJ8ZAekRJY3JUD9SyVMI8gq59NhXUEHN34x3YnOwZBD71M60ZDHejDoZxSRnRCmNi0YYITdocjOGLaJfrA5vAHb2HsLniB+f+CiYgpdT5GWvYeDfMb9D1C1/hlERDZImYEV8th/Px8sCYYKInWjl6OiaFcY2jYjJWTlQSos2rFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825551; c=relaxed/simple;
	bh=hwNHsYHF2oUKtn8n5RD6uuWHQW7AuyNPuOS52/nANlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUPKyfdfzUFKfpPl7G8H2N5FxWu8ly6iiYIFrA7Hllk/Cq4YVM9UmEzLJWl99wEOozzgBUaAY10W/xiE8qDxF/kO3smNCJ9EwExJS9fuxdgag+hUCp3jvC2bNdp8Vta7ujTz1YZ9CSMEcDmpS67J5zwzXwftobPHQMKsmqfc32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Qy5yZG5C; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Dvq12mdy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724825548; x=1756361548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XO0UH3rt2tTGMcGZHCllnQej5STp9ORf7PtLe6wtdEc=;
  b=Qy5yZG5CPFNNN5Z7KT+oCW5TKJpnhPh3NayT8hvCq4/GFgwrvB5/F7Ma
   fbwRcrG3RxVn8fKTPcnx9QrWAutFTMfDOiRNX58qnxNMmliVYXfHr/Yez
   nUgrPjXOcH+jIoCM6rL5+P7RxOoxWZ3MerlrvrMvY2Ed902O0AC9aX+mk
   lCTvo/Pfu944ZAL1F20YkQ8rsZp+XJK5PTt72eY04O8IlRrR+0LvGx+iN
   SbD/z9cq2wALdlb5fBIg+Mb1HOO1uhQrK6tpbz34nFOiTxGbBPQtPTpdM
   C/8DPRVvbMI8VvEmf44XPAJXTVdVP2xFxqgaM/GwlFtTfB3HOynkEPTIU
   Q==;
X-CSE-ConnectionGUID: T+/E5GVUQoadvyANOBmAZg==
X-CSE-MsgGUID: NBxho1Q9TeKtPyB6yq6vkQ==
X-IronPort-AV: E=Sophos;i="6.10,181,1719871200"; 
   d="scan'208";a="38624295"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2024 08:12:26 +0200
X-CheckPoint: {66CEBFCA-1-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 64DA97D51747141F3F980519A02CD7BF_0
X-Control-Analysis: str=0001.0A782F29.66CEBFCA.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA391169D7C;
	Wed, 28 Aug 2024 08:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724825541;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XO0UH3rt2tTGMcGZHCllnQej5STp9ORf7PtLe6wtdEc=;
	b=Dvq12mdymS4S9Uoit4n+DOfLICU2ulohnbYQ6j9esmlsrbA6HzavU5KOcK6jyOKd8b9llC
	SmxdoGYNBRtUh6cSoClGlhzF+xX+IA6IesKo8WKOG7Syz+isPRkc61FXm0ACRZCyTGOhfZ
	6ck14xLohj1CU/VBQmGmu+PnJs0RvgkqlbPkVzooT7bTKw6iXPPz18DMg2/paQiN2ou13K
	NIqmAzGBRR5+6I7p7DPauDyKdw+ORdCjEQWgKZ8pJHePjpKiVaD2ieq4/5CkKMfhR0skWY
	y3+6drFRRn0/ISpgJ99mURng3v93g9pDac1Ld0mxQ5vP3r9zLDBBofmn1BoJPg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA memory
Date: Wed, 28 Aug 2024 08:12:20 +0200
Message-ID: <3313261.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAOMZO5B32Cn6qa3Zqe437pqTZ77bpCVMMtzhH3xzj06x5G5MQA@mail.gmail.com>
References: <20240827142458.265558-1-alexander.stein@ew.tq-group.com> <CAOMZO5B32Cn6qa3Zqe437pqTZ77bpCVMMtzhH3xzj06x5G5MQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 27. August 2024, 16:32:10 CEST schrieb Fabio Estevam:
> Hi Alexander,
>=20
> On Tue, Aug 27, 2024 at 11:25=E2=80=AFAM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> >
> > Default CMA size is too small for HDMI output and VPU usage. Increase t=
he
> > default size by providing a CMA memory area.
> ....
> > +               linux,cma {
> > +                       compatible =3D "shared-dma-pool";
> > +                       reusable;
> > +                       size =3D <0x14000000>;
>=20
> Just curious: how did you calculate that this is a suitable CMA memory
> area size?

Just after startup and a simple weston running on a 1080 HDMI output I habe
this CMA status:
> # grep Cma /proc/meminfo
> CmaTotal:         327680 kB
> CmaFree:          137764 kB

AFAIK also DMA setup is using CMA memory.

When playing (and decoding) bbb_sunflower_1080p_30fps_normal.mp4 free CMA m=
emory
shrinks down to ~60MiB
> # grep Cma /proc/meminfo
> CmaTotal:         327680 kB
> CmaFree:           63144 kB

So, 260MiB should be enough (but just barely). But to give some spare memory
it has been increased to 320MiB.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



