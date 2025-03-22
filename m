Return-Path: <linux-kernel+bounces-572526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F6A6CB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AA53A5EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7F225A23;
	Sat, 22 Mar 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="I9QpnGYR"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F1DC046
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655528; cv=none; b=q9FUOIuKCO2H4fVUfFvzGxzv9BJpcZFmY4qJJcAv1SuS3pIEQm1dPi4B/0tVCV+1UIM6TKUkBzeSKUB1Gr6ApYQaqYfvU1tUUQHEC3xoing8jmN/S5VSuQNDC8kTPr1PwgLzDpaAA79NR73gEcJk4Tojwzlwa2hVrEmeOMngZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655528; c=relaxed/simple;
	bh=wfdxvmJ7rInHtabvEY5/lJ0hKqPUV/TnWpsdUY/ZqjQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uuMuQ0SFNJnHgRvGXgKPZQJTcralF1/JzZicH35YYLCaVoWAIU7lPfu0lfrLmkfmuXQK38WQ3Qg+Pl0sE2OX8QC/q56ZBSnik1Ri3yEzQBqWPzSVct2il8lHex7B5EACmRgIdFt77RZvf9jfk4HLYV9d3RKajIZqghCK5AUsEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=I9QpnGYR; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lVEH2hrBEQMIsAPkBs7umzjrjytfMK4To1+kh6aSsw0=;
  b=I9QpnGYRVvnDYe6PskBTh2ADigiTWnTEYPDeacv88OfhTgjBTmbdOgCz
   np29zMlg7jHx8+GAwN/s+bhkPU9qeuFL4EsEz384tIWvr1/8WzBGxS14T
   05tf4djFJRTKX2IWi/BBaGbP5W3/M89rwr9Q52CN2PVXD7lrTexE7Y/T6
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,267,1736809200"; 
   d="scan'208";a="112318639"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 15:58:44 +0100
Date: Sat, 22 Mar 2025 15:58:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Samuel Abraham <abrahamadekunle50@gmail.com>
cc: outreachy@lists.linux.dev, gregkh@linuxfoundation.org, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-camera: Modify function call
 formatting
In-Reply-To: <CADYq+fboc+_cncOdrBh-2sDNSz9YAFvTqREmV+mmKOHy5QV5gA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2503221557370.12345@hadrien>
References: <Z97Bl9RyFRGZUXNM@HP-650> <alpine.DEB.2.22.394.2503221510230.12345@hadrien> <CADYq+fboc+_cncOdrBh-2sDNSz9YAFvTqREmV+mmKOHy5QV5gA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-941195677-1742655524=:12345"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-941195677-1742655524=:12345
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Mar 2025, Samuel Abraham wrote:

> On Sat, Mar 22, 2025 at 3:11 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Sat, 22 Mar 2025, Abraham Samuel Adekunle wrote:
> >
> > > The line is a function call which ends with an opening parenthesis
> > > thereby not adhering to the Linux kernel coding style.
> > >
> > > Modify the function call to include parameters on the same line as
> > > the opening parenthesis to improve readability and consistency while
> > > adhering to Linux coding styles.
> > >
> > > Reported by checkpatch:
> > >
> > > CHECK: Lines should not end with '('
> >
> > Please check the get_maintainer script (see tutorial).  It looks like
> > there are some other people who should receive patches on this driver.
> >
> > julia
> >
> Thank you very much for your review.
>
> Please just to be sure, do I include the emails of the people I
> initially sent the patch to or
> I should only send the patch again to the other people I did not
> include initially?

Send it toeveryone (ald recipients and new ones).  You should write [PATCH
v2] instead of [PATCH].  Below the --- you can write v2: and an
explanation of what has changed, ie adding more recipients.

julia
--8323329-941195677-1742655524=:12345--

