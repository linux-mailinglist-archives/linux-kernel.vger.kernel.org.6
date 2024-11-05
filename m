Return-Path: <linux-kernel+bounces-396251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF29BCA18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC60283FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEC1D0942;
	Tue,  5 Nov 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="jlwJqGnI"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5101CC881
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801715; cv=none; b=IDYp8264vlipWlvKMZeELtBpkgRJ/Lgs4u8FbAaQL5xtnBYye+RJoj78pbf7KOXHvEmtQ1l5MdZeI4ewdIqxyAtOaIpCc2uLh5sTZMgdpuSbEO42rX7n0sNbyViQrv1Zs0hzJqzyRnN0e3VTOlRy0ERjKM5sAPiupno0p0nLXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801715; c=relaxed/simple;
	bh=yCK/jIu4+/eQ9rMKru1nGfLzJOuNt5rtQEg1bUXqW+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BRKkWAnA5gH3BZWinFvgnjr+jA5gxLOYTlxd7ssDaiqeJ2+YYjSq4lvdPIrDCT1cFmNTr2vxhRC+WeyNaBuQzrg+uEfuw/sDCn0rlMCie0+NDCYNRP22m+uB4saxDk5ru+H34miBCsWDHUkXyIb3j5jWnbpO+mfLJFReWrbrIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=jlwJqGnI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1730801710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCK/jIu4+/eQ9rMKru1nGfLzJOuNt5rtQEg1bUXqW+I=;
	b=jlwJqGnI65jXo/ALzYwviSqMluhCblUHuyPkpfbw7J0MlzDjKKO4MU/HeOmMIqagmtxBOT
	Q3lT8Hl856211zWflv7K1PPflNkvKxouZk9aeNixjF9dcUoWXrK7wYE08aJbVnQdp2rNEB
	Sz5qHx5CMgh0cG/QYwaw/cfUIdoSmWHkohsG0OqX+vGFqUxUTWzc80NIWNRCY3Z21d1yYj
	BX2Oa7GahknL++kNPIagwYbQgCIxAfqRn1Z43pkwt25hZVrh62/YpQ5p2hCJch4V26T2k9
	Z+gUit/4PShCYcGcr8B3aH0wZPmm5jD2qu09XgnEF/0tBHDda0rCVMty3h90EQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Nov 2024 02:15:03 -0800
Message-Id: <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
Cc: <kernel-dev@igalia.com>, "Simon Ser" <contact@emersion.fr>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, <joshua@froggi.es>,
 <ville.syrjala@linux.intel.com>, "Daniel Stone" <daniel@fooishbar.org>,
 "Xaver Hugl" <xaver.hugl@gmail.com>, "Harry Wentland"
 <harry.wentland@amd.com>, "Simona Vetter" <simona@ffwll.ch>, "Alex Deucher"
 <alexander.deucher@amd.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, "Leo Li" <sunpeng.li@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David Airlie"
 <airlied@gmail.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Xinhui
 Pan" <Xinhui.Pan@amd.com>, <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which
 planes to async flip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
 <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
 <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com>
In-Reply-To: <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com>
X-Migadu-Flow: FLOW_OUT

On Mon Nov 4, 2024 at 12:52 PM PST, Andr=C3=A9 Almeida wrote:
> Hi Christopher,
>
> Em 03/11/2024 03:36, Christopher Snowhill escreveu:
> > On Fri Nov 1, 2024 at 11:23 AM PDT, Andr=C3=A9 Almeida wrote:
> >> Currently, DRM atomic uAPI allows only primary planes to be flipped
> >> asynchronously. However, each driver might be able to perform async
> >> flips in other different plane types. To enable drivers to set their o=
wn
> >> restrictions on which type of plane they can or cannot flip, use the
> >> existing atomic_async_check() from struct drm_plane_helper_funcs to
> >> enhance this flexibility, thus allowing different plane types to be ab=
le
> >> to do async flips as well.
> >>
> >> In order to prevent regressions and such, we keep the current policy: =
we
> >> skip the driver check for the primary plane, because it is always
> >> allowed to do async flips on it.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >=20
> > Should I do a R-b too?=20
>
> If you can review the code, it's always really appreciated.

I mean, I did review your changes, they looked good to me. I just didn't
know the protocol for reporting review in addition to testing.

>
> > The changes looked sound enough for me to feel
> > like testing it as well. Tested Borderlands Game of the Year Enhanced o=
n
> > my RX 7700 XT at maximum settings at 1080p165, and the tearing support =
in
> > labwc allowed it to reach over 700fps. No problems from the hardware
> > cursor.
>
> Thanks for testing and reporting!
>
> >=20
> > Tested-by: Christopher Snowhill <chris@kode54.net>
> >=20


