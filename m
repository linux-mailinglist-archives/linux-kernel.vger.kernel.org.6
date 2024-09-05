Return-Path: <linux-kernel+bounces-316407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0596CF1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240E61F2828C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739A1891A3;
	Thu,  5 Sep 2024 06:22:28 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED542BB15
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517348; cv=none; b=XfNOmnrbtSDX/C47/DVnCJ4Cv/qk/GWtkUbcatgNfeWGj5sPrTVqQQEnxjLDQSD94+tBg3iqFmtfKtGBTeO/5/8T05A35U8KUtKDnEvNibVL0iFqm5emwnFUEFQ42BIDndYulJEOBxAH76IAMTXfEEQwH7JtiUkeTf6det6I9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517348; c=relaxed/simple;
	bh=Q2j2tWUXkTwK5T9jOW7ZebvzgdNQ6YYUgTh6LbNtGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwW+jAKPIUThY0Zkj9Xd/UvbW23MXHjVMdS3IFxDFgAIs3BepEcYBVdQemQBd++vOyBFgvAUHSIqNBOIN9IS5YTOIKM1kXkMTdBc3CpKudmstblOqFGQoNR6XcfKTiycqSCc8AXPn399ICLDlA5a7ETr9aJmL8eKMwGUfe2ZCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 4856MIHf001122;
	Thu, 5 Sep 2024 08:22:18 +0200
Date: Thu, 5 Sep 2024 08:22:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <ZtlOGkADy7OkXY9u@1wt.eu>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>

Hi Thomas,

On Thu, Sep 05, 2024 at 07:59:13AM +0200, Thomas Weißschuh wrote:
> > > > I tried setting TOOLCHAIN_BASE to the directory I installed gcc-13.2.0-nolibc
> > > 
> > > Not sure where this variable comes from, but I have never seen it.
> > 
> > This is from the notes I got from Willy.
> 
> Could you forward those to me?

I've finding this in the old "test-all-full4.sh" script that I shared
last year:

   https://lore.kernel.org/all/ZNvIkD1oxZENVkoe@1wt.eu/

> > > > Something changed since the last time I did the pull request handling.
> > > 
> > > In the test setup not much has changed.
> > > Maybe you cleaned out your ~/.cache?
> > 
> > Not intentionally ...
> > Guess I just have to do run download.sh again.
> 
> I guess download.sh also comes from Willy?

I was about to say no until I saw it in the mail above :-) I did
not remember about it.

> > > Or it's the first PR with run-tests.sh?
> > 
> > I have been running the following successfully in the past:
> > 
> > From tools/testing/selftests/nolibc
> > make run
> > make run-user
> > 
> > ./run-tests.sh -m user
> > ./run-tests.sh -m system
> 
> Ack.
> 
> Could you provide a transcript of the commands you are running and their
> outputs, including the failing command?
> From the error it looks like run-tests.sh is the one failing, but that
> script was written completely oblivious to download.sh and
> TOOLCHAIN_BASE, so those probably won't help solving the issue.
> 
> The following command should automatically download the toolchains into
> the location from the error message:
> 
> ./run-tests.sh -p -m user
> 
> These toolchains can then also be used for direct "make" invocations
> through CROSS_COMPILE.

I really suspect an empty CC variable somewhere that could explain why
only CROSS_COMPILE is used. I'll try to find time today to give it a
try here as well, just in case I can reproduce the same issue.

Thanks,
Willy

