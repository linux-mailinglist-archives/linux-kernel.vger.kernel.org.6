Return-Path: <linux-kernel+bounces-515314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A55A36325
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216EF3B41DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB55267B63;
	Fri, 14 Feb 2025 16:29:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF02676E8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550553; cv=none; b=Sx4vfo6NM89H9p5ik0no+Z7cSF6A6cQLaFwGfYUL+LP99uVzSO2sFkB1edDvt8pqoMOwaFbsE71ST14xExB7Jg49GCZoAuyrWoHpZ44rHLcdLOBopY5uzFUsJGgHqvwmgsnSVx6ZkOs+b76a4kimYiVYokE3Pmp2jvvTfHrE9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550553; c=relaxed/simple;
	bh=USDDppoY45ze1zboaiXFyIhKCyt4uYM6VaQYbFL31to=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLbaWX0i8eEQKNu028Fhle4TqQ5IlsVuoWySsQw0tgvWGiJSItOptVOeELOyGv16lc+T7Zaqq6tY3XKkdBQj6R79PrUSNga6dj21W6NxXCw2l/4obZoih/We9AOs7s3gjYOfnBjw4sCPcKnXNdI8Z4cKsmVrxamr+JPxXi2RVe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tiyYk-0006jh-A8; Fri, 14 Feb 2025 17:28:58 +0100
Message-ID: <d0dd61ea558ef8b18978301ef710925b83ef4037.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] arm64: dts: imx8m: Add pinctrl config definitions
From: Lucas Stach <l.stach@pengutronix.de>
To: maudspierings@gocontroll.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Date: Fri, 14 Feb 2025 17:28:57 +0100
In-Reply-To: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
References: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Maud,

Am Freitag, dem 14.02.2025 um 16:57 +0100 schrieb Maud Spierings via B4
Relay:
> Up untill now the extra function mux (pull resistor, etc) has been
> defined as a raw hex value, this is difficult to interpret. Add
> definitions for these parts of the pinctrl registers to allow for more
> readable pinctrl definitions in devictree files.
>=20
I certainly prefer the short form with the hex value, I find that quite
a bit more readable than very verbose swathes of defines ORed together.
But each to their own.

> At this point the patch is not complete, some pinctrl definitions set
> bit 30 (0x40000000) but according to the reference manual this is a
> reserved field, I currently have no way to identify what the meaning of
> this bit is, I hope someone in this CC may be able to provide an answer
> to this. It will then be fixed in the v2 of this patch.

This is not a mystery bit, it's used by the pinctrl driver to force
enable the input path of the pad (SION). This is defined in the generic
i.MX pinctrl binding, see
Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt

Regards,
Lucas

>=20
> It should also be done for the mn/mq but I currently do not have the
> reference manuals for these to verify these fields, though I can only
> assume that they would be the same.
>=20
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> Maud Spierings (2):
>       arm64: dts: imx8mm: Add pinctrl config definitions
>       arm64: dts: imx8mp: Add pinctrl config definitions
>=20
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 ++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++=
++++++
>  2 files changed, 54 insertions(+)
> ---
> base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
> change-id: 20250214-pinctrl_defines-237e7db61c6a
>=20
> Best regards,


