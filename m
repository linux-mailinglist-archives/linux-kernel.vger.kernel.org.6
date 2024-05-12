Return-Path: <linux-kernel+bounces-176841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8C8C35C6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9F71C20C45
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E81CAB3;
	Sun, 12 May 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="KY+iSqsX"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464C18EB0;
	Sun, 12 May 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503729; cv=none; b=bdEWtiu9PWkDQcQarXM9Mv17iSeNes6owevFqLC/IR79Ewuyg0dDBL7fetzZAloUhvAU+RZ+2yen3JtgR/iOMXTp+Ato6/i+AE/TogZKp2lfIhcmdxxE30KQJfwN1bODK4XyDZswduC1/XCoxiW7x55KWjuDRBvvAXTC8WmLDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503729; c=relaxed/simple;
	bh=R8RO8aBLaka55Gq/3lS8uQ8AX1Pmr0nvvosQt44euyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=K1gjcG0MxIHsQvOSsEi+WJL2YJjC3akaIHfpZ/Qp5S+NHb0EKv2kTsjmnFySym8v0csxooshbqzjFxud1ASKAFRPYuZ2PgF690bc9ykoYu61A3nNpwoqtQC2TAlfq0/Lktoq3/CGhRxSWrRTG7A56R76eB7wRuntYk9/Lda8DYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=KY+iSqsX; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1715503699; x=1716803699;
	bh=jiUz6rePe05psAKtR82w0cLT+peUJK9N46yQy+W+TYY=; h=From;
	b=KY+iSqsX6oCx8uwjAzbO76XNdc4+hyMpTpm8XPY6iFSLzKkcW/OE7nwki/kHzfLwh
	 3imGJMt5f/kOHzchM9F00f4konskdrYgkB+aeQHLm918EW17cQwuNeuluUBxp1DVHw
	 osycE90vYQDMaQJWgvOckDZH3u9EXUlAXRfWdwTrzUId718b1ym5qvuAOfB7c3W/mh
	 H1sF2MrC6fuCpyyvZVKuQFxY3m4fVseTctZPQRyS7iUhcsHy+hzpUmgSPbzndYyy1N
	 eDX9pXsdtR9F+TQzmRCtYQt90rZnupQu6Ym30DEKMQyZPVv4mm8fn+3+lFt1OLZeUm
	 jBcJ5+tzZEYNA==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 44C8mF33076270
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 10:48:16 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 May 2024 10:48:15 +0200
Message-Id: <D17JB1SPR5SK.1B6BRVVU2Q6XN@matfyz.cz>
Subject: Re: [PATCH docs-next v2] docs: handling-regressions.rst: recommend
 using "Closes:" tags
To: "Thorsten Leemhuis" <linux@leemhuis.info>,
        "Jonathan Corbet"
 <corbet@lwn.net>, <regressions@lists.linux.dev>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240510183748.13028-1-balejk@matfyz.cz>
 <8ebe6545-de7e-4ee4-b36e-e91e90b90b70@leemhuis.info>
In-Reply-To: <8ebe6545-de7e-4ee4-b36e-e91e90b90b70@leemhuis.info>

Thorsten Leemhuis, 2024-05-12T09:47:31+02:00:
> On 10.05.24 20:34, Karel Balej wrote:
> > Update the handling-regressions guide to recommend using "Closes:" tags
> > rather than "Link:" when referencing fixed reports. The latter was used
> > originally but now is only recommended when the given patch only fixes
> > part of the issue, as described in submitting-patches. Briefly mention
> > that and also note that regzbot currently doesn't make a distinction.
> >=20
> > Also fix a typo.
> >=20
> > Signed-off-by: Karel Balej <balejk@matfyz.cz>
>
> Many thx for this, much appreciated. Looks good!
>
> Acked-by: Thorsten Leemhuis <linux@leemhuis.info>

Thanks!

> One quick note:
>
> > =20
> >  What's important when fixing regressions
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > @@ -112,10 +115,16 @@ remember to do what Documentation/process/submitt=
ing-patches.rst,
> >  :ref:`Documentation/process/5.Posting.rst <development_posting>`, and
> >  Documentation/process/stable-kernel-rules.rst already explain in more =
detail:
> > =20
> > - * Point to all places where the issue was reported using "Link:" tags=
::
> > + * Point to all places where the issue was reported using "Closes:" ta=
gs::
> > =20
> > -       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.=
Helsinki.FI/
> > -       Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D1234567890
> > +       Closes: https://lore.kernel.org/r/30th.anniversary.repost@klaav=
a.Helsinki.FI/
> > +       Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D123456789=
0
> > +
> > +   If you are only fixing part of the issue, you may use "Link:" inste=
ad as
> > +   described in the first document mentioned above.
>
> Not totally sure if...
>
> > Some maintainers may even
> > +   prefer it over "Closes:" entirely, although the latter is generally
> > +   recommended.
>
> ...this sentence really should be here, but whatever.

I think I can see your point. I added it as it was something you
mentioned before but looking now at that mail again, I think this is not
really what you said. So I'm in favour of dropping it.

If you give me a go-ahead, I will send v3 with this sentence dropped and
your Ack added right back.

Thanks, kind regards,
K. B.

