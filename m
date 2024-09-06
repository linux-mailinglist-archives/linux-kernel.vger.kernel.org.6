Return-Path: <linux-kernel+bounces-318793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC596F36E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DA01F214F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDF1CB50F;
	Fri,  6 Sep 2024 11:47:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAA1C9EA2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623220; cv=none; b=eG5bnZeicBUrnNBvR+o5sjcipNnqBvOHLVntis5Uie1PIoaUToyTfNJY31XScdyY2toNu5IxyTnaYS++Spc7rDx17Qv/15ppL8GJhaE2/xSrscz6pBEStgwyitwkYNHQhb8paWr8Iext/Z0W19HHWLkWycGThZrI6nPS6t6tdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623220; c=relaxed/simple;
	bh=+1NIRiUVMBo8EjMzhxcpr/IDwbogu1+HnG9cOWveE5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1xe/AE18MKiHx4Jy+3JW8DDh9jtcIqKIie6mJx5fCdbGrTf7dBdZTKg1OFIb14fpJ+Z3IaR9GZnMsq9PKNWX26YdKp5gG850EVOD3acNAp/59qcNHmoRP4mR05jygSgNSrWgm4U60IrCHJ3dV9l5IqzEGtSASIb6+SxtyRFWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXQL-00027c-8B; Fri, 06 Sep 2024 13:46:45 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXQK-005w12-69; Fri, 06 Sep 2024 13:46:44 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smXQK-00076I-0J;
	Fri, 06 Sep 2024 13:46:44 +0200
Message-ID: <c4e1da1d2f005e22f74eb2461382fd4666dedd4f.camel@pengutronix.de>
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
Date: Fri, 06 Sep 2024 13:46:43 +0200
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

drm-misc-fixes? drm-misc-next doesn't contain 9da7ec9b19d8 yet.

regards
Philipp

