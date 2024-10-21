Return-Path: <linux-kernel+bounces-374585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDE9A6C74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A2D282966
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA431D175B;
	Mon, 21 Oct 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="C7cLxQJH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m3KmhpM3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6E1D2718
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521877; cv=none; b=qFAXi4bPCy86xGtAcGVxbPU2Rbfpt04iD4q9ZTPDX1lv3n7kYinxCvaGcEHlXE5r6j4yrX23+FxCWCuiRQ+IEn1UJD3wO8bHRqgB56oLNSJCAr4rWZXwAOTMoBgHxCzxlyg97ZljPU+VNdI2hEBojKdzzYaE7Born2Gc29XAyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521877; c=relaxed/simple;
	bh=1RBfEmxbMElSHuGi/ZfNw9GuOJ/LcpL0xT0FGzEaRi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1zmleOL95EHcbxqOw++K74wsyMoMEvJ38sQY3RCWgIt+9Y+8DOPkZNFMZBfuTyYHjqrD2iw/jX8fYI/CUXtrClzGdbrm3k2gFcd3/Yv6imjvfvQA1b4Xwu+Duq9qMxg5ROVDIotAqIHTrokqFNmhY0Nl1+F5hVhFRizgpKsiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=C7cLxQJH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m3KmhpM3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729521874; x=1761057874;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JEBO4bmnA1LwmC5/rU2MmK+d0ytWeHsZV1AVSaGRT2o=;
  b=C7cLxQJHtJYEfleHp6OIobQQdIbOfkNNa6sIQncQMYGeacxgHusjRD6y
   0IcJEuQgsZTYLjFzq+5ZWDiYSGSgnQVCsvn9BxLk43vnVPJtmwIr6h4kO
   fwP1qfB/n43L0DFJPk3fpe9VMOE6kQJiGaQjwvj7JZl6V5fL5LZCHs+NC
   6AD/Boq6VI2yGU7TB+xnTwsCcwfYaLG0xS148KmeD0YY3At1B/mYD4TsD
   oCHtOWhx+kg6YzbJacFFGeLpNafQkN5Kf3VTpS2T9/41Gk3ExOWuuJGwh
   pfcGtMghfwPpybMYj3KOnD6kUC6e2lMvn98ZAsIjlfDUwMfF0OfsZSycE
   Q==;
X-CSE-ConnectionGUID: G0Mrly8uS0yyB3/AfNyLQA==
X-CSE-MsgGUID: uvFFfAWuRdOt+L5KPh99cA==
X-IronPort-AV: E=Sophos;i="6.11,221,1725314400"; 
   d="scan'208";a="39577380"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 16:44:31 +0200
X-CheckPoint: {671668CF-14-8E59014-E6F31237}
X-MAIL-CPID: 3C4F8A4EB954108A790B88B9D00F6D15_1
X-Control-Analysis: str=0001.0A682F28.671668CF.00A0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0E4916139E;
	Mon, 21 Oct 2024 16:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729521867;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JEBO4bmnA1LwmC5/rU2MmK+d0ytWeHsZV1AVSaGRT2o=;
	b=m3KmhpM3fQceCrnzQiU4FbQ+i8yuRTBEQ8Z6Jq4bXCv9sPioglAqt0UIiEwETrRXW0NeMG
	4GRXclMGs8o48VcwR9DxCaJ2vZiLen0ukAhDyIs9QrqMALkrlLb7AJx6GRMP0zjPt+HdPq
	MhHs4KhNtaYPCABGsYS2Sxg3BUKRvdrB04NPeBdF/1V86WVe7mrYgt+28Y59Ss7qfdMuE9
	Y+le+xbe36QC5wYHE3Kvph1IJzk5Mhj7DImh8GTr+9ASxJTz60g+374qEqdjX/+8KA3Rst
	OX9p3yJBGhcD89U7MceFbp6t/yueK7/o4RGGLL1KYTJmFawOXMvjFuQ57h97Iw==
Message-ID: <da174fe9af56d5c0f77ee140456c9d07cc968136.camel@ew.tq-group.com>
Subject: Re: [PATCH v5 5/5] mfd: tqmx86: add I2C IRQ support
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org, Gregor Herburger
	 <gregor.herburger@tq-group.com>
Date: Mon, 21 Oct 2024 16:44:26 +0200
In-Reply-To: <1d2477439ec2bb7f5145648da4be5dcd8cfb6847.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
	 <1d2477439ec2bb7f5145648da4be5dcd8cfb6847.1729509613.git.matthias.schiffer@ew.tq-group.com>
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

On Mon, 2024-10-21 at 13:34 +0200, Matthias Schiffer wrote:
> From: Gregor Herburger <gregor.herburger@tq-group.com>
>=20
> The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> Add module parameter to allow configuring the IRQ number, similar to the
> handling of the GPIO IRQ.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>=20
> v2: improve module parameter description (was patch 4/4)
> v3: replace IRQ 0 resource with an empty placeholder to simplify error ha=
ndling
> v4: no changes
> v5: move placeholder to the end of the resource array, use define for ind=
ex

Ugh... I just realized that I forgot to update a comment for v5. Will send =
a new version some time
this week.




>=20
>  drivers/mfd/tqmx86.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 1fd2212bf492c..94126a484c412 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -50,6 +50,7 @@
>  #define TQMX86_REG_IO_EXT_INT_9			2
>  #define TQMX86_REG_IO_EXT_INT_12		3
>  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
>  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
>  #define TQMX86_REG_SAUC		0x17
> =20
> @@ -60,11 +61,18 @@ static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
>  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)=
");
> =20
> +static uint i2c_irq;
> +module_param(i2c_irq, uint, 0);
> +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)")=
;
> +
>  /* Index of IRQ placeholder in resource list */
>  #define TQMX86_IRQ_GPIO 1
> +#define TQMX86_IRQ_I2C 1
> =20
> -static const struct resource tqmx_i2c_soft_resources[] =3D {
> +static struct resource tqmx_i2c_soft_resources[] =3D {
>  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
> +	/* Placeholder for IRQ resource - filled in by the probe function */
> +	[TQMX86_IRQ_I2C] =3D {},
>  };
> =20
>  static const struct resource tqmx_watchdog_resources[] =3D {
> @@ -262,6 +270,14 @@ static int tqmx86_probe(struct platform_device *pdev=
)
>  	ocores_platform_data.clock_khz =3D tqmx86_board_id_to_clk_rate(dev, boa=
rd_id);
> =20
>  	if (i2c_det =3D=3D TQMX86_REG_I2C_DETECT_SOFT) {
> +		if (i2c_irq) {
> +			err =3D tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> +			if (!err)
> +				/* Assumes the IRQ resource placeholder is first */
> +				tqmx_i2c_soft_resources[TQMX86_IRQ_I2C] =3D DEFINE_RES_IRQ(i2c_irq);
> +		}
> +
>  		err =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  					   tqmx86_i2c_soft_dev,
>  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

