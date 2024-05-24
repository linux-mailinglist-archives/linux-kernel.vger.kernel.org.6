Return-Path: <linux-kernel+bounces-189148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98AC8CEBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F751C20EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83185C41;
	Fri, 24 May 2024 21:27:46 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7883CBD
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586066; cv=none; b=Qj+iXiMS//1jmt3aC8XcNPyOq18TEZoq3yFv/KLaevMvUxB4v+mD/epXm0g4B6f0/UbdsOtNrfeL8qEj+HMutPUozsnJMfReT1P+HgXi364tcTO0vNZOUptdDorVf29/MrTAaW4e4VP9H64SMufkQ3+gDGZZukHvxAIZ7gkOzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586066; c=relaxed/simple;
	bh=6LUbgEU1sHvRL09NLMAPira3jisNG7ZtwY9v2d7Go5s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cbwiuNXv9NX5R5Z+pfGoFNiJJi/XsHu3jBhpG7ElDbTMumnrFZ5lWBThzuzytcd536HWhlxFugsw9XUugV6C23/1C6NPTddCahJEracSWMv861MVJP1xUe4zrXv+nXB5gf6t9qHQR6CGKp1lL9V4HYZgEAi70EAgJhfUXNfMhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 497716195FCA;
	Fri, 24 May 2024 23:27:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FgmitsyXq52a; Fri, 24 May 2024 23:27:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C0C306195FCC;
	Fri, 24 May 2024 23:27:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WOanlW2rmycA; Fri, 24 May 2024 23:27:42 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9BDD86195FCA;
	Fri, 24 May 2024 23:27:42 +0200 (CEST)
Date: Fri, 24 May 2024 23:27:42 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: kernel test robot <lkp@intel.com>, david <david@sigma-star.at>, 
	oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <39518719.144820.1716586062550.JavaMail.zimbra@nod.at>
In-Reply-To: <D1I6WMDSLOW0.2RS18E7T61X9A@kernel.org>
References: <202405240610.fj53EK0q-lkp@intel.com> <1855855000.144805.1716584815663.JavaMail.zimbra@nod.at> <D1I6WMDSLOW0.2RS18E7T61X9A@kernel.org>
Subject: Re: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:
 sparse: incorrect type in assignment (different base types)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse: incorrect type in assignment (different base types)
Thread-Index: YxKdVb/v6foZyOVf4L0HtOwHX9OJ0Q==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jarkko Sakkinen" <jarkko@kernel.org>
> An: "richard" <richard@nod.at>, "kernel test robot" <lkp@intel.com>
> CC: "david" <david@sigma-star.at>, "oe-kbuild-all" <oe-kbuild-all@lists.l=
inux.dev>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "david oberhollenzer" <david.oberhollenze=
r@sigma-star.at>
> Gesendet: Freitag, 24. Mai 2024 23:24:30
> Betreff: Re: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: spa=
rse: incorrect type in assignment (different
> base types)

> On Sat May 25, 2024 at 12:06 AM EEST, Richard Weinberger wrote:
>> >| Reported-by: kernel test robot <lkp@intel.com>
>> >| Closes:
>> >| https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel=
com/
>> >=20
>> > sparse warnings: (new ones prefixed by >>)
>> >>> security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse: inc=
orrect type
>> >>> in assignment (different base types) @@     expected restricted __le=
32
>> >>> [usertype] payload_len @@     got unsigned int @@
>> >   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     expecte=
d restricted
>> >   __le32 [usertype] payload_len
>> >   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     got uns=
igned int
>> >=20
>> > vim +206 security/keys/trusted-keys/trusted_dcp.c
>> >=20
>> >   179
>> >   180=09static int trusted_dcp_seal(struct trusted_key_payload *p, cha=
r *datablob)
>> >   181=09{
>> >   182=09=09struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
>> >   183=09=09int blen, ret;
>> >   184
>> >   185=09=09blen =3D calc_blob_len(p->key_len);
>> >   186=09=09if (blen > MAX_BLOB_SIZE)
>> >   187=09=09=09return -E2BIG;
>> >   188
>> >   189=09=09b->fmt_version =3D DCP_BLOB_VERSION;
>> >   190=09=09get_random_bytes(b->nonce, AES_KEYSIZE_128);
>> >   191=09=09get_random_bytes(b->blob_key, AES_KEYSIZE_128);
>> >   192
>> >   193=09=09ret =3D do_aead_crypto(p->key, b->payload, p->key_len, b->b=
lob_key,
>> >   194=09=09=09=09     b->nonce, true);
>> >   195=09=09if (ret) {
>> >   196=09=09=09pr_err("Unable to encrypt blob payload: %i\n", ret);
>> >   197=09=09=09return ret;
>> >   198=09=09}
>> >   199
>> >   200=09=09ret =3D encrypt_blob_key(b->blob_key);
>> >   201=09=09if (ret) {
>> >   202=09=09=09pr_err("Unable to encrypt blob key: %i\n", ret);
>> >   203=09=09=09return ret;
>> >   204=09=09}
>> >   205
>> > > 206=09=09b->payload_len =3D get_unaligned_le32(&p->key_len);
>>
>> I think this should be a put_unaligned_le32(p->key_len, &b->payload_len)=
.
>=20
> Please send then fix, reasoning of that, and finally:

Sure. Let me first talk to David and give it a test...

Thanks,
//richard

