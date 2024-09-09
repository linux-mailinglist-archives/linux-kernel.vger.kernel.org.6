Return-Path: <linux-kernel+bounces-321184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA397159A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBF82856E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FD1B4C4F;
	Mon,  9 Sep 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="N3Jbr3qp"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F89179658;
	Mon,  9 Sep 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878735; cv=none; b=nZo5Fw3Tdnlp6MydX7y3wTr7WCdwixMqfarC5ei8R8s25D00E5PdXyem0AlTwYaCsYGc7r06Kpu2RJ5CxCJ8ua1lzBqLB8pU+9YFYmuj4qi7Xg2LAUJTCOeC2eDNzdh5p3tF+785NUIkF7REDdst3hKXkjO/jm+qeuc1YmQbwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878735; c=relaxed/simple;
	bh=5Ta/4DSgQoX8eSaZBH8uX7f7kA1cIdCF5+cIjyuspMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=Zf9Dz49W4CZcGqmUYcAYXhLryRmB9k8FdKkcvljkfcj9FNXRwTOvTVtpXCc77O5Ia8fGloVu0FCOlzuqSyD0iGEm5Jie+tWVVKirMa59s5C2LkEoDuValhma8uSLmBjnWlIu8nkOFmllKsCvodKu4NMvlYw/PMENH1MfZEZ3FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=N3Jbr3qp; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1725877000; x=1727177000;
	bh=09mAxXk5yZQ1FHGrWz6yzqQxvAU0gLKA91bNZ0jSFDQ=; h=From;
	b=N3Jbr3qplkKFBNIhWyfhI0/ftYyX1QYS8sQtNXWbN6B4OTsw0dTznEX6ZRLyoymWo
	 HblPc/hQ2j7f/kU05dM76Ik8FCzMapfz6qEOyYqq3X+0XuFnGXZvbZaUl/zTBQKuc+
	 NLQS4o9zMk8yn42kiCou+9ZO+6PP7jqHIU6Gy1GwJ3tG/S6mRISTDhH4tIIhLeSUUr
	 ADQlUMLkfgTwGfaEvtDCHp4v/jX4iTP5h935D9Jio6oEigV7QYS+lbkGbvWmVx+j3t
	 BXLsZh4manj+XP55OuTvas4SmbtfP9DxzzFxW49mHtfA2pq/rum70p67GUJJlR+U+Z
	 kto3xhVBsrzZQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 489AGc2d025308
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 12:16:40 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 12:16:38 +0200
Message-Id: <D41OC3PTUHE6.1V0FU4PAW4O9Q@matfyz.cz>
Cc: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] regulator: 88pm886: Constify struct regulator_desc
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
From: "Karel Balej" <balejk@matfyz.cz>
References: <0261f8b951a489859ee0fa41c584804b2e3f1557.1725783921.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0261f8b951a489859ee0fa41c584804b2e3f1557.1725783921.git.christophe.jaillet@wanadoo.fr>

Christophe JAILLET, 2024-09-08T10:25:56+02:00:
> 'struct regulator_desc' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some

"increases"?

> function pointers.
>
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>    3251	   6928	     16	  10195	   27d3	drivers/regulator/88pm886-regulat=
or.o
>
> After:
> =3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>    9795	    360	     16	  10171	   27bb	drivers/regulator/88pm886-regulat=
or.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> --
> Compile tested only
> ---
>  drivers/regulator/88pm886-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/88pm886-regulator.c b/drivers/regulator/88=
pm886-regulator.c
> index a38bd4f312b7..68c83a4ebda8 100644
> --- a/drivers/regulator/88pm886-regulator.c
> +++ b/drivers/regulator/88pm886-regulator.c
> @@ -56,7 +56,7 @@ static const struct linear_range pm886_buck_volt_ranges=
2[] =3D {
>  	REGULATOR_LINEAR_RANGE(1600000, 80, 114, 50000),
>  };
> =20
> -static struct regulator_desc pm886_regulators[] =3D {
> +static const struct regulator_desc pm886_regulators[] =3D {
>  	{
>  		.name =3D "LDO1",
>  		.regulators_node =3D "regulators",
> @@ -340,9 +340,9 @@ static struct regulator_desc pm886_regulators[] =3D {
>  static int pm886_regulator_probe(struct platform_device *pdev)
>  {
>  	struct pm886_chip *chip =3D dev_get_drvdata(pdev->dev.parent);
> +	const struct regulator_desc *rdesc;
>  	struct regulator_config rcfg =3D { };
>  	struct device *dev =3D &pdev->dev;
> -	struct regulator_desc *rdesc;
>  	struct regulator_dev *rdev;
>  	struct i2c_client *page;
>  	struct regmap *regmap;
> --=20
> 2.46.0

Reviewed-by: Karel Balej <balejk@matfyz.cz>

Thanks,
K. B.

