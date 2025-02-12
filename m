Return-Path: <linux-kernel+bounces-511764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E815A32F55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273A4162859
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35A2627F1;
	Wed, 12 Feb 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFj8MrI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFE261391;
	Wed, 12 Feb 2025 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387605; cv=none; b=LRoYYJRODJpVwmIVvJA3ZHGYl0kZ+OANtGyv7xwQOmq9ENzjSvCRfQgs35fA8GMjvnZknqP9HzzdqmKFwDO3fOUyxhD/5GV7RUunL7E33KW67X1a69a0/RLQA3iM2yNKCnymVn48X70LD87zgOUI2fQWJcud2ZHdFMUU/MCh4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387605; c=relaxed/simple;
	bh=tPcQmuq57W9bXwaHJcm+Qhck95cDJJUSoG9iHKWr4Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFl4DeUxp40kjrQEWpKUDMCtFrPmK7TqBJWhTtA/KP9HxBnacjKJcX9tkrJKb+lXcpqPh9GZoqVSFl6ZtbRUGZATsChbXIJylRCxPzkcy30U2+fTPXSLwc0n/4qpZwd/nYxyboHDgrJVbs9EVUVAEpPgHsbHIUUijrlFap4rytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFj8MrI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8606C4CEDF;
	Wed, 12 Feb 2025 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739387604;
	bh=tPcQmuq57W9bXwaHJcm+Qhck95cDJJUSoG9iHKWr4Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFj8MrI/gskDs7ezI+ZaIjV2XR92dCAIlGqQxtEGJ5/b0LrHzpKvawTDSerjLxILw
	 TdfNdVWm8KXuEjdK8T2U6h0baLhcUeBOnlP30ZyKfINHcDHg/9WIIPhhVFri5mUggp
	 iD9bCjA8o/vaC//kmHzdLHEMNcxLvQKjT3OUQPh3EKkht81bJkrb8Hein41CKyBgMM
	 s3+rOqz19Cynku9ot0jaI5X6wUxspbEhWAkP8v9FuOuI1Ss3PuNkYVna3/ISrlimXA
	 ng7X3V1QJ+NcjKmydI3ophGsVyMY1AxLyeldUgn/T5+UQLO37yEHdBrqXFJrM0ojCR
	 jBl4p1njJmZWQ==
Date: Wed, 12 Feb 2025 19:13:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, festevam@gmail.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH next v2 2/3] dt-bindings: usb: microchip,usb2514: add
 support for USB2512/USB2513
Message-ID: <20250212-upgrade-backboned-32c8f19f75f1@spud>
References: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
 <20250212135649.3431570-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/HFl2vbZl+odnN6J"
Content-Disposition: inline
In-Reply-To: <20250212135649.3431570-2-catalin.popescu@leica-geosystems.com>


--/HFl2vbZl+odnN6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 02:56:48PM +0100, Catalin Popescu wrote:
> Extend support to Microchip hubs USB2512 & USB2513 which are identical
> to USB2514 but offer less downstream ports (i.e. respectively 2 and 3
> ports).
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/HFl2vbZl+odnN6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6zy0AAKCRB4tDGHoIJi
0pu8AP92UX/yXaHPiBt1LZBrX4ZH3I2Ysfc4EnW7gOyrKAa+NQEA1eTYRXZgQmeL
rVSJ1VevOv4idk2IF418tLUhCAwtwAM=
=mflK
-----END PGP SIGNATURE-----

--/HFl2vbZl+odnN6J--

