Return-Path: <linux-kernel+bounces-449935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528179F5857
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E0C1892445
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8351F8AF9;
	Tue, 17 Dec 2024 21:04:23 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63332208CA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469463; cv=none; b=ndOrOryZpcNeVlbeROxTRYCf9smYBGXTWLfSZ3YXx7o2RaWs7wRY30MsnnpJrCW5iXuAcXGW222i7A6mbHBz787G8i55RKEklsA/jUXgRwLih9mCvTIIZG1fmVcx/+G32uyIN42ngoECvaUsT52hgdIU74mZycLRf/AS3PT+PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469463; c=relaxed/simple;
	bh=l6D1mT2VWBESQSXbEZ30D8ey4IP/zcaz0b3H6y5Iw9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jZXo80ZBIfU2yKAQY/FXjMxF+ul4YOT5l3Gz+2gfvTG80wMNEvgdvFkcjpsMY+L8Eff7eTuC3pjTT5DCDZcrDArLcc3Dzwh486/iVjaMce4t/AQ6/HmTDXZUEF3FDO3Fh+/zRLmMcqdaXy9hlxJ0z3caRpGUi7rIpFMpo92u6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net; spf=fail smtp.mailfrom=users.sourceforge.net; arc=none smtp.client-ip=185.67.36.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C2EAD240027
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:02:59 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YCTmL5sTgz9rxB;
	Tue, 17 Dec 2024 22:02:58 +0100 (CET)
Date: Tue, 17 Dec 2024 21:02:59 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Michele Martone <michelemartone@users.sourceforge.net>
Subject: Training: Semantic Patching of C and C++ Code with Coccinelle
Message-ID: <Z2HnA3E1ahiBVUPW@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kernelnewbies@kernelnewbies.org,
	Julia Lawall <julia.lawall@inria.fr>,
	Michele Martone <michelemartone@users.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZLJOIGXCvwN8W1OT"
Content-Disposition: inline


--ZLJOIGXCvwN8W1OT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Hackers,

this pretty unusual on-site training at LRZ in Munich, Germany may be=20
of interest to some you, despite the HPC context that motivated it.
___________________________________________________________________________=
_______

 What: Introduction to Semantic Patching of C and C++ Programs with Coccine=
lle,
   or
      A language to update large swathes of C/C++ code with non-trivial cha=
nges
          (with emphasis on HPC-specific restructurings).
 Why: Code maintenance and porting to new CPUs/GPUs is difficult. This can =
help.
 When:               Wednesday, January 22, 2025,   09:30 - 17:30
 Where: Leibniz Supercomputing Centre, Garching near Munich, Germany  (ON-S=
ITE)
 Who: Dr. Michele Martone    https://github.com/michelemartone
 Prerequisites: Good C/C++ knowledge; HPC experience recommended.
___________________________________________________________________________=
_______

 Registration URL:  =3D=3D=3D>  --->  https://tiny.badw.de/gsRkBW  <---  <=
=3D=3D=3D
___________________________________________________________________________=
_______

 The maintenance of a large software project can be very demanding. External
 factors like evolving third-party software library APIs, or constantly cha=
nging
 hardware platforms might require significant code adaptions for the code t=
o run
 efficiently, or to run at all. Failure in coping with this can lead to
 obsolescence, loss of performance, incompatibility, vendor lock-in, bugs.
=20
 Have you ever wondered how to detect and manipulate specified C/C++ code
 constructs, be it for code analysis, or better, to restructure an arbitrar=
ily
 large codebase according to a specified, non-trivial `pattern', without wr=
iting
 a source-to-source translator yourself, but using an existing programmable=
 one?
=20
 In this training we introduce you to a tool to do exactly this: match and
 restructure code in a programmatic, formal way.
=20
 After this training, you shall be able to write your own code transformati=
ons,
 be it for a refactoring, performance improvement, paving the way to an
 experimental fork, or for debug/analysis reasons.
=20
 The training will also show how to analyse code looking for interesting
 patterns (e.g. bugs), integrate your Python scripts to achieve the custom
 transformations you need, and leverage Coccinelle's increasing C++ support.
 =20
 Special mention will go to performance-oriented transformations, of intere=
st of
 HPC practitioners.
___________________________________________________________________________=
_______

--=20
Dr. Michele Martone                                   https://michelemarton=
e.org
Leibniz Supercomputing Centre (LRZ)            High Performance Systems Div=
ision
Boltzmannstrasse 1           D-85748 Garching bei Muenchen               Ge=
rmany
      ()     ASCII ribbon campaign   - against HTML e-mail
      /\                             - against proprietary attachments

--ZLJOIGXCvwN8W1OT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQdu1Va6jWbiq8Ma4jg5mnI7xJYuAUCZ2HnAgAKCRDg5mnI7xJY
uC+EAKCCAco6iJjf7xMo1e9DN1KWHnUXiACfcECQ9WTQL0DeaMhX3uk0AYg3BHo=
=5jUJ
-----END PGP SIGNATURE-----

--ZLJOIGXCvwN8W1OT--

