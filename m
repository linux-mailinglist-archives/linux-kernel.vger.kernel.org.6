Return-Path: <linux-kernel+bounces-286356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C5951A00
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE69281722
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251171AED3E;
	Wed, 14 Aug 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="L32EFz5T"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C91AED58
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635261; cv=none; b=uLaergB1Iln7E/rPg+jRVWamSPvLx/fW4kthBEA2iHl2XAm8jtMQ00EaOY3C8QgrMXU0eTSpwe9oSRfNSh1fgvbqYSGR0JsjI4pFq1BsYOLZsK/5QyYUxCkXE1fxGwQDsXg2OoKOdb1YaJMPOrvvd0qd09Trk8mSWun5d1AZlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635261; c=relaxed/simple;
	bh=GtsydK3H2mtGrPUzBQhR5SKnRk+T0FBFM4LqeGBRGo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dvswCZnxv4gPMvxs9YY0QwSxUuESjw3rjJFZclblmaXDObzFfZe8honRm7Ha38eatEmMBBGKzxPQKe5WNepWzf8mH8aycEG6TGboZi5eJ+LHCa2GUZiPXD8sxPMd2Vju3BNX1mOFHB7VsCiL693JNSAvLFakAWYxEO085BKA+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=L32EFz5T; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1723635257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtsydK3H2mtGrPUzBQhR5SKnRk+T0FBFM4LqeGBRGo0=;
	b=L32EFz5TVtcaOdUG+wAtIwcfmqFVG2LtCUevJwpkq3iWmMYTxFjhkEZ+ntGpip+e7n8iHq
	/FH3z0mbJIs+h+eo7bCT1ANfJxfvur4eSKjehvO6xKhRWSRHsLhfb1ztveGGgdF+RjHIkl
	7F0mUEn0rH8TgJKCnG1WeVR6eKV5JciiB/dLiPlRwbrAWY+db43ncJK1ph8bb8wyD/nKYS
	aR2eKeZ8FqBOsVGI/qbtwFvEEC1mZTP+sKkTmDiFcTGFPHYQjuXVUq73GFK5CJK0Q82+KO
	gyehPgFFi+e3viVGyvBYi7UFS7xVxX7tXrUTMWOj67RTgC1bxnPd67stDYH3oQ==
Content-Type: multipart/signed;
 boundary=49f49828ccf4e026245bb992825ca7b630ee10042c0f52336e40d8fcb356;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 14 Aug 2024 13:34:13 +0200
Message-Id: <D3FLPC79YN2S.34PAJFECP21X9@cknow.org>
To: "Sergey 'Jin' Bostandzhyan" <jin@mediatomb.cc>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "Daniel Golle" <daniel@makrotopia.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for
 FriendlyARM NanoPi R2S Plus
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <Zq7LBqKVvVVVLg7a@makrotopia.org> <2309282.ZQ0cqP7t2B@diego>
 <20240814112138.GA21761@ветеран.su>
 <D3FLMBPACMF8.249JV2GI2QGHA@cknow.org>
In-Reply-To: <D3FLMBPACMF8.249JV2GI2QGHA@cknow.org>
X-Migadu-Flow: FLOW_OUT

--49f49828ccf4e026245bb992825ca7b630ee10042c0f52336e40d8fcb356
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 14, 2024 at 1:30 PM CEST, Diederik de Haas wrote:
> On Wed Aug 14, 2024 at 1:21 PM CEST, Sergey 'Jin' Bostandzhyan wrote:
> > In case you tell me to go ahead with a v3 set, should it be in this
> > thread or not? I understood RESEND's should be new, but updates should
> > stay in the thread, right?
>
> No, a new series should be its own thread too.

More correctly and hopefully more clearly:

No, a new patch version (series) should be its own thread too.


--49f49828ccf4e026245bb992825ca7b630ee10042c0f52336e40d8fcb356
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZryWOAAKCRDXblvOeH7b
biSVAQDc78xS+e8oE/At1dhcSqzFBPxTRCOkxyjn6j3XFmn7lwD/XOQQ3uHY5LsI
lh1vWwLCcz3GWt1nOikJztST3kvHaA0=
=oWIP
-----END PGP SIGNATURE-----

--49f49828ccf4e026245bb992825ca7b630ee10042c0f52336e40d8fcb356--

