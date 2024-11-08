Return-Path: <linux-kernel+bounces-402031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AEC9C226F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E171C23423
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8711990C5;
	Fri,  8 Nov 2024 16:49:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EC208C4;
	Fri,  8 Nov 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084582; cv=none; b=WeIOTRClIB0dlJ35tbSQUY0jU6Llxa8+99Hx+rcXPPYFbNWFVXuYxGvhFDpTFuEog16KSI6MWZWx/KInJ2Si6Wb2VM0TDdiawoFKRHg61GPUZOu0TaVOeedGNRIArBEu6pBSUdg6MOzCdwr3O781M9xmYPmx69u+ibAiEa5Mtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084582; c=relaxed/simple;
	bh=/oe65rcHVkbyM7aAb65bqPnnYJwjRCH4vs1rkGed3Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wfj4HTmyd3O3s+Hg9c/gnhuEs2cX9i/PMEhLWlD510KoxlxoeOK5SDHB1nAcNVPtYhw8SFCc9E/yLmbM9WSsUCL0AgE6JuLgPoGcB2azsaAG1e7KstkxdAQ+jESrRN7FNzZoC5zSA/PJUH3y94P5zjXXiClW0of9XaVEKmX5u1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74B9C4CECF;
	Fri,  8 Nov 2024 16:49:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Fu Wei <fu.wei@linaro.org>,
	Aleksandr Mishin <amishin@t-argos.ru>
Cc: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()
Date: Fri,  8 Nov 2024 16:49:37 +0000
Message-Id: <173108456808.1559945.7267714266798748439.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240827101239.22020-1-amishin@t-argos.ru>
References: <20240827101239.22020-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 13:12:39 +0300, Aleksandr Mishin wrote:
> In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
> will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
> because do{} block will be executed even if 'i == 0'.
> 
> Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()
      https://git.kernel.org/arm64/c/1a9de2f6fda6

-- 
Catalin


