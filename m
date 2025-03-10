Return-Path: <linux-kernel+bounces-553736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CAA58E47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72718188EA10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365F223337;
	Mon, 10 Mar 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TOj9xa47"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BFF9CB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595871; cv=none; b=ag4f3+Bnk9g0C46sNldV1MTR/MgUH/yD+4RQ61Zh/9OpAPGSpnYLENzxGXTzfCtW3ify9p5tVV3uuPT2soXu/6mIFBVaLVmmAm/n2LV9b23/vrwCsb+yS0cHx414FVsPVarlH+lNFp9R67KTSWC393fP4EL9lmx9w+Zc84wony8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595871; c=relaxed/simple;
	bh=IZBEXmfRn6QWwxUlIzBdGeCRXZ6xRAsQuuxJX9yIhPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/A3Tee5ghqbb9G2j0Bxv7DEKIZitsKyUXAv/jkDaEQ7M7L2EZcXKVPE9+xXv1n4TqBFBY3FwclwAdASnJ8cOy3zStCK0hjTa9gVrFe1REYBeLvjDbLJVty8xa2PBDyArFtw70gcnv6MPM5EgBh7fQFnoQK6uEg0YMBFQaD+Ngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TOj9xa47; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l6PTBHTCDiiRj8yM9SoUD7SlUxVaru4NfOsXm/ymtRY=; b=TOj9xa47MBJUcrTZLIccqGL3iR
	7T/TZnUwnVGDVQE2rLlX8Hq2sowBdDyQSeTKS38jCA9UApVjp7qVOgcrpE3dSgAJXY9jWQ9xmSWut
	Z5gkb2qB5rvN0RfOlPo9v3TLky+XpM+bluZl0RqE95texc62S5J6xteekceYb4ivvcxrocym3v8R9
	ktadE7tRmWNSQOnstu6lU1/hwUsF6K5Euh+AtqPeHA8h5gU3SmayYGUY/a37ALmvKSIYHd1TH4jyo
	AoSLHgl6nd2oQFUTHGAx/aTpRxoCFiqIfXEjoyihleAlhNkm+UVpJ4qo+Ms+VoXuy2EOjDTFtQ+rZ
	XHd88zRA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1trYdt-0006LZ-G7; Mon, 10 Mar 2025 09:37:45 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: lee@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH] mfd: Convert comma to semicolon
Date: Mon, 10 Mar 2025 09:37:43 +0100
Message-ID: <13715971.uLZWGnKmhe@diego>
In-Reply-To: <20250310031145.650950-1-nichen@iscas.ac.cn>
References: <20250310031145.650950-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 10. M=C3=A4rz 2025, 04:11:45 MEZ schrieb Chen Ni:
> Replace comma between expressions with semicolons.
>=20
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.

oh ... wonder how I could've messed that up.

And thanks a lot for finding this.

> Found by inspection.
> No functional change intended.
> Compile tested only.
>=20

=46ixes: 998f70d1806b ("mfd: Add base driver for qnap-mcu devices")

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/mfd/qnap-mcu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> index 4be39d8b2905..89a8a1913d42 100644
> --- a/drivers/mfd/qnap-mcu.c
> +++ b/drivers/mfd/qnap-mcu.c
> @@ -158,9 +158,9 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
> =20
>  	mutex_lock(&mcu->bus_lock);
> =20
> -	reply->data =3D rx,
> -	reply->length =3D length,
> -	reply->received =3D 0,
> +	reply->data =3D rx;
> +	reply->length =3D length;
> +	reply->received =3D 0;
>  	reinit_completion(&reply->done);
> =20
>  	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
>=20





