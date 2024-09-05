Return-Path: <linux-kernel+bounces-316258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711196CD25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24950285CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C1145B25;
	Thu,  5 Sep 2024 03:22:05 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCF42AA2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506524; cv=none; b=phzhrYqoHhw6vUYiDbKkMq0m1F6rgA2P4rXsK7RVV1vlwRaxzWpB2QPcLhF+WuJ4LeKgUotZKbaq9QAT2dDLIIYpgUq2zME3d7aq5SNekInGebOMHKWP6cQQ6bJS5cCUt8D2VrLZenldplEDUNZMkpcd8Prcy1PT9DcsMgUGzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506524; c=relaxed/simple;
	bh=ElO+9uuM3oV7yzTPx99G1jGd2YGUKC+h38xsFa6DBsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGeq8qHrx7WME3V+hrIzgFfJoF6QkhavqUjgLPP+NKjhvjYeOMIUAdi7/QUBZY5Uz1/bEeXtoKj2dA7grocSyKr52Kc7o/TqmPHHzvb/pUwvDG7iOEi/vx568kqr+BQxXibWOXoEjyCWpFvEhgTmE+KiSUGileVchb6uvfbDV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48538ghR029098;
	Thu, 5 Sep 2024 05:08:42 +0200
Date: Thu, 5 Sep 2024 05:08:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <20240905030842.GA29082@1wt.eu>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 04, 2024 at 03:19:42PM -0600, Shuah Khan wrote:
> On 9/4/24 15:13, Thomas Weißschuh wrote:
> > On 2024-09-04 15:04:35+0000, Shuah Khan wrote:
> > > On 8/27/24 06:56, Shuah Khan wrote:
> > > > On 8/24/24 12:53, Thomas Weißschuh wrote:
> > > > > Hi Shuah,
> > > > > 
> > > > > The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> > > > > 
> > > > >     Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1
> > > > > 
> > > > > for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:
> > > > > 
> > > > >     tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > nolibc changes for 6.12
> > > > > 
> > > > > Highlights
> > > > > ----------
> > > > > 
> > > > > * Clang support (including LTO)
> > > > > 
> > > > > Other Changes
> > > > > -------------
> > > > > 
> > > > > * stdbool.h support
> > > > > * argc/argv/envp arguments for constructors
> > > > > * Small #include ordering fix
> > > > > 
> > > > 
> > > > Thank you Thomas.
> > > > 
> > > > Pulled and pushed to linux-kselftest nolibc branch for Linux 6.12-rc1
> > > > 
> > > 
> > > I am running sanity tests and getting this message:
> > > 
> > > $HOME/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
> > 
> > This indicates you are using 'run-tests.sh'.
> > Pass "-p" to let it download the toolchain automatically.

Maybe it appends a "$CC" at the end that's not yet set anymore for some
reason, e.g. the change of includes.

> > > Something changed since the last time I did the pull request handling.
> > 
> > In the test setup not much has changed.
> > Maybe you cleaned out your ~/.cache?
> 
> Not intentionally ...
> Guess I just have to do run download.sh again.
> 
> > Or it's the first PR with run-tests.sh?
> 
> I have been running the following successfully in the past:
> 
> From tools/testing/selftests/nolibc
> make run
> make run-user
> 
> ./run-tests.sh -m user
> ./run-tests.sh -m system

At least it means we've broken some setups and we need to figure how,
and what to do to fix them :-/

Thanks Shuah for the report,
Willy

