Return-Path: <linux-kernel+bounces-401811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA89C1F80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876A92828F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EDD1F131F;
	Fri,  8 Nov 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="WmMpNN/V"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93F38DC8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076785; cv=none; b=nEJLeZGWBa6NwG2q/bFx1OwvDfjcPtwnDl7wPnYZpn1Bnn9EI+Jnz2TNgqzjHEQwvAkZWJD4pGoD9sEVaZuCcl47gJsjDHfMtMNcR9iO3ELuovAMgghRJylhdCtTIWQjSmH7y5G5xpUQQ7lsSGievhee9zmVIzshRetUnVSEjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076785; c=relaxed/simple;
	bh=53qQR13oD92PNNQk+kdkbfDxG393O5NLmtcjVDp6qjs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject; b=M4v33bqP22cPbdp335UmpHSn6W1evEzNpDon3t6bRc5TTYJv63beGhmqRN1KjZzY+4HwjeNtRVK3ueW1G/QQhHHwnOhRvVkwN+HM+kFqko3sfD+Q+RoNfHGUlIwb+p140KSR/ejf4DVUSo6hPZpv3tnm6ItCZZGkDsXJembWq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=WmMpNN/V; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1731076780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jC6RQvdalAaD3FEmS6MVpWwqzOr/U1gTtWFRsxOXO2A=;
	b=WmMpNN/VRhm60XQWaSOd1o3BdHKeoKqGm9/1RxF0tQIkzkrEcr762T5SmCiXwMRsX20Bl6
	964+kLod+7CT8RTo+jdR2sgBesZojCKwGCqGvGFkGippzggnybF4arbF8f6FHmLe7cok+8
	AFD49u5XuinB4AFATHB1ANdHEMxsKKcZQAnE94YXG6eeaI0+O9twMeTsqa2Mac9nGfdmTj
	7QvB7z1l03OQnWBVdpOq3m/VXEhPQ4mP8unMeS3WfPsmWNQPpVSHurBftufKl7I++igf59
	6+3naGX9zCuSiN6PUMJkRt6h2mes1IrY/d6HISG0wZd9wNWfq8In37i1vdTzcA==
Content-Type: multipart/signed;
 boundary=71c104a0a8a0a912df6151f652c3536d0c5dbd311ec259957e1ff91df396;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 08 Nov 2024 15:39:30 +0100
Message-Id: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-rockchip@lists.infradead.org>, "Shawn Lin"
 <shawn.lin@rock-chips.com>, "Sudeep Holla" <sudeep.holla@arm.com>
Subject: Q: Kconfig: 'If unsure, say N'
X-Migadu-Flow: FLOW_OUT

--71c104a0a8a0a912df6151f652c3536d0c5dbd311ec259957e1ff91df396
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

In quite a number of Kconfig help text entries I see this:
"If unsure, say N."

But that raises the question: How can I be sure?

To me, this comes across as that the person who implemented the feature
recommends *against* using it, unless you think you know better then the
person who implemented it. Which is quite a high bar.

IIRC I did come across an entry which paraphrased said:
"This module can be useful in situation Y, but you run a real risk of
physically damaging your board when you use it.
So normally you REALLY should not enable this, but if you still need it
then the functionality is implemented in this module.

If unsure, say N."

Which is an excellent reason not to enable it ;-)
Moreover, it specifies when you can/should go against the advise and
tells you what the risk is if you do.

But the vast majority just says "If unsure, say N."

The problem is that I'd need a better justification to enable (as 'y' or
'm') a module then "Based on (the rest of) the Help text, this looks
really useful".

Not to discuss these specifically, but just for illustration:
``drivers/firmware/arm_scmi/transports/Kconfig`` has this
option: ``ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE``
which IIUC enables an *optional* feature for an atomic transaction.

Which sounds useful and harmless, yet ... "If unsure, say N."

And the trigger which caused me to actually write this email was
"scsi: ufs: rockchip: initial support for UFS"
which I interpret as: if you want to use UFS on Rockchip based devices,
you should enable this. But ... "If unsure, say N."

So it would be really helpful if the Kconfig help text:
1) did not say "If unsure, say N."
2) If the recommendation is indeed to NOT enable it ('normally'),
   specify why and under what situation/condition you can go against the
   maintainer/implementers recommendation

Cheers,
  Diederik

--71c104a0a8a0a912df6151f652c3536d0c5dbd311ec259957e1ff91df396
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZy4ipAAKCRDXblvOeH7b
bqMkAQC+MkAusJ4jN8vz+TnQ8cKySh54NYC+Uqvx6Mxbo3h9TAD9Fh6D/GyHLhJ4
6ek1YXYij0Te73Vj/b4O5NkeJC++ewQ=
=DMd0
-----END PGP SIGNATURE-----

--71c104a0a8a0a912df6151f652c3536d0c5dbd311ec259957e1ff91df396--

