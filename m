Return-Path: <linux-kernel+bounces-169660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC98BCBE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2941E280D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23FF144306;
	Mon,  6 May 2024 10:20:50 +0000 (UTC)
Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897491442F7;
	Mon,  6 May 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990850; cv=none; b=O2hKKfG0oVsbc2VLBKNIeyAMt3GcX8vvz6u+c6MZByJ4hPEMnKkGp+pYIE+bnaZ/Yy629v6fLBCfd/NW0ToSBrtE02fMayVL7tSl3xztLVGSyNaLCk4hdtndCw2vjJyA1O88iJrABNUvfs9IwRa4ytSWNx3RhVauX6xAv7ZOo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990850; c=relaxed/simple;
	bh=iMHW3BkixUYr+ZbXggRmQqhIfuthgKaRkXgSYbRcnIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU24f1zu12aiVxEO38cp68cwOlLxip/CfVdx5a+zL2kUjRGbLu091WPbG4nFf6XZWYRVfxceN851FBXn7olGkF8BkceLKiEGcEdURYemJxxBszTNVzInZ1FrzGoP+qQA0MYM1Cz72TEHtXoSPf7pMgLDQF8G9X/ajOj960+r3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=47572 helo=creeky)
	by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1s3uS5-0000QS-Rp; Mon, 06 May 2024 21:16:06 +1200
Date: Mon, 6 May 2024 21:16:00 +1200
From: Michael Cree <mcree@orcon.net.nz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-alpha@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Message-ID: <Zjif0B9RKNO6hKsL@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <CAEdQ38GNU_vCFgi-uuFCW_QVBObTdD8VwoyQ71Cm5dNfZ4+=JQ@mail.gmail.com>
 <b72c2b7a-a929-4c7c-9bef-b230630df882@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b72c2b7a-a929-4c7c-9bef-b230630df882@app.fastmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Fri, May 03, 2024 at 10:15:10PM +0200, Arnd Bergmann wrote:
> On Fri, May 3, 2024, at 18:06, Matt Turner wrote:
> > On Fri, May 3, 2024 at 4:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> Al Viro did another series for alpha to address all the known build
> >> issues. I rebased his patches without any further changes and included
> >> it as a baseline for my work here to avoid conflicts.
> 
> I've pushed out the series with the additional Acks to
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/log/?h=alpha-cleanup-6.9
> and merged it into the main asm-generic branch for 6.10.
> 
> Can you give this a quick test on one of your machines to make
> sure I didn't introduce a stupid regression somewhere?

I built a dp264 specific kernel and its working fine on an XP1000
(EV67 arch).  Just built a generic kernel (as that's probably a more
important test) and that is also working fine on the XP1000.

I also built a titan specific kernel to test on an ES45 (SMP EV68
arch) but that OOPSes early in the boot process with a kernel null
pointer access.  I suspect that has nothing to do with your patches
as I have a recollection that I have seen that OOPS before. So I
tried the same generic kernel that I have running on the XP1000 but
that fails to unpack at the initial boot stage (!) with:

aboot> 9
aboot: loading uncompressed vmlinuz.test...
aboot: loading compressed vmlinuz.test...
aboot: Can't load kernel.
  Memory at fffffc0000310000 - fffffc0000f45df7 (PHDR 0) is Busy (Reserved)

unzip: invalid exec header
aboot> 

Cheers,
Michael.

