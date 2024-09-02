Return-Path: <linux-kernel+bounces-311180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436AE9685AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35F4287472
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2801D61A8;
	Mon,  2 Sep 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scrumplex.net header.i=@scrumplex.net header.b="CRTnr98n"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE3185B56
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275003; cv=none; b=eSjd4NNptS8tvBQRVTP2VtAUYxgIjIX3vN3iCs5Wn5Qb+NxA3DGV6TWkUMB7ZnT89+80gu82B/Dyo0VAekE5FA7yGYj4VclkIgXtMUXTAOtRXubtB3g2kiEJdxb0OZYMHIhyU9MPQbyKkxGk8F77mwXfmYWYCdYDeEUw2aCzrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275003; c=relaxed/simple;
	bh=yKAniYDup19w5bAb3ijERiqyFUkCRm+E0lzkWj4PpUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZjfQPDVz1MhbPeyYhPTRZeAPpf2DLfldAYkjfX5ct4XOVW90bju2tSC7ypELdIgF85tVY5MIraUY83Dua/L3QiBQfeBqPyFWPttTXFkl8RxbmTqdo3Ye1bHluEtBbyRX6ydMsUEWlvHrzyhCRrXhjcR1uHV2WVRJm5hYWXmUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scrumplex.net; spf=pass smtp.mailfrom=scrumplex.net; dkim=pass (2048-bit key) header.d=scrumplex.net header.i=@scrumplex.net header.b=CRTnr98n; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scrumplex.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scrumplex.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wy5TH6gX3z9s51;
	Mon,  2 Sep 2024 13:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scrumplex.net;
	s=MBO0001; t=1725274996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdI66KMK6lKhDVRjj6ESMSKTeCR8cIAJ7x8sCBJ8p6s=;
	b=CRTnr98nw7pds/oHETJD0m15GVJcfwB9251OxIppdHCb+wdDhCsExhLZspVq/p3N/6wIsV
	oHwdG9TxuColVJPT/cm+dZljkAwcXOyzPwyeJmOEt4D668Mv1J7Z6f2KAqzOuBYRJVJU08
	Q77SvdMEIVmexfF4FFh3P7Y6AqYuAMqCfYGY3TrLEbY5xcOB8WPyJ7dX1srk4dimigdTS1
	xxqwlOtk8ZpfojqMtQvtJj7xIjqT3BTpkfL3xJhk0H5tv80qB+DYqHBmoYZC/pdNnuJZOf
	h3DN391yaH5/J3vSV5fWS6r2LY7Qmqbsr2d2TEdwFOKKpRiix3DWz5hL4jSrNQ==
Message-ID: <62065e7c858ed2d532543d6defaac22f69f3f1e8.camel@scrumplex.net>
Subject: Re: [PATCH 1/2] drm/amd/display: Avoid race between dcn10_set_drr()
 and dc_state_destruct()
From: Sefa Eyeoglu <contact@scrumplex.net>
To: tjakobi@math.uni-bielefeld.de, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 02 Sep 2024 13:03:07 +0200
In-Reply-To: <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
	 <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZxEGB9cY50KrDsfsrhPG"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZxEGB9cY50KrDsfsrhPG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-09-02 at 11:40 +0200, tjakobi@math.uni-bielefeld.de wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>=20
> dc_state_destruct() nulls the resource context of the DC state. The
> pipe
> context passed to dcn10_set_drr() is a member of this resource
> context.
>=20
> If dc_state_destruct() is called parallel to the IRQ processing
> (which
> calls dcn10_set_drr() at some point), we can end up using already
> nulled
> function callback fields of struct stream_resource.
>=20
> The logic in dcn10_set_drr() already tries to avoid this, by checking
> tg
> against NULL. But if the nulling happens exactly after the NULL check
> and
> before the next access, then we get a race.
>=20
> Avoid this by copying tg first to a local variable, and then use this
> variable for all the operations. This should work, as long as nobody
> frees the resource pool where the timing generators live.
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
> Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while
> keeping DML and DML2")
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
> =C2=A0.../amd/display/dc/hwss/dcn10/dcn10_hwseq.c=C2=A0=C2=A0 | 20 ++++++=
+++++------
> --
> =C2=A01 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 3306684e805a..da8f2cb3c5db 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3223,15 +3223,19 @@ void dcn10_set_drr(struct pipe_ctx
> **pipe_ctx,
> =C2=A0	 * as well.
> =C2=A0	 */
> =C2=A0	for (i =3D 0; i < num_pipes; i++) {
> -		if ((pipe_ctx[i]->stream_res.tg !=3D NULL) &&
> pipe_ctx[i]->stream_res.tg->funcs) {
> -			if (pipe_ctx[i]->stream_res.tg->funcs-
> >set_drr)
> -				pipe_ctx[i]->stream_res.tg->funcs-
> >set_drr(
> -					pipe_ctx[i]->stream_res.tg,
> &params);
> +		/* dc_state_destruct() might null the stream
> resources, so fetch tg
> +		 * here first to avoid a race condition. The
> lifetime of the pointee
> +		 * itself (the timing_generator object) is not a
> problem here.
> +		 */
> +		struct timing_generator *tg =3D pipe_ctx[i]-
> >stream_res.tg;
> +
> +		if ((tg !=3D NULL) && tg->funcs) {
> +			if (tg->funcs->set_drr)
> +				tg->funcs->set_drr(tg, &params);
> =C2=A0			if (adjust.v_total_max !=3D 0 &&
> adjust.v_total_min !=3D 0)
> -				if (pipe_ctx[i]->stream_res.tg-
> >funcs->set_static_screen_control)
> -					pipe_ctx[i]->stream_res.tg-
> >funcs->set_static_screen_control(
> -						pipe_ctx[i]-
> >stream_res.tg,
> -						event_triggers,
> num_frames);
> +				if (tg->funcs-
> >set_static_screen_control)
> +					tg->funcs-
> >set_static_screen_control(
> +						tg, event_triggers,
> num_frames);
> =C2=A0		}
> =C2=A0	}
> =C2=A0}

This fixes the panics with my RX 6800 XT on Sway with VRR enabled!

Tested-by: Sefa Eyeoglu <contact@scrumplex.net>

--=-ZxEGB9cY50KrDsfsrhPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQThcyN6x4IpbZj1razhPf1LRxJ5UQUCZtWbawAKCRDhPf1LRxJ5
URouAQClbMaSkmkbxtKXPZ/lGXFoSSzNd2gpI6XFdv7BbYP7ggEAtVhhKRf9EXtg
2ctl7Tt+Kr6WVn5mddDd2YbJyqWJGww=
=h4TA
-----END PGP SIGNATURE-----

--=-ZxEGB9cY50KrDsfsrhPG--

