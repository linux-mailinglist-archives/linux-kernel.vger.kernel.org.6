Return-Path: <linux-kernel+bounces-576421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0204A70F05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E35168736
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD177149E00;
	Wed, 26 Mar 2025 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="TBbOSYjI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BA13E02A;
	Wed, 26 Mar 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956104; cv=pass; b=e8PLvRPo+Lw0MLr2Q6dU0QjDG0+Tw56R7EFwqCKpK++nA2zrtNxmEhaBw6aJKLQ4pdWTV56UgEfcYOA29XOg+LLMY49dcMWzmKyXryDvyqK9iuw02RmNbXGn10sEo5w0qsE4FB7N5oBft4QuA6LrCeCWBkJYatxe9Va8tK2Cxr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956104; c=relaxed/simple;
	bh=5gmQ+tJhOEQ6J3LvTEGDk1RfsDiQRB37WVqm6a/dV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1j1AdiY9pcnKB8goXd1wOXhHMoSx9MBSZ/vMdRP5P3soyE3TqaeJAsJcA5tc1h9s5J2K/QHVDdVDoRGJAFxpIIVeylrxKcWu5a4E8sZHRZuoMGiyAAYI3ot2PJkyALYr1OpKThgR+wkED0uFe26GEYYWS1jfgZKcI2S4fhR4ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=TBbOSYjI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742956088; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c2qWMYu/bl46WfHteQAeOd/fYIoIViStB67wJdkgm52GsXDEiGvGOzOXQJ9F5b1TMJGPNWRRkqLYBvsAFG41N74gg0bS2zV810ofbA9Hulls0xF3wuiVInCSKp38r9MH+PIe7cGerglaFhRKPI6cSylC0Ehh5Q5QviujT+/D0dQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742956088; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5gmQ+tJhOEQ6J3LvTEGDk1RfsDiQRB37WVqm6a/dV8c=; 
	b=PT9UWjn+jSZrlV13Y0iYWkBhZVngAz0F235zWcMlXdZGQkw59LJ5V0aUUoVmhNDgJKOoP58JtK5otuUvMR+XkIaZJl6IAN+RDBnIJgRccg7AvvNOhi+6Ckatt01r/ZM7bTYsVWyV22QDauvOE6pSeUIeGEn/WHa28zK5Mw5N1Dk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742956088;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5gmQ+tJhOEQ6J3LvTEGDk1RfsDiQRB37WVqm6a/dV8c=;
	b=TBbOSYjIZrFmcaHjmvWUsbLV8+JeqzuMqMwyH7vAdyV16nsHh/xI1Rg7sjfEcJFM
	ATskVII0vJglhMjxuuHyKe9VAd3rK4qjrCb7apKRZU4M1CMLj6MCwbR3wkhKvjzQo5Q
	T53/JQL1pxGp9vqvYWwT6L7Uth5cfxN8thcG2Yf0=
Received: by mx.zohomail.com with SMTPS id 1742956085688129.13714269607817;
	Tue, 25 Mar 2025 19:28:05 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id F0ACB180811; Wed, 26 Mar 2025 03:28:00 +0100 (CET)
Date: Wed, 26 Mar 2025 03:28:00 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>, 
	Rick Wertenbroek <rick.wertenbroek@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, cristian.ciocaltea@collabora.com
Subject: Re: [PATCH 0/2] Enable HDMI features on NanoPC-T6
Message-ID: <jzoyhh73c5dmvvkfkvnnig3bzcgpr3fvrfrosvkeft26ovimze@i5akqrmk524i>
References: <20250325-nanopc-t6-hdmi-v1-0-299a2ed45878@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz72wtjkngnhfly3"
Content-Disposition: inline
In-Reply-To: <20250325-nanopc-t6-hdmi-v1-0-299a2ed45878@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/242.878.74
X-ZohoMailClient: External


--yz72wtjkngnhfly3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] Enable HDMI features on NanoPC-T6
MIME-Version: 1.0

Hi,

On Tue, Mar 25, 2025 at 08:51:45PM +0100, Marcin Juszkiewicz wrote:
> This patchset follows other SBCs and enables second HDMI output and then
> enables HDMI audio on both ports.
>=20
> Tested with 1920x1080@60 and 3440x1440@60 displays. Worked nice, audio
> played on both monitors.
>=20
> Would be nice to have an option for more than 60Hz (larger screen can do
> 75Hz) but I assume that this will come one day.

3440x1440 can be used up to 90Hz with 600 MHz TMDS signalling [0].
So it does not require FRL and as far as I know should work once
the scrambling support patches from Cristian (added to Cc) land.

[0] https://en.wikipedia.org/wiki/HDMI

Greetings,

-- Sebastian

--yz72wtjkngnhfly3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfjZiwACgkQ2O7X88g7
+pqFsQ//cylOZLEs6DQqi+V2MbkcIvWd7W05qyBM0k1HPdzrCIcgw+STplA3Ps5x
HIqFp4zx8f61K+000Xhr1ATCNsmWid5Sy8ghAGvd8VH+0a0vq0R850UorlAnsQMa
Er9uZuE/cMbFfybvSWM6WghEh5XAv67W1i1P6Mh55M3ozAJTCVK3GtRRnnDKwqPz
GeERslbWhjknLH7zBKEUjQMLGKakTrYSqbSfUdARmje5Xvmf8urmuE8wgbrhSyP2
XLFv0VfU6C5qkPvHoluMYl9HEliprwascRYQfXok+m6ADUVLjvsU7plwlv61TM7V
v2NN+GoeWnRLq2oigDW2dq7SCPMcgkDGVB516q29CyL2OcbOfsRVXuHCtk14zaUo
vgdaiWMoADwc4obfLpw63947DVpO/W8Kf8qnSCWdSmS7TJmF8MdJUtxRK1g06Htq
/tq3KY86cu/zLdw4APrhhgagI0KOPVhWdfeiKNvG0+jtfY2ua1fVBfIUA8N3hCQI
G0tNtkfjq5Xc7bowXVSCAlAe76V2PiRE85K2I/y69yAFmh6qIeahyP0pYKe13G9o
JYT5FwLNS3oX73D/jzLoxO0/V0XFJHACd/d1X9DEetPnRp4CLKFlKpzZ/X5fQnr6
uWnAaP5o0qnfVTBPtBU+Wpsj7qSYUeqmc0bCxO0JTKYtie3Wbvs=
=Xj4D
-----END PGP SIGNATURE-----

--yz72wtjkngnhfly3--

