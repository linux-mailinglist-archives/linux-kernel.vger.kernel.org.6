Return-Path: <linux-kernel+bounces-192179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F306A8D1987
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305051C22DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5716C869;
	Tue, 28 May 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjavsE/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF596CDC8;
	Tue, 28 May 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895851; cv=none; b=dEF5PAobZee2k1WEvFTJa9ABLev9zOJZ2yw0R+r5HziVoBtds/3FIkn4wXl00rYtbVy0znqPdb6BzKUSmoB0Q5C0ZE1rtEQn7saaITO0g/rWJgfqJN/VqXOPM0APg96pivy+dSCYpFofrjHJdN+EcEMcdNYs/O2cdM1sUkjE6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895851; c=relaxed/simple;
	bh=J2mWDdJtos/H4lrmEII8x+5AKEqMgDmRzY9/k9sRI38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWjZ3Vihit7t75ih+WM10wRIYP+xmTKdjlIK8f8YcZu5SWyIKKKBZU2RS2922Kv1h63rbD9xnL8D5GQDk0JJRcElqVQmRdf42uhxzS3Ryd5Uc6CDyKO4unFBBwVHrj9vyWMSPiHZgyD1lJxq6ht9oOSRiUhgD4rIDxDBMHOpif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjavsE/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B148AC3277B;
	Tue, 28 May 2024 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716895851;
	bh=J2mWDdJtos/H4lrmEII8x+5AKEqMgDmRzY9/k9sRI38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjavsE/HR1q6SqX7BknI3GNgr/s/PsVb+eMfFgjREQ7IvE0102h6PO0ItgahJRsvS
	 O+6Ov04jlmuFGEWdk15DdtKkD0MDC5evcOFELwmk9rGCyTgKmO5GPkD18GW92lNxnK
	 9QIBY/rKZn0Mb+UzXNUTfiNGYBDNA9aiVgQbNG/DGXbpmJv1YnqYz+W1D4KtEhsElc
	 KnYy/XU6bYZAR/GqL9m2fPU8O8IhYbIdWxlTqpcYj2o1w8yGrnWLrmE2O2rTqz6rdv
	 PiGFWRVYtA77wLaxY6fZhp6HX/ePoIWi9p+QC/ATgaI9PUGQNRl1yxVNV2uctFbIli
	 7bhNLMUfB+eJA==
Date: Tue, 28 May 2024 12:30:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
Message-ID: <20240528-outpost-subduing-2e84f77427a4@spud>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
 <87wmo2nmee.fsf@linux-m68k.org>
 <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
 <87zfsy102h.fsf@igel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dcH1rd/ToVgelCkf"
Content-Disposition: inline
In-Reply-To: <87zfsy102h.fsf@igel.home>


--dcH1rd/ToVgelCkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

On Fri, May 10, 2024 at 11:35:34AM +0200, Andreas Schwab wrote:
> On Mai 10 2024, Emil Renner Berthing wrote:
>=20
> > You don't include any information useful for debugging this, but if it =
get's
> > far enough to load the firmware could you at least make sure you run the
> > version below, so that's at least the same.
> >
> > https://github.com/esmil/linux/blob/visionfive/firmware/brcm/BCM43430A1=
=2Ehcd
>=20
> That didn't change anything (and there are no messages related to
> firmware loading from hci_uart).

Looking at things to apply post -rc1, are you still looking into this
issue?

Thanks,
Conor.

>=20
> [  +0.879623] Bluetooth: Core ver 2.22
> [  +0.004843] NET: Registered PF_BLUETOOTH protocol family
> [  +0.008787] Bluetooth: HCI device and connection manager initialized
> [  +0.021944] Bluetooth: HCI socket layer initialized
> [  +0.008488] Bluetooth: L2CAP socket layer initialized
> [  +0.006333] Bluetooth: SCO socket layer initialized
> [  +0.097478] Bluetooth: HCI UART driver ver 2.3
> [  +0.007943] Bluetooth: HCI UART protocol H4 registered
> [  +0.006066] Bluetooth: HCI UART protocol BCSP registered
> [  +0.006962] Bluetooth: HCI UART protocol LL registered
> [  +0.000015] Bluetooth: HCI UART protocol ATH3K registered
> [  +0.000084] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [  +0.000247] Bluetooth: HCI UART protocol Intel registered
> [  +0.000455] Bluetooth: HCI UART protocol Broadcom registered
> [  +0.000084] Bluetooth: HCI UART protocol QCA registered
> [  +0.000008] Bluetooth: HCI UART protocol AG6XX registered
> [  +0.000057] Bluetooth: HCI UART protocol Marvell registered
> [  +0.051854] hci_uart_bcm serial0-0: supply vbat not found, using dummy =
regulator
> [  +0.000387] hci_uart_bcm serial0-0: supply vddio not found, using dummy=
 regulator
> [  +0.094658] hci_uart_bcm serial0-0: No reset resource, using default ba=
ud rate
> [  +0.990297] Bluetooth: hci0: command 0x1001 tx timeout
> [  +0.022893] Bluetooth: hci0: BCM: Reading local version info failed (-1=
10)
> [  +3.306159] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [  +0.013336] Bluetooth: BNEP filters: protocol multicast
> [  +0.124262] Bluetooth: BNEP socket layer initialized
>=20
> --=20
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

--dcH1rd/ToVgelCkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlXAZgAKCRB4tDGHoIJi
0rRYAQCPV3NyOXggUlW5QYTcZrOknlvRNJsQPgvriNuR3R88agD/b1uTRd5yeqxu
DGOC09v8twvgMfBK721fZgjGYgug3wQ=
=k8pT
-----END PGP SIGNATURE-----

--dcH1rd/ToVgelCkf--

