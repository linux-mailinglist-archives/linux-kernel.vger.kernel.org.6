Return-Path: <linux-kernel+bounces-370676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97E9A3096
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07AF1C210BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB41D7E37;
	Thu, 17 Oct 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttsCIhsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FFF1D5CD1;
	Thu, 17 Oct 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203783; cv=none; b=J6m9Mr2inF/2u3C/PDwMDMwvs2x4Kqoymua3pMDjR0LEzaN+x1jbOaihAbsCuqz12rwwvpWGzui0o/P96D6TZnl64XZiYmX+IuyErn7+R2U5Um74gKELhNuqv4At9by+ioLRQNxnK2w7P/oIgrXxru5SjnhI9snUdj5ojPXmzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203783; c=relaxed/simple;
	bh=+3MEtwbMVg+pwHIOeCpCnFSyC1XGVPop3/Krqu4bssQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UyHSoyFwdJxuZF4lc91NEW085DJuwYqyPeduvTdErBiNm44k61WtcFHfO5n9TgBe5J7d3jtJnnXUxL12FtdC8BPFSgYJ99uWSVBLCxY08nu3MYCXS+dkNsgQJcfa+SMK6Td3cYTugN25RZq3SQ/s2PPHmxp8hYnhM4naVCA2450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttsCIhsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDBAC4CEC7;
	Thu, 17 Oct 2024 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203783;
	bh=+3MEtwbMVg+pwHIOeCpCnFSyC1XGVPop3/Krqu4bssQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ttsCIhsDOxpnh4ZxU3GKaWXCvvBSUdXqX6jTUljO5LLzwOHtsf6r4OqsN1iH/Ch5+
	 PJqgb189ELh3Ie7EpHW6vdOZJl+JfnLofOGVXgz3fXamudWuFK4tBvuQ4ShNH1Zf0d
	 bTscJprk8amaKk5GdD7Jj/FnmdypN9iM8ZJf9WmFy+7TgML1it4CA0SDuDdlOsdDVu
	 WMHixm16XLvyW+ZNfSy9Vc9NrJ3FjyOnM0BcTbWcfvbJLMoLMzG8R03Z9fbspgNjr0
	 bT90uIuLSzGVtfcy4oi9DDLpXX7HX2E8n7TPAmdkzKXEaPd1Q44VkpV2hGcaoOxT7W
	 sgP3CL8NtiP+w==
Message-ID: <f85d4a18a18859e15989732caff2144f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240912191038.981105-3-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com> <20240912191038.981105-3-tmaimon77@gmail.com>
Subject: Re: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Thu, 17 Oct 2024 15:23:01 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-09-12 12:10:37)
> Add NPCM8xx clock controller auxiliary bus device registration.
>=20
> The NPCM8xx clock controller is registered as an aux device because the
> reset and the clock controller share the same register region.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Benjamin Fair <benjaminfair@google.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

