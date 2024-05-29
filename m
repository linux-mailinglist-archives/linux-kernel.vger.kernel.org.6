Return-Path: <linux-kernel+bounces-194267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50B8D392A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA491C217BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E571581FC;
	Wed, 29 May 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JWOEY5Fe"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A571386C6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992877; cv=none; b=f7lH5yh5TmFllyKgBmOfdkgIvF8xiVnHKsASxbDroHt+2c/ePGRS0dIkSeSWayKdi+4DF/jKzJoEopX31iRNTA+zwfolLLbksrradsCZyFMfTc1uZZlKpsmK8vz0elSQoLIqQiZyjKwIUC40eN9O+zZ9etT6+xHSkWAP4RuOBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992877; c=relaxed/simple;
	bh=wllaugfLH4XOoxwomJKK6MPaqTtVsABW1UD4EEKk+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5sIsSihP6hOFxeIauoXQ3NxHtiRzbbAHDedZp9k7wfyBA3qyDMmRPS875bcVTbXfrrTcYj4wA7wghwU0c2UWvTucZwmAPDkGlXEzgW65UdfEmDrtUBatWiQVKAD+W5WEERHc5VS8ynyf7Zz0MzaD+/stMwIr87+zmwuxNdwcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JWOEY5Fe; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wlla
	ugfLH4XOoxwomJKK6MPaqTtVsABW1UD4EEKk+4c=; b=JWOEY5FeWD44RFriaKFC
	Y/mqXRSe3P2VUVAqOZnYS6e541cu40MbqDwXjAH10ViFZ8+8N2fkUDvp2u5R8fTH
	mOHeklMKaUvylxN5MBwvmw58lfi5+uyB96Ob8MwCNTxDYlihvcc2ZMSj0UO2sV2/
	TY6QcNeRPZm8YsA/wMK6SNgTfxN3OpxLRbvUIWpKr/fCb3M2ErnWvMcEba0V5KXv
	6jKZN09LMxmpWrwBVpwfBukjQ491dnuJJobNdngrsKdzLMAsAmxr21QXL86oVXCI
	eILZfrm3aqIBneI1K7VlfYdlZwSU3OfsuCnteWLXxqcjACdSWEdeFrmV2zMESLsa
	8Q==
Received: (qmail 601684 invoked from network); 29 May 2024 16:27:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2024 16:27:46 +0200
X-UD-Smtp-Session: l3s3148p1@+AbhjZgZFLNehhYM
Date: Wed, 29 May 2024 16:27:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>, Evan Quan <quanliangl@hotmail.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] MAINTAINERS: update email for Evan Quan
Message-ID: <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>, Evan Quan <quanliangl@hotmail.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
 <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j2otqm2jcsamjrln"
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>


--j2otqm2jcsamjrln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Evan no longer maintains the SWSMU code, it should be changed to Kenneth and Jun (CCed).

Thanks for the heads up! Kenneth, Jun, will you send a patch or shall I?
If you send one, please add:

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--j2otqm2jcsamjrln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZXO10ACgkQFA3kzBSg
KbZHlg/9F+2c1F9o7iMtBCsbFoqlmiMCPU1elLljAwccCfdgR+XSvuE7E7E/yRy9
EZhJ8IeaE8WmHWLNKoQkjwpLoCV6RtFeIaL+sHL3sDOwGPrN78zVTDAdbPC/09v3
KsYmxGdftAPxiebSQ30Fqysp9lPt3P8f5BRAP1CFKj4j39p1mK/XiXliErVDgfw1
hTOm/hA1xRa1w/7bxFiHz+kXXxW8K7sznyZUQvJKIisLbfYB4cgIc+VuWtlTlL9F
/cvmmn03BpBHhd5Y5RzhjYBmmjurpxEFMnAUqadpLOSoQdhL4XnCs9d7LwYYNQJV
MG+ccCYUNPZoYPUZ0whEx0booaXdK+o3eMmUvA1AAVnRSMWValopfRfFnnNSpO58
vcrXUVe2yac/pphd86CAfgnL9iFkTsGCfoDfbPTOjBYYS/xXujbWzCLrpJlnSFwY
sxJ7ZSf4iHewBB4ZafRQFQrplZL93l0fdMYou/wCtQU6QGDk2gKAurtuFLzTkJZ7
salS1TNdA1vA9CJi69qQe4nOyR97FVcw10yn+ylBBtlZkYgE3m/fERMhM2Eht9z1
1KGNUP7+heXTY9zd3db9jnhZaoXg+1Xv2H49PIKO2NT3i8yEq96QhkKUgnU72+ub
m+QuzLTAaaQD93S4jwB4iWuBS5cNlXsggG1XMTQ0y4ZTz9mvd20=
=VtWZ
-----END PGP SIGNATURE-----

--j2otqm2jcsamjrln--

