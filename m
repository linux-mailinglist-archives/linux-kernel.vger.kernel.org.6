Return-Path: <linux-kernel+bounces-223006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483C910B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538371C24A30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72701B14F4;
	Thu, 20 Jun 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL1Zmpak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668A3BB50;
	Thu, 20 Jun 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900060; cv=none; b=cS5oFSXrRfqv+L3vdLrJF+qa5UXwDRkg088eJh4dAhovc/tpv2eP5nCqQhBgDzzYl46Bw3eHHCYvGUREuaYbqxrJ1kUx5xYTkOqMhH5znSUoIZyWmsFgu5KZIMsUs7otyYQZ19G6gD3JdtyDd6IGuYqjh/HlnhB31/lwy67TxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900060; c=relaxed/simple;
	bh=+GHT9WcvwhnXq3uv4PeG/J2phcFuK0s3zZGAxE9Vr94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZU6BZ7st+yZ4kOe6C69O10bL5gN7KLmI/CjhTdWoOcmR+2JpBGRji+9hd8SnWvQJhfgQ/N8heQEu7SoSTzo05qJnqgvKvE64orN8Ng/yNa9yOtGoZnBI8QGVUpXPUEfPTTBF6jB+67wYbf7v90LSioUketL4KbWFwPkxfHALjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL1Zmpak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A0EC2BD10;
	Thu, 20 Jun 2024 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900059;
	bh=+GHT9WcvwhnXq3uv4PeG/J2phcFuK0s3zZGAxE9Vr94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL1Zmpak4E6ksK9u+PVo5VdVvcL+kvWyI8ZQX46xQpOe6Xj/v/RqajdHhXoBlKJkF
	 qhLB8HB641YNFZpDspRhNRiHPITXDqpNsDMIzE9VXAF5rHa4cuV6t6zFAX4UdAng3L
	 DIwe6PgCD/V+PohEOjfcntpY7b3Q7K83LgVtTnMIjZqdXxgpfmU8Wt8tt0C/evsUvs
	 TaeySm/znVYAg0k3/1iTkaXClkLqDU2GpOl+o26hMvFKKSLIhMTMHZ2JaKoc4UxzSj
	 SIPZqV1xTJ8CbvLuEo1Dd2oZl3yRRbPNDhBbqjhzUk0iJvKW4zkaMX93RbVpw4L37b
	 fGyPyCy4hGmsg==
Date: Thu, 20 Jun 2024 17:14:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.co, dianders@google.com,
	hsinyi@google.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: display: panel: Add compatible for
 kingdisplay-kd101ne3
Message-ID: <20240620-shiny-germless-d5b8d532c9d1@spud>
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620080509.18504-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aDlbeZ9BUzsTHd9G"
Content-Disposition: inline
In-Reply-To: <20240620080509.18504-3-lvzhaoxiong@huaqin.corp-partner.google.com>


--aDlbeZ9BUzsTHd9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:05:07PM +0800, Zhaoxiong Lv wrote:
> The kingdisplay-kd101ne3 is a 10.1" WXGA TFT-LCD panel with
> jadard-jd9365da controller. Hence, we add a new compatible
> with panel specific config.
>=20
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--aDlbeZ9BUzsTHd9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRVVwAKCRB4tDGHoIJi
0ncSAP43WLQQ6LFeUx/1Ug5lQcZ4fs4MmDPdXIqCNU8WuIBgmAEAxXbKXm2s74+Q
2TWp6pYecg8Oo+td+P35lDWuiEil0wo=
=6avv
-----END PGP SIGNATURE-----

--aDlbeZ9BUzsTHd9G--

