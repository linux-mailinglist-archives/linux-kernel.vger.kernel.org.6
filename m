Return-Path: <linux-kernel+bounces-344205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13A98A65A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0940D1F2367F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F219047C;
	Mon, 30 Sep 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJXUfV7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFD190462;
	Mon, 30 Sep 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704473; cv=none; b=Twxtqm9qI6H/F1MzHmwog/ejG4GwHfLKJjgcg1P0ez+BZXQJd3ewv9jkglVwSrXPKkMsoCHGFMzwduJqhL9zSKAx/AYEYuojSp1H06VCUmDLc2X6NQ5xk/xlb8YkJMdTNRnGUwwKhd9qIEiGxiDM4T+Ov7abEnKNZN3AT5fgO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704473; c=relaxed/simple;
	bh=d7gElJyf7D9ksXwAIpophG5Uqbgtl7nqygwS91dUJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOrwHZGQI8rDDd7pgquWm4njMa8p8BHj5oWNzH8XoLgx3NiByfwo+cGcUqRkrafhp5P4CkB09nVoSCuHPeNZRdj0Kt+EfrqKCVFdyxwX4/D0LAACgJf3KgWC+5dMNjSEJV+KDruOxsrriD+j/b2fgnJMR16rgQ+z1pfJLfnt3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJXUfV7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C0C4CECF;
	Mon, 30 Sep 2024 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704470;
	bh=d7gElJyf7D9ksXwAIpophG5Uqbgtl7nqygwS91dUJ38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJXUfV7cCMSkCaK5VN1ykIgI6bvWdDJfSG4mh1k5Hr5NeY/xi9qatMjlr3Ud077uv
	 LSX0khtMy9DyBRAaoLTeNoU6DOx5PIXX1qHipQIaiNHaZ0HA5M+LJQYKq+t4deHzQd
	 6dVO+ffGD+oMUrgIaGE2PD0Y8D+q0IxWw7u427cphbu3aqHEN4SOZZvi6JMXvA45xe
	 12L5azxtBta4vRmon85LlA4ttUv9tcfjUv49zpQDyMWzYbEn+WAyAXlW+cLc9UMHPV
	 Fihnc1GI9xwrbVOuprYjw71PEspjD/geJxVVkcwviChiJu/Pa10M+voCQ1WfGurHGQ
	 asCWbvZ8mgTAw==
Date: Mon, 30 Sep 2024 14:54:25 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 15/20] dt-bindings: riscv: microchip: document
 the PIC64GX curiosity kit
Message-ID: <20240930-knelt-sway-04060e0ee22b@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-16-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7QH427KuhNWnm3Mj"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-16-pierre-henry.moussay@microchip.com>


--7QH427KuhNWnm3Mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:44AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> Update devicetree bindings document with PIC64GX Curiosity Kit, known
> by its "Curiosity-GX1000" product code.
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--7QH427KuhNWnm3Mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqtkQAKCRB4tDGHoIJi
0s9QAQCk+iAJ6+t1MuQmVPsS7UwIejIRLvJZBRC44V9oqc7iUQEA6iSPYqHZ0Byj
a5bXIew4y2/U/Gbw6YuzeCkNzT4jOAY=
=IK+Q
-----END PGP SIGNATURE-----

--7QH427KuhNWnm3Mj--

