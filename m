Return-Path: <linux-kernel+bounces-397621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D479BDE26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB431284DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485C19048D;
	Wed,  6 Nov 2024 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="niRMnD/A"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92117BB1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869467; cv=none; b=PQ+nxLPKT1rZwKGcOdHPAJBKfKBNK895Q/0QkH5PVVrpY8fAg2nKfo+k9vrxB9wPxBy0p7NcjAKNbpFXcnzmXpk62zZPqW+Ec3nHO9QUhD0smIEIQ6cVIG7caMiLPWNo6xK+3r1qhDF+HCWwCgyuOam/wgiEqFZDHLu4U5y3//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869467; c=relaxed/simple;
	bh=HU2FgKEr1fhOjtgslxIdAEo3xX+OzWXmdwVSvh7wQrk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AaZx2dZ0IfpjjjWBBfAlg0hYURSaeT1YDhVBf2VAi4n+6t7CLqhi/Favgf6qXcKmC6WRS/PffF1V7rmv3SZ6IBv0BL0VI/SAyA4ZZtMNpmMG89S1LIT3Fodv/6pQTEKvAsGI3pC3hH5CSoFWXalbHbuJNcuTHKe1lJCGICZCQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=niRMnD/A; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1730869461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU2FgKEr1fhOjtgslxIdAEo3xX+OzWXmdwVSvh7wQrk=;
	b=niRMnD/A6eZ6rUQyFxKiXIPVFga8PQ7mvS3yX8P5oK41TiTdgDrvGy4n0N1KsWMaSRJATC
	iwyanom3nmNGGh1mO+zWBJsgjpRjnAPP8FNXK0qz6OUUfG2PwgwrD4yV/qZMEDywSYZBcp
	nxh1kMB42C81RMbnr9bYgAeLb07pKwU0wxs3ZX5TgksGmkdRAhMAIpHMn1Lk27ZNnyfpiU
	zSMDSKrcyy2Z1whmplJqjZYmxpA8MeIxAdJXAeIBgcYsphIyX+8Cu5oin9XDJUT54cFDkW
	1+kRnbuLpTC9bWqSK1EpxX4IB4Gj2VqkUz8k4srRjDBJixI6wgDmeihe64W9XA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Nov 2024 21:04:14 -0800
Message-Id: <D5EU0I3P38QA.NOC91EEFYWMG@kode54.net>
Cc: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 <kernel-dev@igalia.com>, "Simon Ser" <contact@emersion.fr>, "Thomas
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
 Pan" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which
 planes to async flip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
 <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
 <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com>
 <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
 <CAA8EJpoEEo5tB00Yqoi7V2U=pRud1W44W3V8bJnr3N468EhQOw@mail.gmail.com>
In-Reply-To: <CAA8EJpoEEo5tB00Yqoi7V2U=pRud1W44W3V8bJnr3N468EhQOw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue Nov 5, 2024 at 2:51 AM PST, Dmitry Baryshkov wrote:
> On Tue, 5 Nov 2024 at 10:15, Christopher Snowhill <chris@kode54.net> wrot=
e:
> >
> > On Mon Nov 4, 2024 at 12:52 PM PST, Andr=C3=A9 Almeida wrote:
> > > Hi Christopher,
> > >
> > > Em 03/11/2024 03:36, Christopher Snowhill escreveu:
> > > > On Fri Nov 1, 2024 at 11:23 AM PDT, Andr=C3=A9 Almeida wrote:
> > > >> Currently, DRM atomic uAPI allows only primary planes to be flippe=
d
> > > >> asynchronously. However, each driver might be able to perform asyn=
c
> > > >> flips in other different plane types. To enable drivers to set the=
ir own
> > > >> restrictions on which type of plane they can or cannot flip, use t=
he
> > > >> existing atomic_async_check() from struct drm_plane_helper_funcs t=
o
> > > >> enhance this flexibility, thus allowing different plane types to b=
e able
> > > >> to do async flips as well.
> > > >>
> > > >> In order to prevent regressions and such, we keep the current poli=
cy: we
> > > >> skip the driver check for the primary plane, because it is always
> > > >> allowed to do async flips on it.
> > > >>
> > > >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > > >
> > > > Should I do a R-b too?
> > >
> > > If you can review the code, it's always really appreciated.
> >
> > I mean, I did review your changes, they looked good to me. I just didn'=
t
> > know the protocol for reporting review in addition to testing.
>
> Please respond with the R-B tag. Also ideally the Tested-by should
> contain the reference to a platform which was used to test it.
>
> >
> > >
> > > > The changes looked sound enough for me to feel
> > > > like testing it as well. Tested Borderlands Game of the Year Enhanc=
ed on
> > > > my RX 7700 XT at maximum settings at 1080p165, and the tearing supp=
ort in
> > > > labwc allowed it to reach over 700fps. No problems from the hardwar=
e
> > > > cursor.
> > >
> > > Thanks for testing and reporting!
> > >
> > > >
> > > > Tested-by: Christopher Snowhill <chris@kode54.net>
> > > >
> >

Reviewed-by: Christopher Snowhill <chris@kode54.net>
Tested-by: Christopher Snowhill <chris@kode54.net> on Radeon RX 7700 XT
using labwc-git

(I must admit, the documents do not make it clear what format the
Testing-by tag should take, or how to append which hardware it was
tested on, etc.)


