Return-Path: <linux-kernel+bounces-170846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A98BDCE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC581C2311A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5E13C83C;
	Tue,  7 May 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fNwpQ7EC"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3013C825
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069011; cv=none; b=YEJ7kEkoPsGTej/WZoMuJ2mksfbqIXIiP05yJX7YqNe39vlNRPHhqSKtWYdQUt22LiJZQ97Q/NEsHq+441aTVBDwTv2jNNBDPDevOi36Qans15wewPOAkDSSd94gTxElV0WpD8slQ0tV2Dsrkz1jhmq93W5K5w8tCcGE3k2S1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069011; c=relaxed/simple;
	bh=vxTK/WdGHBVxGvI38+NcIIAAZ6xtmiWpTx2AFmt1GrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTGd5IwTuyZyRLl2GQ7t/KJMwWUykAECVVf8ZI9ZhJC+goiSC6tg2+2DcEXeY2+sh/CajTfH1BTjGJ6Sa2MkQ/K/qW032WBZwKfXIOE3MZw975v07f6xzcubiKw9JcyEjOjgJjces60Wc64BCcwwiZxifS+Bpx4XOXjM/alK8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fNwpQ7EC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 852B41BF20A;
	Tue,  7 May 2024 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715069001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Ei+DgII1ACjLBqbEo7/JpuP+L5JG4dJUUqKjECzuo=;
	b=fNwpQ7ECmfGij6EkQo/jw3zchLWtOfWIfA6jaF2G2SreFnwdb5UR/Tno9lxKR0sUuRWEQM
	oefoxxpMBWsmsdIpQmI6QxJJI7UTyFttalD4qWnKxVKcrorbjxQvGKaKJdxeIHAJLUE6O8
	reml2ByM5BXQfI7bpYkgIFPny2vYPhVWOUt5IsA4Q74JXjTaT8ar/zGqFbzDVn6c/kOO23
	UFcxittD1nWgPPDScwLL04VjLVyPoJpCPqKUNk/mJhJiJ+DNmol2fUzD/FJK9zXIeHidha
	WMIRWYKthKkM7WvAZzsCBl5sHnEUhruCiebAmpbZP+Nr15gPYnX7QyIL+FYtGw==
Date: Tue, 7 May 2024 10:03:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 imx@lists.linux.dev, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] i3c: Add comment for -EAGAIN in
 i3c_device_do_priv_xfers()
Message-ID: <20240507100319.04d8039f@xps-13>
In-Reply-To: <20240506164009.21375-1-Frank.Li@nxp.com>
References: <20240506164009.21375-1-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Mon,  6 May 2024 12:40:07 -0400:

> In accordance with I3C spec ver 1.1.1 09-Jun-2021, section: 5.1.2.2.3, if
> a target requests hot join (HJ), In-Band Interrupt (IBI), or controller
> role request (CRR) during the emission of an I3C address in
> i3c_device_do_priv_xfers(), the target may win bus arbitration. In such
> cases, it is imperative to notify the I3C client driver and retry
> i3c_device_do_priv_xfers() after some delay.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v1 to v2
>     - new patch
>=20
>  drivers/i3c/device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 1a6a8703dbc3a..b04a55a1337d4 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -27,6 +27,10 @@
>   * This function can sleep and thus cannot be called in atomic context.
>   *
>   * Return: 0 in case of success, a negative error core otherwise.
> + *	   -EAGAIN: controller lost address arbitration. Target
> + *		    (IBI, HJ or controller role request) win the bus. Client
> + *		    driver need resend this 'xfers' some time later.

			 needs to resend the 'xfers'

> + *		    See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
>   */
>  int i3c_device_do_priv_xfers(struct i3c_device *dev,
>  			     struct i3c_priv_xfer *xfers,


With this little nit,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l

