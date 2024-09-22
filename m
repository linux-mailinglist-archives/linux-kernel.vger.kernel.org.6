Return-Path: <linux-kernel+bounces-335034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAAC97E027
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8474F1C209BD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9F746E;
	Sun, 22 Sep 2024 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="mK1COd1i"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C113F43E
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726980432; cv=none; b=BGJ7mVRsi+2JaWhShSHK68bBCbmwcB2194deg68jb76Hb9uC6EcqVrSyP8jZVrU7mEV/OmMlJOE6CY8I8TOh6jw3CMVBurCjxb2htAv1fxeav1P+eZgGJMZbUiC6fhMtBLRXEpb4+9R3sDfRhV6qFcN/84KTY6uC666VleBL5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726980432; c=relaxed/simple;
	bh=3AxrJkZSCvpu2QswkaoJvXrEe3R/d4sZXhjfhtlY7MY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=vAHbFMdIxiBTjKojR6XTcifOArwy4sHG6QYYEB31xMbUIJNiBpRb3I0+o96rGQNwPZBxrZvU7kRGClA267+NVD1sxWsNsqFgwjoj/ldr4GZj0W0j99Y9bjcg11VQzqgxM70aMrbURDOfgwRpdnLTYZVWHUu6R6a2uQ2r+mCXgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=mK1COd1i; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726980427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxQyxCAuVBZrfiF5eft7EVLOqBClYzYAkecO5nQExFg=;
	b=mK1COd1ibpugHtXi0xlsi1ITjTOcXuX2mPKjNumja8oDkf8Zvc1sQ5dMdOj93/syx2NEjg
	PC/EfKJLchmYbJkSkSgwomQ7sSWJsNnF8UO+BFGP2zylbV4u1WTeu7+V2yjXVNssWnSM4i
	KCV261VBX+/EQuuyWfXFIwFvQnjWxixCKeD70s6F7Afo+5KA6NNYCdrrbZTNOqscyGkc+/
	hQmi5LLLBJYy1TIzvVlVK4MgXBWcDdv3mJxUGmcpR9lm5Kfth6YZAEcFadwhBzIHPFG1Vd
	VC4UXkB9HRm2xkNka3vxTYVagvMyg7o4BhZmg+eUR3MdcEEucS+U3RoeyRYNsA==
Content-Type: multipart/signed;
 boundary=7447cf5d295afa9f6e73ac259aa2fc145734e23f40bd4384c0e721050913;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 22 Sep 2024 04:46:59 +0000
Message-Id: <D4CJGS1HHGX4.3TQ3II37GY5QT@b1n.io>
To: "Philipp Hortmann" <philipp.g.hortmann@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] staging: vt6655: Rename variable iTDUsed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Xingquan Liu" <b1n@b1n.io>
References: <20240920162025.31465-1-b1n@b1n.io>
 <20240920162025.31465-2-b1n@b1n.io>
 <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
In-Reply-To: <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
X-Migadu-Flow: FLOW_OUT

--7447cf5d295afa9f6e73ac259aa2fc145734e23f40bd4384c0e721050913
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

Ok, thanks.

-- 
Xingquan Liu


--7447cf5d295afa9f6e73ac259aa2fc145734e23f40bd4384c0e721050913
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iM4EABYKAHYWIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCZu+hS1gYaHR0cHM6Ly9r
ZXlzLm9wZW5wZ3Aub3JnL3Zrcy92MS9ieS1maW5nZXJwcmludC8zMEFGMUFDMDcz
MDg5M0VEQzE0OUI3OTVCMDA3OUIxMkU2Qzk4RUE2AAoJEDYjUsMc9adeE6YBAN+H
xwvoemllyoXxx29F8htwcMJi0FZNrwD0tyH8WzPgAP9mpNe9zKUqVwaLzQdXSvvU
/j3XKSQtXYofiaYkseJKAw==
=s4tT
-----END PGP SIGNATURE-----

--7447cf5d295afa9f6e73ac259aa2fc145734e23f40bd4384c0e721050913--

