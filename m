Return-Path: <linux-kernel+bounces-227006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE091470F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6BB25275
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F713665B;
	Mon, 24 Jun 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VO8TTlNd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="svytGqe0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7D3BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223631; cv=none; b=ELjaS1wdHNDKpaORGTpVh6OO5dF+5IqaaYR/HdulF36sMF8Ae9fzOh14IJFcaXcmPtLTl1gr5X+dEhehxVue89C5L7zzg8Qe+pPRv+0yS234pNZzUZ3va18ZVLhEjVKj8hiVIV7pPFsgBVizJptJri5YXcLeU/4O0h1An/EXCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223631; c=relaxed/simple;
	bh=5WKe6cF0t4/JZVw8xXEG7h3J6oRfzq3wAvGhg9F45zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcEIdg4wl2a3TwFokCJ1TM//2/60D+OSSFoDq78QrjPHUxA4dQtCRj+akDC1qOBGwKZxIsg37ObVv1PWD1I6vXRjZy95EmSsQxxesS9gm8F4z4oz5KtPi7lXaX5fxifXsxksWM4B+hSk06HD/L0hTyT4UZlGZspwl5AgeJsjIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VO8TTlNd; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=svytGqe0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719223627; x=1750759627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WKe6cF0t4/JZVw8xXEG7h3J6oRfzq3wAvGhg9F45zs=;
  b=VO8TTlNdNH06pBwXI3n0VaoaGItTjzkTtobGrTFkSrzEQWwEq/fBhOaq
   d+im2iqhb74VvhrZXLl/KzwgHOX2287enVce7wJ0wn/z8DnZ0fKh/BY9P
   mKwXk8YJ/U2+x5zEkLcHCUCjesGZ7xu8PBUBruUIvUjK0+1PHQSuHRR1K
   rsS+o2C4HSDsj7N+JacjFkFZBxmJpK/p+RbphvPNdJZapVpeSdd9VmBRq
   Y5g2LPGTy7A6FpOQcQ7rjQpxMkxy1MGoD0BgJrZv1BCvNjeBzUDVe3AjH
   gBIfTAxX0IVKY0CIyx6CZR2r/Sq5smYwWPKrhZ0+d+IHRv8HRsmFX/H7D
   w==;
X-CSE-ConnectionGUID: rUy8VgVNRzu9aoUvS0wfyQ==
X-CSE-MsgGUID: jPFoXd6EToSIi3icnE01NQ==
X-IronPort-AV: E=Sophos;i="6.08,261,1712613600"; 
   d="scan'208";a="37549044"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2024 12:07:05 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EC3B16FF59;
	Mon, 24 Jun 2024 12:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719223621;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5WKe6cF0t4/JZVw8xXEG7h3J6oRfzq3wAvGhg9F45zs=;
	b=svytGqe0izs746zACmpPMTJ7MqmA1BpKvXFoDNwKB65Gl0VQDA2ZQDIQZvny/IeMlig/BM
	JUG1Tbiz3oqlVI7nYq0Nc019kKaJQMmR17njDLNoiwMVR03UenljGt2uH8yLPSEfVl9cI5
	WWLqjonRjcnZTF5SzIHI96tXal8o4AFAk8uJctnBHULuRfU4VN8m6JXeTrotsI/iYCCVN/
	T9P/N6N7GZB6/2ReqsaVFhL1ufFvAQberkaImOZYtwsXE3Kj4zrGwfDUEjUtPI54Kovq4g
	lMhfxKg83Cbht6c6I1aLFK2D2Dr0txxCphDEXPKBEMgLVGxAUy/zQehzZ+PR/Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>, dri-devel@lists.freedesktop.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Date: Mon, 24 Jun 2024 12:07:02 +0200
Message-ID: <2469374.jE0xQCEvom@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <st6vgd2k6dxo4vd3pmqmqlc5haofhbym2jeb2eeh2pa2n6zcca@tradpzxrzexl>
References: <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com> <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com> <st6vgd2k6dxo4vd3pmqmqlc5haofhbym2jeb2eeh2pa2n6zcca@tradpzxrzexl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 24. Juni 2024, 11:49:04 CEST schrieb Dmitry Baryshkov:
> On Mon, Jun 24, 2024 at 03:07:10PM GMT, Aradhya Bhatia wrote:
> >=20
> >=20
> > On 22/06/24 17:49, Dmitry Baryshkov wrote:
> > > On Sat, Jun 22, 2024 at 05:16:58PM GMT, Aradhya Bhatia wrote:
> > >>
> > >>
> > >> On 17-Jun-24 13:41, Dmitry Baryshkov wrote:
> > >>> On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
> > >>>> On 16.02.24 15:57, Marek Vasut wrote:
> > >>>>> On 2/16/24 10:10, Tomi Valkeinen wrote:
> > >>>>>> Ok. Does anyone have a worry that these patches make the situati=
on
> > >>>>>> worse for the DSI case than it was before? Afaics, if the DSI la=
nes
> > >>>>>> are not set up early enough by the DSI host, the driver would br=
eak
> > >>>>>> with and without these patches.
> > >>>>>>
> > >>>>>> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and D=
PI, so
> > >>>>>> I'd like to merge these unless these cause a regression with the=
 DSI
> > >>>>>> case.
> > >>>>>
> > >>>>> 1/2 looks good to me, go ahead and apply .
> > >>
> > >> Isn't there any way for the second patch to move forward as well tho=
ugh?
> > >> The bridge device (under DPI to (e)DP mode) cannot really work witho=
ut
> > >> it, and the patches have been pending idle for a long time. =3D)
> > >>
> > >>>>
> > >>>> My local patches still apply on top of 6.10-rc4, so I don't think =
this
> > >>>> ever happened. What's still holding up this long-pending fix (at l=
east
> > >>>> for our devices)?
> > >>>
> > >>> Neither of the patches contains Fixes tags. If the first patch fixe=
s an
> > >>> issue in previous kernels, please consider following the stable pro=
cess.
> > >>>
> > >>> If we are unsure about the second patch, please send the first patch
> > >>> separately, adding proper tags.
> > >>>
> > >>
> > >> Thanks Dmitry! I can send the patches again with the required fixes
> > >> tags (or just patch-1 if we cannot do anything about patch-2).
> > >=20
> > > The problem with the second patch is that it get mixed reviews. I can
> > > ack the first patch, but for the second one I'd need a confirmation f=
rom
> > > somebody else. I'll go on and apply the first patch later today.
> > >=20
> >=20
> > Thanks Dmitry!
> >=20
> > However, would it be okay if I instead add another patch that makes 2
> > versions of the "tc_edp_bridge_funcs", say "tc_dpi_edp_bridge_funcs" and
> > "tc_dsi_edp_bridge_funcs", that have all the same function hooks except
> > for the .edid_read()?
> >=20
> > The dsi edid_read() will remain the same, and Tomi's patch - patch 2/2 -
> > will only fix the dpi version of the edid_read()?
> >=20
> > The bridge already has the capability to distinguish a DSI input from a
> > DPI input. This can be leveraged to decide which set of functions need
> > to be used without any major changes.
>=20
> I'd prefer if somebody with the DSI setup can ack / test the second
> patch.
>=20
>=20

Now that my DSI-DP setup works apparently without issue I could test patch =
2.
Since my setup does not use DRM_BRIDGE_ATTACH_NO_CONNECTOR (running on
drivers/gpu/drm/mxsfb/lcdif_drv.c), I can only say
there is no regression.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



