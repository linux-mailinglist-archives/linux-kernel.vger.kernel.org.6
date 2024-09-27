Return-Path: <linux-kernel+bounces-341936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF104988893
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E082821F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D01C172D;
	Fri, 27 Sep 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="q2K/+3Qa"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADE18B1A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452429; cv=none; b=PyxiZjDa3VsApGIacUBsoZUpDyZ92cdDhFUkWhn/HH/DW7J/MHIwLm8TiwG4UPcVaCUix2aUJ1OXF25TV78v8tSURxRB8xQdgbnIznlGs7pnrBd9oDj16RNJSE4xJwtlahNBQhtyuKQwxzRlSsKQY/TNh86o68wt+I0IxfMnyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452429; c=relaxed/simple;
	bh=m73kTn1FiOVjNDuAAijNwcVvwqRvcR31r50qp6jVgys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QAMBujiyfZxOvMf0eky4NEIam8OaNIO5G/F+/llSbvFDIFNdLn0FR/kPjBZ2elNJtmGP5+jSycS6y+xSG2Z4+BjD+aeGbDVmS8a7qn1Hql3K/JFYofTeAO7flTTvlNHqH4dFMWU7HuPPyj/0ZbZ4IC5NpgT3aKfyjgNuSF3hubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=q2K/+3Qa; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1727452425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrRWjp70LLWukpDeEqzl+DxRbjw0dZRDDnsvuRSCUtQ=;
	b=q2K/+3Qa8JVirMw2MrvS1IurBVxTV8aniXUYcR128zktaKIt49wkqyAXjA46A7Rtpy3+KI
	/8l7e/RGJBEGWVllZhGJyG+hZiGZ1JsDvluO64z5dT+4UwKUHcJ13cSg6mul9rgI+fmXxN
	3D5LJxljlR9E5gvkkEK27QBqDsI9m1dSetd/tl/wpITDDQawgG1CtgvlRzBRI0axIndXkq
	39pKeIiX1TR5NZEthnCvVKBXRUe3lbRIZa98oFEzqS56DfRfxl9hu7vU/OFhJLmnzIMIX2
	fQ/h8s+G1mzzYucOEIBD3EKcpZMJQ6ej3SB4FIZ5gTvhDClwXAD2u6KFDj4YLg==
Content-Type: multipart/signed;
 boundary=b8bd27bd84e1265222b75fe1216dfdabde64cd8d460f647eb948bcb0026a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Sep 2024 15:53:37 +0000
Message-Id: <D4H6RX1ZCSQ8.1BQ8LW44D65X1@b1n.io>
Cc: "Florian Schilhabel" <florian.c.schilhabel@googlemail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Xingquan Liu" <b1n@b1n.io>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
References: <20240927151637.82772-1-b1n@b1n.io>
 <9bf11c06-85c7-4ef0-ba26-e4780a28f23c@stanley.mountain>
 <D4H6EYM973NS.13D8BVWVTVO2D@b1n.io>
 <75267b21-f800-41a5-8a7a-ddbf0062ffcd@stanley.mountain>
In-Reply-To: <75267b21-f800-41a5-8a7a-ddbf0062ffcd@stanley.mountain>
X-Migadu-Flow: FLOW_OUT

--b8bd27bd84e1265222b75fe1216dfdabde64cd8d460f647eb948bcb0026a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

On Fri Sep 27, 2024 at 11:45 PM CST, Dan Carpenter wrote:
> Greg doesn't agree with checkpatch about unnecessary parentheses.  If the code
> looks like this:
>
> 	if ((a == b) || (b == c)) {
>
> then just ignore checkpatch.  However if the code looks like:
>
> 	p = &(foo);
>
> Then change it to:
>
> 	p = &foo;
>
> This sort of change would need to be split up by driver instead of all of
> driver/staging.  So it would be a series of patches.  You don't need to split
> it up by file.  Split it by driver.

Thanks, this information is important.

-- 
Xingquan Liu


--b8bd27bd84e1265222b75fe1216dfdabde64cd8d460f647eb948bcb0026a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iM4EABYKAHYWIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCZvbVCFgYaHR0cHM6Ly9r
ZXlzLm9wZW5wZ3Aub3JnL3Zrcy92MS9ieS1maW5nZXJwcmludC8zMEFGMUFDMDcz
MDg5M0VEQzE0OUI3OTVCMDA3OUIxMkU2Qzk4RUE2AAoJEDYjUsMc9adecmsA/1CT
ARv7d7BNP8jqMV01kDzfhh6aMo18uku1ssSaCCm/AQDxRh6mwE9BIwRfYM85Iu7F
GHZ/mLrhGgDY9tQ7kGJaCw==
=0GIo
-----END PGP SIGNATURE-----

--b8bd27bd84e1265222b75fe1216dfdabde64cd8d460f647eb948bcb0026a--

