Return-Path: <linux-kernel+bounces-570354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE8A6AF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050C09839CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4EF2288E3;
	Thu, 20 Mar 2025 20:36:04 +0000 (UTC)
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610051EFF9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502963; cv=none; b=cMBefe6PExD6PtRFEUgnKRaGCoBLe+6x7J++BTT6ZFTarLuVWwdGBTriKiS3SggBiipD7soQWMwHw9wi9PeV0o1WbY+8rwn8K4tLYrBhwQ/epiz07ko5LKLmMJHWUb4RDjSxvzr2cG+0OHGi+vm/w0SVN+9O+K+VRTbZC/v5U2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502963; c=relaxed/simple;
	bh=PfndGSLY+iboN6f9+gaut54Qgk8MXkVIEpXxkkY6nPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsW9bMw2k16qWjyxtGPay7jxhsUp+XlDkqpt0ZSbOMiFYb7x7qwLVyLGFtfqgZTvhrFP5VvjGFftooDJhPtfi4TQFASCrmkJW4ZTh3kHbCiu9OmUzw1fbLOikOpBVNWSeAojYZbc4fGsJaRZ3qk8uanY3VDNCywUv1bb/LwDA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Thu, 20 Mar 2025 21:26:56 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells on
 i2s nodes
Message-ID: <1742502327@msgid.manchmal.in-ulm.de>
References: <20250318192256.3534046-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f1DBgl1mI/wxhvd1"
Content-Disposition: inline
In-Reply-To: <20250318192256.3534046-1-robh@kernel.org>


--f1DBgl1mI/wxhvd1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rob Herring (Arm) wrote...

> On some powermacs `i2s` nodes are missing `#size-cells` properties,
> which is deprecated and now triggers a warning at boot since commit
> 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
> handling").

Tested-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>

Can confirm this makes the warning disappear on the both devices
reported earlier in private:

* PowerMac3,4 7400 0xc0209 PowerMac
* PowerMac11,2 PPC970MP 0x440101 PowerMac

--f1DBgl1mI/wxhvd1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmfcegwACgkQxCxY61kU
kv1a6g/9HC6bEykB/+61fjSoQVJI8E81MoUTox/RI2t3M8b7DNc5pGZpvQIAkF+P
ZIc40UuDVeN0w1JOpVU37apAYkJyT+hQPvzCpW2u86M1g+x7YkvN+2XU2TCgg5Hi
OwYcobc7zxJqmtJVF3tnairxP8gn7vofx5AwDn6fmtcgt+sL0XCxGCt0Xetp+kCv
eDu4I3+Jkil569H9xK25N2h/P0lO6G6wK0nXO82GUn6hxl7svRIbHPwcdqf+snP/
v9LRjepybJ8ZgGdYkOy0M8VN53lWQVTN8UOKBWiUNSssjhiYAa09/givmxdNJVeO
MbssmvmV8mHr/l6cxLwWn6cYfB6mi68KBhqDoNdhi6AorY5cjVevBDRnliCWYYel
xDpsIqWGigY1Q2ll1eL+GORL5FPW9r6YJPSQxLK3G3o169OULbVj1i8k6/y6dsEY
rHVVXH2f2zp3JjqvjP2yOhMJgz6q1abxYHQmfLVc6B670ni9hbStyODzsRMHsouv
fC/AzT7WfmkFzWRkWjiQ+2R14fOEMD63cFMSpBEaDBjK9nzAgpbI6ziv5MMIjqeY
jWOT1tvSeeTRsEjcwYWgnKR06icJlOLBWdkMsIDdmaVSraJdYOHIGPtHDlqYkOcI
dgGr4wql5qGt4YYoplZOWwkAKQSu+36zZojA5y4030Ervd5Vta0=
=HLvb
-----END PGP SIGNATURE-----

--f1DBgl1mI/wxhvd1--

