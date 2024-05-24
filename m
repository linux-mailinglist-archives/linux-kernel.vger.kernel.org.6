Return-Path: <linux-kernel+bounces-189136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7598CEBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8AB20B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED085260;
	Fri, 24 May 2024 21:07:02 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17381736
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584822; cv=none; b=ma51TinZbZ5jTFqRlOqh3nlQtzGyUDrhmOes7uPGNlk48KA42wJLRAhZb7k/QdvKQ4iEveuj8QCSMNoK2Bnnoe1lgv7jaSEKsvCmIudTm95QgFnvCBnaln6bK/mIkC/4udbWCm1LkOPtq2+cHlt+aVoKQ78GOcjr9VDXQ4nNL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584822; c=relaxed/simple;
	bh=Sz6ZUVRXx17p9MUniuhApiR8QthQCg38UlEL+WVHPBM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TEVHO9KvEwWNsWrrhG2uDvd00Gh58plbg9PJ30co0ippe30tigxe3ejqJr1oMx+/oRWiiohoh2YOu+kQ5ocFB61RBj7k/JlIQJ5M+6PQNcp4TObSOGKyIj3hyUNfCdIC2VxVeSBK3h+oZuXt2iSNXUxmvs7IEffj8Fi9enPFHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A555962348A5;
	Fri, 24 May 2024 23:06:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id TY85XimMHdoO; Fri, 24 May 2024 23:06:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EEDA96195FD9;
	Fri, 24 May 2024 23:06:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hq2mlyIH99_G; Fri, 24 May 2024 23:06:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD1CE6195FCC;
	Fri, 24 May 2024 23:06:55 +0200 (CEST)
Date: Fri, 24 May 2024 23:06:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: kernel test robot <lkp@intel.com>
Cc: david <david@sigma-star.at>, oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <1855855000.144805.1716584815663.JavaMail.zimbra@nod.at>
In-Reply-To: <202405240610.fj53EK0q-lkp@intel.com>
References: <202405240610.fj53EK0q-lkp@intel.com>
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
Thread-Index: CtnofoC0Fpa85+mbFcGqHZ2NTw79OQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "kernel test robot" <lkp@intel.com>
> An: "david" <david@sigma-star.at>
> CC: "oe-kbuild-all" <oe-kbuild-all@lists.linux.dev>, "linux-kernel" <linu=
x-kernel@vger.kernel.org>, "Jarkko Sakkinen"
> <jarkko@kernel.org>, "richard" <richard@nod.at>, "david oberhollenzer" <d=
avid.oberhollenzer@sigma-star.at>
> Gesendet: Freitag, 24. Mai 2024 00:48:26
> Betreff: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse:=
 incorrect type in assignment (different base
> types)

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
> master
> head:   6d69b6c12fce479fde7bc06f686212451688a102
> commit: 2e8a0f40a39cc253002f21c54e1b5b995e5ec510 KEYS: trusted: Introduce=
 NXP
> DCP-backed trusted keys
> date:   2 weeks ago
> config: arm-randconfig-r112-20240524
> (https://download.01.org/0day-ci/archive/20240524/202405240610.fj53EK0q-l=
kp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce:
> (https://download.01.org/0day-ci/archive/20240524/202405240610.fj53EK0q-l=
kp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes:
>| https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.co=
m/
>=20
> sparse warnings: (new ones prefixed by >>)
>>> security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse: incorr=
ect type
>>> in assignment (different base types) @@     expected restricted __le32
>>> [usertype] payload_len @@     got unsigned int @@
>   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     expected r=
estricted
>   __le32 [usertype] payload_len
>   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     got unsign=
ed int
>=20
> vim +206 security/keys/trusted-keys/trusted_dcp.c
>=20
>   179
>   180=09static int trusted_dcp_seal(struct trusted_key_payload *p, char *=
datablob)
>   181=09{
>   182=09=09struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
>   183=09=09int blen, ret;
>   184
>   185=09=09blen =3D calc_blob_len(p->key_len);
>   186=09=09if (blen > MAX_BLOB_SIZE)
>   187=09=09=09return -E2BIG;
>   188
>   189=09=09b->fmt_version =3D DCP_BLOB_VERSION;
>   190=09=09get_random_bytes(b->nonce, AES_KEYSIZE_128);
>   191=09=09get_random_bytes(b->blob_key, AES_KEYSIZE_128);
>   192
>   193=09=09ret =3D do_aead_crypto(p->key, b->payload, p->key_len, b->blob=
_key,
>   194=09=09=09=09     b->nonce, true);
>   195=09=09if (ret) {
>   196=09=09=09pr_err("Unable to encrypt blob payload: %i\n", ret);
>   197=09=09=09return ret;
>   198=09=09}
>   199
>   200=09=09ret =3D encrypt_blob_key(b->blob_key);
>   201=09=09if (ret) {
>   202=09=09=09pr_err("Unable to encrypt blob key: %i\n", ret);
>   203=09=09=09return ret;
>   204=09=09}
>   205
> > 206=09=09b->payload_len =3D get_unaligned_le32(&p->key_len);

I think this should be a put_unaligned_le32(p->key_len, &b->payload_len).

Thanks,
//richard

