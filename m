Return-Path: <linux-kernel+bounces-514904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E767AA35D34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4183516A6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E0263C6A;
	Fri, 14 Feb 2025 11:54:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94D2627ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534064; cv=none; b=qwtVgj3Jm9EFqA9gANqEViJRTEXnRimg7hUAUsXuaIpmnsPpWsLW/G63Qe/vDqRmniSmSXQ3PY5HVSmu3ZHGFTpVotCnBapfSV7Dn2M5saG9Erq0qAdfnonbW7q2XqdG3QBqM/MtIiuyw7e4lbTU/lFrYzGM6lzFLWJkT+JGBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534064; c=relaxed/simple;
	bh=VT78mR7dUGc932RxV/+e1g3QcpekS3eT7VVUIE3ocuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+TIwiZDkW+V9QJTxSp9gGY5Bx0I/gtD9EEZMNB0EPZHH5Yfvx2DzQL2pWDQsJO6IUZJdFWCPgFJvly+gIGrQ4/qwK8Txim9TkzTarvhGlAW+DjUdkewKrTUB4iFwLFXt7H/20jo+yLAKiRsUdY1I/aa5Sb/Yj1ClgDgMfnz/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiuGw-0007wn-Ob; Fri, 14 Feb 2025 12:54:18 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiuGv-000uUu-2E;
	Fri, 14 Feb 2025 12:54:17 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiuGv-0005mD-1x;
	Fri, 14 Feb 2025 12:54:17 +0100
Message-ID: <6dd9ed2750abe1f5174805673411ccb919ee5461.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device
 compatible
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wilson Ding <dingwei@marvell.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, salee@marvell.com, gakula@marvell.com
Date: Fri, 14 Feb 2025 12:54:17 +0100
In-Reply-To: <20250214065833.530276-3-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
	 <20250214065833.530276-3-dingwei@marvell.com>
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

On Do, 2025-02-13 at 22:58 -0800, Wilson Ding wrote:
> Introduce the new ops for updating reset line and getting status. Thus,
> the reset controller can be accessed through either direct I/O or regmap
> interfaces.

Please don't add a new layer of function pointer indirection, just add
a new struct reset_control_ops for the regmap variant.

> It enables the support of the syscon devices with the simple
> reset code. To adapt the DT binding of the syscon device, the number of
> reset lines must be specified in device data.

If the DT node had a reg property, number of reset lines could be
determined from its size, like for MMIO.

> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  drivers/reset/reset-simple.c       | 117 +++++++++++++++++++++++------
>  include/linux/reset/reset-simple.h |  11 +++
>  2 files changed, 107 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 276067839830..e4e777d40a79 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -15,8 +15,10 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  #include <linux/reset/reset-simple.h>
>  #include <linux/spinlock.h>
> @@ -27,10 +29,9 @@ to_reset_simple_data(struct reset_controller_dev *rcde=
v)
>  	return container_of(rcdev, struct reset_simple_data, rcdev);
>  }
> =20
> -static int reset_simple_update(struct reset_controller_dev *rcdev,
> +static int reset_simple_update_mmio(struct reset_simple_data *data,
>  			       unsigned long id, bool assert)

No need to rename or change the function prototype.

>  {
> -	struct reset_simple_data *data =3D to_reset_simple_data(rcdev);
>  	int reg_width =3D sizeof(u32);
>  	int bank =3D id / (reg_width * BITS_PER_BYTE);
>  	int offset =3D id % (reg_width * BITS_PER_BYTE);
> @@ -51,16 +52,40 @@ static int reset_simple_update(struct reset_controlle=
r_dev *rcdev,
>  	return 0;
>  }
> =20
> +static int reset_simple_update_regmap(struct reset_simple_data *data,
> +				      unsigned long id, bool assert)

I'd call this reset_simple_regmap_update().

> +{
> +	int reg_width =3D sizeof(u32);
> +	int bank =3D id / (reg_width * BITS_PER_BYTE);
> +	int offset =3D id % (reg_width * BITS_PER_BYTE);
> +	u32 mask, val;
> +
> +	mask =3D BIT(offset);
> +
> +	if (assert ^ data->active_low)
> +		val =3D mask;
> +	else
> +		val =3D 0;
> +
> +	return regmap_write_bits(data->regmap,
> +				 data->reg_offset + (bank * reg_width),
> +				 mask, val);
> +}
> +
>  static int reset_simple_assert(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> -	return reset_simple_update(rcdev, id, true);
> +	struct reset_simple_data *data =3D to_reset_simple_data(rcdev);
> +
> +	return data->ops.update(data, id, true);
>  }
> =20
>  static int reset_simple_deassert(struct reset_controller_dev *rcdev,
>  				 unsigned long id)
>  {
> -	return reset_simple_update(rcdev, id, false);
> +	struct reset_simple_data *data =3D to_reset_simple_data(rcdev);
> +
> +	return data->ops.update(data, id, false);
>  }

No need for indirection. Better to just add separate
reset_simple_regmap_assert/deassert() functions.

>  static int reset_simple_reset(struct reset_controller_dev *rcdev,
> @@ -81,10 +106,9 @@ static int reset_simple_reset(struct reset_controller=
_dev *rcdev,
>  	return reset_simple_deassert(rcdev, id);
>  }
> =20
> -static int reset_simple_status(struct reset_controller_dev *rcdev,
> -			       unsigned long id)
> +static int reset_simple_status_mmio(struct reset_simple_data *data,
> +			     unsigned long id)
>  {
> -	struct reset_simple_data *data =3D to_reset_simple_data(rcdev);
>  	int reg_width =3D sizeof(u32);
>  	int bank =3D id / (reg_width * BITS_PER_BYTE);
>  	int offset =3D id % (reg_width * BITS_PER_BYTE);
> @@ -95,6 +119,31 @@ static int reset_simple_status(struct reset_controlle=
r_dev *rcdev,
>  	return !(reg & BIT(offset)) ^ !data->status_active_low;
>  }
> =20
> +static int reset_simple_status_regmap(struct reset_simple_data *data,
> +				    unsigned long id)
> +{
> +	int reg_width =3D sizeof(u32);
> +	int bank =3D id / (reg_width * BITS_PER_BYTE);
> +	int offset =3D id % (reg_width * BITS_PER_BYTE);
> +	u32 reg;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, data->reg_offset + (bank * reg_width)=
,
> +			  &reg);
> +	if (ret)
> +		return ret;
> +
> +	return !(reg & BIT(offset)) ^ !data->status_active_low;
> +}
> +
> +static int reset_simple_status(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct reset_simple_data *data =3D to_reset_simple_data(rcdev);
> +
> +	return data->ops.status(data, id);
> +}

Same as above, no need for indirection.
Just add separate reset_simple_regmap_assert/deassert() functions ...

> +
>  const struct reset_control_ops reset_simple_ops =3D {
>  	.assert		=3D reset_simple_assert,
>  	.deassert	=3D reset_simple_deassert,

... and add a const struct reset_control_ops reset_simple_regmap_ops.

regards
Philipp

