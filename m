Return-Path: <linux-kernel+bounces-205780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1267900033
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FCC1C2105B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AF15CD65;
	Fri,  7 Jun 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b="aZprkIRz"
Received: from ambassador.madduck.net (ambassador.madduck.net [188.174.253.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0002B2CF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.174.253.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754527; cv=none; b=gwVosw/taa8Rfe2PE5OfSo5uLHNhwqFA4CZQUe74sFPIR48IEqASiiBpOM9d5H1vh+lD08IcTA/7Mq72vcZMuM2jh8nnsEprwlns3IU4HwnwBGQx9DHWdQXxCweLVcLPNtcvZoGknnDcFTNjinTOk1+LQjJlgBkfjTL9nwjVEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754527; c=relaxed/simple;
	bh=dnKVMjd62RrJI2+D/Kg8MmoB1La/2JXsXyzEDF+J+QM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f2SRfU+fCIBzxX1p76m6ozT+3YUT1ITv6dKUKtS8EJGgavrE4q11uHjQrHdBAwkRL04HT0I7KfQ7UBSyRfPtvlAutUnRb/PL+OzxNENdPFbEL4N+bM4giOOQcSiASAuTTMw7mmXG5IEUZ4gKFkUhPFdZNsqxIy54Zb6PTA7cRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net; spf=pass smtp.mailfrom=madduck.net; dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b=aZprkIRz; arc=none smtp.client-ip=188.174.253.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=madduck.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=madduck.net;
	s=2015-11-14; t=1717754075;
	bh=dnKVMjd62RrJI2+D/Kg8MmoB1La/2JXsXyzEDF+J+QM=;
	h=Date:From:To:Subject:From;
	b=aZprkIRzztGVM/lSUL5H5r4t+wQSPwNE92gVoKAR+Wwv4Ykv+NXWah+e/LcVRk6Eq
	 iS/6xgZV16ZDsSC5W5KtTikNJR0tuGQBUlG4jD2rBMUar7bI0dudS6hpYA0DgvS1RU
	 RjoGOHAlvvdgo4wRb+nRZNENUtVEduG6rmrQL+qA=
X-MadduckNet-Submission: from albatross.fo.krafftwerk.de (host-80-81-19-185.customer.m-online.net [80.81.19.185]); Creds Client CN "albatross.fo.krafftwerk.de", Issuer "R3" (not verified)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.3 at ambassador.madduck.net
Date: Fri, 7 Jun 2024 11:54:34 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: USB device causing reboot
Message-ID: <rqlax4nkaff2vhzgtlvldh7wggtvlpc4n2ryx3m7hk3d6v3ssm@aknbt3urp44l>
Organization: The Debian project
X-OS: Debian GNU/Linux trixie/sid kernel 6.8.9-amd64 x86_64
X-Motto: Keep the good times rollin'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwh2zcujbgjvtkj4"
Content-Disposition: inline


--uwh2zcujbgjvtkj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I built myself a new computer with quality components, and was=20
surprised to have kernel 6.8.9 randomly reboot (at least once per=20
day). Thanks to netconsole, I was able to see one of the last=20
messages prior to reboot:

```
[30315.872267] xhci_hcd 0000:0c:00.3: Controller not ready at resume -19
[30315.872295] xhci_hcd 0000:0c:00.3: PCI post-resume error -19!
[30315.872298] xhci_hcd 0000:0c:00.3: HC died; cleaning up
[30315.872316] usb 3-1: USB disconnect, device number 2
```

So I removed `xhci_hcd` for a test, and the system didn't reboot=20
anymore. So I removed all USB devices, loaded it again, and=20
subsequently proceeded to add back the USB devices one by one.

Turns out the bad boy is the combination of a [Genesys Logic=20
Hub](https://linux-hardware.org/?id=3Dusb:05e3-0608), a [MosArt=20
Wireless=20
Mouse](https://linux-hardware.org/index.php?id=3Dusb:062a-4102)=20
plugged into a USB2.0 port on the motherboard.

After I moved the hub to a USB1.1 port, the problem didn't occur=20
again.

I am happy it works now, and not really keen on wanting to keep=20
testing this (I am using the system, and reboots are painful), but I=20
also think this is a bug, and wanted to ask what I could provide to=20
help isolate the issue, and permit a fix being developed?

Best,

--=20
 .''`.   martin f. krafft <madduck@d.o>
: :'  :  proud Debian developer
`. `'`   http://people.debian.org/~madduck
  `-  Debian - when you have better things to do than fixing systems
=20
dies ist eine manuell generierte email. sie beinhaltet
tippfehler und ist auch ohne gro=C3=9Fbuchstaben g=C3=BCltig.

--uwh2zcujbgjvtkj4
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital GPG signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----

iQM4BAABCgEiFiEE49rR4ErfOnOmLTLCnJ1pea6UFjcFAmZi2NAxFIAAAAAAFQAT
cGthLWFkZHJlc3NAZ251cGcub3JnbWFkZHVja0BtYWRkdWNrLm5ldMARGmh0dHA6
Ly9tYXJ0aW4ta3JhZmZ0Lm5ldC9ncGcvc2lnLXBvbGljeS81NWM5ODgyZDk5OWJi
Y2M0LzIwMTEwMTI0MTEyNT9zaGE1MTJzdW09MWNhZDk2ZmQyN2QzMjMzZjUzZTIy
ODQ5NTMzNjQ4MTA3ZTVlZThkNWJlNjU1MjUxZDc0YzhmMWM1YzNiYzQyZjIzMDRm
YTUxNTE1MGY3YmQ0ZGQwNWU5ODE5OTI0ZjA0OTUxM2VlOTk2MmNhNzE3MDlmODFk
OTQ1MTU4NTJiZDgACgkQnJ1pea6UFjdnhBAAv1TCbAKJ9OaUwEqI94B11B6sTaWu
eb5SEOZU/CfGyhu83IV3Hjd9ZtR5fOZ8pRI0ZZoKqReW6Ug4H4ZTi4ZRi+ppyHgP
N35DH4Uq1LClk4/GxX2J6CTFUf57YCtsPFYx1xbzaHMMGmALpFMqTKCt0shjTmGd
X02ODKmwOYjdD1Wp+Kn7WU/W1XaXic2rnOxxrxWidaF1eUnbcNwN1acZORFd1o8x
At9DmE+fqraA3OHIeVy6gWFyD4wxITe8zGrm+/Gzr+ocZpiLJYPW3dKtxIOJ1U/r
xt6Uup8VB3XzZ0R14ISd2InluK6xPL3mn8VdTsYZSxrCd52qelS4GvN3cJbz+iCM
59skLK2deoHEvAg+e1rbZRyVYdOwMs33weE9FMmSBptJE24Ly4XmiTzUNuUMmC1B
Ui6CERbwJroEy5Mv7ADyHl91+axuiZtycDcRjeoXTQF6QPBT/qomYWLC3Su6MPaI
R+7oKlV6qAKrI1N/VhW55PBC6lhhJ/UTfDiGwflPP6N4VZynJiECmWEnkN8T37DH
N9DUFMyiCUrIu0R9NKEoA0RmqLaoFq1Dho8kiKum9AHcRLXTwdr8EMj/ROdWhttL
W4gDOMbijzpEZZ1c1X9gVUnvjAy9IDu24vV7RHiVtVhyDXM1xFl9CBCjX8EP2KUT
AUfPWva03BKq+Ls=
=yTLm
-----END PGP SIGNATURE-----

--uwh2zcujbgjvtkj4--


