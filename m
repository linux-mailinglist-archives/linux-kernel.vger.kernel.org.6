Return-Path: <linux-kernel+bounces-553114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A41A58404
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E5F1892B91
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C41CF5E2;
	Sun,  9 Mar 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Gt67NgUt"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942ED1C3029
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523184; cv=none; b=sfxdozCI0DPO0gvyDicOL9IeDu0B/7P5Ao4E69lgEdVqii/XSqmCBsjd++WJFfuewQPrGmWYYX5F0xZSwk8/57tW8q5udE/VNRO6BZm1KoyhOE33SG4FQJi1LDi79ormxv7bsyWz6GO0BliL7F6WLIX0O0JmCcPip3RVPygpDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523184; c=relaxed/simple;
	bh=JZSeyhDtPHaKD3UhUUiibdM5iU3Mp8v+MGN8BFdVcME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbv1dU6PeZ6nXWEkO+UYBWfi1QYkPvWrKA9hzBktkbtLWHg0/1J6OjAuByGMl2IPx6x2nAAINRGv+ebP6qNrCAdvTcDXA3x6Yqcsy/ETT7LWRbmryNiSqstWe5elLUgx6zc1275RIkjFmcBnur3sSvezkBq98VW2OGKRAU/1lEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Gt67NgUt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=HMfgH1oc2KcA3y65lhe0YmhTGOBUQGCusNDP3uPlZOs=; b=Gt67NgUt4I9eTnUz
	S/SS1mSeD3ODlJ1eg/X05YbEw1pLVmchxI3h8C5ZiAiAitp7mHoVCjO3LStlEZIL/LGSuhLsSmT2g
	GMEx+1xqtHnI/IvodGI5B/iz8StNFW3FIB5TDEze54H/cj7HAU4e0XNjFH5OBkqd7Z0xG0ovObscx
	KOpaybKIwIMvNFpw1orgiGzxwQeDTmC3K5h546OeFS5lGW516bEUw2ydrrU5Sq4pCKewy3B4n3QXl
	75XssSnaNHV6W8v+AGrxgxbtspwAOETXsl9NzJY8spP4wgzxD0A0uH0BEDSBJqUDaJgqRZ0x+HDxY
	WLxM9F4qw/NOfNmQ8Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1trFjW-003hj6-1Q;
	Sun, 09 Mar 2025 12:26:18 +0000
Date: Sun, 9 Mar 2025 12:26:18 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: the pcf50633 - dead?
Message-ID: <Z82I6vuJPufg6mjA@gallifrey>
References: <Z8z236h4B5A6Ki3D@gallifrey>
 <d68fbcda-d77c-4426-b579-57010de82c7b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d68fbcda-d77c-4426-b579-57010de82c7b@app.fastmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:25:15 up 304 days, 23:39,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arnd Bergmann (arnd@arndb.de) wrote:
> On Sun, Mar 9, 2025, at 04:03, Dr. David Alan Gilbert wrote:
> > Hi Arnd,
> >   My scripts noticed pcf50633_adc_sync_read and a load of other
> > pcf50633 symbols weren't called; and hmm I'm pretty sure most of it's
> > dead.
> >   Your:
> >  61b7f8920b176e3cb86c3b5e7c866261720a7917 
> >   ARM: s3c: remove all s3c24xx support
> > removed the last/only includes of any of the pcf50633 headers,
> > I think it was part of openmoko.
> > The only place I see it enabled (=m) in a config is
> > arch/mips/configs/ip27_defconfig  which is the ancient SGI Onyx
> > which predates the pcf50633 by a good few years (and is definitely
> > not portable and battery powered!)
> 
> Yes, I have that one on my list of drivers that are unused upstream
> and should be cleaned up.
> 
> See also my reply at [1], feel free to send patches for any of those.

Ooh, Juicy list!
I'll probably do the pcf50633 soon, and I've made a note of that list.

Thanks,

Dave

>       Arnd
> 
> [1] https://lore.kernel.org/lkml/a15bb180-401d-49ad-a212-0c81d613fbc8@app.fastmail.com/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

