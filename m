Return-Path: <linux-kernel+bounces-391483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F89B87B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77A0B22450
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B41C28E;
	Fri,  1 Nov 2024 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="AgQzWna8"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B518E20
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420778; cv=none; b=EGr6yn4q9weMz9w6Z0EZcnyYWK2mIHueAfjzFbQQQ8jmpZ1tMlurqjexnVf9pUx1HwKYPrYceBALaIiWlLoET8KncYsOva8FaQbR8SFvcm5DyvPQM5A5Ogdu67pIzQ3XsROlCPdhHyLZ0rQILzEP0tlabOHtF7hAKuCCIvSer2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420778; c=relaxed/simple;
	bh=hHQMzWdvIRkFAAdThHUBCMm04+TgayDIk6ZW6LYgpGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/fBWWh4N2MmSUHhGftz/pYxWbq8AEnIsrIai8Gd3+Ag/vyVeKGll3ysZGV3vw7kUMv48Y9h/C2nrjR+dVXdzo0zvkt31GSzXkw13M2uQZAt+J/pUMZUEEzrK8C4NJEILxp52YbJLyjgdysD4xop+Yxxdf5SnXO8edbVnS1Q7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=AgQzWna8; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 130241770C0; Fri,  1 Nov 2024 00:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730420772; bh=hHQMzWdvIRkFAAdThHUBCMm04+TgayDIk6ZW6LYgpGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgQzWna8QiLrIzQsqgVJg9R1QQoZvYx6Fo+axigwerf0bSNA3Fs0kEzQyZ7fuiBGB
	 pRQD7VDLV+tRwYJOhXv5slT4jQyPWQoOW+6IE2joi08GV7DH6SL8iPggiari9QWcWK
	 NkW0pq8/jF/5Y7gjw620tLt6PsKg0xpbCNsrzh8TsCqMuNbgTAm5/y4lBkcjZkQ6CO
	 NKO4mT5SAUx6Cw6tPSXp1lRlK7+GLXl8DgRTCuJn+ppmtY7nrLTuHI54FnjnTdQrkd
	 wG7/a5V8msVX3f18c3KAX45ki2Pv27LCg08zZlgDOloK9Dr1mm6seFsbVXT3ixQhsB
	 5J6ikzt4ycMkg==
Date: Fri, 1 Nov 2024 00:26:12 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
Message-ID: <20241101002612.GA29456@lichtman.org>
References: <20241031192350.GA26688@lichtman.org>
 <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>

On Thu, Oct 31, 2024 at 04:06:03PM -0700, Doug Anderson wrote:
> >
> > kdb doesn't react to ctrl p and n, and following the code flow with GDB
> > reveals that these values map to the up and down arrows.
> 
> Really? kdb reacts to "ctrl-P" and "ctrl-N" for me. It also reacts to
> "ctrl-F" and "ctrl-B".
> 

Interesting, how do you run kdb? I use the kgdboc=kbd kernel boot param.
I haven't checked with serial as the console since I work with the keyboard,
but if serial does go through this using ctrl+p/n then the code in the
current state is misleading since the keys change depending on the I/O method.

Evidence in the code for usage of arrow keys in the case of keyboard can
be seen by examining kdb_read in kernel/debug/kdb/kdb_io.c, in the /* Down */
and /* Up */ cases the values 14 and 16 can be seen.

Do you suggest to keep as is or to work on a patch with a more generic name that
would fit both?

Thanks,
Nir

> 
> -Doug

