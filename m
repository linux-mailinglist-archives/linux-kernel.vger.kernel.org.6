Return-Path: <linux-kernel+bounces-318791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1773B96F369
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526EA288B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA91CB525;
	Fri,  6 Sep 2024 11:44:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056D1CB154
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623087; cv=none; b=BoQUKdtCATilXiY7zQq+Q5DrEpdpIVl8mYzIQfGSFuncy/sWsGqz5ujr488+7XkDf7cxMm6WtoHwD4RWOJkdEgrScAKlwPAIM08VLsMLSX+hfakw7bsfIzm5MZMW/UfPTGncqpNtYJm3hVrIjWrqyeSYsrJZeVfDtVI40hlmh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623087; c=relaxed/simple;
	bh=EzyEwRgLGiBkrBgGamBbcHsNgaaSq6ZSyw6/X4X0zyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxeJMCt7wqDmAgFNT4f5gVeu5o4bz7qJkRcxgJKiIGpQ92cr5cJ+OFWxYRG6FJPaUSeqFhjwe3laz3lBaWA0compA7nD7T7EmVA++zgS496aTndM09Kfk4pHqIxejqJTgZRc9MXFCQOFS5DT7Fd/MPNA1t9soXa53VN+DewAi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXOB-0001ZM-0B; Fri, 06 Sep 2024 13:44:31 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXOA-005w0g-06; Fri, 06 Sep 2024 13:44:30 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXO9-0006xv-2w;
	Fri, 06 Sep 2024 13:44:29 +0200
Message-ID: <baa18c3414c75476c154f564a7058f53d4913972.camel@pengutronix.de>
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Alexander Stein
	 <alexander.stein@ew.tq-group.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 dri-devel@lists.freedesktop.org,  imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 13:44:29 +0200
In-Reply-To: <CAA8EJpoz7jtjN-Dxq-6SHNiZCz2xsFFf5j4HOoFiLAq=OnHn6Q@mail.gmail.com>
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
	 <CAA8EJpoz7jtjN-Dxq-6SHNiZCz2xsFFf5j4HOoFiLAq=OnHn6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-09-06 at 14:35 +0300, Dmitry Baryshkov wrote:
> On Fri, 6 Sept 2024 at 09:39, Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> >=20
> > When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
> > users were updated. Add missing Kconfig selections.
> >=20
> > Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER =
module")
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  drivers/gpu/drm/imx/ipuv3/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>=20
> I'll update it to drm-misc-next if nobody objects within a few hours

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

