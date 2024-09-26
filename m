Return-Path: <linux-kernel+bounces-340458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9719873AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB631C225F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1393F9FE;
	Thu, 26 Sep 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="srSWgb2L"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283B4C66
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354120; cv=none; b=VCqMeDts+i6uk/gTFc2uIsSXAGfkuVqR3RfSXCUwmWrW12CVTtRN1iNNrVz5WMoNllv1Fd+XO/IOsWP251T2Lp93qbHoxHcm10iiPjUVJKhYtxjYr0h1CczLZG+nAKfB6wUQfpbDt1AWTUURDiNScT9WTHOLLX0yL7QLh8UpzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354120; c=relaxed/simple;
	bh=xqTm2IU401BGZSwAId5NTjaL5szRhRxRZiEZYPgJUQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=V5CCOplghUDLTKsyFDueA/9F15ioLE34iabyLvspvlcLGzmm/h2GgESh3e2MbKu+e/8jixU9AgpfeIKaayWftyevGv1gUK32vIdJhmuKm0fbOtaHKZ1GPcFYJGlfMR2ahTeOCB3G47gkhjieKlq2Biw/6w7UMXX26MFSt+hG2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=srSWgb2L; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727354114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6Udtso42v7GuUf6mlt75M6dK/iDKNUeKUeov5Ey7C00=;
	b=srSWgb2LAyDQnMKdr3ZLmz8RWHUml1H/goD1z8Q+fBIwUBAfp1V3vzY82bjxq4lOm3hxhO
	rg4aLgs0uPJFBAZezWLM1XKrGN27XevS6DuPblSV1Iv/9ZeEngwhIt7IJq1Ld9I8sYL7c3
	uUGwdQJtf4bT0/CXydBJt4zO293MP1KLkPI+g0RVnckcW0LvXgDnB9pAS0p/8D/IAHzLT6
	Bu+/HCD726icWyaHhbg5j5FnIoC2MHDLy7d/iAhMZ8pdQYx+hBKDbW0mOFM2pQLvANEO+S
	7JZpusPoDJ/EaR5ZiHWb7U1mTHkyVlIT4ANyV8BRD/YdOfbBPnH9xkyIeP6jfA==
Content-Type: multipart/signed;
 boundary=fb000acc6642996efc1bdf45f79306aa5ed858aba5d29912cb80ee88566d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 26 Sep 2024 14:35:05 +0200
Message-Id: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
Cc: "Armin Wolf" <W_Armin@gmx.de>, "Guenter Roeck" <linux@roeck-us.net>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 <linux-kernel@vger.kernel.org>, "Diederik de Haas" <didi.debian@cknow.org>
Subject: Error "ee1004 3-0050: probe with driver ee1004 failed with error
 -5" since 6.11
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Arnd Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

--fb000acc6642996efc1bdf45f79306aa5ed858aba5d29912cb80ee88566d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I updated an amd64 machine to (Debian's) 6.11 kernel and got this error:
``ee1004 3-0050: probe with driver ee1004 failed with error -5``

which I didn't get with 6.10.9.
If needed I could do a git bisect, but maybe you can already directly
tell with commit would've caused this?

If you need more info, please tell me where to get it as this is a
(relatively) new system and I actually don't know where the eeprom is.

Cheers,
  Diederik

--fb000acc6642996efc1bdf45f79306aa5ed858aba5d29912cb80ee88566d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZvVU+wAKCRDXblvOeH7b
bq+SAP9MqGFgIVFhWWdVkGW61p4I9dahmNMHFPG7tJhiNONXdAEAx2Q+GAZRb7Q1
yEa1cag5ARFAOibeTfXdsvVDX99fKQQ=
=Lp/S
-----END PGP SIGNATURE-----

--fb000acc6642996efc1bdf45f79306aa5ed858aba5d29912cb80ee88566d--

