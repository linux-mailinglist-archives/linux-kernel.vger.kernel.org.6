Return-Path: <linux-kernel+bounces-189143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A898CEBC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D6E1C20FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98E85264;
	Fri, 24 May 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6J1ClIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567C29403;
	Fri, 24 May 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585874; cv=none; b=A7dyG3eQwYOf34gRO0cLJs2kro/L1zXPlN/2cnAcewFP8+6tbjhznJRFiYBP0guoAqzPT/QVDTv0MPcWGDqhezJJNPbigsjmGwdG+Xlv8z0HwSjW35t3FAqZf1fYke2sypJarIr9GjvlTaV1eZR6jU9ioganLrRDhVP4RnwHjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585874; c=relaxed/simple;
	bh=ZVPg8EMx0Yr6yPElmIUEkpUwH0oSsvKTxevOdlxBNxI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hGjJoxDDAwHD0L0O4BO2v2Xx5NXB0kmQ2rX8Jxvxbr68St37cSnCd3q7RzcYirGX45OCUvV/jnEc/3Ae+h1hqCs5hhXSONdcJmZP2wrGC090L4UBSORBojHOXo6rXoy5IKv/ZLIzIGxLhRdmAU9DHD0nrUafC3QMXnVSfiasDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6J1ClIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B325CC2BBFC;
	Fri, 24 May 2024 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716585874;
	bh=ZVPg8EMx0Yr6yPElmIUEkpUwH0oSsvKTxevOdlxBNxI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F6J1ClIK/S5O+G6GhHyDpJt5o5KL5E+VS3FheUVROo53UdlMEojNnYsSStUS+R9yw
	 UC10CcHcy0pjGU+ivFhvQO4ikOXqQjNQzHipPspVJt3Z1wrImN5HYKu6xzR8xcAloy
	 FMfZ6hF9CTEtrod8mQIi4T6qleSicQFYxkqtgkCkT6poqYTs2aWmMqXdh4vNOw8J3p
	 cqzbYAZjCc2cjHtbc/O9LS9VPL4IuUih1ysCu0pEklQ0KScMHaVksP6hMQwe2u/uC6
	 Nzi/GBYWD2h6VWw05InFZsKFZYGEBEbGTojIrUBfB3EVYsgmVtfYNQ+dGTMkoZmHi7
	 Y7KKqD8fC2LCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 May 2024 00:24:30 +0300
Message-Id: <D1I6WMDSLOW0.2RS18E7T61X9A@kernel.org>
Cc: "david" <david@sigma-star.at>, "oe-kbuild-all"
 <oe-kbuild-all@lists.linux.dev>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "david oberhollenzer"
 <david.oberhollenzer@sigma-star.at>
Subject: Re: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:
 sparse: incorrect type in assignment (different base types)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Richard Weinberger" <richard@nod.at>, "kernel test robot"
 <lkp@intel.com>
X-Mailer: aerc 0.17.0
References: <202405240610.fj53EK0q-lkp@intel.com>
 <1855855000.144805.1716584815663.JavaMail.zimbra@nod.at>
In-Reply-To: <1855855000.144805.1716584815663.JavaMail.zimbra@nod.at>

On Sat May 25, 2024 at 12:06 AM EEST, Richard Weinberger wrote:
> >| Reported-by: kernel test robot <lkp@intel.com>
> >| Closes:
> >| https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.=
com/
> >=20
> > sparse warnings: (new ones prefixed by >>)
> >>> security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse: inco=
rrect type
> >>> in assignment (different base types) @@     expected restricted __le3=
2
> >>> [usertype] payload_len @@     got unsigned int @@
> >   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     expected=
 restricted
> >   __le32 [usertype] payload_len
> >   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     got unsi=
gned int
> >=20
> > vim +206 security/keys/trusted-keys/trusted_dcp.c
> >=20
> >   179
> >   180	static int trusted_dcp_seal(struct trusted_key_payload *p, char *=
datablob)
> >   181	{
> >   182		struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
> >   183		int blen, ret;
> >   184
> >   185		blen =3D calc_blob_len(p->key_len);
> >   186		if (blen > MAX_BLOB_SIZE)
> >   187			return -E2BIG;
> >   188
> >   189		b->fmt_version =3D DCP_BLOB_VERSION;
> >   190		get_random_bytes(b->nonce, AES_KEYSIZE_128);
> >   191		get_random_bytes(b->blob_key, AES_KEYSIZE_128);
> >   192
> >   193		ret =3D do_aead_crypto(p->key, b->payload, p->key_len, b->blob_k=
ey,
> >   194				     b->nonce, true);
> >   195		if (ret) {
> >   196			pr_err("Unable to encrypt blob payload: %i\n", ret);
> >   197			return ret;
> >   198		}
> >   199
> >   200		ret =3D encrypt_blob_key(b->blob_key);
> >   201		if (ret) {
> >   202			pr_err("Unable to encrypt blob key: %i\n", ret);
> >   203			return ret;
> >   204		}
> >   205
> > > 206		b->payload_len =3D get_unaligned_le32(&p->key_len);
>
> I think this should be a put_unaligned_le32(p->key_len, &b->payload_len).

Please send then fix, reasoning of that, and finally:

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@int=
el.com/

> Thanks,
> //richard

BR, Jarkko

