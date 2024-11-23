Return-Path: <linux-kernel+bounces-419162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DDB9D6A27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC00B214DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384AA146588;
	Sat, 23 Nov 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7xbFM0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADC17736;
	Sat, 23 Nov 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379539; cv=none; b=tGRYJmuXgL2JvQrJV08qtJR4tntfhspMh7bdDgF6hO7N04OBGFf4F9Ublh0z7JPJ97hJVlWcsv2/WITGvX6Psk78iRUkWUeK2P5DatO7TPJPv12sl0MXQhAGUfoTA7cYKQ6XiaMW2FIbRP7epVCN30o1l9Y3dJzHBbUxiw16Dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379539; c=relaxed/simple;
	bh=z5xZlFjgutW8J5lsLl5fgjAOUKmkKMFTGUE5LqX8dm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfNYPTfyBbIO+kt0RxfUfkiIXkrMRP+dATV2bMA4VmOI3WhJ1hKNQKUxN/fnMn/UZX9VRHJd6/PmishFYqRzD+tONn3lpHMMfQv4LS8Qy5uDu56DioL4P1hZXz0N4wYkrnkwcgcCkbSMQf/AQhKSPMPs0QcxO75ifKUNNHvOT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7xbFM0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F53C4CECD;
	Sat, 23 Nov 2024 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379538;
	bh=z5xZlFjgutW8J5lsLl5fgjAOUKmkKMFTGUE5LqX8dm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7xbFM0mObTIeSkIqmiiSCKMgl5tu4+/dZV4PSd1/404Fbqhi2eXL22MnLbCDvrlk
	 pDZHH9PDLgA85dLuXBs9cKJ/zTXzH/6NrGWzs/yftEFpZMJLae2ClpfqhYggMfTnaa
	 EtKJ96CWHyuETJee3W/0BKxN6T8z8Qpj9fJusvao1qARZ1t9XoW6OUGosxykTzOoJD
	 JLgOEAjXH8YtUl5zRC7WVs2Gf+Em1U5aC0zc8vF9mBEVjqR4XKpk94mTy4ZYERFEFR
	 rshJ9sWbggg8RLQOil1778ZZMAz7XrxxXUR7gd8a8l3tzt8tKHn39PoI1+ZXFytByZ
	 IvhUh9owAIg6g==
Date: Sat, 23 Nov 2024 17:32:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] w1: ds2482: Add regulator support
Message-ID: <2ff7omfp752zdtzozcle5jn7nsyonsbqgjefrx5t4lncoer5bw@wb76uxg26ugg>
References: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
 <20241122-ds2482-add-reg-v2-1-a5a03ee74da7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241122-ds2482-add-reg-v2-1-a5a03ee74da7@gmail.com>

On Fri, Nov 22, 2024 at 09:53:57AM +0100, Kry=C5=A1tof =C4=8Cern=C3=BD wrot=
e:
> Adds a support for attaching a supply regulator.
>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
>  drivers/w1/masters/ds2482.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
> index a2ecbb863c57f38bffc8e3cd463db1940e603179..3fb35e92fc1587dc4e609c006=
1fa5057e0027a80 100644
> --- a/drivers/w1/masters/ds2482.c
> +++ b/drivers/w1/masters/ds2482.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> =20
>  #include <linux/w1.h>
> =20
> @@ -117,6 +118,9 @@ struct ds2482_data {
>  	u8			channel;
>  	u8			read_prt;	/* see DS2482_PTR_CODE_xxx */
>  	u8			reg_config;
> +
> +	/* reference to the optional regulator */

Drop comment, obvious.

> +	struct regulator *vcc_reg;

Missing indentation after type - see earlier lines.

>  };
> =20
> =20
> @@ -445,6 +449,7 @@ static int ds2482_probe(struct i2c_client *client)
>  	int err =3D -ENODEV;
>  	int temp1;
>  	int idx;
> +	int ret;
> =20
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> @@ -457,6 +462,18 @@ static int ds2482_probe(struct i2c_client *client)
>  		goto exit;
>  	}
> =20
> +	/* Get the vcc regulator */
> +	data->vcc_reg =3D devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(data->vcc_reg))
> +		return PTR_ERR(data->vcc_reg);
> +
> +	/* Enable the vcc regulator */
> +	ret =3D regulator_enable(data->vcc_reg);

You wanted devm_regulator_get_enable().

=2E.. but your comment also suggests devm_regulator_get_enable_optional().


Best regards,
Krzysztof


