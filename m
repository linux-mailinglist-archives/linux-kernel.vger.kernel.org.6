Return-Path: <linux-kernel+bounces-367678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287C9A0542
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9651F2613C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAF20514E;
	Wed, 16 Oct 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dTwXUxgw"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94851D90DD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070456; cv=none; b=Cqt6BX5joOLaHo5sU4zrD9n6SWW9/LSoVnsG4/7Z8W9ZNigzd0VotF3VCP/L7AH0BTLXSO/SUDcQddX8yYhvpOew2yO5jCz3MesASq1NPlOnb8fMC9U/9JftKAEgo+trzAcqABL9LhruC8xJVnL70ooYY374/GWC7AX/OWb24uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070456; c=relaxed/simple;
	bh=ASnhTiI9Zj4VlqH3e6Vrg804fSxhSb+KIGUHBuAcIbI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GAkS8l4sd9RfoPm0mJQu6q66eVvgEIJ7VlfkHVMvtjebvXmbi/DgXjCqi344cMhBaC+t+zWPuNRaQvE+Ap6kRekCWEPcRZankIG/VtI9xih1FeAYTMHOKeAv/bgjl/0MLMgFC3zVqetYqron9gX+pA/Lrb5Hc7s1Gvzr8cpMOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dTwXUxgw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729070451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASnhTiI9Zj4VlqH3e6Vrg804fSxhSb+KIGUHBuAcIbI=;
	b=dTwXUxgwWOSp/7cSq8f+Q9BrSVJvBcZpuWiRO/C0MuMXqKEy65LUdMFhyugjkPuiaKQX+J
	XjcYVNA0Y2k03FXkPsghIoowCYUlgBDrEoW4XEybvokiVsAyLuVorWOxlD7DHgIii2hniw
	CDLA70L/+bDiZRl/Kc/vXFA5BHJ3ZMNeccgsSOae5TJhiwckMViYuMGOaR7C9NI4RUIQ5Y
	Ufy0KDNdklLmEWtzDW3b9g/PTcscWmYM25j4SQR720pEorD03PNfCcxsCTtzMlc6A1j7Xe
	RfEUbXtSqypKLmD1EW8n6id4Q4C+7a/TNvnUNyZYAY/4umYI49rl3u8DB5c3cQ==
Content-Type: multipart/signed;
 boundary=39b5e2c23b7ab15aaaaca0434076be4b6e0bbab25d73def0f3a97a2bb909;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 16 Oct 2024 11:20:39 +0200
Message-Id: <D4X4BE9PTJ1Q.2TDYBLWRFYMYA@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Piotr Zalewski" <pZ010001011111@proton.me>, "Andy Yan"
 <andyshrk@163.com>
Cc: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <skhan@linuxfoundation.org>, "Daniel Stone" <daniel@fooishbar.org>, "Dragan
 Simic" <dsimic@manjaro.org>
Subject: Re: [PATCH v5] rockchip/drm: vop2: add support for gamma LUT
References: <20241014222022.571819-4-pZ010001011111@proton.me>
 <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com>
 <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me> <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me> <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com> <QvjHFQ4xeCu-8Isrm_jtNRWLowVNFzC8qnHJ6LUGI2iFTTJoEK8fBrXjG9LUrn5Wt9fJ9F04ukEf-koifwCR0uH9nr0AelyiWI85KASNkOQ=@proton.me>
In-Reply-To: <QvjHFQ4xeCu-8Isrm_jtNRWLowVNFzC8qnHJ6LUGI2iFTTJoEK8fBrXjG9LUrn5Wt9fJ9F04ukEf-koifwCR0uH9nr0AelyiWI85KASNkOQ=@proton.me>
X-Migadu-Flow: FLOW_OUT

--39b5e2c23b7ab15aaaaca0434076be4b6e0bbab25d73def0f3a97a2bb909
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 16, 2024 at 11:16 AM CEST, Piotr Zalewski wrote:
> I will rework it to[1] and test it. (Have to check if hdmi out on pt2 wor=
ks).

Last time I tried it, hdmi out did work.

--39b5e2c23b7ab15aaaaca0434076be4b6e0bbab25d73def0f3a97a2bb909
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZw+FbAAKCRDXblvOeH7b
bjJ/AP9HFSyCMdeIZVb5Xx2YLeCvCLYIdCd+0plBVEZMy44IyQEA7w7WGs8+Eh2X
6nE2wlGoI5H/WUG0o0By0qK9bgse/gs=
=BmBs
-----END PGP SIGNATURE-----

--39b5e2c23b7ab15aaaaca0434076be4b6e0bbab25d73def0f3a97a2bb909--

