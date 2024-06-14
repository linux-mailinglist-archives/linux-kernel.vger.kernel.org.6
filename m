Return-Path: <linux-kernel+bounces-215478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E79909359
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3882A1C229CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7831822CA;
	Fri, 14 Jun 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="dEp5aFQo"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40C60DFA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396659; cv=none; b=epfcT6CfJZ7QD+2SbZGNWuJ5lXZ2ATxKk4TQw69osj0AI6+u+6syO1BJAyHlHOXLS6jDGClztEQQ+AEzSe0AM0RrUoghFB9TS0rZ4RjoMvjlhDheDxLGoHtkDZOUXPZBvPgH/vcy/9t66LQ8h3uaI18EjYW8F/FkGLw6BxK3pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396659; c=relaxed/simple;
	bh=11VPQKqaeaxlgRxGP67qEOTpQlcThjhhJEmfMZx9RYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRuEB8LvmfVGe0uknnYjsAOXH69eVBwBlfB4y6b5GNv4BBGd+hY1bwDzW+W4Pai/QHwmLDJpUuHdl3jFjZ+gpDRSIaODMW/bhDEao9eEmDSJhdqu5T/1TOyOUB8q9npguMUkQA7boIFhZ/koWQkGSe26uam0Wft89/bv06RHhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=dEp5aFQo; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C7F71C00A9; Fri, 14 Jun 2024 22:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718396654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11wEK8Clby+612CgqiRJqYq/lMXJ8CEG8ZdCUKNN3o4=;
	b=dEp5aFQothUREbECVVo0OdD6dmKTHwx+KFVhdcLYq0IGkj13qouAtxiS+MunjcCC9hGcgu
	Gvl+5rzBnsQkCMnJ8aVU+iPE1US3jKon9Ootv8/mW6vJc6r9AzwBbwb9WookOPoXknCNm6
	792V+QKfgwbM0PQ0EEknai/R0cjX164=
Date: Fri, 14 Jun 2024 22:24:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <Zmym7SuLa32UjVyZ@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
 <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u7NG0n/GuAps+/Vo"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>


--u7NG0n/GuAps+/Vo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Let's bring in the actual gpu people.. Dave/Jani/others - does any of
> > this sound familiar? Pavel says things have gotten much slower in
> > 6.10: "something was very wrong with the performance, likely to do
> > with graphics"
>=20
> Actually, maybe it's not graphics at all. Rafael just sent me a pull
> request that fixes a "turbo is disabled at boot, but magically enabled
> at runtime by firmware" issue.
>=20
> The 6.10-rc1 kernel would notice that turbo was disabled, and stopped
> noticing that it magically got re-enabled.
>=20
> Pavel, that was with a very different laptop, but who knows... That
> would match the "laptop is much slower" thing.
>=20
> So current -git might be worth checking.

Is that:

commit 0cac73eb3875f6ecb6105e533218dba1868d04c9
Merge: 94df82fe5bfd 350cbb5d2f67
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 14 09:52:51 2024 -0700

    Merge tag 'pm-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/rafael/linux-pm
   =20
    Pull power management fix from Rafael Wysocki:
     "Restore the behavior of the no_turbo sysfs attribute in the
      intel_pstate driver which allowed users to make the driver start using
      turbo P-states if they have been enabled on the fly by the firmware
      after OS initialization (Rafael Wysocki)"
   =20
    * tag 'pm-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/ra=
fael/linux-pm:
      cpufreq: intel_pstate: Check turbo_is_disabled() in store_no_turbo()


? I don't think I tweaking no_turbo in the sysfs.

But the thermal stuff looks important:

commit cee84c0b003f2e0f486f200a72eca2bcdb3a49a7
Merge: d20f6b3d747c b6846826982b
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 14 09:28:56 2024 -0700

    Merge tag 'thermal-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kern=
el/git/rafael/linux-pm

So I guess I'll have to try again.

Thanks and best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--u7NG0n/GuAps+/Vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmym7QAKCRAw5/Bqldv6
8kb0AJ97gwIRHUiD47Mml3lQACLV5Xsu2wCdFT+Pwv7O4oovUY9/KqIbjbSEaUE=
=YIIy
-----END PGP SIGNATURE-----

--u7NG0n/GuAps+/Vo--

