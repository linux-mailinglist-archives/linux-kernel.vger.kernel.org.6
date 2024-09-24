Return-Path: <linux-kernel+bounces-337461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3408984A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D76B2131C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E321AC42A;
	Tue, 24 Sep 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZytR1qLv"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840161DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199538; cv=none; b=exnfoMg+/8mlj3pYo1JbyDpb4Ry83IZ/6/kfdzNN3PjwEz5b5MScnSFPmTz48/aOS83bSYdt23If6+RCaWN3mTp1ZJidIUC2fjSfee4DG8d4b/RXJGH0C74a146CtEQn/WjNpY/5Hk5XNa0xqtyApv+I8kbxhrzkKxnwT8M6c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199538; c=relaxed/simple;
	bh=wu2KUbPtZ3wIziHapURVAHXp2bOB88rPIO15MFj6Rpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH3gHaeoUjwwMNvJPeOcyicN/eYkGSnakkJmAMMndT4JTqqT+lLDM3bq5wOdNMo2p4ibWRg9bCkbIqBNtM7cHCpJfTfi2UHJAl6HHWoiv8qFbCL6dqzsOLHqU8FxqCuqXChhKRjVFuw54dW+JGtOHxs5v/fwLhGWTNiUPcFtJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZytR1qLv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=M9TUQDMRJDjlgh3owcxaD9H83PPUtYCIzP7lrrP0PJc=; b=ZytR1qLvSJw4TPdG
	3MEIVJSG6JNhRevjCYJ13W9cTHmyMiyixa3mti3+ChAs3IGIiyWFINWxzmre9X7zVvnyYg34COgiF
	+bgQdYRLQV8H88GSh4IPkkydT/pK9gbQaCrlx3tbOwuYwwQ6+zt5X9NFHjUDi7/a/FCn0iH5Fg0wZ
	9jS9TPrffU18vdu5mggSEeMZxFeargFNx1xBYS7fV6GHMYV82xm2Ey3dVGvodSvl4vXcPAgjYEYX+
	dqT0N3+GzREJUhtr3eg0NH67Bu14bnBcIOQgexeSc9uhOu6K+u5v0xrFqoXLp02F5bEGeA8nIIOYZ
	Qq7+loQzyQgRZPw0EA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1st9Ur-0072Lb-2d;
	Tue, 24 Sep 2024 17:38:45 +0000
Date: Tue, 24 Sep 2024 17:38:45 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] AMDGPU deadcode
Message-ID: <ZvL5Jbw9RNCqjBS4@gallifrey>
References: <20240923012446.4965-1-linux@treblig.org>
 <CADnq5_PxBfpG6C80Wcm50wLzz=4eEKsscuZXiQ=ZsG8=gULhRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PxBfpG6C80Wcm50wLzz=4eEKsscuZXiQ=ZsG8=gULhRA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:35:20 up 139 days,  4:49,  1 user,  load average: 0.01, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Alex Deucher (alexdeucher@gmail.com) wrote:
> On Sun, Sep 22, 2024 at 9:43 PM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Hi,
> >   This is a bunch of deadcode removal in amdgpu;
> > some of the functions are ones which were previously
> > used but haven't been for a while, others are functions
> > that were added a few years ago and haven't ever been used.
> >
> >   There are some others that I've not removed, which have
> > been added in the last few years but not been used,
> > I was worried maybe there are patches in someones tree
> > about to use them (e.g. amdgpu_lsdma_copy_mem, amdgpu_mes_reg_wait,
> > amdgpu_ras_unbind_aca, amdgpu_seq64_alloc, and
> > amdgpu_xcp_prepare_resume) - I'd be happy to take those as
> > well.

Hi Alex,
  Thanks for taking the series, and the reply.

> There are patches in flight that make use of at least some of these.
> For example, the seq64 functions are used by the user queues patches
> which are being reviewed now.  Feel free to send out patches though if
> you are inclined.  If someone has plans to use something, they can
> bring that up in the patch review.

OK, I've made myself a note and will swing back at some point.

> >   One other thing I wasn't sure of; I removed
> > amdgpu_device_ip_is_idle
> > which has been unused since about 2016, but does that make
> > the 'is_idle' methods unused or is there something else that calls
> > them?
> 
> They've been used on and off in proposed patches over the years.  Some
> of the IP specific code may call the IP specific is idle functions
> directly rather than using the callbacks.

Do you think the 'is_idle' member itself should go?

Dave

> Alex
> 
> >
> > (Sent from this kernel booted on my RX550 GPU)
> >
> > Dave
> >
> > Dr. David Alan Gilbert (5):
> >   drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
> >   drm/amdgpu: Remove unused amdgpu_atpx functions
> >   drm/amdgpu: Remove unused amdgpu_gmc_vram_cpu_pa
> >   drm/amdgpu: Remove unused amdgpu_gfx_bit_to_me_queue
> >   drm/amdgpu: Remove unused amdgpu_i2c functions
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 --------
> >  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 12 ---------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ------------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 10 --------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 --
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 12 ---------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 25 -------------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  4 ---
> >  9 files changed, 100 deletions(-)
> >
> > --
> > 2.46.1
> >
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

