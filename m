Return-Path: <linux-kernel+bounces-569293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B1A6A109
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2A07A36E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE9C3597B;
	Thu, 20 Mar 2025 08:17:52 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA92AE74
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458672; cv=none; b=dJec9o7QDk5LXc1hjNDHnwXXkZlxgThFGKqkJxXoz8oVy9d8qD27/mn3oKQhz/xt47eFJ83SfJRhSusv6EuYVC6EIJ7BpWKP6c8SbxFVuH8v7+YFMkK7dJgv+fCveGNkMl3I/Xm2WaXGqh5/AQjJsaUwakGILFdrKfVvPvvASag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458672; c=relaxed/simple;
	bh=4mjAa+nyl0BSHp8qtJKT+jbtIMlL+xyANc9xP6daZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJB5j+VMVuN5/l0jSjxa+koUvuksT+3525yD29LlxQkkklhVdDTNWSYC8moLeID4OPnSa39Z8k2oXuNSCR5PcduKKwFGq3/qp68b6lo2bo519roPJnLlqIczo9Ce0rWzveFvpkVND6ZYmnqjA2UUFA+5J2FKmDXj9afNw9GNgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id BD2775F88D;
	Thu, 20 Mar 2025 09:10:40 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 4/4] iommu: make inclusion of riscv directory conditional
Date: Thu, 20 Mar 2025 09:10:34 +0100
Message-ID: <2365431.ElGaqSPkdT@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <Z9vMwUQ679SdSwhG@8bytes.org>
References:
 <2301497.iZASKD2KPV@devpool47.emlix.com>
 <3536592.QJadu78ljV@devpool47.emlix.com> <Z9vMwUQ679SdSwhG@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4971840.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4971840.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Thu, 20 Mar 2025 09:10:34 +0100
Message-ID: <2365431.ElGaqSPkdT@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <Z9vMwUQ679SdSwhG@8bytes.org>
MIME-Version: 1.0

On Donnerstag, 20. M=C3=A4rz 2025 09:07:29 Mitteleurop=C3=A4ische Normalzei=
t Joerg=20
Roedel wrote:
> On Tue, Mar 11, 2025 at 11:15:12AM +0100, Rolf Eike Beer wrote:
> > Nothing in there is active if CONFIG_RISCV_IOMMU is not enabled, so the
> > whole directory can depend on that switch as well.
> >=20
> > Fixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device
> > driver") Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> > ---
> >=20
> >  drivers/iommu/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 41b00cdc8621..17133876f777 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -1,7 +1,8 @@
> >=20
> >  # SPDX-License-Identifier: GPL-2.0
> >=20
> > -obj-y +=3D arm/ iommufd/ riscv/
> > +obj-y +=3D arm/ iommufd/
> >=20
> >  obj-$(CONFIG_AMD_IOMMU) +=3D amd/
> >  obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
> >=20
> > +obj-$(CONFIG_RISCV_IOMMU) +=3D riscv/
> >=20
> >  obj-$(CONFIG_IOMMU_API) +=3D iommu.o
> >  obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
> >  obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
>=20
> This allows for some additional cleanups in the Makefiles of the
> sub-directory, no? Same for the other patches in this series.

Yes, and I can send those cleanups as a followup if you like. But for the f=
irst=20
step I wanted to keep this as less invasive as it could be. And to be hones=
t I=20
didn't want to invest time to do this cleanups if it's unclear if they woul=
d=20
be rejected anyway because these things are this way on purpose.

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart4971840.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZ9vNegAKCRCr5FH7Xu2t
/NdZBACSGqKgQgJa4SmTU/OK6oUG11vk94MlA62E75QJ0SJrm89SOhFQgEALSEEe
TXyuy+HkWvvUO5X+K1KaKPhP7STk73+OqqqXS1MHU9/+sOXw97us5R/awRy+SDhE
/QJDDJGaO43pqnLvqI1+fxPYwz7qAw1fMdojAQhTh40iyI591w==
=NJZm
-----END PGP SIGNATURE-----

--nextPart4971840.GXAFRqVoOG--




