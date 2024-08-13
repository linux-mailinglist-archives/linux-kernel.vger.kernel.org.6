Return-Path: <linux-kernel+bounces-284338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEBC950010
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318501C2251C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94045170A23;
	Tue, 13 Aug 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Z0Y+eyTN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tPnoRsbz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8A170A0E;
	Tue, 13 Aug 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538410; cv=none; b=hR2PjoEDSG8RfTy/58QvOqBZHokdAU81GwDLK/c0GmqGS4exIOxNnjpVxTSnQKgd5/EPZx8QsTRPElfVQvLE+HQEsXMoQNXspWnfslQB95oclLZrkn16fRnvtWPZs4hV/cRuQHSx0+9DGAp+cSqlwMEynmtZuQjRTHaTBd6wKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538410; c=relaxed/simple;
	bh=inEEz4filmbo8qqOPd4E0V8HGmq9VX2EYngrDIfWBXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCNGFKhpvfuEArdR/jRcFGZkZtNQe3gWUZA5hhhKu1DMo4jnDNS+sYYkESc3mzPnJUU9Q3qr6u9M8i7DG7+S29qeXbzMWIwK76QIoI+WKmLaxNGoPvJC0X6JS6pJbVfB0pB/JX8xAUzISzX08lR1TNhsXoQB9d2YkH/5AuR6/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Z0Y+eyTN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tPnoRsbz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723538409; x=1755074409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lWEnrYT/2zokPYs6W1DQexseb+uW1P/nNlbcer9G350=;
  b=Z0Y+eyTNMzLWvk4X1fgfEL+QrB60synKGZ57oK550x8qE2TmFAlYjQ09
   MLk3owP03fXmQ1EMGImlgrYFmENcP5BrHAEWXYZbYLz95zVxYEQh0lxjR
   dNasqGHdS/1nhFKGhCQIM9Ty2beOdIocayhd7gkwbrsnxeCYCDOYr5cDu
   Cc1iJP+QmFbiwpFn6J05t6+sc1ItGeQSs8dI2clbny6q408Tgpvvb+f8E
   Mpe7oTl9kJfXGuZNmmpQlGsUuAfQeWOhx80JyCzhjHr4jDSoADgzdrx0s
   yRDMwrJiMxXV89a0BJEE4ZNPhxV5TYOYVQb7dYxzh/BYxkNSVsd42lze3
   g==;
X-CSE-ConnectionGUID: 9CA1SSZ6Ri6prkb6IjLvEw==
X-CSE-MsgGUID: gI2OKmTiSMmFMuUPLWmyGg==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38379221"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:40:06 +0200
X-CheckPoint: {66BB1BE6-19-751552D8-F91D2344}
X-MAIL-CPID: 11420822777CC4675A7EDCCC6C392185_4
X-Control-Analysis: str=0001.0A782F29.66BB1BE6.0182,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABA6E164B7F;
	Tue, 13 Aug 2024 10:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723538402;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lWEnrYT/2zokPYs6W1DQexseb+uW1P/nNlbcer9G350=;
	b=tPnoRsbz1yjwAD8SQ6xexda0bhZqZOyO7HzvwHPzYNJNbXFVE3tmzkgLT9/azVosf6xKnl
	Gle8tCXj9oi8HH59z6HUX1/DjU2CnUH/I/Yw4pV4XnO4pa0OmKXSerVrTAfv9UPxxwez1R
	Y3QLkdEgdNAOqc4Px0Eye/o9gn0UnpDo58lTz1ofZnB3sW5t7bKi2sf+tWMoKmoNeJUuLY
	Dx1zq7CVa5oB3Vwh6LXluky9woKWkY8HgUS2TB162nSdWg5NwI78cKWCc7PkWccCv4AAq8
	2s+w5SJaOsC14DRKuWUQK6DBVctqokXitbg4469gpZ909Z6IJHG7TOg3ze2Ovw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 15/17] arm64: dts: imx93-tqma9352-mba93xxla: rename hub to usb
Date: Tue, 13 Aug 2024 10:40:04 +0200
Message-ID: <1802961.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-15-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-15-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:35:10 CEST schrieb Frank Li:
> Rename hub to usb to fix below warning:
> arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dtb: hub@1: $noden=
ame:0: 'hub@1' does not match '^usb(@.*)?'
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 2 +-
>  arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b=
/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> index 852dd3d2eac74..325d8097bf7fc 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> @@ -533,7 +533,7 @@ &usbotg2 {
>  	samsung,picophy-dc-vol-level-adjust =3D <7>;
>  	status =3D "okay";
> =20
> -	hub_2_0: hub@1 {
> +	hub_2_0: usb@1 {
>  		compatible =3D "usb424,2517";
>  		reg =3D <1>;
>  		reset-gpios =3D <&expander1 2 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b=
/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> index da8f19a646a98..b1fcbc12bd882 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -486,7 +486,7 @@ &usbotg2 {
>  	samsung,picophy-dc-vol-level-adjust =3D <7>;
>  	status =3D "okay";
> =20
> -	hub_2_0: hub@1 {
> +	hub_2_0: usb@1 {
>  		compatible =3D "usb424,2517";
>  		reg =3D <1>;
>  		reset-gpios =3D <&expander1 2 GPIO_ACTIVE_LOW>;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



