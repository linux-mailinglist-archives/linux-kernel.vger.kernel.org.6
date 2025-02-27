Return-Path: <linux-kernel+bounces-535259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71FA470AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2787A8813
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644145038;
	Thu, 27 Feb 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeOvY+ee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAC24B28;
	Thu, 27 Feb 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618216; cv=none; b=fn/3swLKpPhwi9O8YEhmzxr6KMc806HYPUTZmlRLJh5pZPOWf2eickvHfuh7e8NVlmjtyHqAUIzYER83Cds2CqjU3YLnuRLgl5QAx5nQ3RvxUBH83bDHmnep83qABOiKZP6Z59egBJ/UkyGtQBqbmO2624dH9RkBm7WwQyStKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618216; c=relaxed/simple;
	bh=3b0trcqZRkNGYmjXDSE3w2Fcq+D3OS7D4tCZA8ZK4TY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pUWweIgF32XuRkv0uyyqLGkE4NCWwVqPkV+tCNvgyb+WAJTbgcJVRI4kxoZqSU1XKlAw5eJpelEvmdUxHwDtk5b3MrvK/tFVxnPt2MrXV3BMCs2Aq1X6q9EsipyTZqKK4F6zoBAYsVaNYLORwDkognPr+Ol9jGQWOf3I1Fyo27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeOvY+ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B320C4CED6;
	Thu, 27 Feb 2025 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740618214;
	bh=3b0trcqZRkNGYmjXDSE3w2Fcq+D3OS7D4tCZA8ZK4TY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oeOvY+eerU9W0wXRIdGa/7e/Mg/kezvTNdTlxZ9Viuvygnvhi4EDirHNCxRMOz5v+
	 Gg4ZMdhDCgs/Xhd/PYAIizvto7RKd0GvNPbAHLgyMMYTMvYdNJbtnvhJ7o7LLzrJ3d
	 6oYTHQ0Z79y+YiDtP3x87ZkvCZyjMbCSBNQ849urmKMiurMUlAH6k+qdOnB401vPpk
	 y/iUoZyeosJNlIBZNTsFSwqPaWeKYLsHZmRKFAQF6/iueCbGuQAbzCX40oUGFKrbu0
	 yhFyMsC5iji/omcpOnxgNTn64mGSk7e92UinFWbDH8hbiauGsCV2UhO1lk9EM/8tY1
	 7ACo4KheJXu5Q==
Message-ID: <b49cecb83051d825fa6f61e9998a8fcb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250212100342.33618-2-angelogioacchino.delregno@collabora.com>
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com> <20250212100342.33618-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: mt8188-vdo1: Add VDO1_DPI1_HDMI clock for hdmitx
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, u.kleine-koenig@baylibre.com, amergnat@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, kernel@collabora.com, macpaul.lin@mediatek.com, pablo.sun@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Wed, 26 Feb 2025 17:03:32 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting AngeloGioacchino Del Regno (2025-02-12 02:03:42)
> Add a missing clock found in the VDO1 controller for the HDMI TX
> controller over DPI1.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

