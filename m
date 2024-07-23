Return-Path: <linux-kernel+bounces-259974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC3E93A0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6102837D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F3152527;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvM9r+ot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE41C15216A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739516; cv=none; b=vF7a8fIZlgVLpdlsIyg9w1okQe9if5lanmUwKzRMTtwP+RHeyru2jBh6UkwN0V4EmQtW0qytoYzrvIe8OI9eRF/GaV4cNoq7Bc6KbqdIpKlu41k8OlcJefbfQ68lRB+sBS8uju5FaaiCo2QU+WKLDO3MHfHfhxyRiQN1ubBsPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739516; c=relaxed/simple;
	bh=MTx3Yhz4wCNFxt8epbAA+GjuRUdAILMPbUYRovO+OVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dpvWQC43hgBjUbI7OrVy6I9vX+oajGZSqiPHbTrSxZf0ejdEXrnlPF+8X4Q7rgZYPnOu6P5Rw+4JAwD1s+a0vMeLyNe8+zBW1R2dkJiNzvxu/rQ2bjYR0vwI6NIsLCxgi1A7F36yd4v631PUs81Ct9lfNiMw9TvkiAalyIRh91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvM9r+ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65238C4AF0A;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739516;
	bh=MTx3Yhz4wCNFxt8epbAA+GjuRUdAILMPbUYRovO+OVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EvM9r+ot/ByNtKDgPHhwxfEsiOgD4qLC6dq1qmja/+WdFIrl4xj66LA2lHHLu3A7s
	 Vh1mpUIK0mz6uE3vha64vJ92/bKZZX99FT5T8j5I8RfCB569RIG2WmXhiAYZL3Ywse
	 riEwoL1MFv3mLyyQx91gFKaImpaatwMSd8QA5HdO9hBsrpazm2/AWgNz1MZMJK0B+b
	 uSZnpkq6SnE3lKwvxOiHhIVbNcnBa4O460CvlkdY7XX9+vxWiw/ZHD+D+U/2iuJEBM
	 ykWieW3hr/pcDBet7rtdnUxPhV2XPOFVquB8ahQevZ6zA/uYhdQ7SMaOqxrHFcr0fb
	 hotRk430gHSYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55C55C4333D;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0()
 alphabetically
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951634.10883.1451787380987627929.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
In-Reply-To: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 17 Jul 2024 09:54:38 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Currently the entries appear to be in a random order (although according
> to Palmer he has tried to sort them by key value) which makes it harder
> to find entries in a growing list, and more likely to have conflicts as
> all patches are adding to the end of the list. Sort them alphabetically
> instead.
> 
> [...]

Here is the summary with links:
  - [v1] RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0() alphabetically
    https://git.kernel.org/riscv/c/3d8d459c8ba2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



