Return-Path: <linux-kernel+bounces-211002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1465904BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B68E1F20F88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7058167D9F;
	Wed, 12 Jun 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b="kglw2r7S"
Received: from ambassador.madduck.net (ambassador.madduck.net [188.174.253.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629F167270
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.174.253.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174906; cv=none; b=fYTaYPIQzKiVNnFaUkU1VKQRNvBtqB5xHS58KQqgHlOFpcVKTVzAWLaiHQA+6BFkcl3JuqX01dJsizdcHGDFgr/7BgH2B8MQxHm5o2sn1at1ghhIUZed0FCX186NZIQApKX/N4sb2rqAlEMinkCbKZC7oCo3N8w5H4KpwhUvs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174906; c=relaxed/simple;
	bh=Um3GtIsaVptr6H7kiV4JIQYu6hGUa01b13fLp4C7tgw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eSyUwz64fsN7z3nLRukhtBT2Nco9fco8oUngTHZ3kWtkk0nE3+m297PRD0KJd9zMjQfPUOrIY+I5BPi6jDIkFgdXfsb4XNPmanynRBrTQXcBKKKSfXtu6gfrUfWcSZe9rZMT6uGU9mAlWbl+NxSphye/mw9wGTquOw98niPr+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net; spf=pass smtp.mailfrom=madduck.net; dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b=kglw2r7S; arc=none smtp.client-ip=188.174.253.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=madduck.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=madduck.net;
	s=2015-11-14; t=1718174895;
	bh=Um3GtIsaVptr6H7kiV4JIQYu6hGUa01b13fLp4C7tgw=;
	h=Date:From:To:Subject:From;
	b=kglw2r7SCpWK06nRAt8K0e3ympU40J5CbsiRiOKd1vI7eqlT+UHIidy2x6cV4svJO
	 BkfpndE5BAQJSETMNeD295xIDdGDcMa1pthj+jwRm5gRQjtio/04kziDOe8zA+zDTr
	 MMHp+Jbuby0X/uZ2bta0ElCdJh+CY8Sn9M6scMqQ=
X-MadduckNet-Submission: from albatross.fo.krafftwerk.de (host-80-81-19-185.customer.m-online.net [80.81.19.185]); Creds Client CN "albatross.fo.krafftwerk.de", Issuer "R3" (not verified)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.3 at ambassador.madduck.net
Date: Wed, 12 Jun 2024 08:48:13 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: EINVAL on bulk access of CIFS mount
Message-ID: <dodkxllnsozs4z3yzw5bgm35fs7t5fziwpvsczxpak2jqe6rvk@ebo364wns2dq>
X-OS: Debian GNU/Linux trixie/sid kernel 6.8.9-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qc5j5bozlylrcnq"
Content-Disposition: inline


--2qc5j5bozlylrcnq
Content-Type: multipart/alternative; boundary="gesbfyxvn7myji37"
Content-Description: Group of alternative content
Content-Disposition: inline


--gesbfyxvn7myji37
Content-Type: text/plain; charset=utf-8
Content-Description: Plain-text version
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I have a local CIFS mount on 6.8.9-amd64 (Debian unstable):

```
//fileserver/m on /server/m type cifs (rw,nosuid,nodev,relatime,vers=3D3.1.=
1,cache=3Dstrict,username=3Dmartin.krafft,domain=3Dsamba-ad,uid=3D1000,forc=
euid,gid=3D1000,forcegid,addr=3D192.168.231.42,file_mode=3D0660,dir_mode=3D=
02770,soft,nounix,mapposix,rsize=3D4194304,wsize=3D4194304,bsize=3D1048576,=
retrans=3D1,echo_interval=3D60,actimeo=3D1,closetimeo=3D1)
```

I am trying to tree-walk that mount (depth-first). Every couple of=20
dozen files, I get EINVAL on file access. I modified my script to=20
then wait a second and retry, and it generally works then, or on the=20
next retry.

Accessing the same file directly (i.e. not as part of a bulk=20
operation) works fine.

But also, restarting the bulk operation does seem to cause it to hit=20
EINVAL on exactly the same files as before, though I am not 100% on=20
that.

Access works fine from Windows, even in bulk, leading me to believe=20
this is a cifs client-side problem.

How could I go about narrowing this down?

Thanks,

--=20
martin krafft | https://matrix.to/#/#madduck:madduck.net
=20
"die menschen dr=C3=A4ngen sich zum lichte, nicht um besser zu sehen,
 sondern um besser zu gl=C3=A4nzen."
                                                 - friedrich nietzsche
{: .blockquote }
=20
spamtraps: madduck.bogus@madduck.net
{: .hidden }

--gesbfyxvn7myji37
Content-Type: text/html; charset=utf-8
Content-Description: HTML version
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>

<html>
<head>
<meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"content-type"/>
<meta content=3D"width=3Ddevice-width, initial-scale=3D1.0" name=3D"viewpor=
t"/>
</head>
<body style=3D"font-family: Lato, Calibri, Tahoma, sans-serif; max-width: 3=
2em">
<p style=3D"text-align: justify; text-justify: auto">Dear list,</p>
<p style=3D"text-align: justify; text-justify: auto">I have a local CIFS mo=
unt on 6.8.9-amd64 (Debian unstable):</p>
<div class=3D"codehilite" style=3D"background: #f8f8f8"><pre style=3D"line-=
height: 125%"><span></span><code>//fileserver/m on /server/m type cifs (rw,=
nosuid,nodev,relatime,vers=3D3.1.1,cache=3Dstrict,username=3Dmartin.krafft,=
domain=3Dsamba-ad,uid=3D1000,forceuid,gid=3D1000,forcegid,addr=3D192.168.23=
1.42,file_mode=3D0660,dir_mode=3D02770,soft,nounix,mapposix,rsize=3D4194304=
,wsize=3D4194304,bsize=3D1048576,retrans=3D1,echo_interval=3D60,actimeo=3D1=
,closetimeo=3D1)
</code></pre></div>
<p style=3D"text-align: justify; text-justify: auto">I am trying to tree-wa=
lk that mount (depth-first). Every couple of dozen files, I get EINVAL on f=
ile access. I modified my script to then wait a second and retry, and it ge=
nerally works then, or on the next retry.</p>
<p style=3D"text-align: justify; text-justify: auto">Accessing the same fil=
e directly (i.e. not as part of a bulk operation) works fine.</p>
<p style=3D"text-align: justify; text-justify: auto">But also, restarting t=
he bulk operation does seem to cause it to hit EINVAL on exactly the same f=
iles as before, though I am not 100% on that.</p>
<p style=3D"text-align: justify; text-justify: auto">Access works fine from=
 Windows, even in bulk, leading me to believe this is a cifs client-side pr=
oblem.</p>
<p style=3D"text-align: justify; text-justify: auto">How could I go about n=
arrowing this down?</p>
<p style=3D"text-align: justify; text-justify: auto">Thanks,</p>
<div id=3D"signature" style=3D"font-family: Lato, Calibri, Tahoma, sans-ser=
if; max-width: 32em"><span class=3D"sig_separator" style=3D"display: none">=
-- </span>
<p style=3D"text-align: justify; text-justify: auto">martin krafft | <a hre=
f=3D"https://matrix.to/#/#madduck:madduck.net">https://matrix.to/#/#madduck=
:madduck.net</a></p>
<p class=3D"blockquote" style=3D"text-align: justify; text-justify: auto; p=
adding: 0 0.5em; margin: 0; font-style: italic; border-left: 2px solid #666=
">&ldquo;die menschen dr=C3=A4ngen sich zum lichte, nicht um besser zu sehe=
n,<br/>
 sondern um besser zu gl=C3=A4nzen.&rdquo;<br/>
                                                 - friedrich nietzsche<br/>=
</p>
<p class=3D"hidden" style=3D"text-align: justify; text-justify: auto; displ=
ay: none">spamtraps: <a href=3D"&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#1=
09;&#97;&#100;&#100;&#117;&#99;&#107;&#46;&#98;&#111;&#103;&#117;&#115;&#64=
;&#109;&#97;&#100;&#100;&#117;&#99;&#107;&#46;&#110;&#101;&#116;">&#109;&#9=
7;&#100;&#100;&#117;&#99;&#107;&#46;&#98;&#111;&#103;&#117;&#115;&#64;&#109=
;&#97;&#100;&#100;&#117;&#99;&#107;&#46;&#110;&#101;&#116;</a><br/></p>
</div>
</body>
</html>
--gesbfyxvn7myji37--

--2qc5j5bozlylrcnq
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital GPG signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----

iQM4BAABCgEiFiEE49rR4ErfOnOmLTLCnJ1pea6UFjcFAmZpRKMxFIAAAAAAFQAT
cGthLWFkZHJlc3NAZ251cGcub3JnbWFkZHVja0BtYWRkdWNrLm5ldMARGmh0dHA6
Ly9tYXJ0aW4ta3JhZmZ0Lm5ldC9ncGcvc2lnLXBvbGljeS81NWM5ODgyZDk5OWJi
Y2M0LzIwMTEwMTI0MTEyNT9zaGE1MTJzdW09MWNhZDk2ZmQyN2QzMjMzZjUzZTIy
ODQ5NTMzNjQ4MTA3ZTVlZThkNWJlNjU1MjUxZDc0YzhmMWM1YzNiYzQyZjIzMDRm
YTUxNTE1MGY3YmQ0ZGQwNWU5ODE5OTI0ZjA0OTUxM2VlOTk2MmNhNzE3MDlmODFk
OTQ1MTU4NTJiZDgACgkQnJ1pea6UFjdCOA//ZidmytNg1UdgH+vkC0xLutEPeRQe
V32KpHIpy3obnPF+ZjoCpwAnBy0PUsiSSv56pND+TxcdPfT14lEYJsBa0rF8BjnP
A1a0mSbxN2YhZF4aYtxPTXrLPvo4JMv+TxaAGRnRWyCIc3UDcxOcc1L1bQbbvDzS
F9ZHc3x7ZgAjSp6oUcesC1Mvhs7lPspz/Tra1/8Gxe1CCti3algAYh4RR5ZCV3co
A/qa/UhgRgsydGELLVDNK97w8eTWPmfMspuk/0JNomFivclIsKFCYltE37dqEtuL
xErY9bhhjRVYgjVaV5FQDKiuf33aV+rS1eeABOsp+TQFuk7exScPO98D779mmWb9
3Kt11BqISbUZjVKSXUni7heBetXaq1vbpxu0F8pHZrvVxa3wVWvRtx2MT87YAMec
JE1+GSIHJCofTBxu8ffxdi7LB+AIwAdLcLKzA6xi3sf5NNj1z0y2Vo5Xwml2qCmy
8gOx3RwrP45wm0PTuo2XZppvcTihnssunYTtMk7bVZSIR+R8EzAmTe+dPhSmo0Ha
VVqtizonCZP2Jg7D+tegJUGnlfxQNQTj1zPm4BRWOTmKzaliad6UpD2wU1IQXevw
pcHwYfJvD1V+76Sfe/QeIUn/IegAx57O6gadpd4UTCkV2POw3EMaxFRIEdtwSKHF
SU4X1doZQL94B9I=
=3uWK
-----END PGP SIGNATURE-----

--2qc5j5bozlylrcnq--


