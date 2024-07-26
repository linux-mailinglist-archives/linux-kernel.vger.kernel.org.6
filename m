Return-Path: <linux-kernel+bounces-263518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5493D728
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2001F24753
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDA17C7B8;
	Fri, 26 Jul 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StIKHOPn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45F63CB;
	Fri, 26 Jul 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012267; cv=none; b=GJFyEG90S5QmIoBRlHwuP69Dmk+FbTNROxPG9R6h6ohURGtuFsFbN2VBNjCKiB9wg23/LSjnzM/fCV3G9cl00mufGSxW46rbPvd2Uqi37K0S7RLZAtsplGQLRfh9bPREYs1ltGx7Ij/EDlSUTNP1dAHEqWC6TQoNs+zMMdyiIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012267; c=relaxed/simple;
	bh=9youBC6MiVIpwrFNTCy5T5voV/G4s6p+REdUfBArF/U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iD/ehvqG/+a0k0Nf5DDcAyWOnOugI96fcxM11TQspPMbV+ALJBIg58Se2pASnMm4zxCNsBKzV/WLx8qhEEwQmzoeVDX08anr7oPfhPRiHYx8h4hoLpYc8O+DbQt09PD8CWUZNPcUvhwTx4u+pNlPVcE7ZSba+O4Ec3fT1PodY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StIKHOPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8DFC32782;
	Fri, 26 Jul 2024 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722012267;
	bh=9youBC6MiVIpwrFNTCy5T5voV/G4s6p+REdUfBArF/U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=StIKHOPnykRDZZRdGrF3Oxugwi6NJfR+EwNkf912hwC3yVs7BnhXqKQwAHh8ws4zb
	 NC5Vh5GqtBS94AzcftxjmbHPVB8GKjwGbLyRaKCkYSuPhpI+ka7Kxig+698BUqzh7V
	 Xyjso+5vyujXGYutg9D1tN6RVeFn9Rf6xN6+9fYnwmSmuAMli7FA/eeeK9quYd+4nQ
	 24yhOYdD3Cy4IxQNcTYdOyQ3FyDuqmdjSEgOi06LplH82poCadqBc1NqfzBwV8Vcjo
	 l5SgS7NytDp3pFygYTy6/Dl3OkJ7+ldIuvX1x1JhcXsDbGIqtAQXzysw3qHw07FLMu
	 2upLbZJGTWlUw==
Message-ID: <936d1eaa5089b2b2834bb60dd10ceae4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <298d204a7d9c8dce1f1a2f180b12bd3887ea4802.camel@linaro.org>
References: <20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org> <d17567eb0ad9a6082d55ca016771abbc.sboyd@kernel.org> <298d204a7d9c8dce1f1a2f180b12bd3887ea4802.camel@linaro.org>
Subject: Re: [PATCH v4 0/2] gs101 oriole: UART clock fixes
From: Stephen Boyd <sboyd@kernel.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, =?utf-8?q?Andr=C3=A9?= Draszik <andre.draszik@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peter Griffin <peter.griffin@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 26 Jul 2024 09:44:25 -0700
User-Agent: alot/0.10

Quoting Andr=C3=A9 Draszik (2024-07-25 00:12:48)
>=20
> I didn't think that was necessary (and no, I don't have a binding update =
at
> the moment). It gets the clock associated with the serial port (of_stdout=
),
> if any, and works off that.
>=20
> Did I miss something?

No, I missed it. I was thinking it was the chosen node but it's actually
the serial node.

