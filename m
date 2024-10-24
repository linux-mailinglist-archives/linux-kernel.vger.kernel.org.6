Return-Path: <linux-kernel+bounces-379040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC29AD8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E4C283C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EBC848C;
	Thu, 24 Oct 2024 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YDAmSUvB"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FBA932;
	Thu, 24 Oct 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729110; cv=none; b=o8X/FjGyev7btrWDgu7xuoXwHPmpm9dLo1zaclRBQxhN62lla6xnUb2b/qr45Fwcdb8DXnQKK8/NUghIoDIszBOEXRT+6cBO+k0mk16e/47IUC8Jg73JBJA8oobdWgALowL5HXPTAt8dzoXi765ra1lVlfOjehuKlzrAfpTSRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729110; c=relaxed/simple;
	bh=w5vZCzcJVxYOYIuk5aHJF0HK91ZHIC7EZrhJuLYnQjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNquQLmkszTp+msNZX3sAqeAO/79NGVE0lj4TFX6f66+EtBlllhugVsayFjV+JWd6yc5eUGGZR8MGQU+TwuyA2mnQ70BdJHkw8cdS6Nwr8gnq2nRGmYpnMounMDXbjKVpZtAWY00uaZSnbZUnA92VzbNGR9470mPZEknYK8uKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YDAmSUvB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729729104;
	bh=WtnDx7HtpgMGToc67LvWVCZkY6l3tklYm20D0ZsZQYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YDAmSUvBbl4YtLfaeZNLAXebR7kAnuQTy9tN79E1k/JZOhQi6XQiS2LcvGdpxqdxc
	 qCjFi/DwBiL1/H8TCjOtcAPJLLeirRckkhJn6NL/g1sC2qxbYSv3Q5jmq+Iis+V8a2
	 Qcv7FYFwhXXiVJhX5dZq1Wk5I0mGUzRoRjsefxJHALCE2TJbpjHx7CPEblHa6Qzfxi
	 xgXWPT/hXrUKzIiBOSkosHGsLBX8O/kYmiWHokoIiH1zTPiPNC3lywBchKq0ihIQiS
	 IMJgA31Yv6T/oYVrMUYKWiQOo1CLfMxo1h50yEqyP2TIf0imLC1DiBJtdOvBUe6mIf
	 TNBOQ3pxVoYbQ==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 815BB6494E;
	Thu, 24 Oct 2024 08:18:23 +0800 (AWST)
Message-ID: <32cb6d9388fb136f7cd7ad1ab0d60d83ae387982.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?UTF-8?Q?=E5=BE=90=E5=82=91=E7=94=9F?= <jasonhell19@gmail.com>
Cc: yang.chen@quantatw.com, jerry.lin@quantatw.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, patrick@stwcx.xyz,
  devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 10:48:22 +1030
In-Reply-To: <CAFGtgY3BJcpC=Q0cYZQa01D5BFAQTt6GEr=0_mrPGUntHYVioA@mail.gmail.com>
References: <20241022021230.2322132-1-jasonhell19@gmail.com>
	 <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
	 <CAFGtgY3BJcpC=Q0cYZQa01D5BFAQTt6GEr=0_mrPGUntHYVioA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 16:32 +0800, =E5=BE=90=E5=82=91=E7=94=9F wrote:
> Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >=20
> > On Tue, 2024-10-22 at 10:12 +0800, Jason-Hsu wrote:
> > > Add Linux device tree entry related to Meta(Facebook) Ventura specifi=
c
> > > devices connected to BMC(AST2600) SoC.
> > >=20
> > > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
> >=20
> > What commands are you running to generate and send your patch series?
> >=20
> > The patches must be threaded properly.
> >=20
> > `git send-email` or `b4` both do what is expected without any effort
> > required. Please consider using them, particularly b4, if you're not
> > already.
> >=20
> > Andrew
>=20
> We use `git format-patch` and `git send-email` command to generate and
> send patch series as below, could you help to check?  Thank you.
>=20
> git format-patch -2 --cover-letter
>=20
> git send-email --smtp-debug --to=3Drobh@kernel.org
> --to=3Dkrzk+dt@kernel.org --to=3Dconor+dt@kernel.org --to=3Djoel@jms.id.a=
u
> --to=3Dandrew@codeconstruct.com.au --to=3Dpatrick@stwcx.xyz
> --to=3Ddevicetree@vger.kernel.org
> --to=3Dlinux-arm-kernel@lists.infradead.org
> --to=3Dlinux-aspeed@lists.ozlabs.org --to=3Dlinux-kernel@vger.kernel.org
> --cc=3Dyang.chen@quantatw.com --cc=3Djerry.lin@quantatw.com *.patch
>=20

So from the details in the cover letter I'm guessing that you're using
Ubuntu 22.04 LTS (Jammy). At least, Jammy ships git-2.34.1, which is
what is mentioned in the cover letter.

The --thread option in the man-page for git-format-patch[1] says:

   The default is --no-thread, unless the format.thread configuration is
   set. If --thread is specified without a style, it defaults to the style
   specified by format.thread if any, or else shallow.
  =20
   Beware that the default for git send-email is to thread emails itself.
   If you want git format-patch to take care of threading, you will want
   to ensure that threading is disabled for git send-email.

[1]: https://manpages.ubuntu.com/manpages/jammy/en/man1/git-format-patch.1.=
html

The --thread option in the man-page for git-send-email[2] says:

   If disabled with "--no-thread", those headers will not be added (unless
   specified with --in-reply-to). Default is the value of the
   sendemail.thread configuration value; if that is unspecified, default
   to --thread.

[2]: https://manpages.ubuntu.com/manpages/jammy/en/man1/git-send-email.1.ht=
ml

Since you're not supplying any thread-related arguments in either case,
I wonder if you have thread values set in your git config. What's the
output of the following two commands for you?

   $ git config --show-scope --get format.thread
   $ git config --show-scope --get sendemail.thread

Regardless, you may want to try passing `--thread` in your `git send-
email` invocation.

Finally, please pass `-v $X` to `git format-patch` to version your
series (the value for X is how many times you've sent revisions of the
series). Currently I count 3 distinct attempts, so next time you send
out the patches you should pass `-v 4`. However, the b4 tool is helpful
here, as it largely automates the process for you.

Andrew

