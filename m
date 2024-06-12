Return-Path: <linux-kernel+bounces-211981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CCC9059A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBC91F23500
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357F181D15;
	Wed, 12 Jun 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfkZA/dt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5716C84F;
	Wed, 12 Jun 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212183; cv=none; b=adjlf9A3uP8c3fPNKaivEdA1NGQ17r2aPf6vtS9D+EcKu4T+XuJ8p4UtGZfilDbxvDVwohZv0uB9Ov677hhZqdU3xuUBZVlAi1wacF0i4ZFVobX5wEm/HQ6dAjzEyxjCTfen0GjFbb/lAVq1KsLkwwceVaGvzVhgCVpfAdKXdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212183; c=relaxed/simple;
	bh=qXn2J2Ad1IeHu7jqmyxVFj5XlOylI3qbh7DnQSO8Dgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NBeRHq3A9thcOT/L8sqK3/9kZYvl8n1oEMpR84VErcCoecsSTXJIivO3bsPi7GMAvsVEG0HFvo1XlcLxRDJ1abYCSP2C+2oPsMWavOIwTEsMai24TilkY5F60SPgQSq0ol4vsgbA/7XfZgg1dInJYeyYbwu/xKEuIG9KSEj0jBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfkZA/dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76482C116B1;
	Wed, 12 Jun 2024 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212182;
	bh=qXn2J2Ad1IeHu7jqmyxVFj5XlOylI3qbh7DnQSO8Dgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nfkZA/dt8kMAeWdKD4n12L0JnifHFVghUZLjoBySN1jvxF0V5b8fYdoW5dYgDQ+w8
	 kzWjwJI7ODj/cQVjuCPPdRZBUrTBQxjOW6Md0Y6pfATWk4bCmhj/YIx0LhjegDpBao
	 oCVnrCt60f6XirBObzQZwjiSarLhk/kHsbRJYsqRgLRsJLJKQEnMrXTLqQMh/e0Ff1
	 +0Hkoh59khSdACfTzhupW7rOlITO1d4zuXB7lhljxVBkoCMTgskAzmmLARXRMlirPS
	 iICF1MKWpzMX4Do0in0epfyJ74rSLLJT5Hia1yfWSeVASv9s70YWZP8o50XyuQ8S7q
	 x635lx9uDVqsg==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240606041212.78428-1-animeshagarwal28@gmail.com>
References: <20240606041212.78428-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: linux,spdif: Convert
 spdif-reciever.txt to dtschema
Message-Id: <171821218010.232443.15741334839027344442.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 18:09:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Thu, 06 Jun 2024 09:42:00 +0530, Animesh Agarwal wrote:
> Convert the dummy SPDIF receiver bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: linux,spdif: Convert spdif-reciever.txt to dtschema
      commit: a694956df4ca75d74bcd422908ddcd8e2ea3042e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


