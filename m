Return-Path: <linux-kernel+bounces-576219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D8A70C78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4847174768
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B2267B9D;
	Tue, 25 Mar 2025 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1XyMEmN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03D1A725A;
	Tue, 25 Mar 2025 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939824; cv=none; b=ckjpLRxvYZQXo2LC2Uq/VsoSafJHWnjo7J9KSM4mlVdX25S9zMCzQy1nA7drVfMQVFp3Oqy7uoyY5EO4OqcmUf4i/KL6tvNskH0twm5qd8DC8jOTVELpWgEO22w7AC7E+stqKl69I+PNY10i61iSEmBzuK2OgIjz7mZqQkH9Kp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939824; c=relaxed/simple;
	bh=dVbKSNw9IpYPnjB4Ud3V8KshkTL7MxnrLDQsyEYyjgs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=s90kHz72AXhnfl+Vg/qcjEnndEWFxXM/ZjD4j4OA6uiBpnGPDvy1OZ7jjeaY4D5+GQh7DlzOOHTyf2IfrEmhprj05fDqskGy+Qx59OKD9jg7r7QTEftNlqiloQOetcf7YXfXeH8wnNDUw1o99Ui2DrNuKoYx+fGLA7zP0WcU3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1XyMEmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B47C4CEE4;
	Tue, 25 Mar 2025 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939824;
	bh=dVbKSNw9IpYPnjB4Ud3V8KshkTL7MxnrLDQsyEYyjgs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U1XyMEmNYZIlwYioOLPxclfPhiC+yUspDrhkZq+hTqghQwVjwS0zv2BVZbh2GVg89
	 9otj4z/5i+7itFygyS8sD2cfaHriu6bLgJ+l2P2O8hQcSU07nLPDrKt6M4tqEiyvTN
	 ZztdVM9vFRbExjb0NzQBvOzxk1yXRP+VN0G1BYdUBCQSyPbstgBzS2TUHuWaR50a3y
	 K+QkC1xQ9k0hM3kXBkBIHNSQwO3eKsLYojZ/rXqJ47GtUh8Vp5DMdu+XGaOkqmjQ5Z
	 M+w1s7PRQfeXZQDUQ/oAR4FiAcUtlN+24cCvCuOOSvJv6Tf8GZYWBI4h/atfb8K5aF
	 KzDUpJTwDMq2g==
Message-ID: <4db0bf5937c6c2a480b89b11e841782c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jv7s21d8y.fsf@starbuckisacylon.baylibre.com>
References: <20250120-amlogic-clk-drop-clk-regmap-tables-v3-0-126244146947@baylibre.com> <20250120-amlogic-clk-drop-clk-regmap-tables-v3-1-126244146947@baylibre.com> <508a5ee6c6b365e8d9cdefd5a9eec769.sboyd@kernel.org> <1jv7s21d8y.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH v3 1/4] clk: add a clk_hw helpers to get the clock device or device_node
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 25 Mar 2025 14:57:01 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Jerome Brunet (2025-03-21 10:53:49)
> On Wed 26 Feb 2025 at 17:01, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
>=20
> >> +static void clk_hw_get_of_node_test(struct kunit *test)
> >> +{
> >> +       struct device_node *np;
> >> +       struct clk_hw *hw;
> >> +
> >> +       hw =3D kunit_kzalloc(test, sizeof(*hw), GFP_KERNEL);
> >> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> >> +
> >> +       np =3D of_find_compatible_node(NULL, NULL, "test,clk-dummy-dev=
ice");
> >> +       hw->init =3D CLK_HW_INIT_NO_PARENT("test_get_of_node",
> >> +                                        &clk_dummy_rate_ops, 0);
> >> +       of_node_put_kunit(test, np);
> >> +
> >> +       KUNIT_ASSERT_EQ(test, 0, of_clk_hw_register_kunit(test, np, hw=
));
> >
> > The stuff before the expectation should likely go to the init function.
> > Or it can use the genparams stuff so we can set some struct members to
> > indicate if the pointer should be NULL or not and then twist through the
> > code a couple times.
> >
>=20
> I'm trying to address all your comments but I'm starting to wonder if
> this isn't going a bit too far ? The functions tested are one line
> returns. Is it really worth all this ?
>=20
> I do understand the idea for things that actually do something, such as
> reparenting, setting rates or what not ... But this ? It feels like a
> lot of test code for very little added value, don't you think ?
>=20

Just so I understand, you're saying that this is always going to be a
simple "getter" API that doesn't do much else? We're not _only_ testing
the getter API, we're also testing the registration path that actually
sets the device or of_node pointers for a clk. I'm not really thinking
about the one line return functions here.

Writing tests is definitely a balancing act. I'd say we want to test the
behavior of the API in relation to how a clk is registered and writing
tests to show the intended usage is helpful to understand if we've
thought of corner cases like the clk was registered with a device
pointer that also has an of_node associated with it. (Did we remember to
stash that of_node pointer too?) We have a bunch of clk registration
APIs, and we want to make sure this getter API works with all of them.
Note that we don't care about the clk flags or parent relation chains
here, just that the device or of_node passed in to registration comes
out the other side with the getter API.

A little code duplication is OK, as long as the test is easy to
understand. Maybe genparams stuff is going too far, I don't know, but at
the least we want to make sure the clk registration APIs behave as
expected when the getter API is used to get the device or of_node later.

I've found this google chapter[1] useful for unit testing best
practices. I recommend reading it if you haven't already.

[1] https://abseil.io/resources/swe-book/html/ch12.html

