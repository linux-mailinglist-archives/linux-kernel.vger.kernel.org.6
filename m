Return-Path: <linux-kernel+bounces-305708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B4963317
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4081F234FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE71AD9CE;
	Wed, 28 Aug 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0CC4mln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AA1AD41B;
	Wed, 28 Aug 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878459; cv=none; b=DT+SwRvICiCSUZ7u6n9c9Xnsb2kQbycg5GknhMUJW6Lr+lyYWa2+T8JjQO0yk6tIoZiYx5FGcaESF4HdkhUlCcJ/2eE9Y4Lq0huW16AuNwt3nrf912E+QzdAkGp6mGRx7OJX8+lrcDdGij1vgRpl9x4nMs8Pv5DblV5C8Eo+23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878459; c=relaxed/simple;
	bh=jjWwY3ciCOHAxUorLjKt2OVq3TE7O7c5UcD25ZB+8Kc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=uuqOg2eVvUjAfETuOSOPN77n6UwI9kP7NhsDTge1kzV9z3SDyhav6cn2Rf6HPsiRlpHeKDVoeIIEuxgMSQBv588yp6cHPSYzDpWvhcbXSDgm8qJuoONGMmPYMybiuTSFtI4M4OPlQUy10dcOvzHJQJNsLwSdYefElBrIrGvBafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0CC4mln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC8BC4CEC1;
	Wed, 28 Aug 2024 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878459;
	bh=jjWwY3ciCOHAxUorLjKt2OVq3TE7O7c5UcD25ZB+8Kc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j0CC4mlnUhyh0CeF/GmUCTrq347itA0WvySX0UKDklYSQNdepvZJX7frFNCVp3grX
	 Xm8lY6/YiDuJ10UFx38YmzAyuBaw3HE4j2Wpl1QdsNw0hr3UNKGNbSFQoV/iuJs+KO
	 dq+vYOD1GBAFfrUKzu9NsXRlwWkQf4l1pt0Yi/rwqCYXuyKcunohCLwQdNbkHaOEdY
	 yevyBYhXTkeTss80FXST3J43/dtHlv8e+V2q6n8jhfeK0o+NMwqYKGexeePc0EJt4l
	 lTaOMi/Yi30OL52cYP3HY+CLor61ocPminvqA5NUVSV41bpDxf367TpXp+9x+B/VqY
	 WesZWOy5eGHfA==
Message-ID: <2f21322a2412684c6aa7bb7d817e861c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240815150255.3996258-1-tmaimon77@gmail.com>
References: <20240815150255.3996258-1-tmaimon77@gmail.com>
Subject: Re: [PATCH RESEND v27 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Wed, 28 Aug 2024 13:54:17 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-08-15 08:02:52)
> This patchset adds clock support for the Nuvoton=20
> Arbel NPCM8XX Board Management controller (BMC) SoC family.
>=20
> The NPCM8xx clock controller is created using the auxiliary device framew=
ork
> and set up in the npcm reset driver since the NPCM8xx clock is using the
> same register region.
>=20
> This patchset cover letter is based from the initial support for NPCM8xx =
BMC to
> keep tracking the version history.
>=20
> This patchset was tested on the Arbel NPCM8XX evaluation board.
>=20
> No changes since version 26, only tested in kernel 6.11.rc1

Thanks for working on this! I'm waiting for Philipp to review/ack the
reset driver part. Until then I don't think I can apply this series to
the clk tree. I'll add a review tag to the clk driver patch in case that
helps.

