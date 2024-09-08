Return-Path: <linux-kernel+bounces-320139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE097068C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601BD1F22250
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38BA14E2EF;
	Sun,  8 Sep 2024 10:23:10 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AB1494CC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790990; cv=none; b=U9OE7tOnAY922P0eQpKFuq4v49/6eyR+OuM6HkhGRO4RPgFcoxchl8uLgR6jSfVnuAge384d3aKFI9nWxhebuzoAWFqg11eC8HI65zNZep+J902EdRaEuY2iZCkh3IoeVgwIu3BidMuvyVGhPM//sYfP4uT4K68vu6/njngFSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790990; c=relaxed/simple;
	bh=/I2xsDKtHCWK29Dtri1Aq+cD29P6i7WEO/zFf0RCbIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2SLcW8f/a3uWOqZ85YS2huNzva7qUjbN1/gjyfZ1rrkA1EUeRqPQGxuyDqq8sOHhBtL9jKRbcsxM0KHiS2QiIFK1GOwezEhiJKpka9VwbpPgfifK7G96k0Nir725+MEJrX5FHVVZuB11fXLl3+ND5UXhOqMObnjfjGUTHyBguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 488AMlwr001183;
	Sun, 8 Sep 2024 12:22:47 +0200
Date: Sun, 8 Sep 2024 12:22:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <20240908102247.GA1175@1wt.eu>
References: <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>
 <ZtlOGkADy7OkXY9u@1wt.eu>
 <ZtlQbpgpn9OQOPyI@1wt.eu>
 <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>
 <Ztnd26IlnMwrywUO@1wt.eu>
 <e36fb1f5-f370-4806-912e-d9d2f777a1bc@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e36fb1f5-f370-4806-912e-d9d2f777a1bc@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Sep 05, 2024 at 05:57:52PM -0600, Shuah Khan wrote:
> On 9/5/24 10:35, Willy Tarreau wrote:
> > On Thu, Sep 05, 2024 at 05:57:22PM +0200, Thomas Weißschuh wrote:
> > > On 2024-09-05 08:32:14+0000, Willy Tarreau wrote:
> > > > On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
> > > > > > 
> > > > > > ./run-tests.sh -p -m user
> > > > > > 
> > > > > > These toolchains can then also be used for direct "make" invocations
> > > > > > through CROSS_COMPILE.
> > > > > 
> > > > > I really suspect an empty CC variable somewhere that could explain why
> > > > > only CROSS_COMPILE is used. I'll try to find time today to give it a
> > > > > try here as well, just in case I can reproduce the same issue.
> > > > 
> > > > In fact I'm getting it without any options:
> > > > 
> > > >    $ ./run-tests.sh
> > > >    realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
> > > > 
> > > > It comes from here in test_arch():
> > > > 
> > > >          cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
> > > > 
> > > > Thus it's indeed related to the absence of the toolchain there. It's
> > > > just that the way the error is reported (due to set -e) is a bit harsh.
> > > 
> > > Ack. It should not occur with "-p" though.
> > 
> > Agreed, I was focusing on first experience for users essentially.
> > 
> > > > What about this ?
> > > > 
> > > >    $ ./run-tests.sh
> > > >    No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
> > > >    Did you install the toolchains or set the correct arch ? Rerun with -h for help.
> > > >    Aborting...
> > > > 
> > > > or anything similar, achieved by this patch (warning copy-paste, mangled
> > > > indents):
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> > > > index e7ecda4ae796..0f67e80051dc 100755
> > > > --- a/tools/testing/selftests/nolibc/run-tests.sh
> > > > +++ b/tools/testing/selftests/nolibc/run-tests.sh
> > > > @@ -143,6 +143,13 @@ test_arch() {
> > > >          arch=$1
> > > >          ct_arch=$(crosstool_arch "$arch")
> > > >          ct_abi=$(crosstool_abi "$1")
> > > > +
> > > > +       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
> > > > +               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
> > > > +               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
> > > > +               return 1
> > > > +       fi
> > > > +
> > > >          cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
> > > >          build_dir="${build_location}/${arch}"
> > > >          if [ "$werror" -ne 0 ]; then
> > > 
> > > Looks good.
> > 
> > OK thanks, I'll try to handle it this week-end if I'm not beaten to
> > it. If you or Shuah want to merge it before, feel free to, no offense
> > on my side!
> > 
> 
> Sounds good. My system is back to a good state with the tests after running
> ./run-tests.sh -p -m user
> 
> My guess is my setup was lost when I upgraded my system.

Makes sense.

FWIW I've just pushed the patch above to nolibc-next. Since it's not a
result of a change of the last PR, there's no need to udpate it I think,
it can easily wait for the next one (it's just a help message after all).

During the tests I've also got caught with -d which needs a trailing slash
otherwise doesn't concatenate directories correctly. I don't know if that's
intentional or not so I didn't change it (and it's not important either).

Best regards,
Willy

