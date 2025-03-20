Return-Path: <linux-kernel+bounces-569421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D1A6A2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB58F189DE33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C8224249;
	Thu, 20 Mar 2025 09:32:07 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E42221DA0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463127; cv=none; b=JK0oegQIuHUD8invuAAoMJ1VisgN6DXGupwVl94GFq+ck187UE37f3VNvgtPxe2UJTQQTPuOOmLXuayoyTJ7D8ZGNHbTYfr09x80b4WzTuaeDGUoT2zvOYZbn7XCBiSqE+ccI2PrPk5k+EIU/+ckrx4QfuQmKiAcJc7ecvdZ1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463127; c=relaxed/simple;
	bh=cP96Ga6Wb2QsqdS2mmypFULWz7tPrLEpp/5d+TrLzAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3iToiBayRfTn+vNIQ+liKn5VbqTF+Dhn4PY5FWGZJxygR0iEws83bQbC4Fbn+8q2PUCJHqR4ITkNXM0heQS84pomxyW97EiVJzbng/U46tob7jbrbyoEwQ0eW1BxHCNSU7GJ97nEUV+H/T5TzABKrkYy8hXOpdDPjMaX+04JKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id A88995FE16;
	Thu, 20 Mar 2025 10:31:12 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCHv2 0/6] make vendor specific subdirectory inclusion conditional
Date: Thu, 20 Mar 2025 10:01:45 +0100
Message-ID: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5893241.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5893241.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Date: Thu, 20 Mar 2025 10:01:45 +0100
Message-ID: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

I found it strange that the vendor specific subdirectories were uncondition=
ally=20
added. Everything in these directories obviously depends on the specific Kc=
onfig=20
option. This series cleans this up by making the directory itself depend on=
=20
the respective option which looks more natural to me.

I must confess that I am too lazy to find a good solution for the "arm/"=20
directory, so I left it as is.

Regards,

Eike

=2D--
Changes in v2:
=2D clean up subdirectory Makefiles to use obj-y now
=2D add arm/arm-smmu-v3 and iommufd patches
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
--nextPart5893241.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZ9vZeQAKCRCr5FH7Xu2t
/KzhBACEdmdr0bY0N6eQxB1byUc3X3h+0fMpnAPDybVl8uNLVdes2BnFk1VDMZCt
Etxao2Oyzq2vNJuDl8zYA8utbXiiIz0LeenQwyrVo1kgEev3GkJbqRwIkpyko3q/
K8Esb1BlIF85LDn81KbjQgi2YHG0fMEuRHID/dL2/4SUbTConw==
=+N/3
-----END PGP SIGNATURE-----

--nextPart5893241.DvuYhMxLoT--




