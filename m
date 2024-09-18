Return-Path: <linux-kernel+bounces-332694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12297BD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFF2834B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704F18A920;
	Wed, 18 Sep 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="akTmxwdM"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57084176ABB
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667286; cv=none; b=AE3O5Zuqw7OIG9aRRl1RmHIj8j9QqjCuPcRqA3IPrvwsy9VdmNQWKhjxIGqtzXry595BBgZOOK0S3qV+o/v+dmGVLNL9hcG+SgHO0HsaxjQaRcH7hRTJNd9Bj7UMrXZ+fMctlKOpBVbU30N2t7/qsAJifdgkuuP6t10f/zZ5juQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667286; c=relaxed/simple;
	bh=8NzT2njURVAodVDWsNDB2bqu8nvesd7OC/MB8WdRBd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpB0pnPYUW368BjvIf29Bb6eNu+/NRLt/n8C4PQLxRnVEQipoiDAYJFaLjjvP438++EwTd55DKdzftXXRlxys7wLrPzGDdyn3dk+/2Yn59dngZyK7HcE261g0JHf4i0KbkMSk4zXVDe2dwb5wHxwz8MeNc0IAq+OBJ7+F6vR2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=akTmxwdM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A8041C0013;
	Wed, 18 Sep 2024 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726667282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvpWoQXAYtUPd9EY76fswMQOKLOSqERrVd3F2SkMjkI=;
	b=akTmxwdMuiZEErfM02jtFIUMh43UIxfDd11v7OJBJbewtnqjma2PuaxZayXGLiL8Nwg1DL
	sRNwb+9s9u+p5usq/rRgrWoQDX6+8fhTMMElzqjSPO9g9kbG/gt3zBTApwP5TYtnPyhykM
	KvJFqRYOfdtQf360fz+Hw2P0hQSLWxE1GhEDAdKWi2+1whnHz1GEHmSLW7EVp/ArGRDuEo
	jZaaPldqSu/kmvuqygI3/V3l52VfQe1pvwmMeG/IKrjqnfn5oaOSVPpjX09B1Chk+xvsQF
	b6Z1dwTcU6EV8ZGO2GiQNjASjNjEWC2rIoKTlOs5tfrKzcE+EvT1irnws9rygA==
Date: Wed, 18 Sep 2024 15:47:59 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: airlied@gmail.com, arthurgrillo@riseup.net, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, miquel.raynal@bootlin.com,
	mripard@kernel.org, nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com, seanpaul@google.com,
	thomas.petazzoni@bootlin.com, tzimmermann@suse.de
Subject: Re: [PATCH v3 0/4] drm/vkms: Switch all vkms object to DRM managed
 objects
Message-ID: <ZuraD0t6KZTGTFng@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	airlied@gmail.com, arthurgrillo@riseup.net, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, miquel.raynal@bootlin.com,
	mripard@kernel.org, nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com, seanpaul@google.com,
	thomas.petazzoni@bootlin.com, tzimmermann@suse.de
References: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
 <20240917160242.2959-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917160242.2959-1-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 17/09/24 - 18:02, José Expósito a écrit :
> Hi Louis,
> 
> Thanks for making this change even more atomic.
> 
> > To simplify the memory managment this series replace all manual drm 
> > object managment by drm-managed one. This way the VKMS code don't have to 
> > manage it directly and the DRM core will handle the object destruction.
> > 
> > No functional changes are intended in this series. This series depends on 
> > [1] (for writeback connector) and [2] (for cleaning code).
> > 
> > PATCH 1/4: Migrate connector managment to drmm
> > PATCH 2/4: Migrate encoder managment to drmm
> > PATCH 3/4: Migrate connector management to drm
> > PATCH 4/4: Migrate writeback connector management to drm
> > 
> > [1]: https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/
> > [2]: https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> The 4 patches:
> Reviewed-by: José Expósito <jose.exposito89@gmail.com>

Thanks!
Louis Chauvet
 
> > ---
> > Changes in v3:
> > - As suggested by Maxime, split the managed and the dynamic allocation 
> >   parts in different series
> > - To reduce the diff in this series, extract the "remove crtc index" part, 
> >   see https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
> > - Link to v2: https://lore.kernel.org/r/20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com
> > 
> > Changes in v2:
> > - Applied comments from José
> > - Extract the rename vkms_output -> vkms_crtc to avoid useless changes in 
> >   the last commit
> > - Extract the rename to_vkms_crtc_state to
> >   drm_crtc_state_to_vkms_crtc_state to avoid useless changes in last 
> >   commit
> > - Extract the drm_mode_crtc_set_gamma_size result check in its own commit
> > - Rebased on drm-misc/drm-misc-next
> > - Link to v1: https://lore.kernel.org/r/20240814-google-vkms-managed-v1-0-7ab8b8921103@bootlin.com> 

