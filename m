Return-Path: <linux-kernel+bounces-367722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6279A05D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CF1C20ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3F206062;
	Wed, 16 Oct 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Kdoh349s"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E9206059;
	Wed, 16 Oct 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071709; cv=none; b=FtJLyPMzkLC6JMvWmp5svLEJMW48+E2qrlm+JhTEgGtHW0tUCxZizffkuqjwDHlWvCfjgBbgZ6Iuj7jDMC5/Mrn23ETz/F7g3SHtca4bbR9/YasmV5ss1zwdgmjy7/cEoBhjWiekEYvYgSgRWucgNUwBuoyQU+Sqixk0tkJi2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071709; c=relaxed/simple;
	bh=66ay4QtP9Kc+ykJWW3cFhTy2uuEZqIUly6G7N57ci9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dUFBiuVQYcXmCw6WJ7RTA6wh2F9GTvwI5NFaWgd6/8zBCorJFO3jJwIdO4jsVObk+Xfg72f7l7TmsNjH+39WSGCXNnK3CLZ2h95Q6XL6M0h7WfdQjazSbQvFd/Yn3BVEvSVK6QpSnp3ot/+Ri40pR/99lPFEXP4RBr4H9q0fLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Kdoh349s; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729071705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+G7yTuYEAXeIa8//sVKc2le4Wa/PTI7ahlJZN0gv2IE=;
	b=Kdoh349s00o3RtuPRonP7fb2sxvK01XJjgBydUPeuemDro+f5fqaJ1qZO2sZlxd0+gq1Qn
	8UiKvqUnLa7P9hO8/1vqKY//+737tiUadRBKdbXhcuxzCD3Jdc9KSwvyKq714dUHzT3DBs
	22mUU8K4tu5grXv+Qio7j2Pfry79RuVjScFO83vTuZOTAVTMdDqU3gea/AGz3aApQwaPpt
	fIkLcbMecTIQWmDZsXr4ydKY7bt0+/yn/FPFt+vtR51V/eplDzbFsV/d0ZblJih3FGcEM2
	8Q3nNCXIh6S3SbwgyD77jhg+DrRatRGb70Qye49WMWwN7edkiYkWHrg/Vr6aTg==
Content-Type: multipart/signed;
 boundary=faeb94c4c6c54e37cbfcce4f20fd5406a08769967964b4ca64d2ba0e7639;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 16 Oct 2024 11:41:25 +0200
Message-Id: <D4X4RACGCRRH.39SMPGMZZ2GK4@cknow.org>
Subject: Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation
 errors
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: <linux-rockchip@lists.infradead.org>, "Samuel Holland"
 <samuel@sholland.org>, "Dragan Simic" <dsimic@manjaro.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael
 Riesch" <michael.riesch@wolfvision.net>,
 <linux-arm-kernel@lists.infradead.org>, "Diederik de Haas"
 <didi.debian@cknow.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
 <172841572989.2562611.18254512768409976284.b4-ty@sntech.de>
In-Reply-To: <172841572989.2562611.18254512768409976284.b4-ty@sntech.de>
X-Migadu-Flow: FLOW_OUT

--faeb94c4c6c54e37cbfcce4f20fd5406a08769967964b4ca64d2ba0e7639
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Heiko,

On Tue Oct 8, 2024 at 9:28 PM CEST, Heiko Stuebner wrote:
> On Tue, 8 Oct 2024 13:15:35 +0200, Diederik de Haas wrote:
> > This is a set of 4 small device-tree validation fixes.
> >=20
> > Patch 1 adds the power-domains property to the csi dphy node on rk356x.
> > Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> > Patch 3 replaces 'wake' with 'wakeup' on PineNote BT node.
> > Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes.
>
> Applied, thanks!
>
> [2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
>       commit: de50a7e3681771c6b990238af82bf1dea9b11b21
> [3/4] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
>       commit: 87299d6ee95a37d2d576dd8077ea6860f77ad8e2
> [4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
>       commit: 2b6a3f857550e52b1cd4872ebb13cb3e3cf12f5f

Please revert the 4th patch.

I must have messed up my testing previously, but BT does not work on the
PineNote with the 4th patch applied and does work with it reverted.

With the 4th patch applied I get this:
[   20.298465] Bluetooth: hci0: command 0x0c03 tx timeout
[   20.299036] Bluetooth: hci0: BCM: Reset failed (-110)

And then running the `list` command in `bluetoothctl` returns no
controllers and `hciconfig -a hci0` reports `DOWN` and when trying to
reset hci0, I get that timeout error again.

With the 4th patch reverted, the controller does work.

I also get a HUGE amount of 'spam' when running `bluetoothctl` like:

[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 0000110e-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 0000112d-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 00001200-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 0000111f-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 0000110c-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 00001800-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 00001801-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 0000180a-0000-1000-8=
000-00805f9b34fb
[bluetooth]# [CHG] Controller 90:E8:68:B9:60:46 UUIDs: 03b80e5a-ede8-4b33-a=
751-6ce34ec4c700

and this is only a tiny fraction. So there's definitely room for
improvement there, but at least it does work.

Dunno yet what to make of it as this will re-introduce the DT validation
error, but working hardware seems still be preferable to non-working HW.

Sorry about this.

Regards,
  Diederik

--faeb94c4c6c54e37cbfcce4f20fd5406a08769967964b4ca64d2ba0e7639
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZw+KUQAKCRDXblvOeH7b
bhnxAP9n+rlPuUutF7F77uY3BcDFisDJkTklvco4RH+AzVaO/QD/foEQc21La4tM
T9BfqGjcYGN2XKJ9U/7D3koBQyOXCAQ=
=xqKK
-----END PGP SIGNATURE-----

--faeb94c4c6c54e37cbfcce4f20fd5406a08769967964b4ca64d2ba0e7639--

