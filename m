Return-Path: <linux-kernel+bounces-201371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3158FBDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CE828293A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83298179AF;
	Tue,  4 Jun 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrGssVz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535914BFBC;
	Tue,  4 Jun 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534803; cv=none; b=PSJGGohfuyxxyRHGS95Z5QLBrg6emQhJzGXp0Hhuct6+R/epWFfc+ItrFPcSmrVwK0gB63ye5hE1lQ8cvHa7KazRP+SAXv9cZhh+oPITNKmQWK2xC8DAnS8Bm0enOu0AvRyaMQb+NudA23uhlfgLbaHXQC300xIKmNEDEcgW8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534803; c=relaxed/simple;
	bh=L/mgQJMftiW2D6Mtz++/7s/z/IY5FtyLQtyHNLV0Bfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RIGgZ4Hf3t028RJCrnZmjU3cyyVx11QWSQKNGvfDWnjxlbcpOE80qPxNiEPWKNz9VXBxtsyj/t8okURHPafA4ZMih7F06rofUb96j8F0uA6OcBSTNd2Y4KVP6u7MRr4mhiE7DkX1tr8A7hylMTtks3GzapArp5zoyLZiS0kKcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrGssVz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137E2C3277B;
	Tue,  4 Jun 2024 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534803;
	bh=L/mgQJMftiW2D6Mtz++/7s/z/IY5FtyLQtyHNLV0Bfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NrGssVz3b2HOSCVY1xcjaLRfjFRlZuKbeoZ85bRNRoqr2QEOXGZoKJywZ10nEngy+
	 4Qm9C/TjWLbGJKK5/OTGeGUBfkfkCHP8NYNeqbWB1KOQHm5My6eSUJxG5+WTRXHLU8
	 rHzc1ljX3W1aJiqvY7Qm5xLI1CCznXF29AqXQlz+iPaZtcitlDxV9GG1Re3z/7Rbsk
	 p24KDy4bL/IxT4EjplwEbxiGWqT5wIhAs9Aq3QLppPbEdsLbAKdGWo4RXSNx8WvifD
	 4sRDC+FKtM88GUqamA37Cil1mIe6RkeM53wqDTg1zUkBIMZk9IDiMz4mOfTNmtipEt
	 SNr08PqbqeUEQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240604132843.3309114-1-ckeepax@opensource.cirrus.com>
References: <20240604132843.3309114-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l43: Increase default type detect time and
 button delay
Message-Id: <171753480179.301205.11382815004369484420.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 22:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 04 Jun 2024 14:28:43 +0100, Charles Keepax wrote:
> Some problematic headsets have been discovered, to help with correctly
> identifying these, the detect time must be increased. Also improve the
> reliability of the impedance value from the button detect by slightly
> increasing the button detect delay.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: Increase default type detect time and button delay
      commit: afe377286ad49e0b69071d2a767e2c6553f4094b

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


