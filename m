Return-Path: <linux-kernel+bounces-443828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EE9EFC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B26816F754
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B470198A29;
	Thu, 12 Dec 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UXJZs3Xf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2CF17BB34;
	Thu, 12 Dec 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031261; cv=pass; b=dOB3JbA2Zjgljrdokm6P+ad5puc3s5kpiAnszQkvP2MnosXKKWBL4o6mfYJlWeiZ68fLh/50mGfHL+wW+11xUYuN8nlri6dVD7ZaNJj5zOsJ8DqkAebttwTmbmspnHS4eWMFe317FgFlUmzI1uuvPKdfBkxQt9Q/A3OMbi20e1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031261; c=relaxed/simple;
	bh=cTjkIgTpmVLR/SFFv4x6gVWSD6/UyHK9Mz2fPwKPeqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQnk/rDwoNQ0l9do7xkVutq08RJFvHKXq6ROy/EdiodGywWTV54j8Y5bVpmDNjmsHcqjXyW7H+AQNfIZe+YI+Ji1q/9SBTYNXbG4VmHKnQwXrao3ZPTkGLSB4eu67xKjsknF6bBdyc9Ww97x5QipzR7xPcYqRksHPAUPZ63bV2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UXJZs3Xf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734031239; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hv3pMKnVGMQwJkekmHeL7LjXMImIf+604RZ+vFWB8clSywL0s8606l692wKCRauqztXbbu0B6A2+2vKfIVVJKpSbEcFPFubKlulBCmTZqVSXffMGsd9q4GILhQ4eqzrmnDHBUA/Zjg/5XYGQiCyfn/wV7IbrWFNMtME8aX4Uko4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734031239; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cTjkIgTpmVLR/SFFv4x6gVWSD6/UyHK9Mz2fPwKPeqc=; 
	b=SZ816jn/eZIXEtHBFKgy4qvWAkKRLS4FCd7wkTXfR95VIdsaj0fppDkJTY6pNTlMB2IYR777zackFUaXppIMN/Fg29VmKi4QZi/ZnPGwFEBGy5J4OZP4Q+Kl+/ihy7AlyswgbhqRyADGtelgmQqr55iJTqJeJ7fi+q+U8tNlTdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734031239;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cTjkIgTpmVLR/SFFv4x6gVWSD6/UyHK9Mz2fPwKPeqc=;
	b=UXJZs3XfwiJKwKhDAbQlSo9msmOJx2iSiv3PfKQd77qWfQ2BIxEwlRfXnGdZAWgY
	6SxHMDpzMm5zhsi/BoBcXXoGf14OETsQqYDNescbTs4e1tAvlRLljDp8rYgjFwvrnRi
	BpDDTBKGEM9ZDIdPTbW6ud+9SEcwdq2PTJ8WtJAY=
Received: by mx.zohomail.com with SMTPS id 1734031237501123.28761842157633;
	Thu, 12 Dec 2024 11:20:37 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id E4C6810604B1; Thu, 12 Dec 2024 20:20:33 +0100 (CET)
Date: Thu, 12 Dec 2024 20:20:33 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
Message-ID: <iloxbrj7ktqto5yphr7i3tioq3cbecqwu4ovxmezovux3nw7t3@j2siyintvy7j>
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
 <FFD6E87BED20DB1B+38b8064e-9945-4cd8-a30e-7800a8c6f37b@radxa.com>
 <3D830E407DCD15A2+de00ea1d-96d5-4766-9dc5-616fc76f404b@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aanin4ghjoz6zq2"
Content-Disposition: inline
In-Reply-To: <3D830E407DCD15A2+de00ea1d-96d5-4766-9dc5-616fc76f404b@radxa.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.931.41
X-ZohoMailClient: External


--5aanin4ghjoz6zq2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
MIME-Version: 1.0

Hi Naoki,

On Wed, Dec 11, 2024 at 09:40:13AM +0900, FUKAUMI Naoki wrote:
> I got random reboot during booting kernel/userland...

That is probably related to USB-C PD communication resulting in
another hard reset :( Can you try to get some tcpm_log() data
=66rom debugfs while the board is powered from the GPIO header or
PoE?

Greetings,

-- Sebastian

--5aanin4ghjoz6zq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdbN4EACgkQ2O7X88g7
+prghA//cw22TCdJFEV/aPEbXVU4VC06Qj2R7CNV7lRGfsQFVzv8OFK7qkkWjTqt
/7jF+oc2slSdPJEkXvpFNz44On84KcrPyKqGgCaDegY3+rx468nNTcUCBXRc19/7
6VMyJWlSReXFg9/SDpze3edKVY6vTiMVZrqb+1wC/563e21EQNC92jwTAQ0ZAHvn
BCv5mr6YEX0184k7KC58wAHmKbD3zJ7lblba37ba8cHSJL9wIqL+iDhdJL6TGl6s
f41Hwy147NBM5G8Usk9zRfS0MWwZFgDQCQ9xq51cJ8uKRanr8RyW1JciGe4CzAp3
bxi4CfCTsBuXkJdFluq6hribUdZISyJ2qtdpNiMqCv0htjcdvsmFJiRnPm7bCo6Y
4iXvLGooLQIuKQlzjrbzH8ZGDzqYia/yvzZ8uHvvbZXCaFNXHIaPWv7ExGMQ2geo
tAi2qlEUpjHiGdhjfMYxmJ+6EQb3OVk5+jKpD7wLkNvktjYo5Vn+2Mwq9HEplfvW
GWNNaTuLOZveIkGeiuVJ6/Z8nUXnX/xV44FnwIJMP4p6rzmfqR6076UmCmUG20Xg
jEwL77CGF+MUkSc5JsZ7Y4hpuefIgIoH0MjwrMqQFsHRLm/MSjLdFOaRc1QekPIW
4Kgs9kTF50ZVEi8f7gcIdw5c8wiCIXyvRhY4cDzOTUvhnPtdm+g=
=W28Q
-----END PGP SIGNATURE-----

--5aanin4ghjoz6zq2--

