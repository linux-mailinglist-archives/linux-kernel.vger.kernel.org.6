Return-Path: <linux-kernel+bounces-441717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE19ED302
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F10F1688DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0A1DE2C2;
	Wed, 11 Dec 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4C3F2Vx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B924634F;
	Wed, 11 Dec 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936551; cv=none; b=U1EOdPjlX9ia2y40vmwoiZHBxHkLJsjywQ3GQNeoJA2HvyuIwuAs01ckvctnTo3xx/Hz+dvz6eK8n+TR7sWbju+pXPdLiu0dV2CRG10kBv5vrDps2tNOY2GirJhW8PdMDxL0bebUPdtTHTE1Q5KdTqz+qNbK7EE+A7K4o+W65Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936551; c=relaxed/simple;
	bh=6xJxIgSUiAFefn/bUMzv+GO3ovLf1Z2S/Rl88N1fANo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KXDcwkg0WTrF4HToZywdOuBpIVPwGTbxZDeBJqsCUJmc9nkGJ4pWB6mogLvZeY9TqMw+hBAv1TqXgpPNlnldfTGjeEJ7OL8vJaxxVX1/K8g7KyCspVkmSAFhutsBwPCnX/hbZ/s4zIYMsGh/UZunvyeovEBokO0dIIY5XhwGqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4C3F2Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F0C4CED2;
	Wed, 11 Dec 2024 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936550;
	bh=6xJxIgSUiAFefn/bUMzv+GO3ovLf1Z2S/Rl88N1fANo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U4C3F2VxWzj+T6bSsqoTOk2yJQgnhaxxu/XiNFg4fNq7SRC7M6PV/ojU/dXsmzQyw
	 2hZHQlX2oBp7i+aZR2wu0LJ3Z4onvtt0kijA/pX2FzOzh3LJa+07k/pXeMlSUrSyts
	 TTi9Gna+6dYS6CioF24/Ju1Fh2BuLgVkGw4KZnd2scv9wR2uaXLiyJiz5gp0sigPMg
	 ohdfUQS9BCY+dhbbWhB0Hg9m2SQUgOWpMVcBO1CqYazfxHThdTI4yFaw95EPbbGxCW
	 t7d0Pn7bAlxXROQroa6o1dhQoY8lmW89w8j2jvkfy5tMWHroGySOit5JEcV8qOZrkK
	 VQgbTI8irIWGQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bard Liao <bardliao@realtek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241211-topic-misc-rt5682-convert-v2-1-9e1dd4ff7093@linaro.org>
References: <20241211-topic-misc-rt5682-convert-v2-1-9e1dd4ff7093@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: convert rt5682.txt to dt-schema
Message-Id: <173393654878.517474.1340002655545945944.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 17:02:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 11 Dec 2024 09:09:55 +0100, Neil Armstrong wrote:
> Convert the text bindings for the Realtek rt5682 and
> rt5682i codecs to dt-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: convert rt5682.txt to dt-schema
      commit: ab20bcb2d0c80b4df9f9a6ef86c6e47d5d10cba0

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


