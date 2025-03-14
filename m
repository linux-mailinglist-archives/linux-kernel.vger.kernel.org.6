Return-Path: <linux-kernel+bounces-561529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E058A61313
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A13462E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD31E991A;
	Fri, 14 Mar 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ3Yqk4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D502E336A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960366; cv=none; b=V8m/pdNc1lcWlgolwuFzz3v/owv0BnPQSNpIydZOHX+oDM00fJbBiTZ23j82pzhi1YDRfkIiuDoyzTkH22frS2MDOE+bnwJcgke04Yr47az5mXLKlqzbQ/dwebPugAf+QpC2L9t2N92DLXMmAeecfnnALH7msqMNF2HojHSmUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960366; c=relaxed/simple;
	bh=CaPV8/DUO42Un9C1VboHhkm+TZPcBTQ9zJaqy+mFrgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEbkw9SJxH36pctihl1IvQf2V9USsOGKthvDm1l+pdsnnk3tg38Xc+o6x5/xlR1XxJ7AT/DEHj40sxu2PNSPXMPjYKj13mlx7ESisckvdnzer4e6xhB/sFldk7+zEBc8qpTyU/aKVMMbZXs05zuLYeSnEwt1wmQlyt7ctwwgKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ3Yqk4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E679C4CEE3;
	Fri, 14 Mar 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741960364;
	bh=CaPV8/DUO42Un9C1VboHhkm+TZPcBTQ9zJaqy+mFrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJ3Yqk4/wMoEP3MlA8qq5PtLHzCiq/rJpOJNLC/IeypEotMw4qQQgEc3a62+5Zv2d
	 5O7bCvxRSI2xwSPj7CnrVSbwy0sZMX8s/Pqr3b6LBUzNpEFruA13Fq1yydUL8MnrTl
	 Y7oKt9/mREVzVTypBLJg3xwzuR3RhD5rcB+WpFPTKzjUsuH/JM/xRuNaIfC9NWnLsM
	 kuny6X7eyKsp6nrKeCanSadCcHPQd/AA4keKxO0/z4pGPe67sAkFXiV27UCG0fc3cJ
	 ZGjzkpZ8gZD/1yjfYXy6u8m+5TBkyBb2SuPxaMG0MqanEzfC4u2VpRFGCJ8RWcbSfz
	 R6SEsNYmHVXlw==
Date: Fri, 14 Mar 2025 14:52:42 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] drm/tests: hdmi: Add limited range tests for
 YUV420 mode
Message-ID: <20250314-didactic-bandicoot-of-perspective-e077ae@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-6-fbdb94f02562@collabora.com>
 <20250311-burgundy-cat-of-diversity-b89681@houat>
 <dca413e0-bad5-485d-9c77-402d806e97a5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3qcnnqf3voxkluic"
Content-Disposition: inline
In-Reply-To: <dca413e0-bad5-485d-9c77-402d806e97a5@collabora.com>


--3qcnnqf3voxkluic
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] drm/tests: hdmi: Add limited range tests for
 YUV420 mode
MIME-Version: 1.0

On Wed, Mar 12, 2025 at 12:54:51AM +0200, Cristian Ciocaltea wrote:
> On 3/11/25 6:17 PM, Maxime Ripard wrote:
> > On Tue, Mar 11, 2025 at 12:57:38PM +0200, Cristian Ciocaltea wrote:
> >> Provide tests to verify that drm_atomic_helper_connector_hdmi_check()
> >> helper behaviour when using YUV420 output format is to always set the
> >> limited RGB quantization range to 'limited', no matter what the value =
of
> >> Broadcast RGB property is.
>=20
> [...]
>=20
> > We need more tests than that to test the various combinations, whether
> > the fallback to YUV420 should work or not depending on the EDID, the
> > driver capabilities, YUV420-only vs YUV420-also, etc.
>=20
> Some fallback tests were provided in the next patch, including checks lik=
e:
>=20
>   KUNIT_ASSERT_TRUE(test, drm_mode_is_420_only(info, yuv420_only_mode));
>   KUNIT_ASSERT_TRUE(test, drm_mode_is_420_also(info, preferred));
>=20
> I'll try to further extend the test coverage.

Yeah, sorry, I saw them after reviewing this patch. Still, I think we'll
need more, especially to deal with the fallback cases. IIRC, you were
testing the cases where you're forced to take YUV420 because of the
monitors (or drivers) limit, but we should also try the tests where
you're forced to take YUV420 but the driver implements HDMI 1.4 only for
example, and thus we can't.

Maxime

--3qcnnqf3voxkluic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9Q0qQAKCRAnX84Zoj2+
djFTAYCuCBkdca3mDmyZr8j1d6GofqJ5n0Bb8bJklVbWIbH7K+7imNbVo3T+A9mB
K/vjC3oBf35IdeIrLSQ8RShZCAynMcSLfo2Oi2WrGtjbVt8aT2fKukV1hGlkB1eu
eI6OqsWeHg==
=qXNN
-----END PGP SIGNATURE-----

--3qcnnqf3voxkluic--

