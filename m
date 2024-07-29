Return-Path: <linux-kernel+bounces-265798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833B93F618
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675FC281587
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42A14901B;
	Mon, 29 Jul 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RmZ9YGTy"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E231465B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258200; cv=none; b=fq0UI1FtgxmyYnj5cj6+WnweEdWRDxoIOGS9Hun920YD4NCwaB635ayJbZDTkSmdmc5WKD4Rq4hfsG3yOLWacwjkIxx9vGs5jbxJNmcFdfoI9qzJinWzkwxSJp1IvXZnPO2Www3iiheOErnC6XfxKLkURriWWtfKE9eurBWjuBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258200; c=relaxed/simple;
	bh=Dj7bP9sSC3CrTfSJAxRjp0FSlhqS+U7DUfQIpJIUFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsm74HYTsKzd12AdZvQ0lNRj8Inx8h5u++5CKdEqwAeXTs+hFnVJxO5W3xuYYEKhs6UgiTVIxrW+294EKAuXbY5Gyu6qTzgGSCGiLX0YicK53DcRxW0kKryGrUJuv0J7kV9qBvCMURadFX90Krd4klZKcuor96KDmeeR6Lrw1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RmZ9YGTy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7Fa3
	FvYszI2v7tZhjSBxOKf5nK/7KsdWSyZ8VQRbAyE=; b=RmZ9YGTy1Lql42Nce0XQ
	DCxRz2HxWnTwXJfgPaI/CjbbhJlxrcGTP2v2+BileckUZRVtHwmyvYYZ+GF4sA/T
	jPNJUNvhpGn9wpbmDQJctHb0vzURBBt33iYrjt/NxsadNySKffvqdAQ2LGwqhyCY
	nlsGFq06rT1bqOBUn/s9i76a7gzupMZ1XZ/rFG08uxGULDn8lIzcries8WqLiH/a
	qdwYiMYNFzKRQIeT7Z9aPQOeelP+XwOKscd885b+NoGjfiEUuVxj2asd3tsCH47R
	Tvmxsu+BcwUe8QUgryD3QNdLaMZAhLVHTSGQQgCIy3hF5GvPUrvWluqAJKnbNSaj
	wA==
Received: (qmail 4110312 invoked from network); 29 Jul 2024 15:03:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jul 2024 15:03:14 +0200
X-UD-Smtp-Session: l3s3148p1@8AjSe2Ie+15tKPFk
Date: Mon, 29 Jul 2024 15:03:12 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update email for Konrad Dybcio
Message-ID: <ZqeTEGVjMD0VqRRx@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Konrad Dybcio <konradybcio@gmail.com>, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20240729125225.2090-2-wsa+renesas@sang-engineering.com>
 <a1ff72a2-7992-4ebd-b48b-2bb85335edaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/FJwCOto+3YIJsnZ"
Content-Disposition: inline
In-Reply-To: <a1ff72a2-7992-4ebd-b48b-2bb85335edaf@gmail.com>


--/FJwCOto+3YIJsnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konrad,

> Already sent a series of fixups, but thanks for keeping track

Welcome. Cool that you are at it!

Happy hacking,

   Wolfram


--/FJwCOto+3YIJsnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmankw0ACgkQFA3kzBSg
KbauLQ//VGH3tiB3g4Zj5iz7b/4cBTixu6XyY7JOrDL2k62xzR2eUiDzJEdR3kP4
p8umhzW69kiEqeOP1CWsGMNfJ5ypd99zrAevJYo5w+YwFeFLofb4oeI+BqUjIlVL
GsFD9KKW14EbRRk1oAELInqkfNCH/0SDWKq/6fpSPmke6Qzwei2VeASua8XtoFp7
Fw8HMjADYi2I0B+EpkL4yzjckLfafmgdtpwrpCWL5hSQ8xKuevEM/OGt+LTTh7lO
vz7Gm7llwr9IZBxe9sVK0WPxs2oPAPhhuwbk9W++FKF7kGcid2QHg2S3zz4MfVSa
7JRGwTGusGpNkmRRpew5033VJ8c1UXYcSRxaEtMYnpoU8F8U5g+TDKzvhkVBofin
aTvK+YdU9+TBzceM/qqfXusoSxvpo6sgNEWrgz1MCg8iSMuygT+G0NK4UCcChSTD
Ys6QTV10FI5cF4CsNEYTDFOnhALtnq68D8wWMIG5Gsn6Wkpazsg+IeYwmNV6pnG5
pVrUeM7ETz9/7xoyRDMc4aPEZjNtzy+uB1STUEb50ag/NbhX9EjO2C7U7BIinCzY
pzvAWFH/cCm8o2yyPSt/3ifNAKe8//lJq9zUZ6c+adHr3GHnKCeO3bjhT15ZrQbR
rs7xewbujhdqeD5jhrkLFyzIttjRVK/Tnn03cnEnFUl9biTKV7I=
=44Db
-----END PGP SIGNATURE-----

--/FJwCOto+3YIJsnZ--

