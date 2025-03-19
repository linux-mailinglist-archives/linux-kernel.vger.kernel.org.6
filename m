Return-Path: <linux-kernel+bounces-568312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF3A693CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA13419C50F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAB1C82F4;
	Wed, 19 Mar 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYZ/OD9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3A158DAC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398363; cv=none; b=FSAvemaXrpiXUUqNJrLHZhc2ep7Mu6r5ZZF+2JAoKOzvOl58LaoVFj5htP46/7Y6Xsc2KXpb4AirNZqHfiQRfRNKJ8bEqBaiwtvmlTCMT1i/yTrKq5chZnZ5ulHl8WlDVXZFoCCSqg5HNwyuCAapbyVbtbanj+mRhFhj4TsfcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398363; c=relaxed/simple;
	bh=HNN0i0ao5Zjs0sbBhT4I9ylYIsk7PK0dzKujNGmQTDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IseRmbQPQU81O1kSkNMTp36T4oukSNXvAugCv2IvNUkqgZ75zSDhBAlnKYy1eCz2vAS296SaKVFb+J271jAX1ivkyWRAZ3kEyr+61InBz3+XQHwCRJ7J0NmlCTDFXkJ/EIfPlG7YIINm0HtmkwYJbjFlDA2fl1Wy1VPRbnntlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYZ/OD9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025A3C4CEE4;
	Wed, 19 Mar 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398363;
	bh=HNN0i0ao5Zjs0sbBhT4I9ylYIsk7PK0dzKujNGmQTDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYZ/OD9xP8N2SjELWjW4puuZk4rgyAL20gY3gC/5U2nMwXTRAuIJRvOwh3ketqRpY
	 7JR2i4LRzv4D2nOXjVfQagiyrf9x7bwc3bceZG7yFEMz2OQZrgffd5QKB0mY06L6JE
	 NDlcn3fzwy5jlCy4fpAYsxA1P3AEdk/JJYqj4WxqQsdz8BMATzrQjcURSgyqcDV72l
	 sjV+opggl+bc43dOvPbCF0sQR9OXbA9vZp823jWt3YFgyO16vfp2n3IrXaWT3HB41b
	 K1aniTioB7RhBH+ltWVpnykWTvymrrNcY1/QnHwgyXEt4dHpz5hdUwoh7gzjDr/bEY
	 xPFOku1KzjsSg==
Date: Wed, 19 Mar 2025 16:32:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/tests: hdmi: Add macros to simplify EDID setup
Message-ID: <20250319-organic-skink-of-judgment-ab4ffd@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-5-fbdb94f02562@collabora.com>
 <20250311-spiritual-hornet-of-prestige-ef4132@houat>
 <a91cabd5-f0af-42a3-95b5-de68e30f7f23@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="d6jchqfwxxdpjzsb"
Content-Disposition: inline
In-Reply-To: <a91cabd5-f0af-42a3-95b5-de68e30f7f23@collabora.com>


--d6jchqfwxxdpjzsb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] drm/tests: hdmi: Add macros to simplify EDID setup
MIME-Version: 1.0

