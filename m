Return-Path: <linux-kernel+bounces-220588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945690E411
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89C11F23BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84630757F3;
	Wed, 19 Jun 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bym2FTkW"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070074E0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781034; cv=none; b=YQ2z09lYbWTvwoCy0jyiumZCHbD/0Jrtr5pC6eouTkhmn3csBQy+yg3/dmNBOrxpFxX8/xB2hFLUzOwUopN0DQWTvJUQgun4UpInSBQ7EWdpGqF9gmYP67XqWWWb/ve0wx0T/UMwV0ZhU9y6+/RomHU57yfRNDlcmSnfnmOVIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781034; c=relaxed/simple;
	bh=+Y5juYbiYVPfmxaci7kMM+Wf55nqEx35suEP4/DlODo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzcMHv2nPnEEVXv4Fx8HgTnuSw2Rq8u40v4skoxxYop4olVef1UZ2g/fklmSlaUg7zSAFeP3vjPFC0O4DWw+yA7e60alukPENczqH3UP8AbaNkqrv674yzs/TSh0RneJFIyeX22XpROTFuG/YBx/g7MtLvfbR9bztLZTK/Px6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bym2FTkW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=h40K
	XelLRYCvulzSdUHa0NxctZhV6+tpDl8kEhBwYG0=; b=bym2FTkWXtuwwTmNq2g+
	XZCmuMKKJ3YsiyTLOX7rr75f7pbQkZUGuojs5wq5LkngRL63BA8oJD03PnhJb9uV
	UNY1sQG1OaPtR7cr7axqMeGI5HrUzMAnFHf7stTCRwuK/eGiSr4WRCv7BSluoOrP
	tGfOnN65u5GB0fQsVR28jjmPNgyTSv3okxFjJjCu4UQnTO+ldW/qYilwXI/JXHEM
	0X9zIB5fXsIrxuSaUw/rwn3fF0Hr6xQQk1QNOUw6O8rQcyFzYO1zURLAIMGIgTMw
	7YlK0vttqHX/4rWvpwo/Uh4LSE7KjHFuy0sWbJ116/wvwlvhgZB0Huar8yKDJahQ
	3w==
Received: (qmail 537824 invoked from network); 19 Jun 2024 09:10:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Jun 2024 09:10:26 +0200
X-UD-Smtp-Session: l3s3148p1@WFWK5DgbCOtehh9j
Date: Wed, 19 Jun 2024 09:10:26 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, 
	linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] docs: i2c: summary: document 'local' and 'remote'
 targets
Message-ID: <cu2mkl42byhce6eytcnw7yseogbnypgtrkoirlezakwg35egdg@vjjye4ca7yey>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614081239.7128-8-wsa+renesas@sang-engineering.com>
 <20240614081239.7128-13-wsa+renesas@sang-engineering.com>
 <4zxr4rlqnjqbqh3oxmd2ufqi6uk4pxa3tniuya5pgjtqi6tswc@utq4r2zt6z6b>
 <ed75fyc2xcsnwubq42eposf6ayt5aj2jmqz6mthugk6vm2zpi4@qqwlmuwayoo5>
 <y34k2k25xdr5z4v7oejp4da237s4o5qym5npihyydwlbsdh75c@vhmfl7sw3pbm>
 <7d5f800f-fc65-4fbf-adad-616d51501c62@linux.microsoft.com>
 <boehtgry7j7ulhrw7tenkmzxujahmxfn25imvb7zw2ibtmebbk@u3jryw4v2y7h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6e46fmxazdb334kp"
Content-Disposition: inline
In-Reply-To: <boehtgry7j7ulhrw7tenkmzxujahmxfn25imvb7zw2ibtmebbk@u3jryw4v2y7h>


--6e46fmxazdb334kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > "Synonyms" from patch 6 does say that controller/target is preferred but
> > couched it in the caveat "If speaking about I2C in general" and
> > adapter/client when "discuss[ing] implementation details." I was trying
> > to give space for an unambiguous recommendation.
>=20
> Exactly, this is what I referred to in my previous e-mails.
> These two statements sound a bit ambiguous to me, as well.

Okay, here is my proposed update:

=3D=3D=3D

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index 90f46f1504fe..579a1c7df200 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -67,9 +67,9 @@ Synonyms
=20
 As mentioned above, the Linux I2C implementation historically uses the ter=
ms
 "adapter" for controller and "client" for target. A number of data structu=
res
-have these synonyms in their name. So, to discuss implementation details, =
it
-might be easier to use these terms. If speaking about I2C in general, the
-official terminology is preferred.
+have these synonyms in their name. So, when discussing implementation deta=
ils,
+you should be aware of these terms as well. The official wording is prefer=
red,
+though.

=3D=3D=3D

I don't want to be stricter than "preferred". If someone still wants to
use 'struct i2c_client *client' this is fine with me.

> Maybe we are wasting time at discussing minor details, but I
> consider this part important in order to give way to the major
> refactoring that Wolfram started at the beginning.

The refactoring only affects "master/slave" not "adapter/client". We are

aligned here, aren't we?

All the best,

   Wolfram


--6e46fmxazdb334kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZyhGIACgkQFA3kzBSg
Kbay2Q//Q1yK77UKCLXDK3rIDeNYUcLVaQou3ZvpZlqe5aBdZ1hAYSOSG2hjad5/
m6GmUQYGwJpKbCRXPCNl6I533vOhUTkkqDYWNJyuX/sWT0+CUjQyOmRUDsx2Dnnu
yAzTftJqkq5nVp326T2uLC2TG2zkEVwUnxZGpaYCZfWuLohiqkxaYGiPN+kDsOTU
NKAkIofHa1v7gFZBEpWIQkUoAiOPqwIRpTmBw94VyfocItMA7cL+u3mO4Kaxmsyu
ZjJOZlv7uyGbeMQIwqR0cWyPeMlmNOxjf6rP3MglghRGqLKfrOSy/RotfRtvgMGF
3zGUYAqMKt08RVshN0rY1zlxWwMfqG7pKbykT7HtIf/b/uq2gbGoVuIqXFGU9h1H
LSpMWWYkgxOz+e03H2Oqs0YYjqGLY7Ur0ntKMsV/F55RavJO8Sy01SdEOctgb7gp
KJhEHKx4xNqlIR1oWv1m5mQEjldMI5Nj0NF1tZ6exAqRqdEWNVy5jM+LzMkfGkip
B/4MPYBtyNg1w/ZYo1up3fBwVcU90Q+HcEolyv+R9LnRC8+lAlN6j45T0EADx/gS
aFaGPMkuG4GpAanNP8PV1OYKfiWwLyBo59RRpDPAcEV/SshmkVdgYpxn8LFwKMYC
hWSdJHhJ4a4eHWPIS50dN/IzKzX9gQ4Cd0RVPN5On0nQY3m5oqI=
=Aen3
-----END PGP SIGNATURE-----

--6e46fmxazdb334kp--

