Return-Path: <linux-kernel+bounces-402514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 780269C2892
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA8BB22BC0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CC139D;
	Sat,  9 Nov 2024 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWQEG8O+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F82907;
	Sat,  9 Nov 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110706; cv=none; b=q3HWCxZaTYcsu3vr+Wsmo8hQEP7htnvL/SJF5alBzXgg+rmJYIAf3NMCucVnNxqjV+o19D6sTuGISBweP1zY16iJB63rG6Vw8d+KKurupBv6M9IfhHDvENWLUSwFEbTQXPDdWS+C3iWLDAZc+uBKfQQ2EljgUfaKQ38C4FhWU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110706; c=relaxed/simple;
	bh=+4fxxGmLXgCRdQeWWK38mQCO3w85tyvAuFsjP1DNG7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uLj3ll/CjbR0D+pm1aEvDTji48WTmSNPNe7r16e9vs9BE2xk73vI5Nvp0Fsx8mdwA3LUDYNBhekXhslgCpEOq8p7WsaApqMrhqtaxyY5+T4y2JOF1J12w7XiQtPCkE67Q3dgcu3ahqytMwTbr3My8LSA+i4Nhe8bNbMx86yFiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWQEG8O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780DAC4CECD;
	Sat,  9 Nov 2024 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731110706;
	bh=+4fxxGmLXgCRdQeWWK38mQCO3w85tyvAuFsjP1DNG7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IWQEG8O+6qk2aUsaF4fKzZHzlRNZS7Z0mxte8F9Wcf6ugVTwQLoN72UEBiRC6gMGy
	 ZffpVQPnP+EL5hJkIp+mQURF5Xno0OqX5hfM/6hWsbSgH3G5LJYJa7XlpjRT8Qqqa2
	 rK4dFQ36MVTM0ZO0krYbo8LC859OYA35OuGBI1bT9y6KwrtvH23lEm9Y4bXSEFbqY3
	 kJe107rhcaoPX/me1mTCLuNpwtLZe6CGFg6xqCagifpuFEfFjSkAwhguVIGO83kjWd
	 afSr8aunRrm593AxsjJRYEwvuZOGnOuARcrqoyDqxDCsWnJL9qCaWLsTZLt2FI+0Gu
	 Ctt6SZv66LqLg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241025090938.3480-1-tangbin@cmss.chinamobile.com>
References: <20241025090938.3480-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183: Remove unnecessary variable
 assignments
Message-Id: <173111070418.137066.13301486224854553399.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 00:05:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 25 Oct 2024 17:09:38 +0800, Tang Bin wrote:
> In the function mt8183_dai_i2s_register, the variable
> 'ret' is redundant, thus remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183: Remove unnecessary variable assignments
      commit: f3c889745cd3500bcbce6f6c8cb7e343f067ac18

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


