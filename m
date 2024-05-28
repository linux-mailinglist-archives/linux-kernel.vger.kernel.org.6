Return-Path: <linux-kernel+bounces-192656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C328D203C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497D11F24468
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4217083D;
	Tue, 28 May 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEjCB5ys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C21E867;
	Tue, 28 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909630; cv=none; b=ELZYz7SGIFWz99LJC8Jdt+dbD/09doMaLj4xajw0SwxJTkhdevvygiqwI0phTLKaMss+3c7CK0e+itjA5LwpJkLMDr5PhCPhx32+UOasmE9prKSSSB8OhAbPIIAhgj/nfL2ev9GX/KEicUWvBI/7rAsaN3iChHdaUER4SKWdBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909630; c=relaxed/simple;
	bh=QqDR9e2t8bWRx9dhnA1nB/3n1Rs9kv7BgeSLvf9TYFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl9QZFkkbvZQ3JVn5jcvP+aWy7UAKSeWI+/GtgvN9xJhNxh/uFif6RthwU8+4wUj6nF9jtHph8P+bTBa18IZFwQCdejO9Rzdj+z2OoWyPvXoD+LhBXel2XGnSd8raf9LFxsxgybRtZ4KNzWiSmk3CIQjNhQnV4xmSW7Z3ay3bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEjCB5ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B2C3277B;
	Tue, 28 May 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716909629;
	bh=QqDR9e2t8bWRx9dhnA1nB/3n1Rs9kv7BgeSLvf9TYFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEjCB5ysRGmNvu75KO3mEfBXhSTO9bcxQ4YAUoG1JEHdOLU9soei1/OJr+S/B4uU9
	 CQjqQr4OfGq0+bm0qthVLI7TsbLjaxbzPxsUoNiailvWrh8uJxHe3DCVt+D1vXlw0e
	 nPWoO2QS6hlqyg0+6itzVBzjcfVd9wYSkp4vugR+p3JnW53mNZAirxYpI+seUOws+1
	 vAvrJxmvH9ULkWDYiTLIqPbBaXKTnQOwOMcTGa+kU9LBPKIpLRRwZ2OgQJcJyQvDQZ
	 sJNabuQme8bSf7hZyc1QEF+g5kZTNnn2SjBvug4T8Dnxg2Ao7UwphiAgIwM1TMTl7a
	 TcLsdbDU7XplQ==
Date: Tue, 28 May 2024 16:20:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Add max6639
Message-ID: <20240528-deduct-juggle-4ff2e7fae06e@spud>
References: <20240528125122.1129986-1-naresh.solanki@9elements.com>
 <20240528-frame-liqueur-7f37ecc0dad1@spud>
 <c11900ec-dd03-43b7-916a-dc7315bb50b5@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9sDXjxEizOp8NBIa"
Content-Disposition: inline
In-Reply-To: <c11900ec-dd03-43b7-916a-dc7315bb50b5@roeck-us.net>


--9sDXjxEizOp8NBIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 07:41:58AM -0700, Guenter Roeck wrote:
> On 5/28/24 07:26, Conor Dooley wrote:
> > On Tue, May 28, 2024 at 06:21:21PM +0530, Naresh Solanki wrote:
> > > Add Devicetree binding documentation for Maxim MAX6639 temperature
> > > monitor with PWM fan-speed controller.
> >=20
> > Other than unneeded |s where your descriptions don't have any
> > formatting, this patch looks fine. That said - where's your dts or your
> > driver? A binding on its own is unusual.
> >=20
>=20
> The driver is drivers/hwmon/max6639.c which needs other unrelated changes/
> cleanups. Holding those up until the bindings are accepted would not make
> sense, so my guess is that Naresh decided to pursue the other changes for=
 now
> and add devicetree support to the driver after the devicetree properties
> have been approved. On the other side, adding devicetree support does dep=
end
> on the other changes, so trying to do that before the other changes are
> complete would be difficult.
>=20
> That is just my guess, though, and I am ok with it.

Well, I think the binding is fine, so it is up to you whether you want
to merge the binding without having the driver implementation nailed
down.

Ideally with the |s removed,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

--9sDXjxEizOp8NBIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlX2OQAKCRB4tDGHoIJi
0uc8AQCzupW+/6KLITUMKXvrN3b4eLuQhtSXFtOOwZUsnzMPmQD+NOOPuU68KhXX
NAzkgBAfiRBk8yNzpli2gf+Ww7QvrAw=
=ySB5
-----END PGP SIGNATURE-----

--9sDXjxEizOp8NBIa--

