Return-Path: <linux-kernel+bounces-279028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47594B811
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058DD1F22119
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A3189520;
	Thu,  8 Aug 2024 07:41:40 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA496188CAD;
	Thu,  8 Aug 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102900; cv=none; b=WoTEwSNfUMFNmnD2VVZzPC6HmCSRBNm57iozBOb+FZykapTPT98G1tbwDm2PVHNZRQALk/cihL7he9a1R7K/em5LTNxKT/ww4xzS4x6T0KPbs2JGhEJkSL3AXYP0GeU6/IQ3imT+YGOFPOAr+CmTWZwPDAQa7HD8zNOgmvOLpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102900; c=relaxed/simple;
	bh=6rao5J3LQAqYQtlApdQxRXto166epcVVS9yPdbjnty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni4OvBb+m2oEw7uCs/VyIDH3TL/DoTwYeWjdLulZ/8JwktF/h5u1GLcq0wJKs8VYTA/9yfCVDvM23CRkDpZ2HKJoawGdImw2y4HeYkgAcwUzgJ143bF5cjQbEU4zr2TacZOgdrMhRQ+9Fa/PmYZtvYEsGDuooXxLvp2DYoU/ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso637711a12.3;
        Thu, 08 Aug 2024 00:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723102897; x=1723707697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1CWSXYpFT0/hD7O1zJokfpF8mNmWS83/j2Y6ehXkwY=;
        b=Rp5F5aMXpn4dmV1pke1aOZUzUsq6VDlDWHYHHypKMZZLWVDDsr0gS1z4I1+evqzgFB
         e/jIfKRkSZgGFR+mkoP7K9Rnt6RwfQDSOZR42j8C594agJgbXTYklha1ZHnFwqguL2Eg
         9F7JW0YaePOwaf3KL89hmQXU1I1ftzDHWACGNjOGZJQKj6Izxmu3iNfgM3seIzcwDX3t
         eI7RgnipbupzThkLo1EV+G13r8601aKbYtaQ4WFR3+6aiSJ5RSUoRZTmE7Nxv/sDqt5o
         eZWPOwkAIWxEL9Trj7lkMef6vkMMzsvgS2POkhhyTZgc5NpxVcjVldjojS0vnD9K+7nC
         XKMg==
X-Forwarded-Encrypted: i=1; AJvYcCVT3o/pX717XfRKtvA70PSH6fgXIJIsO+f4M1yNW9/dU8u26ESZC7T+R14pvR5EehJvJRkOEWaCyS0JMU+LraTRFhmhaj4+g0JRrmsnWzniCGqcdzhK7sKnnpRJSB0EofcRhKIoshlH
X-Gm-Message-State: AOJu0YwFZbEjkj/P5GezDpFz5ZwO6izhh3Ld9lIvC+JJrU9QADmCB8uT
	UVmi2gl6tbLAACsDL1GK1Qv9srnewW01KYDlqMLi9je+OtI5AZZ8
X-Google-Smtp-Source: AGHT+IGxZKbgMYUucR/1+l7qLZEUndn1+1Eip54ld1tNywrysARUhmlAO+35dYT+S1J+hnpwh1i2sQ==
X-Received: by 2002:a17:907:84b:b0:a7d:a21d:ffb8 with SMTP id a640c23a62f3a-a8090f03addmr89094766b.64.1723102896682;
        Thu, 08 Aug 2024 00:41:36 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de2d923ccsm591013566b.79.2024.08.08.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 00:41:36 -0700 (PDT)
Date: Thu, 8 Aug 2024 00:41:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, kuba@kernel.org,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: fault-injection: document cache-filter feature for
 failslab
Message-ID: <ZrR2rlVkLqp0GXgt@gmail.com>
References: <20240726120930.3231333-1-leitao@debian.org>
 <87plqkrwns.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plqkrwns.fsf@trenco.lwn.net>

On Wed, Aug 07, 2024 at 12:54:31PM -0600, Jonathan Corbet wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > The failslab fault injection mechanism has an undocumented capability
> > that provides significant utility in testing and debugging. This feature,
> > introduced in commit 4c13dd3b48fcb ("failslab: add ability to filter slab
> > caches"), allows for targeted error injection into specific slab caches.
> >
> > However, it was inadvertently left undocumented at the time of its
> > implementation.
> >
> > Add documentation for the cache-filter feature in the failslab mode
> > description. Also, providing a practical example demonstrating how to
> > use cache-filter to inject failures specifically when allocating socket
> > buffers (skbs).
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  .../fault-injection/fault-injection.rst       | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> I've applied this, thanks.
> 
> It seems to me that the fault-injection docs should really move under
> dev-tools; does anybody object to that?

I don't object at all. This doc should be inside dev-tools.

Thanks Jonathan,
--breno

