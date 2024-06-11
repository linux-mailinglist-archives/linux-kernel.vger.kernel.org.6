Return-Path: <linux-kernel+bounces-209661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9890390B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C6B282506
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CB178395;
	Tue, 11 Jun 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Xae1nHkV"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB214F13F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102269; cv=none; b=k3vhOPMuaHpGblIJMjpwwZlHtXuHCCZN0QlMz6Fu2EEQ9EGjhvt2rT1Y80zgk2IORGipYyifytWX4bx9Z0VJMlFOL7YVQsFVXyrZvbsqGYcBmX7Gf3xIrRTq2IMVocoVItRSceFfC517QUAj3QqILLP4z3xn8hVCVM6MTWMpYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102269; c=relaxed/simple;
	bh=q9DRe2L7BaTpw3s+dFxYjrnov2ho+fHZiPpUFdoj/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjh04vkk1U3w3P8GF3yUgh0x0iwVeCVcKOO2yt7SxvZQNyVgPJS9JsmXpZpCbPyKlMEYbd7Q3gn6siyI7bt8nIHEnwxlh9yT3CXy+YY0I/gHweVNeW1Smmh6Qjb9ZtJ2+UPFUgxZZzQeoiO+2tifcAILhqiuUlr8dRDsv0W/IZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Xae1nHkV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=RJEjwUTNqxARRNi+A8Omlry3cWQer/5aK7szXPhq1oE=; b=Xae1nHkVIBr4AJjv
	Tg/tcKEZ3do6YJRnY/vmjK6quHsH4TrVpocgmXHoOnW3d5KRWVRGisngBN7bX3Yb4c5x/QrzqpFW8
	XIIBYG49XKCAoDk7Z2SSu70R+ENQ2DsJohrS6abpCdnZqMhdNRvLwMuXS1kqdyMo3CyyEXz8GTURO
	yLBD8Ye+7BMxjEFcEQpgNdXXGNvO+mcmf5NE+/HgzJR+nBlfMqTPfNNDv96VnkQSyvM7kJEP3F669
	tjqAZ1eRsttZvlBt4jY/2rF+inQMJTBzRIbxswrwsAxAJOYTdYMOHabK3JrJwxlNV6JI6hZUiKL/o
	BS0er4lRBbAZCqGL1A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sGysk-005X9R-13;
	Tue, 11 Jun 2024 10:37:38 +0000
Date: Tue, 11 Jun 2024 10:37:38 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: daniel@ffwll.ch, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kherbst@redhat.com, lyude@redhat.com
Subject: Re: [PATCH 2/6] drm/nouveau: remove unused struct 'init_exec'
Message-ID: <Zmgo8leSWpsjVVBS@gallifrey>
References: <20240517232617.230767-1-linux@treblig.org>
 <de79f41d-3a9b-4f15-b270-246af8b4c5b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <de79f41d-3a9b-4f15-b270-246af8b4c5b0@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:36:34 up 33 days, 21:50,  1 user,  load average: 0.07, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Danilo Krummrich (dakr@redhat.com) wrote:
> On 5/18/24 01:26, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'init_exec' is unused since
> > commit cb75d97e9c77 ("drm/nouveau: implement devinit subdev, and new
> > init table parser")
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Acked-by: Danilo Krummrich <dakr@redhat.com>
> 
> To which series does this patch belong?

Actually all of them were independent patches on drm
some of which are all in, so it can be taken by itself.

> Need me to apply it?

Yes please!

Thanks,

Dave

> - Danilo
> 
> > ---
> >   drivers/gpu/drm/nouveau/nouveau_bios.c | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
> > index 79cfab53f80e..8c3c1f1e01c5 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> > @@ -43,11 +43,6 @@
> >   #define BIOSLOG(sip, fmt, arg...) NV_DEBUG(sip->dev, fmt, ##arg)
> >   #define LOG_OLD_VALUE(x)
> > -struct init_exec {
> > -	bool execute;
> > -	bool repeat;
> > -};
> > -
> >   static bool nv_cksum(const uint8_t *data, unsigned int length)
> >   {
> >   	/*
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

