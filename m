Return-Path: <linux-kernel+bounces-345752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189F98BAB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E181F22094
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34F1BFDE9;
	Tue,  1 Oct 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hab0Hn36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBF1BFDE6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781225; cv=none; b=URSryyGsKv5hFhomGY52MTxOVbgLQOtk3B5gMqpXL+EqKhggOOWE+MAXxmdBotO9iKJgZBn+DfzjihLicCqKy5XoyiW4iaLzajaaoy7ag231v3fOIsOEYfWgfzb+0kt9+2GgseKjBGHqFbvZp97PEWmYk6FaoqyN5hRxlG0jo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781225; c=relaxed/simple;
	bh=Cf6LRmX7/UXa2wmXe6STr5l0q36ojoWOWVZ7a+EEJxc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oQh5CQFh75/kC50pcDWDmIGRgBioVmMAJ6qMnQC0nGdFaMZTAEKleWBnq4aVlcVzSn7MFGiXop+wNadEDFCSSFMXFjVzCw1JvaT9uCj7KEVrcwIfofa0cO4B/ctIflFEclYSGCyPYdA3o7JIGuzSP1dqiqt/eSN5W7kpWlcW1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hab0Hn36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0382C4CECD;
	Tue,  1 Oct 2024 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781225;
	bh=Cf6LRmX7/UXa2wmXe6STr5l0q36ojoWOWVZ7a+EEJxc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Hab0Hn36BCt6Q+f7+Rc7RVZthyHP59PHvhqBrobGE6J4lnlzmuGAesIyfmjy0ggCk
	 jYw9nkFhHBLdkLgdfBolL09OQ5PaCp5GeP81/rcAAPGvkx/j8MKh6W+k1XAKXS43oo
	 kpPE6P/LiqfYH0EsMKa9ZFgrbTRt3obaSpoFbpUzfPN+sl1XUpBoPIqGNBVWnt1nsC
	 0ICK97aZXjDSpKO9PgXtsurgWpk66TkBARnd/UxXi1aA887KgHZehy2cwIRKLdzjQy
	 UKKDcspCMpbLBFUIqSMPOyY0Li70fGivnC/xa90X6ngQA3iU3e7hVaJaoRbvdmreO3
	 hSy4VCZriJfkQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240924-regcache-document-types-v1-1-e157054e1215@kernel.org>
References: <20240924-regcache-document-types-v1-1-e157054e1215@kernel.org>
Subject: Re: [PATCH] regcache: Improve documentation of available cache
 types
Message-Id: <172778122409.2280830.17014674659882395758.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 12:08:08 +0200, Mark Brown wrote:
> There is some user confusion about which cache types to choose when which
> is not helped by the lack of any central documentation providing an
> overview of what's available. Provide a short overview in the API header to
> try to help reduce this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regcache: Improve documentation of available cache types
      commit: caf78b0465053c23aa6211b9815dd5433766627d

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


