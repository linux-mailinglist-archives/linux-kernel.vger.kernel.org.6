Return-Path: <linux-kernel+bounces-341769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A29885DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85B21F24071
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CD418DF90;
	Fri, 27 Sep 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="WZOTffPP"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DD18872F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441874; cv=none; b=ptbY2+7aEZ1+DsUB30dxyl57spGqbhhbfTHMw7WOVXXw8bU4oFxpj9yYZbjLkQJxgKuJ2IPzTwrpC9VpOWEh5WAaUoiephv+XdKAnsflwr0PiZ4FCtX+xPuSZEuwp7iHqqQgMN7C7qlYx0yahYd4uthCVSZpCsAJ2JsKY3T0cnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441874; c=relaxed/simple;
	bh=UJ+kOsafPP7ZHPNPsAD3rM8c6mavEuItHtapXNmRr6w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MHosPpFLW42z3M/tSvJOLoczlnmO5IdIArVmdUcdUH6WbwFkKWiEL+E9BxIrThM7nhdhR2Jpwwx23dqhXafch6Csljun11RMsqP7gtMcpaI+zATK7tdBoSXahKsD2VGuU5zDtJqdLGtZtWyo9LAluJ9wzpUO6sQwz0t6PNqkCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=WZOTffPP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727441868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwQj17JsjEZzEC18m20crarmH5JliQVFVvBilPC4tJI=;
	b=WZOTffPPCLR5IDmsfQ/WPpZgP2jPOrGabaXqOi3x9PN2+/7tZUOKXe+OS6V9f8SnZt+KFC
	ReH22BYxkwynYSZcabFGnkJVIQ8xZ8J/yxRYgw1qfMmYoKiw/0rBcYCoKBN9n48KwMEzWd
	j0wRtUQU7cWckhuwAgVpo6+hUyI4qCpIsfr11m5jLX378AurKGhk17JxQPSfA3YCWjAVfK
	qfApSZARFIJCVPVbwbqr+xt3ytsXwqkpzW5WHwLnsdEFX+noA9RP2Drjbg6QNTdjCc38MG
	Hel/oTTud9YNwoL1vbx3/0+yrraEN58q77eyvWS93/Izoo5TYYNqyNd/fBkAGg==
Content-Type: multipart/signed;
 boundary=23a9527a0cdbc70b448e427a917e8e47687f3f411803ceaa4c4ac765047c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 27 Sep 2024 14:57:30 +0200
Message-Id: <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Armin Wolf" <W_Armin@gmx.de>
Cc: "Diederik de Haas" <didi.debian@cknow.org>, "Guenter Roeck"
 <linux@roeck-us.net>, "Vinod Koul" <vkoul@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with
 error -5" since 6.11
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
 <2024092616-showing-fragrance-f70a@gregkh>
In-Reply-To: <2024092616-showing-fragrance-f70a@gregkh>
X-Migadu-Flow: FLOW_OUT

