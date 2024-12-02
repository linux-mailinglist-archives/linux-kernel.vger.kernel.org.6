Return-Path: <linux-kernel+bounces-427776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64559E0626
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E65016F4B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A020D4F3;
	Mon,  2 Dec 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMXUSJXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4D205AA7;
	Mon,  2 Dec 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150735; cv=none; b=uLd0O7keXYfhDvnF25rSOJvPdWWk87vi6k5Llz05BCEHJqDqQ74JHuoAibJQ7UkM1WC2UzruXkEREWyDURNRneAxuUVviQOqga6HXhlrOnc+u4Qh7aqMQdTbjeDT0jjKUxXgZAKgEMXC5w7gDs7pDeWLofpMU9TTLxvi4386ArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150735; c=relaxed/simple;
	bh=e2rrDEvywhWQ4EYBH710HTQ+e9cR3+UR3KpwBFubgGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYy1O2b+EXy90Z0cqQHnayK7hEMM+nKV72tohLHdlUoIwCoB0dtEGWIgL3TEl9wWBRLSPOdpD+lSmZDNKRLN+XXrblBElNjH+vrZWINao4YK1fupViatHwOtyHiNKazfIrUHYCf9SUivBpA7SaYBWHgV/agiBmIr2ahLaM1gBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMXUSJXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01C2C4CED1;
	Mon,  2 Dec 2024 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733150733;
	bh=e2rrDEvywhWQ4EYBH710HTQ+e9cR3+UR3KpwBFubgGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMXUSJXN1sJprPP/MAKp26mqjC9wMzmY0Uxt2Y2UdAB/VSnFvr54zgl+YPoNxnXgI
	 m2w8OrW6lrIuDDbzBnCmDWqN0rsAqrfeEXTpb5QvTIUuvb4RAQNYzNaFbDaxZZmOZs
	 vfyR2I2exHKSi5Ax/QenpaSef4f3XH+7/YoQCoz+jzaUAa3Uxml17IyIzN3vtPXv+b
	 eIM2DAqEZC0SjQaIRc2w5pEDS9caK69qva2Mv4roOOD3OYm24/Rrle9+Ujch3l7hwp
	 nzPBboiG00zkUL7EQ+0dJ9fP4Ybmtd59Y+AmDNCDTSFUEuoPyTXO9k/rAng/pcI2tu
	 7CkZgp/xRSx3A==
Date: Mon, 2 Dec 2024 15:45:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
Message-ID: <20241202154528.7949e7cb@foz.lan>
In-Reply-To: <d8cae2d3-d855-404b-8991-f81c979486ce@leemhuis.info>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
	<20241202092857.7d197995@foz.lan>
	<20241202110210.5e56d69e@foz.lan>
	<d8cae2d3-d855-404b-8991-f81c979486ce@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Mon, 2 Dec 2024 14:54:56 +0100
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 02.12.24 11:02, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Dec 2024 09:28:57 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >  =20
> >>> +Tagging people requires permission
> >>> +----------------------------------
> >>> +
> >>> +Be careful in the addition of tags to your patches, as all except fo=
r Cc:,
> >>> +Reported-by:, and Suggested-by: need explicit permission of the pers=
on named.
> >>> +For the three aforementioned ones implicit permission is sufficient =
if the
> >>> +person contributed to the Linux kernel using that name and email add=
ress
> >>> +according to the lore archives or the commit history -- and in case =
of
> >>> +Reported-by: and Suggested-by: did the reporting or suggestion in pu=
blic.
> >>> +Note, bugzilla.kernel.org is a public place in this sense, but email=
 addresses
> >>> +used there are private; so do not expose them in tags, unless the pe=
rson used
> >>> +them in earlier contributions. =20
>=20
> First: thx for your Review-by given earlier!
>=20
> > Hmm... There is another tag that we use without requiring explicit perm=
issions:
> >=20
> > 	Requested-by:
> >=20
> > There are currently 376 occurrences on 6.13-rc1.
> >=20
> > This is used when a maintainer or reviewer publicly requests some chang=
es to
> > be added on a patch series. =20
>=20
> Hmmm, that is one of those "grey area" tags[1], as it's not documented
> yet afaics ('grep -ir Requested-by Documentation/
> scripts/get_maintainer.pl' gave nothing).=20

> Documenting it would make it
> official; I'm not sure if that is wanted and say that is something that
> should be done independently if somebody wants to make it official.

No, my intention is not to make requested-by (or its variant suggested-by)
official.

The issue is that, when it is said there that
"all except CC/Reported-by/reviewed-by", plus considering other
other hunks of this patch like:

	"is one of only three tags you might be able to use without
	 explicit permission"

You're basically requesting explicit permission for any "non-official"
tags as well, including reviewed-by. This is not what it is wanted here.

See, if we run:

	$ git log --pretty=3D"%b" 1da177e4c3f4..v6.13-rc1 |grep -Ei "^[a-z\-]+: .*=
@.*"|cut -d: -f 1|tr A-Z a-z |sort|uniq -c|wc -l
	764

There are 764 tags (and 764 ones, for the last 2 years) that are e-mails=20
r e-mail related tags. Among them, there are several ones that comes
from the message-id (which may disclose the hostname that was used
during patch development).

The top 20 being:

    185 debugged-by
    240 co-authored-by
    367 requested-by			# doesn't need explicit ack
    563 reviewed-and-tested-by
   1505 to				# doesn't need explicit ack
   1757 author				# doesn't need explicit ack
   2857 closes				# with message IDs?
   3204 reported-and-tested-by
   3451 from				# doesn't need explicit ack
   5106 lkml-reference			# with message IDs?
   6616 message-id			# message IDs
   6858 co-developed-by
  18996 suggested-by			# doesn't need explicit ack
  64529 reported-by
  72321 tested-by
 213673 acked-by
 310825 link				# with message IDs?
 367140 reviewed-by
 739926 cc
2446984 signed-off-by

=46rom that, besides the 3 you mentioned, at least 5 don't seem to require
an explicit ack: author, from, to, requested-by, suggested-by.

Thanks,
Mauro

