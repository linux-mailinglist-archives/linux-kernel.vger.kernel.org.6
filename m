Return-Path: <linux-kernel+bounces-305712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374B963322
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A621F1C20DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B2F1AE84A;
	Wed, 28 Aug 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW85VqHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D71AE040;
	Wed, 28 Aug 2024 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878490; cv=none; b=kUFHL3F8PImu40QJGIWEjrbJ9isCh5XH+gObdFzWIyWQpMWADOaAiw9ocf6vvmQNjqs+yznk++kpXSBGt9W9T5IQWGXWvKngkyF0pqsD+kjuat5vg3yF0CEpGH+nqxGelgYjlb525xyyzt1/mR57Ii6oGSL7+0o+TKf9YhsX/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878490; c=relaxed/simple;
	bh=l6gpZCE/p/bDY8O0UgFYcBlAkFQOYvy8vLn0Az/31/w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ps1MJronpB20XupnsQHbBX7KhyNp+OAJIuaZIMcbsSsJpXYYyKxmfpS0Jr2eHIVSlHGxq9ECzz8h7GX+Zp2sNlZ1rD4K70ZZEXf+fkyJFqnBMH7hG9QhYa4CGreWIqH1HUc6+TeBXfyW1TtpBlJCVU/NhTsYHZ18f3qa+20oqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW85VqHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6669C4CEC6;
	Wed, 28 Aug 2024 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878490;
	bh=l6gpZCE/p/bDY8O0UgFYcBlAkFQOYvy8vLn0Az/31/w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mW85VqHP5ybwlJIpUNGEUUkkAiFDhuEMHdjS7XCAsQ5bf25JCuyIEYu1fGKIRttsI
	 lDvJsLAb3QCo2fBk1E1iZGsycVM+l+yB+NGo58MalbSwqSCvWZnHgGrkyPGeJ1fEkD
	 0jR6UV4xhFF99M1NooI2SwnLfVvLdx+BVh9vwwv+flHiMurXpcRoUAOfusXy6ohdHz
	 Y2EkT1i72weJieTtlrMhBJJ7/qf/6vQfTkdGgwcGWllUvhX1WfChYq8IEwj0nrNvuX
	 kFdVomAGmYZbwhC8RhC1Muy31lze9IMUTiHUTbSqmWOhSW3b83Glmru6jvCStZ05Iy
	 z5G9nq6tRaGeQ==
Message-ID: <4be108b47be46753681932e3879982ce.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240815150255.3996258-4-tmaimon77@gmail.com>
References: <20240815150255.3996258-1-tmaimon77@gmail.com> <20240815150255.3996258-4-tmaimon77@gmail.com>
Subject: Re: [PATCH RESEND v27 3/3] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Wed, 28 Aug 2024 13:54:48 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-08-15 08:02:55)
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
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