--23a9527a0cdbc70b448e427a917e8e47687f3f411803ceaa4c4ac765047c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 26, 2024 at 2:44 PM CEST, Greg Kroah-Hartman wrote:
> On Thu, Sep 26, 2024 at 02:35:05PM +0200, Diederik de Haas wrote:
> > I updated an amd64 machine to (Debian's) 6.11 kernel and got this error=
:
> > ``ee1004 3-0050: probe with driver ee1004 failed with error -5``
> >=20
> > which I didn't get with 6.10.9.
>
> bisect would be great, thanks!

I should've known I'd get this response ;-P

$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [6150e5e1ae2d8ad72f52217f8f41fe446cae9e27] eeprom: ee1004: Instanti=
ate jc42 devices for DIMMS implementing Rev.1 SPD
git bisect good 6150e5e1ae2d8ad72f52217f8f41fe446cae9e27
# status: waiting for bad commit, 1 good commit known
# bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
git bisect bad 8400291e289ee6b2bf9779ff1c83a291501f017b
# good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
# good: [f66b07c56119833b88bffa4ecaf9f983834675de] Merge tag 'vfio-v6.11-rc=
1' of https://github.com/awilliam/linux-vfio
git bisect good f66b07c56119833b88bffa4ecaf9f983834675de
# good: [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 2c9b3512402ed192d1f43f4531fb5da947e72bd0
# good: [6dc2e98d5f1de162d1777aee97e59d75d70d07c5] s390: Remove protvirt an=
d kvm config guards for uv code
git bisect good 6dc2e98d5f1de162d1777aee97e59d75d70d07c5
# bad: [c2a96b7f187fb6a455836d4a6e113947ff11de97] Merge tag 'driver-core-6.=
11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad c2a96b7f187fb6a455836d4a6e113947ff11de97
# good: [786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48] Merge tag 'perf-tools-fi=
xes-for-v6.11-2024-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/=
perf/perf-tools
git bisect good 786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48
# bad: [ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab] Merge tag 'soundwire-6.11=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire
git bisect bad ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab
# good: [b8ec9dba02a74797421c52b1226b23a4302362a6] dt-bindings: fsl-qdma: f=
ix interrupts 'if' check logic
git bisect good b8ec9dba02a74797421c52b1226b23a4302362a6
# good: [7a3fad30fd8b4b5e370906b3c554f64026f56c2f] Merge tag 'random-6.11-r=
c1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
git bisect good 7a3fad30fd8b4b5e370906b3c554f64026f56c2f
# good: [89cc1354d388ba8c8f8b41095736202a83591497] soundwire: amd: simplify=
 return path in hw_params
git bisect good 89cc1354d388ba8c8f8b41095736202a83591497
# good: [13814ed162687be08e34762040cfc2e58831219d] soundwire: intel_ace2x: =
simplify return path in hw_params
git bisect good 13814ed162687be08e34762040cfc2e58831219d
# good: [b72d4af98cae2f74dc8061befcc3c0c2a174894f] soundwire: cadence: simp=
lify with cleanup.h
git bisect good b72d4af98cae2f74dc8061befcc3c0c2a174894f
# good: [fdd3d14ca3c8c5269174f10d33d6181173cbd0b4] soundwire: debugfs: simp=
lify with cleanup.h
git bisect good fdd3d14ca3c8c5269174f10d33d6181173cbd0b4
# bad: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge tag 'dmaengine-6.11=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
git bisect bad 7a46b17d4c00c2547b5bd82eec9489b19128fd65
# first bad commit: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge tag 'd=
maengine-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/d=
maengine

During the bisect operation I noticed the following messages:
[    4.920273] ee1004 1-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.922699] ee1004 1-0051: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.924960] ee1004 1-0052: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.927236] ee1004 1-0053: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly

but only on some. I didn't get those before, but they're informational
so not a problem. (But I don't care for them either)

Good commits, no info message:
89cc1354d388 soundwire: amd: simplify return path in hw_params
13814ed16268 soundwire: intel_ace2x: simplify return path in hw_params
b72d4af98cae soundwire: cadence: simplify with cleanup.h
fdd3d14ca3c8 soundwire: debugfs: simplify with cleanup.h
b8ec9dba02a7 dt-bindings: fsl-qdma: fix interrupts 'if' check logic
6150e5e1ae2d eeprom: ee1004: Instantiate jc42 devices for DIMMS implementin=
g Rev.1 SPD
280e36f0d5b9 nsfs: use cleanup guard
f66b07c56119 Merge tag 'vfio-v6.11-rc1' of https://github.com/awilliam/linu=
x-vfio
2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm=
/kvm
6dc2e98d5f1d s390: Remove protvirt and kvm config guards for uv code

Good commits, with info message:
786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07-23' of git://git=
.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
7a3fad30fd8b Merge tag 'random-6.11-rc1-for-linus' of git://git.kernel.org/=
pub/scm/linux/kernel/git/crng/random

Bad commits, all with info message:
7a46b17d4c00 Merge tag 'dmaengine-6.11-rc1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/vkoul/dmaengine
ad7b0b7b87bb Merge tag 'soundwire-6.11-rc1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/vkoul/soundwire
c2a96b7f187f Merge tag 'driver-core-6.11-rc1' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/gregkh/driver-core
8400291e289e Linux 6.11-rc1

``git blame -L '/static int ee1004_probe/' drivers/misc/eeprom/ee1004.c``
showed the ``dev_info`` line has been present since 2018-10-07, but I
guess it never used the ``ee1004_probe`` function before?

Anticipating the likely next question "Can you still reproduce it in
current master/HEAD?" I build a new kernel from this:
075dbe9f6e3c ("Merge tag 'soc-ep93xx-dt-6.12' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/soc/soc")

And that showed the info messages, but not the error.
So that looks like the bug has been fixed for 6.12.

Cheers,
  Diederik

--23a9527a0cdbc70b448e427a917e8e47687f3f411803ceaa4c4ac765047c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZvarvwAKCRDXblvOeH7b
bsDpAQDrIBaAvq+ND2PjQweK902aUGcBXzhP2WUGlUwA2ftCJgEA6k/+707LFbsM
VO+YA02bsoBk8vz4MFli8/tXWTeHugQ=
=fJ1C
-----END PGP SIGNATURE-----

--23a9527a0cdbc70b448e427a917e8e47687f3f411803ceaa4c4ac765047c--

