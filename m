Return-Path: <linux-kernel+bounces-213177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD3906F03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EE1C20E17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69A145B08;
	Thu, 13 Jun 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai5pawwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DD145B14
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280766; cv=none; b=a2A7wzMqr9jOEVLfz7L4hdmrtBoXd+uzLgWWqhNcUX8YGSqqqFRPa1wOMP5gzLv5lnw9lJZ7LZzAvuAsi58MA0bgSaB9leCyPE5BsNcYr/29VSEezpNV1c9lsIbuncTBU9EMCT70wGyXht8Yf6y9QrVRWdNk3oDfMNNYSfzdSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280766; c=relaxed/simple;
	bh=VL0D7Z1u35TJY1+wnfk182tojLh6CXU2VOnnleoOGPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxq79KYJ6X2t/wDyL76/wxmDEbGX6TYmzNTR73TCrjn0yY32yzoWYf6N+X0inOvnDbBrMMLZnURm6K852WlIzd8Wlkc9qZiJt96NTe23vq+VByugFJnr0pxPj1bg3pyK5fB4gL+X1XnyXy1jc5nYhTmIuQnUopQCLwJYrj265wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai5pawwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB9BC2BBFC;
	Thu, 13 Jun 2024 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718280766;
	bh=VL0D7Z1u35TJY1+wnfk182tojLh6CXU2VOnnleoOGPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai5pawwHc9j0icjq4pAa4AjjNnJZc9FqaRoZzQ0npzN2KgSn4p98y+PlfaOUYfJ8q
	 MiHZkxDgeKTwKMdeb94ZuWvvHjJzbYbkWgyFCmfK4vu+gSxEe2JKouHd+20qcS5EmL
	 2D+b2AsI0/EOTLomxPi9GbZQaPEgvMkd9repImwqs1nCvQu/ewYc42cb30bmjMPIVE
	 8cxGSpaMEplkHnt1ms9x//IYOJooxZYglX9lSOEF74ZmHa6H0exHTPfZGcnMPgLKmX
	 GoqRlJkxuuWEwrdRkqrf/IvimYLufFY7IuheLdO7NhDkgMWHvnQujkLbqpNDtoRsUM
	 eo5p7kBXuPE5g==
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Add const qualifier to host_root in hostfs_fill_super()
Date: Thu, 13 Jun 2024 14:12:35 +0200
Message-ID: <20240613-saugt-hebamme-d4c3ce553856@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
References:  <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=brauner@kernel.org; h=from:subject:message-id; bh=VL0D7Z1u35TJY1+wnfk182tojLh6CXU2VOnnleoOGPo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRlPTJl7Lx9xSXxXb9yu8pj2Z/nCqc7aanzPg2cw3ju2 MfjE8/YdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkZhjD/6CIcu9Iid/76itk z7yIyQ3mCVozyUd+3nfxH2+rbUPX/GRkaL6YaCTI0Vpr9XFtuGPRn+uKU/Tm5DT+ar60P+R+ofg jFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 12:58:41 -0700, Nathan Chancellor wrote:
> After the recent conversion to the new mount API, there is a warning
> when building hostfs (which may be upgraded to an error via
> CONFIG_WERROR=y):
> 
>   fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
>   fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     942 |         char *host_root = fc->source;
>         |                           ^~
> 
> [...]

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] hostfs: Add const qualifier to host_root in hostfs_fill_super()
      https://git.kernel.org/vfs/vfs/c/104eef133fd9

