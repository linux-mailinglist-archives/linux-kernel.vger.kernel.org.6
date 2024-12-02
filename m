Return-Path: <linux-kernel+bounces-427483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB29E02A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC68B2B55B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B3209691;
	Mon,  2 Dec 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtVsEOnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE224209696;
	Mon,  2 Dec 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141468; cv=none; b=T4swxGDjIC5RnrwBrXffuvUm5sJTVkwKhPbMUrLvXCR9bk5opRn46PjruOquUUVUst5zapVMYpGz8Jc8JHZtRRenrD4WSkOyif8WXxxWjVdUaDHAz2jvIcx7RzVLmc8ef3NPwXa5bm6H2xFQPXhNxbpWEbaXdhOdkwPgvj8uRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141468; c=relaxed/simple;
	bh=LsP9CgzJ+Y+sKgxaLMOV69iCWU+C4h7rrlW1sun0Wq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKrMJhDivT6SHGwPCnMI2T65AZxq2GHo8j7wyyZ1Qe7mcXao1q1JcWxqnS4SNg6Lk3wDoSV4LWnpWaT8/ZiQ4sbXyl99WCDW8SzCVuI5HV0t2ia9s/WcpMKbpvoviKKNerG0M5whlHr+QX5831tFFiSrvOMkVmx+twGI+Ei8sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtVsEOnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99FFC4CED1;
	Mon,  2 Dec 2024 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733141467;
	bh=LsP9CgzJ+Y+sKgxaLMOV69iCWU+C4h7rrlW1sun0Wq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtVsEOnEymQbCqj0nMkRW/4Me25USsUS1i7F5u90FS8KklyW0ISsUt8taa/mJ3+zn
	 YEYXz5ty08tFwVYji1+LqnHz+LaVfCtbegVLplbhGsw+Pb7/hindKs9HjfJPcWBkRR
	 UtanJH3XNygwsHcVpQJ1klAstg4WZDrvA3dHD2IITloeQqprq0GawNqtw7AIS/SBtE
	 QZFnXGvHyWUffsMU5tnclRjUWj72FXVebFG8D/IZTquoEAlj39tSxDKs5YnvWAt6+A
	 5NsUFMA+D5HkBTpqCD/ocM/Sv3+PKAJheuZfvwZuQnVr9NQWX+nsVjSyeYFf8LU/fR
	 3Bj4fE2asM/Qg==
Date: Mon, 2 Dec 2024 12:11:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mailbox: mpfs: fix copy and paste bug in probe
Message-ID: <20241202-given-elite-bcff7bdc290d@spud>
References: <9e760329-80ed-4bf7-8d4f-dbb16a736497@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c+C96bfMaMmx84Ld"
Content-Disposition: inline
In-Reply-To: <9e760329-80ed-4bf7-8d4f-dbb16a736497@stanley.mountain>


--c+C96bfMaMmx84Ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 01:07:23PM +0300, Dan Carpenter wrote:
> This code accidentally checks ->ctrl_base instead of ->mbox_base so the
> error handling can never be triggered.
>=20
> Fixes: a4123ffab9ec ("mailbox: mpfs: support new, syscon based, devicetre=
e configuration")

This got merged? Would have been nice to know about it Jassi, you
really should adopt some mechanism of informing people that you applied
their patches.

I had added a fix for this locally Dan after we discussed it previously,
but since this made it in without that:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mailbox/mailbox-mpfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpf=
s.c
> index 4df546e3b7ea..d5d9effece97 100644
> --- a/drivers/mailbox/mailbox-mpfs.c
> +++ b/drivers/mailbox/mailbox-mpfs.c
> @@ -251,7 +251,7 @@ static inline int mpfs_mbox_syscon_probe(struct mpfs_=
mbox *mbox, struct platform
>  		return PTR_ERR(mbox->sysreg_scb);
> =20
>  	mbox->mbox_base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(mbox->ctrl_base))
> +	if (IS_ERR(mbox->mbox_base))
>  		return PTR_ERR(mbox->mbox_base);
> =20
>  	return 0;
> --=20
> 2.45.2
>=20

--c+C96bfMaMmx84Ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ02j1wAKCRB4tDGHoIJi
0p/nAP0T1+p5CcIFqSqdwkulKIE1dpZGe7o3wJ9GOEDok8e//QEA7HDMHVJ1wuBg
teJIyHLOc627VuGVFCijuhJTIPYo3Q0=
=ekih
-----END PGP SIGNATURE-----

--c+C96bfMaMmx84Ld--

