Return-Path: <linux-kernel+bounces-199354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3178D85EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D871C21827
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206E1304B1;
	Mon,  3 Jun 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIvjks5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B506E619;
	Mon,  3 Jun 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428134; cv=none; b=gLhzB2cx4MV4qI3QoqvugY1WxcYjNwv60vYRzSp7u8ZGzzhfxgsrMCKLgoeGcfds7TkJNHP56unJKX04W3ivm3jVPb7BoNF+UAubM9fQIj8D9yXPVHUxlKmSHAk8DQ2bqiPxe8BhAQF5cmWPmD9blhVf5sIe/8aEYx3gBDxiXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428134; c=relaxed/simple;
	bh=aA3t6AtzH0dxyZQ/b6e+4u91SqW6efiyYat2JPiMyI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN6/hgM1441b7AFV9jKZnUKr/vpRm48oVMX4vTpDG8D8NAXXJJGURiUUKvB9Si8INFZzsUQTelqnHmC/JpnEvAG+0iAVsJUC8chWaY/yEEq0eGq7JYT2ZXBK/3Hte7YN/7mrWbtFhnCo0Ui+tdqjKx7i4P88oI+8P1Q+0qlZMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIvjks5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28907C2BD10;
	Mon,  3 Jun 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428133;
	bh=aA3t6AtzH0dxyZQ/b6e+4u91SqW6efiyYat2JPiMyI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIvjks5AoVluZfMA3Wk1JSJx5EKY7pa3A1J4ZhCIrg2F2O4YJaaX3Y0PEgvU/A54H
	 pN7aEdp26lB4WkY+0vcGW0ACK/XdJLtAle+GdYrKH0gpDijiwSCzHCUISPnkrf0ML4
	 S5xsR3cFB4rl7qqJqxk+AyK5FVwQAyLI7zgU1ksITHmA+ZwS4n4SgZSJRKm/Kp3swh
	 ttagu9cBARvcc/pqd8PoojnUrBkdCZmpyec0F/jkBnnvM6QNCyCOtfTtnC1Kqo5WIA
	 jaYODqMk6ZevJHHfnQPHCFLpCFehe7m/uMDWiM7ShLmIWvhXYuuZV7y4MQEJrEpIhR
	 q5Rx/dNQqGPbA==
Date: Mon, 3 Jun 2024 16:22:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] dt-bindings: sound: tlv320adc3xxx: Fix incorrect GPIO
 description
Message-ID: <d8da45ee-d996-4043-9bc9-f94df52540f6@sirena.org.uk>
References: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QVLkXQLHvp1n2raV"
Content-Disposition: inline
In-Reply-To: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
X-Cookie: Don't let your status become too quo!


--QVLkXQLHvp1n2raV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 05:40:04PM +0200, Ricard Wanderlof wrote:
> Fix the description for the ti,dmdin-gpio1 and ti,dmclk-gpio2
> properties to correctly describe that when configured as general
> purpose outputs (ADC3XXX_GPIO_GPO), the pins are available via
> the GPIO framework.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--QVLkXQLHvp1n2raV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd358ACgkQJNaLcl1U
h9CLzQf/b+lwQaBGqVNATDsBF2IwxA1qUDV5bLz/4HDHSc5OhqKJ0IvCZmP0ZeVb
RktIPoEpdLDxtlQZgleTML5wFRFTsQabYXOFxOihSj7l+FNAqaH8I/CeibarFAXk
+OSKfIsJADrycI7tLfOjcVcX4pmlkiNKOrfNOSOtMiEWhVjDCdPxiovYb1x01lVA
5YsXXa1vz7oLXY3WY2VaVBirsmWVN/pGQktSvSRFBb0nfzawbBJIHeMC94UQKp7F
Th+f+F7QU0cuxAONGIKXF9GGkuXL9GJ6vJzs/pfaixWv9ASwC7gye9prfpGQYVnI
9jS/EKt7f1EEQbL9pRFpm/+qc1zhPA==
=2QNh
-----END PGP SIGNATURE-----

--QVLkXQLHvp1n2raV--

