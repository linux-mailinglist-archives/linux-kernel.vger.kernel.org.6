Return-Path: <linux-kernel+bounces-193992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B359B8D3527
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DC22838CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D315DBC0;
	Wed, 29 May 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="eEj8yEUL"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FB15B12B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981008; cv=none; b=XafXonrvCkrsuMK8+8h05szp0AYY4BYZratV2PT9dd8pt0A5YwfnmnTHAXdxUx0QYPGFuYninmkO5I9ZHQ0YdXjIyr3z+4ebEaqOl+GAELH2BugvNrEPgsFi0uYDpwlxtXPI7ErRPKzVti7LYMQtIj29rvpLfLnLAtLX/EezQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981008; c=relaxed/simple;
	bh=m3KF/WLdBKhQ9VooNViA+tD4vHkhi5ZDK5uBZpZrtvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4NDbnXcxVa7BrWPm7Yf9QlgRROo7UWpuVORE7vO9iLYBEzxAtgqvt7LaQ9fxDehgzRvOshSmnirHM9lt8oB8GJXfYrMyl1ivDER3geL3mUyZ+o+EHD4Dt6+vErzJjoT3s1Zk9Ja+F/bTv/NRAy2OH9YAQq00I30mkX4ZZcyQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=eEj8yEUL; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dsimic@manjaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1716981003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3K8AAihjo5jehCWYCuxmJ8F87mjFG1Pk15yaC7Oslk=;
	b=eEj8yEUL/kZ04N94F2Lxv+qcPhuIeQjqXc9M1gpAU7gJkjZONeiRZAr7gf+sUm1okG0O4n
	3VCQI3W/7RvSxcGZ45fzNi+wpeyYZnWeU5g3lgxkMIZ88kp/SYnx229DqSSCsK16W/nHDn
	V82dnEnl0ugY7yX9Oy2aKCNddTvf16s1xyvDCzUZKmTKCH/PMGa9MZl38YiEulVbqPszSU
	P5+7Yy10L9famzqAWQdfAo4PezWKKYOGDIQb+Bt988IZMyhGSseumJFO2Ts1Bt+Ds1LgIp
	KVMEi0G3ks4sxPQLVbTN/nozYeKkpAMXQlprSPl1E7gm0E1I8OgB75l+qrVb5w==
X-Envelope-To: alchark@gmail.com
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: heiko@sntech.de
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: robh+dt@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: quentin.schulz@cherry.de
X-Envelope-To: wens@kernel.org
X-Envelope-To: daniel.lezcano@linaro.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: viresh.kumar@linaro.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org,
 daniel.lezcano@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 viresh.kumar@linaro.org
Subject:
 Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
Date: Wed, 29 May 2024 13:09:50 +0200
Message-ID: <9996796.SDjBYy7pSV@bagend>
Organization: Connecting Knowledge
In-Reply-To:
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
References:
 <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4603407.K66ItMQtme";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart4603407.K66ItMQtme
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Wed, 29 May 2024 13:09:50 +0200
Message-ID: <9996796.SDjBYy7pSV@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

Hi Dragan,

I think the idea is very good.
I do have some remarks about its implementation though.

title: s/Make preparations/Prepare/

On Wednesday, 29 May 2024 11:57:45 CEST Alexey Charkov wrote:
> On Wed, May 29, 2024 at 6:14=E2=80=AFAM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> > Rename and modify the RK3588 dtsi files a bit, to make preparations for
> > the ability to specify different CPU and GPU OPPs for each of the
> > supported RK3588 SoC variants, including the RK3588J.

"Rename the RK3588 dtsi files in preparation of the ability to specify diff=
erent=20
CPU and GPU OPPs combinations for all the supported RK3588 SoC variants."?

There's no partial renaming of things. That you then also change the includ=
e=20
files to match, is implied.
The "modify ... a bit" implies you'll do something else (too), which should=
 be=20
in its own separate patch (if that were actually the case).

If you mention one variant but not (any) others, makes people like me wonde=
r:
why is RK3588J treated differently then f.e. RK3588M?
In this case I don't see a reason to single out one variant.

> > As already discussed, [1][2][3] some of the different RK3588 SoC varian=
ts
> > require different OPPs, and it makes more sense to have the OPPs already
> > defined when a board dts includes one of the SoC dtsi files (rk3588.dts=
i,
> > rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts file=
 to
> > also include a separate rk3588*-opp.dtsi file.
>=20
> Indeed, including just one .dtsi for the correct SoC variant and not
> having to bother about what other bits and pieces are required to use
> the full SoC functionality sounds great! Thanks for putting this
> together so promptly!

Indeed :)

> > No intended functional changes are introduced.

=2E..

> >  ...inctrl.dtsi =3D> rk3588-common-pinctrl.dtsi} |    0
>=20
> Renaming the pinctrl includes seems superfluous - maybe keep them as
> they were to minimize churn?

The reason for that wasn't clear to me either. If there is a good reason fo=
r=20
it, then a (git commit) message specify *why* is appreciated.

> >  .../{rk3588s.dtsi =3D> rk3588-common.dtsi}      |    2 +-
> >  ...nctrl.dtsi =3D> rk3588-fullfat-pinctrl.dtsi} |    0
> >  .../{rk3588.dtsi =3D> rk3588-fullfat.dtsi}      |    4 +-
>=20
> To me, "fullfat" doesn't look super descriptive, albeit fun :)

Agreed with the non-descriptive part. Please choose a different name.

And document in the git commit message why it was renamed and what is expec=
ted=20
to be in the new dtsi file, but would be incorrect for the old dtsi file.

That you went from rk3588s.dtsi to rk3588-common.dtsi (I miss the 's') shou=
ld=20
be described (assuming that was intentional and not a typo).

IOW: let this commit (message) describe what should and should not go in th=
e=20
respective dtsi files, which can then be used as reference for future rk358=
8=20
board additions.

> How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
> something like rk3588-devices.dtsi and rk3588s-devices.dtsi

Whether it's '-devices' or '-common', I think it's impossible for a (short)=
=20
name to be fully self-descriptive.
Thus document what you mean by it in the commit message.

Then we can use those 'rules' to consistently apply them.

> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  414 +--
> >  arch/arm64/boot/dts/rockchip/rk3588j.dtsi     |    6 +-
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 2671 +----------------
>=20
> Rename detection didn't do a particularly great job here - wonder if
> we can do anything about it to minimize the patch size and ensure that
> the change history is preserved for git blame...

+1
The diff does look awfully big for a rename operation, which was supposed t=
o=20
(also only) "modify ... a bit".

Cheers,
  Diederik
--nextPart4603407.K66ItMQtme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZlcM/gAKCRDXblvOeH7b
boXFAQCgLAgi+jdfrwcmNIdE+b3uLByJRWSeiM+fn8Il8DjzDAEAqe1l050CNF9Z
Zwn/WxpqmanDODRRGRh7CrMypeZ4Vwg=
=79tX
-----END PGP SIGNATURE-----

--nextPart4603407.K66ItMQtme--




