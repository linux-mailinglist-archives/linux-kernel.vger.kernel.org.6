Return-Path: <linux-kernel+bounces-199738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4C8F9F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211CE1F26D27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D813C80A;
	Mon,  3 Jun 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U00QJour"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A213BAFA;
	Mon,  3 Jun 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450604; cv=none; b=BsX+a34pRyX4U9LwfpHC8YmlpDCKALG224uH+vQe2ZzdcMLPGav4Et7ght1BA8V67xqYpRXnDAittJgNzJt3sLBnD1LYE5FJJkUA2/FBcNv6XNGjJJ1GEgbN6dXuSez8rmahnAoVOsrgF5RDfWfPr5uE9ox/36ao3tvKrfZdy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450604; c=relaxed/simple;
	bh=1GajkzrxJWwIATnMlSQb8T/W4Z6Ei4LUQqaYzeUpUoE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=oT6i2+Yk1hT5MQ6+WEV0FDPaLeMBZ+jFIHk3Ur7ii1qtGoJCuIf6utAz3Zs0/4sfM0Xg2qbGXnOut+dWsMcnU5dmwfXqZfgNeXqDtgsJS4NuglnNhn83EF9C/KkyCUUrU6SY/ekWFVi5Yb+rzixdXZglIxXV/LydjJYwX8t936k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U00QJour; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E41C2BD10;
	Mon,  3 Jun 2024 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717450603;
	bh=1GajkzrxJWwIATnMlSQb8T/W4Z6Ei4LUQqaYzeUpUoE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U00QJour8XN4wwOSFH/cVWjQ0sCcztZR3LUU8kRQD2tKWhpj+ZIWnXfVShtbYerag
	 XxPA9TeSz6VDHuWdNaLlRgh6ZQUOR5kisfJwtsgXxymhyQIN+FbuOXQb1d8dF5wf1g
	 qgGPxZUD6JN8eurPq9Ffz+x6D8VLVWBnfWy/SBMoAJsGutlOP2Z89ttvM93fgM8nnK
	 Sbs+8EDy2VitP04DtcbOArSzcRkd7XmsE0Tn1jQi2kNhll3j516YkT8Xd3UcfyCySs
	 GY1SZg41dIopeQ++WWQDDGim29SZcfKC1Wj0Vps5qswKxO2tCmJCbbPmkknrDnS43M
	 ZyY+xAZO97Zfw==
Message-ID: <c776960ca7b285626366dd7ecba04018.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240529131310.260954-2-gabriel.fernandez@foss.st.com>
References: <20240529131310.260954-1-gabriel.fernandez@foss.st.com> <20240529131310.260954-2-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v2 1/3] clk: stm32mp2: use of STM32 access controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.or6g>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
Date: Mon, 03 Jun 2024 14:36:41 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-05-29 06:13:08)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Use an STM32 access controller to filter the registration of clocks.
> If a clock is used by the security world, then it must not registered.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

