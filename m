Return-Path: <linux-kernel+bounces-189035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B438CEA24
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70143B20EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848242ABD;
	Fri, 24 May 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOZmcQTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362F47F57;
	Fri, 24 May 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577266; cv=none; b=HrMftVXygFoM26+fEOZBIAquYjNXUmBCsITZmBk0F5MXCqfKE6uCLXGOE9fqTPig6hchZazRqPZoTdjHao72Y/nJk0iuvjgNUnaIBjvEkZ1AQPPo9S+2OxmVRf7SPIXqUKtfQxIsBZXK7U6irgp6YgJLyAZnFfOSfyBZ+401UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577266; c=relaxed/simple;
	bh=lqkyT0jzHP+AbsDxIKKH+kS97cpS93owMRKVsE/Meyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7mNU0v5tG/59JD90dfjiBZbPu587g7a+pOTrCC7K7oJqktCXDZSvbPsJ//1qS5GbPBI+LArJ+fA52we6nYhogZaiYGvTmkyneyETIbKWCHOe7h0uobhcRzx7DsZF/TuecoCUhq5oHkjXUBX6poH/d5A20wbwi+Gi56SJbW1P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOZmcQTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89FC2BD11;
	Fri, 24 May 2024 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716577265;
	bh=lqkyT0jzHP+AbsDxIKKH+kS97cpS93owMRKVsE/Meyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOZmcQTsz1vE4FYet9Q0f2UFtKks5JH7/+XpQ66GdQhwOWh+iiqLC2C382HkpKGc0
	 UHRgKsXDpe4aX3M0XSYiOGOULtITlGKWhf+w7KW9T7luWYqaltl584sW/V/ZezlFzk
	 Jvm/xS8TCjdPAbJ34tIJ5fYm4nwKIokOLX74/zllAanHWw3caUXAal47srKO0xLxpq
	 cJJ0Fl5Br4P0IB0t6gMYCy8BiY2BijjF+eB4zGhNYKAU936bMXfz9ECazAk7Uxxim6
	 XQXF2Ecrc+82pXp8wH3QA+ysyJHqzhLjiX5iTQmwmAJAnCwYHtPQHE5TVdORZH0n+2
	 5wBi+G3FNJArg==
Date: Fri, 24 May 2024 20:01:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org,
	maz@kernel.org, Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] dt-bindings: vcpu_stall_detector: Add a PPI
 interrupt to the virtual device
Message-ID: <20240524-portfolio-spoiled-a77d944d3844@spud>
References: <20240523160413.868830-1-sebastianene@google.com>
 <20240523160413.868830-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOPzgbwwnCxZeu9Y"
Content-Disposition: inline
In-Reply-To: <20240523160413.868830-2-sebastianene@google.com>


--zOPzgbwwnCxZeu9Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:04:12PM +0000, Sebastian Ene wrote:
> The vcpu stall detector allows the host to monitor the availability of a
> guest VM. Introduce a PPI interrupt which can be injected from the host
> into the virtual gic to let the guest reboot itself.
>=20
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--zOPzgbwwnCxZeu9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDj7QAKCRB4tDGHoIJi
0sDXAP9OQbjlYb0CGqvIgBAs4QOeNy77SMyJlCAMtgM6YE9EggD/RVlO6a5dBy2q
bNRf2njTOep+FztTSJQcZ3Nv8bPhJAE=
=4n7G
-----END PGP SIGNATURE-----

--zOPzgbwwnCxZeu9Y--