On Wed, Mar 12, 2025 at 12:44:26AM +0200, Cristian Ciocaltea wrote:
> On 3/11/25 6:12 PM, Maxime Ripard wrote:
> > On Tue, Mar 11, 2025 at 12:57:37PM +0200, Cristian Ciocaltea wrote:
> >> Introduce a few macros to facilitate setting custom (i.e. non-default)
> >> EDID data during connector initialization.
> >>
> >> This helps reducing boilerplate code while also drops some redundant
> >> calls to set_connector_edid().
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 245 ++++++++----=
---------
> >>  1 file changed, 93 insertions(+), 152 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/driv=
ers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> >> index e97efd3af9ed18e6cf8ee66b4923dfc805b34e19..a3f7f3ce31c73335c2c264=
3bdc5395b6ceb6f071 100644
> >> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> >> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> >> @@ -183,10 +183,12 @@ static const struct drm_connector_funcs dummy_co=
nnector_funcs =3D {
> >> =20
> >>  static
> >>  struct drm_atomic_helper_connector_hdmi_priv *
> >> -drm_kunit_helper_connector_hdmi_init_funcs(struct kunit *test,
> >> -					   unsigned int formats,
> >> -					   unsigned int max_bpc,
> >> -					   const struct drm_connector_hdmi_funcs *hdmi_funcs)
> >> +connector_hdmi_init_funcs_set_edid(struct kunit *test,
> >> +				   unsigned int formats,
> >> +				   unsigned int max_bpc,
> >> +				   const struct drm_connector_hdmi_funcs *hdmi_funcs,
> >> +				   const char *edid_data,
> >> +				   size_t edid_len)
> >>  {
> >>  	struct drm_atomic_helper_connector_hdmi_priv *priv;
> >>  	struct drm_connector *conn;
> >> @@ -240,30 +242,27 @@ drm_kunit_helper_connector_hdmi_init_funcs(struc=
t kunit *test,
> >> =20
> >>  	drm_mode_config_reset(drm);
> >> =20
> >> +	if (edid_data && edid_len) {
> >> +		ret =3D set_connector_edid(test, &priv->connector, edid_data, edid_=
len);
> >> +		KUNIT_ASSERT_GT(test, ret, 0);
> >> +	}
> >> +
> >>  	return priv;
> >>  }
> >> =20
> >> -static
> >> -struct drm_atomic_helper_connector_hdmi_priv *
> >> -drm_kunit_helper_connector_hdmi_init(struct kunit *test,
> >> -				     unsigned int formats,
> >> -				     unsigned int max_bpc)
> >> -{
> >> -	struct drm_atomic_helper_connector_hdmi_priv *priv;
> >> -	int ret;
> >> +#define drm_kunit_helper_connector_hdmi_init_funcs_set_edid(test, for=
mats, max_bpc, funcs, edid) \
> >> +	connector_hdmi_init_funcs_set_edid(test, formats, max_bpc, funcs, ed=
id, ARRAY_SIZE(edid))
> >> =20
> >> -	priv =3D drm_kunit_helper_connector_hdmi_init_funcs(test,
> >> -							  formats, max_bpc,
> >> -							  &dummy_connector_hdmi_funcs);
> >> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> >> +#define drm_kunit_helper_connector_hdmi_init_funcs(test, formats, max=
_bpc, funcs)		\
> >> +	connector_hdmi_init_funcs_set_edid(test, formats, max_bpc, funcs, NU=
LL, 0)
> >> =20
> >> -	ret =3D set_connector_edid(test, &priv->connector,
> >> -				 test_edid_hdmi_1080p_rgb_max_200mhz,
> >> -				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
> >> -	KUNIT_ASSERT_GT(test, ret, 0);
> >> +#define drm_kunit_helper_connector_hdmi_init_set_edid(test, formats, =
max_bpc, edid)		\
> >> +	drm_kunit_helper_connector_hdmi_init_funcs_set_edid(test, formats, m=
ax_bpc,		\
> >> +							    &dummy_connector_hdmi_funcs, edid)
> >> =20
> >> -	return priv;
> >> -}
> >> +#define drm_kunit_helper_connector_hdmi_init(test, formats, max_bpc)	=
			\
> >> +	drm_kunit_helper_connector_hdmi_init_set_edid(test, formats, max_bpc=
,			\
> >> +						      test_edid_hdmi_1080p_rgb_max_200mhz)
> >=20
> > I'd really prefer to have functions to macros here. They are easier to
> > read, extend, and don't have any particular drawbacks.
>=20
> Yeah, the main reason I opted for macros was to allow dropping
> ARRAY_SIZE(edid) from the caller side, hence making the API as simple as
> possible.
>=20
> > I also don't think we need that many, looking at the tests:
> >=20
> >   - We need drm_kunit_helper_connector_hdmi_init() to setup a connector
> >     with test_edid_hdmi_1080p_rgb_max_200mhz and
> >     dummy_connector_hdmi_funcs()
>=20
> Correct.
>=20
> >   - We need to create a
> >     drm_kunit_helper_connector_hdmi_init_with_edid_funcs() to pass both
> >     the funcs and edid pointers
>=20
> That's drm_kunit_helper_connector_hdmi_init_funcs_set_edid(), but I can
> rename it if you prefer - I've just tried to keep the name length under
> control, as there are already some indentation challenges when calling
> the helpers.
>=20
> Currently it's only used to implement
> drm_kunit_helper_connector_hdmi_init_set_edid() by passing
> &dummy_connector_hdmi_funcs, but there are a few test cases that can
> benefit of it and help extend the cleanup - will do for v3.
>=20
> drm_kunit_helper_connector_hdmi_init_set_edid() should also stay as it's
> already being used to drop boilerplate code from a lot of places.
>=20
> > And that's it, right?
>=20
> There's also drm_kunit_helper_connector_hdmi_init_funcs() which has been
> used for a few times, but it can be further optimized out via
> drm_kunit_helper_connector_hdmi_init_funcs_set_edid(), so I'll drop it.
>=20
> That means we could end up with just the following:
>=20
> - drm_kunit_helper_connector_hdmi_init()
> - drm_kunit_helper_connector_hdmi_init_set_edid()
> - drm_kunit_helper_connector_hdmi_init_funcs_set_edid()

I'm not even sure we need init_set_edid. We just have to provide the
dummy_connector_hdmi_funcs pointer to
drm_kunit_helper_connector_hdmi_init_funcs_set_edid and that's it.

And yeah, I'd really prefer to use
drm_kunit_helper_connector_hdmi_init_with_edid_funcs() to remain
consistent with the rest of KMS.

Maxime

--d6jchqfwxxdpjzsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9rjkwAKCRAnX84Zoj2+
dlWSAX4k0k9vJXSVTLGjJI0eIWGAJQcHorso0MBfwoXp+n/wKJnNh1DZLBpS+T7G
WCVma6EBgKc5C7e3bq7vIlIs5w3e6WahYpi44+BgGi73yKs0f3/3mULhVmqaSV8q
NoP83ZebdA==
=zKZO
-----END PGP SIGNATURE-----

--d6jchqfwxxdpjzsb--

