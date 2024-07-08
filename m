Return-Path: <linux-kernel+bounces-244467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4492A498
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732BC28283B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512313C3D2;
	Mon,  8 Jul 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiLkv/t3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04225745
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448789; cv=none; b=tOYapj1NZTYotdnFK7owxJtlY0ogNTVRJZxs105Xl2/npIGCtmpQV2hvQep+XJMAaKP7pigRCLjVKHvH+mnemsezDY2bsartdGJOTuAo+dGdRwnpm+W87ltGxjtaaYwuMyyevIZquOlsnPVfgBO2QdM+uqtgf72DRTGpAjcRE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448789; c=relaxed/simple;
	bh=9Wj/hPEZaykcpVERmQVGpw8I+79ZoAPV7DPUO4Fzsaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LE+7En4cAcQ/w/0c9jpGoOhtsl6gAbCG3YUWleM1l8atINmXMDkehPh1dYkPORLDIYHRx8YyXjrtnYZ/+l5EA/1DE0e6FDn7YhDaqo4S3IlIo7s6uZAmcpkQeaSGcqrYozJ3bTwn73QACZwLlXeTWPlDL7Lgt5qjwp30uC6hC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiLkv/t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A6C116B1;
	Mon,  8 Jul 2024 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448789;
	bh=9Wj/hPEZaykcpVERmQVGpw8I+79ZoAPV7DPUO4Fzsaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KiLkv/t3GhKaW/sw+BjPf0p3MQNaMrbG/bDXA9hU+WUoDk/N9mpNTO7r0nI4buI+L
	 oaVZoQyn3ys5yYvfhhnGTr8uN1ypyOsDSciwF2pItAv1jIA0XPNWvpzotpMXzZEM4w
	 FOnZ55G5/hF6fIQUCjaWh985nI7H2uYPFiFPz2xe/ycC0rc4HZPWnwLIefc49Ta1M4
	 EnYPfcC72mBh+nVTnYPxLalV2zio14G4KvwHt61WR8jblzybl+N1J8OrXhk/5ZCi+3
	 kqRbcBJQagjGM0MJ5Ccec0sPBhZlnLjmGzHEshGMYByutSzHIEuAEOD6SWTXVS70Fq
	 nlouY7Dtqcw7A==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
References: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
Subject: Re: [PATCH 0/2] regmap: add const_struct.checkpatch entries and
 constify regmap_irq_sub_irq_map
Message-Id: <172044878853.64339.13835076848317107720.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 15:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Sat, 06 Jul 2024 13:13:40 +0200, Thomas Weißschuh wrote:
> Some non-functional changes to enable more .rodata structs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] const_structs.checkpatch: add regmap structs
      commit: 0f02ba48cdaf482d6756515e6936c1e23a316eac
[2/2] regmap-irq: handle const struct regmap_irq_sub_irq_map
      commit: f21711bbdbf0d95a389bfaad54ce444b46830d58

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


