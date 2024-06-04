Return-Path: <linux-kernel+bounces-201206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF98FBAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6C1C21C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6714A0A9;
	Tue,  4 Jun 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VinTsvil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E918635;
	Tue,  4 Jun 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523356; cv=none; b=LAljxBjW3fJ7TrPJs2F0vMSjCh+OW2wPVpKWPYwkPODqro6ztrQTdIOQTNECAc3pSW0wGqbKBVtDFp0Ucx41V+SwULmL9mC1jeJdyZF13oNM8041R+ip4NBaVNYS8AGPZoVaSqBmOonLwtjzbcXjtWiD4/IIyx1a5OHMLj+mvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523356; c=relaxed/simple;
	bh=WEorQPzJSO/W3CDeE5v1HE6L5st6qd+aFene4UCkc0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ltQirTH9GX8NTnbeW4YIHnDjhB7ikOM3jVqJIxFJiWPGuL2jVFPmB3Oy7zaVjpg7YeqWgk4Iu9OWsAJOAVUDfLkn0OLf2mCbtOHggbzV4ktvo5DnW+oSsS8ZNJaxfxbDE9wWkAI6fJJS+hoZoumDeuFVgabRlp1ZzjVN8Hmox/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VinTsvil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E02C2BBFC;
	Tue,  4 Jun 2024 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523356;
	bh=WEorQPzJSO/W3CDeE5v1HE6L5st6qd+aFene4UCkc0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VinTsvilqOOaUw3n5W+cvLlAcg3zcRKqcpx54sIzp74UrOV6ybQTa+HHF3DGHjE5l
	 mHpTAMLL07g9d2BlmFvkRxa3m9GLvurb4bGIRfomCA1zhq+os0He3bwMZyfYRklFM1
	 iJJiH25c0p8DwkoeEezd55tgYwdN+uhG+mhDNMR6fWBRIDDBzvfAy/TpxqiPv864fp
	 xAYEPzIReTBSPRCAcMxfzMYvs1wMbgIMWNw2tEWseDKGx8+vR8J4qAwke1rN4fqVT5
	 0u3fJhd9s0I5Tuu3rEbtEWsoF2tRjHQ8a93LLgyQP3wR2gLTxsi8dUYthgVYjQ7rxX
	 mmngXpjLj32YQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 kernel@quicinc.com
In-Reply-To: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-Id: <171752335390.124688.10071366948406345970.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 18:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 03 Jun 2024 17:16:07 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
      commit: 65909a7e7aa8b25c9cc5f04c1fd5d6f0f1d76fcd

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


