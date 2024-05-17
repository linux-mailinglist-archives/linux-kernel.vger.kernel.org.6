Return-Path: <linux-kernel+bounces-181897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6478C82FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D91F21CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C41DDDB;
	Fri, 17 May 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kc+TOi2N"
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F522F00;
	Fri, 17 May 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936925; cv=none; b=dXppO6eeynLo0hZrnetIy6sraOySZDOkDP3y3vVv9bHF6fc09hOuxN1iYDoO4NhL33gr/xe8itj6yEq39QEWfOgbFy5EWuO0NvTtrnTZfZ01Odlgr2cJwTC/kDoHjFYKBsEFTdNl0RlvE0lPhs40wcMJhv6DiGjAyeGsSBG1D2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936925; c=relaxed/simple;
	bh=iNBDFhCBNE67NN1Yc2iWdFblOh/QlI+R0LFCWkmYMCM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4xWvEjJsvxsmpPc5DBNO3X3krXbf38Tp9/cKHVeiIO8dsVyr6Js/Y+gTUcpPE/C7G0z3uRMTuIwYbS8phHq5MF0/vF+2Yn9yzV7w3uX6gR9MGORV3PW5ugASCm43/RVOXrOmd5qmSxA9bpqtuhWuIHKug4BQwHE6xey/dB0yxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kc+TOi2N; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1715936914; x=1716196114;
	bh=iNBDFhCBNE67NN1Yc2iWdFblOh/QlI+R0LFCWkmYMCM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kc+TOi2NB0ZHC9etZ2NzJ+JrvRuEICAtejvfHHqq6+YLRuGH+K9iuAv2p637pYUIO
	 CrADfXuZg/ME9WLxifmqeggb4fGPKXsuZ4N7MoTF4RgpsGB+JUWgZLHw12epuk/DNc
	 +aEXgLA60RWimEDABfBX0eZwXnelGnwkex1YVGt4mWp3WFCwH9CLeWvLGl8lFzLNv1
	 Z8lXkKhsa3DgL0DnCnoVUCMR7SaoF2Ry6rwCkDGNh0XifjrVI+dcaEk4ZfvCim0Bbm
	 gb2OTYFQRQu2zXteWNKnicQcj8CZOEQc8AwWDIkMnUvHZ50UrQbrWWGLhbt+gdDAdH
	 3FNj/P1hfgO7A==
Date: Fri, 17 May 2024 09:08:30 +0000
To: Conor Dooley <conor@kernel.org>
From: Kanak Shilledar <kanakshilledar111@protonmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: process: Revert "Document suitability of Proton Mail for kernel development"
Message-ID: <hVKtRvWc18nNqYLUeYn_BDrvTbCR9tNZkgwvHBU3xGFdJjuNuQz-mT3o2QcsHFy4QyXOzwlnFXu_cM5pJxEhBeNa9jV_z6uZf83PO4OoCGk=@protonmail.com>
In-Reply-To: <20240516-tattered-rival-f443328b5971@spud>
References: <20240516-groin-slingshot-c3c3734d2f10@spud> <4oW9pC38sSYZn96BW8abMfVpDDCmG4MDHwwmL73o5bP-WyHAutJ5j2GrSU17MCSWOKufViNl4q2zZUmwmN40evP5OK3QiMnUn2hsgWCYhl4=@protonmail.com> <20240516-tattered-rival-f443328b5971@spud>
Feedback-ID: 26271244:user:proton
X-Pm-Message-ID: bc97481a8a38a7ca766e1c040cb2e186f58efdfc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Sent with Proton Mail secure email.

On Thursday, May 16th, 2024 at 9:34 PM, Conor Dooley <conor@kernel.org> wro=
te:

> On Thu, May 16, 2024 at 04:00:10PM +0000, Kanak Shilledar wrote:
>=20
> > On Thursday, May 16th, 2024 at 9:05 PM, Conor Dooley conor@kernel.org w=
rote:
> >=20
> > > From: Conor Dooley conor.dooley@microchip.com
> > >=20
> > > Revert commit 1d2ed9234c85 ("Documentation: process: Document
> > > suitability of Proton Mail for kernel development") as Proton disable=
d
> > > WKD for kernel.org addresses as a result of some interaction with
> > > Konstantin on social.kernel.org
> > >=20
> > > Signed-off-by: Conor Dooley conor.dooley@microchip.com
> > >=20
> > > ---
> > >=20
> > > I tried to find the stuff on social.korg to provide a link
> > > but could not.
> > >=20
> > > CC: kanakshilledar111@protonmail.com
> > > CC: Konstantin Ryabitsev konstantin@linuxfoundation.org
> > >=20
> > > CC: Mark Brown broonie@kernel.org
> > >=20
> > > CC: Jonathan Corbet corbet@lwn.net
> > >=20
> > > CC: workflows@vger.kernel.org
> > > CC: linux-doc@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > > ---
> > > Documentation/process/email-clients.rst | 20 --------------------
> > > 1 file changed, 20 deletions(-)
> > >=20
> > > diff --git a/Documentation/process/email-clients.rst b/Documentation/=
process/email-clients.rst
> > > index 471e1f93fa09..fc2c46f3f82d 100644
> > > --- a/Documentation/process/email-clients.rst
> > > +++ b/Documentation/process/email-clients.rst
> > > @@ -350,23 +350,3 @@ although tab2space problem can be solved with ex=
ternal editor.
> > >=20
> > > Another problem is that Gmail will base64-encode any message that has=
 a
> > > non-ASCII character. That includes things like European names.
> > > -
> > > -Proton Mail
> > > -***********
> > > -
> > > -Proton Mail has a "feature" where it looks up keys using Web Key Dir=
ectory
> > > -(WKD) and encrypts mail to any recipients for which it finds a key.
> > > -Kernel.org publishes the WKD for all developers who have kernel.org =
accounts.
> > > -As a result, emails sent using Proton Mail to kernel.org addresses w=
ill be
> > > -encrypted.
> > > -Unfortunately, Proton Mail does not provide a mechanism to disable t=
he
> > > -automatic encryption, viewing it as a privacy feature.
> > > -The automatic encryption feature is also enabled for mail sent via t=
he Proton
> > > -Mail Bridge, so this affects all outgoing messages, including patche=
s sent with
> > > -`git send-email`.
> > > -Encrypted mail adds unnecessary friction, as other developers may no=
t have mail
> > > -clients, or tooling, configured for use with encrypted mail and some=
 mail
> > > -clients may encrypt responses to encrypted mail for all recipients, =
including
> > > -the mailing lists.
> > > -Unless a way to disable this "feature" is introduced, Proton Mail is=
 unsuited
> > > -to kernel development.
> >=20
> > Instead of completely removing the Proton Mail section, can we keep the
> > mention about the Proton Mail bridge and the third-party hydroxide
> > (https://github.com/emersion/hydroxide) bridge.
>=20
>=20
> I think that is probably reasonable, but I think writing the replacement
> text is up to someone who actually uses protonmail.

Alright! I will tryout hydroxide and roll out another patch in near future.
For now the patch looks good.

Reviewed-by: Kanak Shilledar <kanakshilledar111@protonmail.com>

Thanks and Regards,
Kanak Shilledar

