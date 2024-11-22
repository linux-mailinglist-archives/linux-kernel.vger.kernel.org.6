Return-Path: <linux-kernel+bounces-418011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A69D5BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F038E28428D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18E18A6C8;
	Fri, 22 Nov 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KME/Hl2e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A0170A3A;
	Fri, 22 Nov 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267240; cv=none; b=mKHnlylFKrLKYtY5jj16Te/3y5wclsBPPEG4GeZDR4LkvC16k7LzDtuVuz/SttuLcHGgo0wlV7kNmbj3Gk+VMA52hQbTFs3/8Y1iCMEHN4+jq0mhP3ueB6GBcVRwdARI3JL6dLnxdvfyMMPyokSQMUZRhpcr1F0ifnV2cm0IPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267240; c=relaxed/simple;
	bh=TJISY0Qp3DpFT5vqFaWzyOjdEgvgZWYGz0dptffo+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRJnT491Rml1jixCV/iG1SYaFRcpsC7pQ19avjt4Gcy6Ll7JL6u1sQPdFzlM3TfRO/yz5A8VfajQsYuWZIo7Fs2Ynhp7/SftVa1owgCwtb4bwBWGjoSYcMdpYv+R5hb52n3QlUWB+fUFus5PQ123F7yjrKXHOkZDazIl04ru52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KME/Hl2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2AFC4CECE;
	Fri, 22 Nov 2024 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732267240;
	bh=TJISY0Qp3DpFT5vqFaWzyOjdEgvgZWYGz0dptffo+IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KME/Hl2eBbCHhY0v0AERmlO4znWAAU34qQDMEbCw7PhvXfSeVYbO+oQvKVDNyamM1
	 AVRD3oJbaJmD4nZeLB7Mkla6Ukzja/tclzHLbkaUA0XFukUx8LdeZBmofRrcOewkHS
	 jPWpjaAoMH38m00bAHypUBbGW8Vuhrl2l0vVEN+sxNt0yQ/locP9l2A/Sp2HfRLj/w
	 +cYS1MgwSrxkwVgrbDYAp/Fqk2S6Co4GEnEVBkFQ0Rw0u1wU3OIhxNjCE1DA1xVKwt
	 y3QwWIUapP4xaPxeHupKheer/zrNwfmKnKqxs6vk8lFeoVOJ50PavLMPXcczHpOMiT
	 YPgbER5kBZ1IQ==
Date: Fri, 22 Nov 2024 10:20:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Message-ID: <20241122-cobra-of-authentic-discourse-e2c5b6@houat>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3dic3xjywnt7kqn4"
Content-Disposition: inline
In-Reply-To: <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>


--3dic3xjywnt7kqn4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
MIME-Version: 1.0

Hi,

On Wed, Nov 20, 2024 at 01:45:12PM +0100, AngeloGioacchino Del Regno wrote:
> Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
> found in MediaTek's MT8195, MT8188 SoC and their variants, and
> including support for display modes up to 4k60 and for HDMI
> Audio, as per the HDMI 2.0 spec.
>=20
> HDCP and CEC functionalities are also supported by this hardware,
> but are not included in this commit.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Just a heads-up, you should really be using the new HDMI helpers, it'll
remove a lot of boilerplate and potential bugs.

Maxime

--3dic3xjywnt7kqn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0BM5QAKCRAnX84Zoj2+
doq3AYCWl8KXP/adtoZQh37W4KQ0qJZyU0dQnXyzmC0rmSXysoIv/perb0JAwCnN
EmwWeE0BgIVw4QDM9RrCyqMR8CGn/NICh9ybOvi4UXzG1UZ/sFYYIoevlH2+U4+7
PHNpqZlw+g==
=Qlnv
-----END PGP SIGNATURE-----

--3dic3xjywnt7kqn4--

