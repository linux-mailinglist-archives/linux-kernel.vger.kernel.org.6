Return-Path: <linux-kernel+bounces-241194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAAE927822
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BB4B240C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1581B1208;
	Thu,  4 Jul 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgWS9U64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2161B1204;
	Thu,  4 Jul 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102759; cv=none; b=H6vsfBevkJ7o/SWSMXuB93dCKe0vqua7i8KuTBNRj4HSGzHLgiU7pwKXPpbUZGqSUT+b49dF1TL7T56lxglm0X+YwYu9a4+GdanNpEOHKc1vhUhcK+vKPk5zJvtNSEDi8zVYV61fux3Xp4xPw1DOGB0jIiOotGGh5a+I5NPnZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102759; c=relaxed/simple;
	bh=tinAthcwQkmZq5KjGGBqNh5ILmv4D1DBUWw8o3PmhJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIpecToR8hhHOAjM0mGq2abN3wXmNiFM8N3XnYnytfLQN2MOfBh9wg04F9SEMmci9ng31yRFMFW1eof9G0Hyeg26ujpiAEfCuuAuvy7/zhh/zulj4/0UmS20wwYF3aPvsTxFaYquC2RuPQTfnlALOa9Tb2XKWvZT4g5KIB8q/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgWS9U64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D26C3277B;
	Thu,  4 Jul 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102759;
	bh=tinAthcwQkmZq5KjGGBqNh5ILmv4D1DBUWw8o3PmhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgWS9U64Q1Rtj422AwKvl9ZE9rydQmtc6v/Q5Z/DUzQF1i5OY5nlH5ox5+QxxSO/9
	 ZKjqyxyWhDNLpg5S15389t71NFQJaQgSPSy4J0WqmBrQrwRn4k1o43ywOYetAvj8mr
	 jbGZIEmcKMlCbHzxjGvnc/LBfKE4mqLhicpTGTMnjbPs7k8Cx+V0QizTEYAm4cj2ah
	 K+OzuTzvAe6PtsNdaBkH50xntcVzaq2s+zHn6+ag+7cSVgfVa6ZsL/kewqnVbNfhYV
	 t5PQacqKf89obLN8RNcl70u0escDHH1Nt958Tq2xbirpt51CnAd2pEN4j4xNKe+Jcm
	 UU6pN9bgsEuJQ==
From: Will Deacon <will@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	yj.chiang@mediatek.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst
Date: Thu,  4 Jul 2024 15:18:59 +0100
Message-Id: <172010203418.3924652.5794968126024490754.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240702120617.26882-1-mark-pk.tsai@mediatek.com>
References: <20240702120617.26882-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 20:05:39 +0800, Mark-PK Tsai wrote:
> The Documentation/userspace-api/iommu.rst file has become outdated due
> to the removal of associated structures and APIs.
> 
> Specifically, struct such as iommu_cache_invalidate_info and guest
> pasid related uapi were removed in commit 0c9f17877891 ("iommu:
> Remove guest pasid related interfaces and definitions").
> And the corresponding uapi/linux/iommu.h file was removed in
> commit 00a9bc607043 ("iommu: Move iommu fault data to
> linux/iommu.h").
> 
> [...]

Applied to iommu (core), thanks!

[1/1] docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst
      https://git.kernel.org/iommu/c/d926e7c04843

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

