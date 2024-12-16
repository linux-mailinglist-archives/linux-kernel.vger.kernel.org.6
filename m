Return-Path: <linux-kernel+bounces-447305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113E9F304E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7857A1F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A6204597;
	Mon, 16 Dec 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HsHzlV26"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512634CC4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351431; cv=none; b=r6oFrBuMA+f7ETzfT1Iv1Ga7/CqOZoOfRbTXn6PF7Mukzf3nozvE27/N4WhWPM/1A6xP2CZEW5YdBWGnv1e2EhyvOdhSMFq+3YgRId0nfovjc1VPaF4pPFVF8dAN/4FnFPu0XmQK8B726S4BxQWaibnxj89qmkBfUjJjmSlEjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351431; c=relaxed/simple;
	bh=BFU17b0C79hkAAo1gImoylZxo7hMJ5jrzR1P/pgMkn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DztPswOfS2YhOnVQxQfEaDvRBMmE/TY8zKf9kGxnBfac7jHhcvcpPuXRz6LgDXFMUfz6J4HH/Dl0/JNUZDgmV2BOVKCozrI4TW3p48F6l3KTGr4azXR2oWEeE/LNsxw7Uppfwp5TRdrYdldQLHSRVNXJMsKUxTDAwFm2FJlK97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HsHzlV26; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A96813C;
	Mon, 16 Dec 2024 13:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1734351391;
	bh=BFU17b0C79hkAAo1gImoylZxo7hMJ5jrzR1P/pgMkn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsHzlV26zyo+ZkP3ISboWUfa1BgnsclRurITZ3CISW1hDATwrRAJEcGCYe+m7fsnL
	 QySwqO79dxIj5xSKSdURPnblPGLhsV8JOQ2ug3n6UkQep7wi4M4vygMt2AsfylE3l6
	 Ns/nx+7hPo7oS+PQqR1NUZnkjEHz+Pi4+Fnm6+tg=
Date: Mon, 16 Dec 2024 14:16:51 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Message-ID: <20241216121651.GP32204@pendragon.ideasonboard.com>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
 <Z2ASy3TQ4suupdvd@cassiopeiae>
 <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>

On Mon, Dec 16, 2024 at 02:11:41PM +0200, Dmitry Baryshkov wrote:
> On Mon, Dec 16, 2024 at 12:45:15PM +0100, Danilo Krummrich wrote:
> > On Sun, Dec 15, 2024 at 12:19:22PM +0200, Dmitry Baryshkov wrote:
> > > The nouveau driver is the only user of the drm_encoder_slave interface.
> > > Demote it from KMS helpers module to the nouveau driver itself, moving
> > > corresponding I2C encoders to be handled by nouveau driver too.
> > 
> > I understand nouveau is the only driver using this interface (and the
> > corresponding i2c encoders).
> > 
> > However, I'm not quite seeing the advantage of folding the interface (including
> > the two i2c drivers) into nouveau. I don't think this legacy interface does harm
> > the subsystem in any way / does prevent the subsystem from moving forward.
> > 
> > Can't we just keep it as it is?
> 
> Well, drm_encoder_slave is a part of the DRM KMS helpers module, so it
> take (a little bit) of space on every system. The nouveau situation
> isn't unique, other drivers (i915, ast) also incorporate the code for
> I2C backends. For the further discussion see the thread starting from
> Laurent's email ([1]).
> 
> [1] https://lore.kernel.org/all/20241117205426.GE12409@pendragon.ideasonboard.com/

It's also a question of whether maintenance of this code based used by
the nouveau driver only should be the responsibility of the drm-misc
community or the nouveau driver maintainers.

> > > Ideally those two drivers should be converted to the drm_bridge
> > > interface, but it's unclear if it's worth spending time on that.
> > 
> > Probably not.
> > 
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > Changes in v2:
> > > - Renamed symbols in defconfig (Laurent)
> > > - Added missing Kbuild file (Laurent, LKP)
> > > - Renamed guarding defines in include files.
> > > - Dropped mentions of two removed functions.
> > > - Link to v1: https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org
> > > 
> > > ---
> > > Dmitry Baryshkov (2):
> > >       drm/nouveau: incorporate I2C TV encoder drivers
> > >       drm/nouveau: vendor in drm_encoder_slave API
> > > 
> > >  arch/arm/configs/multi_v7_defconfig                |   4 +-
> > >  arch/parisc/configs/generic-32bit_defconfig        |   4 +-
> > >  arch/parisc/configs/generic-64bit_defconfig        |   4 +-
> > >  drivers/gpu/drm/Makefile                           |   1 -
> > >  drivers/gpu/drm/i2c/Kconfig                        |  18 ----
> > >  drivers/gpu/drm/i2c/Makefile                       |   6 --
> > >  drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
> > >  drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
> > >  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
> > >  drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild        |   5 +
> > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
> > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
> > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |  11 ++-
> > >  .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
> > >  .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
> > >  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
> > >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
> > >  .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   4 +-
> > >  .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 109 ++++++++-------------
> > >  .../gpu/drm/nouveau/include}/i2c/sil164.h          |   4 +-
> > >  drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
> > >  drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
> > >  22 files changed, 172 insertions(+), 232 deletions(-)
> > > ---
> > > base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
> > > change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9

-- 
Regards,

Laurent Pinchart

