Return-Path: <linux-kernel+bounces-256699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A3935222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABCE1C21BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A63145A05;
	Thu, 18 Jul 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNfAnuxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFD145348;
	Thu, 18 Jul 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330956; cv=none; b=q4eXwx573IdJR7SdANaSAsgdw35J8yPC8fVyb01Pq1P+gy+0xb6zD0+stvgOERl7SqnjdolGC9sSz/vaDnW0ZhJC0VvQy0YhRqCBj1lX5d+rhDsJF58qPbaEUv344zxYueg5d2/bJ8kuaZadzw5rPeZ0wwlKkV5dfoiD+D7HQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330956; c=relaxed/simple;
	bh=AY7KZUhJSS2xHnx5qvpmw6/QZr8U0eAGcyvPvqwirm0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ty91qZD4G2tSmdv3PY3BjqRJQzdBlJzxQPlxnj1McbSBR6hDPudlj3UbdyBmTMs0xX4OnpUDXsj7FDsPUAXBZ/6UsW3lnRCiZcmis/gENwZ0a+A8ZpIuoipPjOtEVSCBSTXhkb9/4xkTVQsYJIQY5e5Tr3pi8/U8RshFzShE3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNfAnuxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C779CC116B1;
	Thu, 18 Jul 2024 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330955;
	bh=AY7KZUhJSS2xHnx5qvpmw6/QZr8U0eAGcyvPvqwirm0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gNfAnuxCO/xcTX51RbCvM9gaik01hcr7jaMt4URGH8qYT87MbfFVVww42i3wK9gPB
	 1TtbK0ioS6GsDRe2CVCIzVz43FtBro51gkNaOwPDLTj/fjgIG5wfNdEk8PM5ymDkcG
	 uFNGaqxWupm6RtvNvFQUhAGM3YRyuNxZY0hv5jH8JGgIC9Zt/R296EZ6ujLIP7YvQi
	 7EimfjsVH+f+PU9zVVyXsbbXemEPWn9NYQDzjCzdUTRb6EBF1wOd7cH3FywH67vuU2
	 PP2E95GB/cKpio13+ekvIkGDRmIDiv7B3Mu3LS6mxYFezfoHPplhgSv6IXOPNz/kIo
	 r3UZd2gpwfmBg==
Message-ID: <11e8dd92e07674133d8a291cc016c314.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f5bc9590-f37e-491e-9978-c1eab8914c30@salutedevices.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-2-jbrunet@baylibre.com> <b12ac6b2-cb46-4410-9846-86ed4c3aea1f@salutedevices.com> <1jv813makr.fsf@starbuckisacylon.baylibre.com> <f5bc9590-f37e-491e-9978-c1eab8914c30@salutedevices.com>
Subject: Re: [PATCH 1/8] reset: amlogic: convert driver to regmap
From: Stephen Boyd <sboyd@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 18 Jul 2024 12:29:13 -0700
User-Agent: alot/0.10

Quoting Jan Dakinevich (2024-07-18 04:01:28)
>=20
>=20
> On 7/18/24 10:19, Jerome Brunet wrote:
> > On Thu 18 Jul 2024 at 05:39, Jan Dakinevich <jan.dakinevich@salutedevic=
es.com> wrote:
> >> and using of regmap_write() (apparently) fixes it.
> >=20
> > Nor does that conclusion.
> > > It is perfectly possible I have made mistake somewhere (I have already
> > fixed one in v2), but sending incomplete report like this, with
> > unargumented conclusion is just noise in the end.
> >=20
> > No, there is no situation in which `regmap_write` would solve a problem
> > with `regmap_update_bits`.
> >=20
>=20
> What is the default regs' value of this reset controller? The doc that I
> have doesn't clearly specifies it, but it tells that "the reset will
> auto-cover to 0 by HW". However pr_info() say that there is 0xffffffff
> before write (I am talking about A1).
>=20
> Also we know, that reset is triggered by writing 1 to specific bit. So,
> what will happen if 1 will be written where we did not intend to write it?
>=20
> > Either send a full analysis of the problem you found, if you did one, or
> > at least send the full dump, explaining that you don't know what is
> > happening.
> >=20
>=20
> Full analysis is following:
> - using regmap_update_bits() instead of writel() is incorrect because
> this changes the behavior of the driver
> - regmap_update_bits() should not be used here because default value of
> regs isn't taken into account and (_apparently_, the doc is terse) these
> regs could be updated by hw itself.

Maybe use regmap_write_bits() instead.

