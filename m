Return-Path: <linux-kernel+bounces-368127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1CB9A0B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EE61F25E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF93A8F0;
	Wed, 16 Oct 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="H+4Bd0ah"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8F1D8E1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085652; cv=none; b=g21zinjvk+t58fczWSCYyVcHlzBo56P+3tlRgOaV6M1BWGotvY0qzvRJNgdtLoavoNaaqM2zjXviw8bgWQRZYlMptUPvmLQSHhezpqIHWzVqJCoD5QAaGER6fz1jrbIPonS4SK0J00Ti5+SlVZWilkHYCKukB9HR0d3iTvC/23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085652; c=relaxed/simple;
	bh=Wm6j0HHXHr6rZrgJv9XtSE7kyw4KMDFQKc6FGm2m+C0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBMjbdMEx1fHFQEFzhn6t60g+bFCqWNMbJ2hMgi6BuLGhXkMDnMspMlG8Dq4GeuoYgIYTmBqJZoS7/MM/c0Jbm21vGFkw/h0R6CktO0/6YwVBHls9+lQgVpbvwxKs2G1MqC2sfE+XyycKEJwx8yyx6VVDw/SSCmwKoqi9ylDozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=H+4Bd0ah; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729085649; x=1729344849;
	bh=Wm6j0HHXHr6rZrgJv9XtSE7kyw4KMDFQKc6FGm2m+C0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H+4Bd0ahESOKUsvwcjZf2E7HUqPfEvb+dzskyu50OGVSduieOznONkKb72qNivKZW
	 Q8GcWbmqioajaH98BLz2tHhtOTOey50VIuRxjBdhUOqXc0DhbdBJasxDS/d82jKfeX
	 254jBfhAHwvNvQg1wbeCFf80Md7l9MVnyiwA4T2WRbDqZl5QrFJVJ7p01XfGTHrGDu
	 4Xw3UkEOh53QMsYnYB4rPDEmKn6vF+pSw11cAJ+L20KCu/rH6vjMIndrz6+lkCYWP8
	 hTSRAnehXzleSsojRVjiseVNEdDBEgxELUM74haoLODapNNI6MPuujOQV8t+FI1Nq9
	 jCSZ2oHvGwkkA==
Date: Wed, 16 Oct 2024 13:34:07 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: gpib: Add TODO file
Message-ID: <B28HXaYBd4-AP7g9jMpXgQEcJIzAQUsaUqMerdy_Hk0tR2Q9RKTAmcYbtq3LR06X3yHj0R6D4bLJHEHCYsszgjvnfhgZ7K5QwOzx5JLNI_A=@protonmail.com>
In-Reply-To: <2024101609-getaway-appendage-1f88@gregkh>
References: <20241015192838.16740-1-dominik.karol.piatkowski@protonmail.com> <2024101609-getaway-appendage-1f88@gregkh>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 5c17d14c4951bdc73c9970c4d97f82f5b669eed7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 16th, 2024 at 07:33, Greg KH <gregkh@linuxfoundation.=
org> wrote:

>=20
>=20
> On Tue, Oct 15, 2024 at 07:28:57PM +0000, Dominik Karol Pi=C4=85tkowski w=
rote:
>=20
> > Add a TODO file stub for the gpib driver.
> >=20
> > Signed-off-by: Dominik Karol Pi=C4=85tkowski dominik.karol.piatkowski@p=
rotonmail.com
> > ---
> > v2: Remove maintainers from TODO, as they can be found in MAINTAINERS f=
ile
> > drivers/staging/gpib/TODO | 2 ++
> > 1 file changed, 2 insertions(+)
> > create mode 100644 drivers/staging/gpib/TODO
> >=20
> > diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
> > new file mode 100644
> > index 000000000000..850dc1102e54
> > --- /dev/null
> > +++ b/drivers/staging/gpib/TODO
> > @@ -0,0 +1,2 @@
> > +TODO:
> > +- checkpatch.pl fixes
> > --
> > 2.34.1
>=20
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman. You have sent him
> a patch that has triggered this response. He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created. Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>=20
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - This looks like a new version of a previously submitted patch, but you
> did not list below the --- line any changes from the previous version.
> Please read the section entitled "The canonical patch format" in the
> kernel file, Documentation/process/submitting-patches.rst for what
> needs to be done here to properly describe this.
>=20
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>=20
> thanks,
>=20
> greg k-h's patch email bot

Hi Greg,

I listed the changes below the --- line. Probably I should have added extra
newline, or maybe even another --- line below the changes in order to not
trigger the patch-bot message and make it more readable. Maybe I should als=
o
explicitly use "V1 -> V2" instead of "v2" when listing changes? I am trying
to understand the filtering rules that are in use, in order to avoid this
situation in the future.

I see that in Documentation/process/submitting-patches.rst there is an extr=
a
newline after listed changes, would it be enough?

Thanks,

Dominik Karol

