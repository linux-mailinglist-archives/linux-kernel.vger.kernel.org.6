Return-Path: <linux-kernel+bounces-336630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26FE983D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8135BB22DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF738126BE1;
	Tue, 24 Sep 2024 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI+Szlgz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4784DF5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160030; cv=none; b=LNmNEdeLmj3qgyJb3z2JOEWrrqsXP0ZPrFg2Yn2jmirlOLmQ3PlJgeKqKwV+n3KhRgLePQGnosxqMOlmsE6Aho/qVpjT9kusF4ToXUXFH56XyrYLNcUYODSbRvSe5CuOq/mRzf/ac2QLuYkCQrRtSBMIfdJsKNFsn+xSYXHlCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160030; c=relaxed/simple;
	bh=Jl0Mt0aDs2vMiWJwF95xu8Ry73OLNmqAOMUD+I7vhmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AvyIqS8zfKwiCxAf6sfqR2oZPxiX1YmTT3fabIb42deIzqjy/JUr9t6RCNZURFvKQPImxt9Uns70j+qMtKhOM7DhhKCzPiqp9IYzAZLcr5WBOchBwU3+ium9Jm66puuDU7i9VlHr/RsMb0P+oZN5/KhEUxUxe9PF6N97ZXmwVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI+Szlgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64CCC4CEC4;
	Tue, 24 Sep 2024 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727160029;
	bh=Jl0Mt0aDs2vMiWJwF95xu8Ry73OLNmqAOMUD+I7vhmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MI+Szlgz5jGSBRGQc5JtCRrAYU5gDXMlVkKqs5i7/V5h8SEa9AOUu69soxICRpdjX
	 gpEXLOlF7Z8WbFqYEmhV86ElEhOZq0XqiD8xzH5a6Nhmelu6Se11lfL8PNaRkH1lXe
	 5+cdygAXF/Ji9D4rm0dpduMm7kGLpzBbUBYiHnhV5PJL7mmm6AIQCoMMiGO82aETt+
	 /s1uEw9WpimKNg5fVaKWFd+Nd9duDjLAz2ljZZPGoy0f16YbrtmN3cYeDgQ2ID2ZOw
	 Bvsq6xAYLSnwoX6vPIoAL0mpgybCFqOy/2elW1JVR9sVd59uJ5QABbpywIN+3pQnFu
	 WV74Y0/Cy4Ibw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B393806655;
	Tue, 24 Sep 2024 06:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] perf/riscv-sbi: Add platform specific firmware event
 handling
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172716003175.3899939.6074882511014223752.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 06:40:31 +0000
References: <20240812051109.6496-1-mchitale@ventanamicro.com>
In-Reply-To: <20240812051109.6496-1-mchitale@ventanamicro.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
 mark.rutland@arm.com, ajones@ventanamicro.com, conor.dooley@microchip.com,
 alexghiti@rivosinc.com, samuel.holland@sifive.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 12 Aug 2024 05:11:09 +0000 you wrote:
> The SBI v2.0 specification pointed to by the link below reserves the
> event code 0xffff for platform specific firmware events. Update the driver
> to be able to parse and program such events. The platform specific
> firmware events must now be specified in the perf command as below:
> perf stat -e rCxxx ...
> where bits[63:62] = 0x3 of the event config indicate a platform specific
> firmware event and xxx indicate the actual event code which is passed
> as the event data.
> 
> [...]

Here is the summary with links:
  - [v1] perf/riscv-sbi: Add platform specific firmware event handling
    https://git.kernel.org/riscv/c/f0c9363db2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



