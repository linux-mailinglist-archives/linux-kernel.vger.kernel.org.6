Return-Path: <linux-kernel+bounces-435946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C433C9E7F06
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6528170B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C071369BC;
	Sat,  7 Dec 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO9sW+EB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C518638
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560394; cv=none; b=JJEX6icQzXfCjh3SFhLBUqp29ce9j4PaPzvGqMBsdZEaCumc/s6Ag2NsxYev9BENs2fWwAQxg5s+GqdJ11xiVrxfBMzsGkwG7dYrelY25DP8JS/2pEJGfVjq7StF+1W5q8g34fKWPB1kw2VxVjzOHWxnvP5MuKFXq3FIIhvV6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560394; c=relaxed/simple;
	bh=ysUzu1cKx69rnPAx2aBIYuDYfVrYDTwWQl2sRqD/khs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbtVBKjpAHAZF0SK/CSwp26nCYToO6cASL04OxERIkh57Qi7Gz32w0Uez1DXtVARbv9/KaR7vr8BOEhE+pIiX+rZS+dPK8870xghpc5s8wQ4yqG7fKSCd+gG+DC8Z8QUYgWBaw6MwrSKzMWkaRdrhlQyWCSXVCkQNysEj6KNS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO9sW+EB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1EFC4CECD;
	Sat,  7 Dec 2024 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733560394;
	bh=ysUzu1cKx69rnPAx2aBIYuDYfVrYDTwWQl2sRqD/khs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MO9sW+EBvR7TU0rUpiDwFwskd0Er3xxOKVEdxCKeukUDoYo+uNGhtn7iLZIzZReDQ
	 4L2avSzyuimVpKNYoGUvnwBpJkmCWEiOK5aSpoSM51fFTSL5+OC64F0QiJtJ6TZWom
	 EQTpJWLZYUq0oKE6Krl1XR7onD7CffJyHvv4hsNGKDhgTmWxTGJqUwz3gvhsBfk0WN
	 NrSUQbdeDlZwJJFwqjvlUfWdahmZuvEnA14vpLEIoBxYFUzzYQYeXTlew2BsRvuaPj
	 99WDnJv0tkDhXilJnxpp1Thkh2smnLPmQpnHrgfPkzqhXTGjyZn9F3byvMaXNKOiSc
	 Lsb83FpqtXeyA==
Date: Sat, 7 Dec 2024 09:33:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 27/31] DEBUG
Message-ID: <20241207093308.55376e8e@foz.lan>
In-Reply-To: <87ser02f28.fsf@pond.sub.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
	<6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
	<CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
	<87ser02f28.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Sat, 07 Dec 2024 07:16:31 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Ani Sinha <anisinha@redhat.com> writes:
>=20
> > On Fri, Dec 6, 2024 at 10:51=E2=80=AFPM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote: =20
> >>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>  hw/acpi/ghes.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >> index abca351b18de..1fe4c536611a 100644
> >> --- a/hw/acpi/ghes.c
> >> +++ b/hw/acpi/ghes.c
> >> @@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, si=
ze_t len,
> >>      ags =3D &acpi_ged_state->ghes_state;
> >>
> >>      if (!ags->hest_lookup) {
> >> +        fprintf(stderr,"Using old GHES lookup\n"); =20
> >
> > I don't like this. If you must please have them under #ifdef DEBUG or
> > somesuch. See ich9.c =20
>=20
> Judging from the subject line, it's not meant to be posted, let alone
> merged :)

Sorry! Yea, this was not meant to be posted.

I ended submitting the entire pile of patches I have pending, including some
patches I placed at the end to test that what method is used to calculate
offsets (the one supported up to current QEMU version, which is limted,
and the new one that uses backport logic).

I'll submit the right patches again. Please ignore this.

Regards,
Mauro

