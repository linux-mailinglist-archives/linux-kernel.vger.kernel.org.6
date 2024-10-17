Return-Path: <linux-kernel+bounces-370678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A79A30A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB171F22A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C71D88DC;
	Thu, 17 Oct 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m35UKRgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B501D7E5F;
	Thu, 17 Oct 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203800; cv=none; b=We84oBMrOsvQwdGQ5gXYKTOz/Dw6ObV6BSPwqHqxaW04brZX1V5kf+GAGuxFzIryqFbABjCFSDGjHCFgyr73Yb7bsMI9wJkzCnHejU0JcOawG/FXS0wGy/6fY8KsQ2LYr1Q/vLgcU1CYDCBOzjfpEYYAGDN/xYOnvSvbpYYn7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203800; c=relaxed/simple;
	bh=KwT/aJPiK5xkDRNj9pug3grDAGO4P5xSfLj+FmVfLyw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZKhFamHneXiwErKnYOzNSbhIoBICHZVj9X/oxXtMMilUcCxXbOx1iovGsr69gfcbPeU5+UoqrZ+ak3i1rSMbqTS79GFZLDa77n+tQ2886teudnZgrP+4A5MTS/+TWKv5BziGJA4Ne5iEQqXYjrHCK66pCe+M9mzJjXE0pgqbwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m35UKRgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C67C4CEC3;
	Thu, 17 Oct 2024 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203800;
	bh=KwT/aJPiK5xkDRNj9pug3grDAGO4P5xSfLj+FmVfLyw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m35UKRgWmadvUcB4X61Ask++YicqU09fqrTf4VnB0Vsv2xgJZUviSmxYPDrxG0TXE
	 qTV2ulmJySWIpWTMtvlZFTld6ReLwIDyXsoJ3v1gLZDAIXGz+2KxArh8XM8F/GYiE/
	 0i4w+QZ+TjC1uyCxTOM9mXcYfiNsFeK9UszNGIdvV6abueMHTMb3zsfc9P5SxngUxx
	 7B5UWU1kZkY25oP+VwP1SPFdt2Uy25OROQFtvlBxV9nzFVsVsevvlUKd9ppjkZhbCp
	 ZiafBn0gB+B2gVHTGRb1iqOZ92KoZpdu/YXvQgmulxPq+HMsbJbKqV2Fx7RKn3S1IT
	 j68GAAQVxbfLQ==
Message-ID: <94fe46018da3f565b065cf914733531d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240912191038.981105-4-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com> <20240912191038.981105-4-tmaimon77@gmail.com>
Subject: Re: [PATCH v28 3/3] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Thu, 17 Oct 2024 15:23:18 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-09-12 12:10:38)
> Add auxiliary driver to support Nuvoton Arbel BMC NPCM8XX contains an
> integrated clock controller which generates and supplies clocks to all
> modules within the BMC.
>=20
> The NPCM8xx clock controller is created using the auxiliary device
> framework and set up in the npcm reset driver since the NPCM8xx clock is
> using the same register region.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Benjamin Fair <benjaminfair@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

