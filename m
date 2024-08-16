Return-Path: <linux-kernel+bounces-289937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F61954D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1611F251B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFFA1BE228;
	Fri, 16 Aug 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzjFTtOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BC1C0DF3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821403; cv=none; b=f66K283u+fmMq5ITkVdRZGC5m98srAYq9tM5CPMfMLfsDjPdWLYA6q9jvP1C9ZREkiSJY1W3fq+4/thYx5zDuEo/TKYiFcvVZS1zrP6CUSk7YLd1OhMbsWp6K9nGgi0tkBxeIT5OEMldaNrPkkaMvZzkImGDap4gYZFUHfy1bR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821403; c=relaxed/simple;
	bh=/hVd5ORiPPhhJ2kcUPJhtXGPSis/LyoL3hp4MKPlADA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFEzKz77SPOhaVOjGEn6ji/cSOt0MAmZH9NBNTqy9sRMccNvfda5zPVwiVCQsfJTwQOwj1/GKlPcuKuBgF8k0/7hjZ2F2+EcvOaaCDIX4vdXn0hllGQ+7E4FL8gwwWNRceT8dzT/53vNROUKdTWZ4MPWVVbBHWI+ZHWEDFaEEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzjFTtOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2CC4AF0B;
	Fri, 16 Aug 2024 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821403;
	bh=/hVd5ORiPPhhJ2kcUPJhtXGPSis/LyoL3hp4MKPlADA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzjFTtOHFY88f/8B/exKoaGQTCPfblhcQh/mf6WAX2p0Bq7oQQLVwrSxoJLNJPYab
	 29PJ6FVlgtoEGooTUzAAMQUWd8vNf+CLSN9ygiYET2aeE7UicJsFGDDNzbqN70onoC
	 KnIS6j2V9+2ySVm5w/LPdAUpqV9fGw8FGHT+ODlBfbFCNwGFD7ZsCq7iGWnyMCKQxi
	 TUXUxt6q/4INzTOnbVkISDKjYuKItW2VGDzhewVnUd+/YZ4f/3Rgk0vd7h0IwjeLvf
	 4WlT7ojIDbbUcdoYzUxvGBqElm7awP0u+D41hELHMiRQObFKEkfClN3hK9bKfjUc5i
	 2tEQ8IVh5z4Rw==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	ardb@kernel.org,
	msalter@redhat.com,
	Yue Haibing <yuehaibing@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: mm: Remove unused declaration early_io_map()
Date: Fri, 16 Aug 2024 16:16:02 +0100
Message-Id: <172380414438.1160828.14404207342386712346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240805140038.1366033-1-yuehaibing@huawei.com>
References: <20240805140038.1366033-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 22:00:38 +0800, Yue Haibing wrote:
> Commit bf4b558eba92 ("arm64: add early_ioremap support") removed the
> implementation but leave declaration.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mm: Remove unused declaration early_io_map()
      https://git.kernel.org/arm64/c/4960f9a5a5ac

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

