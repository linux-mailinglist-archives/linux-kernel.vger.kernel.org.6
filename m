Return-Path: <linux-kernel+bounces-341920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60B98885E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B13A1F21E48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAF1C1724;
	Fri, 27 Sep 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="GX5uzrKp"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B034A2D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451414; cv=none; b=lCkOrvm7XGltRoy9U8J/pzRoi+sQdwo1tZNNmZJ8R4fvyh+479ryiXM0nT/7LTYREGz3QI49nr/NQaM7XsIgEWz4cnblYGTyl5QcVoJA3xuK8/SRN/VNs86C92mKvhS+fXzoX3UMThUsf9mTzmSQVqj3ACK/bCDNa1A2NWFSlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451414; c=relaxed/simple;
	bh=2XzSmEIxMqOQJGajVpkx1LKfnmWIqcrtVNjWVSFDLNQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OwTfjHIpRjKa2YpDHyTePk4Xl4wFPXsZ0Va0xOEWLFSGo02NJLWl6UKyDswaDIkgnBi+X3NRTlyrlA6QKzTozZdshmkLJf6s09eBy9FzMayaD1yhqxE45Ks64eauFW3bOpNTUvqCxexwcOsiEvzWsEwsQZlwn6R1/MXKHEDX15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=GX5uzrKp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1727451410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWOCtZNHvExTJWPl6zOcHCnalrg6dlIXoMXlsDqnC40=;
	b=GX5uzrKp5jR6NC0HbC+LOiRUlHdU49YqYBb3pM8Xw2NtxhJEr7NX+Bdy8wJwiqa7nTepgC
	4TEaBKlCbrX5Uq3aF2MJ15dKQqoGrVPzQm/Q5/KIYaebNgCsO6KNJoUC8a2LWDQQKZutKg
	h5qdMa9nRKwqQI/UpMTdvB1s8QL0e6DUYYvu/1MHHrHVGjKH4jxz42BAVZ+y1kWMVcijDo
	ahxSSemdPFXgwSEtzP662cj5gaouUSdGj2yJ6BdXtpLmoQOsuhpnnD8FgSmlRWMQfStcBL
	fK87VNNqjbvcMLeHOTktdPiyB15CKJkl3xPIB/atpi4mxE2WvmjT0s/9dkOjyw==
Content-Type: multipart/signed;
 boundary=fc626e4455c1f108b7a81f84b9816a2fb7e07555a83fb72b408f50b05b4f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Sep 2024 15:36:42 +0000
Message-Id: <D4H6EYM973NS.13D8BVWVTVO2D@b1n.io>
Cc: "Florian Schilhabel" <florian.c.schilhabel@googlemail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Xingquan Liu" <b1n@b1n.io>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
References: <20240927151637.82772-1-b1n@b1n.io>
 <9bf11c06-85c7-4ef0-ba26-e4780a28f23c@stanley.mountain>
In-Reply-To: <9bf11c06-85c7-4ef0-ba26-e4780a28f23c@stanley.mountain>
X-Migadu-Flow: FLOW_OUT

--fc626e4455c1f108b7a81f84b9816a2fb7e07555a83fb72b408f50b05b4f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

On Fri Sep 27, 2024 at 11:26 PM CST, Dan Carpenter wrote:
> On Fri, Sep 27, 2024 at 11:16:36PM +0800, Xingquan Liu wrote:
> > Fix all unnecessary parentheses warnings in checkpath.
> > 
> > Signed-off-by: Xingquan Liu <b1n@b1n.io>
> > ---
> > I ran clang-format additionally because I noticed the Linux community
> > recommends submitting code formatting patches along with other patches.
>
> Probably avoid running clang-format.  If we wanted to do that, we could have
> done it already.

Ok.

> > 
> > I'm not sure if there are any issues with this.
>
> This patch does way too many things at once.  This is a long way away from being
> something we would even look at.

I wanna fix all unnecessary parentheses warnings in one patch, is it ok?

-- 
Xingquan Liu


--fc626e4455c1f108b7a81f84b9816a2fb7e07555a83fb72b408f50b05b4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iM4EABYKAHYWIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCZvbREVgYaHR0cHM6Ly9r
ZXlzLm9wZW5wZ3Aub3JnL3Zrcy92MS9ieS1maW5nZXJwcmludC8zMEFGMUFDMDcz
MDg5M0VEQzE0OUI3OTVCMDA3OUIxMkU2Qzk4RUE2AAoJEDYjUsMc9adeydsBAPxJ
DCRl/pmfskFaU9/lrbWXNc7HonDmcJXlEQqlDcDuAQD3u4d2p3Lclerhtz27Fa7s
x72euY6lrOaaBh2AaHWVCw==
=bM16
-----END PGP SIGNATURE-----

--fc626e4455c1f108b7a81f84b9816a2fb7e07555a83fb72b408f50b05b4f--

