Return-Path: <linux-kernel+bounces-331721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1475197B076
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA1F288E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAF185939;
	Tue, 17 Sep 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeAP3Lig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88F183CB2;
	Tue, 17 Sep 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578047; cv=none; b=HsURBsUFHYXIN8VRIScOkBL591iM1KaOnNOOCGUCq7SgotLxiE0/BM1gFY4KsC0dbi+yXh8+/EVJYwQIajtLYw3Kj2F+Nce3SKsQ3JrYAmpMIr0Fc0sKWau7AsCS3/mSoEC3QN+IRZW6Eq+XkRXnjQ3A7BjrgBX0AjTarmHZ/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578047; c=relaxed/simple;
	bh=vTvMx1oNGJjm1PhwOnzQdSKI1GIYzb7T3kcv//bAFCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r89qqL8nk2o4bJ93Xyu0+Z6Rgr22p7mcf2dKY66qqGEWOADLHbj/amPOEgxVR1pWLOZkpU4MQkYDjHn/YZ9R3S+Ub6fln71bfBZS556hGTPxGTcP8hoZobhZ8C5EkeUkPxR87iR1mDLV56cw0pi4j9QUP/2PXJWpuOqLd+YO21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeAP3Lig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D7C4CEDB;
	Tue, 17 Sep 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578046;
	bh=vTvMx1oNGJjm1PhwOnzQdSKI1GIYzb7T3kcv//bAFCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WeAP3LigiMlwxUcF2xHOoW35WtlhkOao/QUEEED/NhbcFKCilFKeaAv9O7AWujJof
	 kGC1zq7lp9cb4jXgq/VLS1IF4XDedj4Bv9ZEdA1gKtbaH/jKw4arzYKjF3x/IvtuaN
	 o7CqSWhUNNTaDQ7iZxX9rzN9skirGaZV/ouHRciirdtZw2B1iyHAOoU8JaLptZmKuB
	 7uDhg2Rqq/oq6Xjw9aDZovfGReuS0hSJObJ7ywXQNM2H9xm+MB5wulWdMtdYstdGeE
	 asEp+hlPHl7ivZFGxM4xgREGw1mXNHH4qhdTN/vCdTqQKG+qLJxxCYjFJl53uLcQGd
	 vpvTOE2GTeLlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711A53809A80;
	Tue, 17 Sep 2024 13:00:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Svvptc extension to remove preventive sfence.vma
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804824.126252.9959954454312019280.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:48 +0000
References: <20240717060125.139416-1-alexghiti@rivosinc.com>
In-Reply-To: <20240717060125.139416-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ved@rivosinc.com, mev@rivosinc.com,
 cuiyunhui@bytedance.com, anup@brainfault.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 17 Jul 2024 08:01:21 +0200 you wrote:
> In RISC-V, after a new mapping is established, a sfence.vma needs to be
> emitted for different reasons:
> 
> - if the uarch caches invalid entries, we need to invalidate it otherwise
>   we would trap on this invalid entry,
> - if the uarch does not cache invalid entries, a reordered access could fail
>   to see the new mapping and then trap (sfence.vma acts as a fence).
> 
> [...]

Here is the summary with links:
  - [v4,1/4] riscv: Add ISA extension parsing for Svvptc
    https://git.kernel.org/riscv/c/a6efe33cc594
  - [v4,2/4] dt-bindings: riscv: Add Svvptc ISA extension description
    https://git.kernel.org/riscv/c/d25599b5933f
  - [v4,3/4] riscv: Stop emitting preventive sfence.vma for new vmalloc mappings
    https://git.kernel.org/riscv/c/503638e0babf
  - [v4,4/4] riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc
    https://git.kernel.org/riscv/c/7a21b2e370da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



