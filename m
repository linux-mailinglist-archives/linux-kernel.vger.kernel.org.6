Return-Path: <linux-kernel+bounces-244725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEA92A888
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCA1F217C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2051494C9;
	Mon,  8 Jul 2024 17:58:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697C1487ED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461490; cv=none; b=r42N4ZSm5mPZFzo6f3GaTLf/AIe9h2QEEIMns0h0ljPMjr4HAdAJTB6tE0uHQoxyv1C7/SMp3RhtQixNhrvX2Mt5PuLp7D7AzbaWSlRmlc4g24Y65MYDQ17S9NbZhoPjXseqe7j5Er8K++sZ80Z2oehNF55xPUWR7+R9uo2K2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461490; c=relaxed/simple;
	bh=7ayyb6iLuqTVH0ycXriEz+hqf4Zn3ShRmqzhDUHwA8c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMa7KLvGy2iwcPUNBBtX7ZjEHR7qS7CqVPtyL6OlBJHdgRM2sXLcveUdsyCxKUgs5wEI92PzebNRABAP03lC5bzgrRSnq8hKVgaWHManhcYZr2U9ExktoTlh44s8yoJsnoh2fHNNCE0zC+bMSBzci1tymBORwNojZZhL3MwbtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC84C116B1;
	Mon,  8 Jul 2024 17:58:07 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	dianders@chromium.org,
	swboyd@chromium.org,
	sumit.garg@linaro.org,
	frederic@kernel.org,
	scott@os.amperecomputing.com,
	misono.tomohiro@fujitsu.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH RESEND v2] arm64: smp: Fix missing IPI statistics
Date: Mon,  8 Jul 2024 18:58:04 +0100
Message-Id: <172046148193.2416893.14063402610800960595.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620063600.573559-1-ruanjinjie@huawei.com>
References: <20240620063600.573559-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 14:36:00 +0800, Jinjie Ruan wrote:
> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
> is missing in display.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: smp: Fix missing IPI statistics
      https://git.kernel.org/arm64/c/916b93f4e865

-- 
Catalin


