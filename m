Return-Path: <linux-kernel+bounces-561978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34464A619A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C27F19C6B47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B12036ED;
	Fri, 14 Mar 2025 18:38:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8E14A0A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977487; cv=none; b=uMRi3kjVj/6sH+AR8gIp4QfhAFtnk1gBHn24sXcXPqFv0f1dGPLreF7Vi3hj/WdWBhxy9LR9G3W16SAkpehoGaxsHK2ObYQBRpuSP6i/gDJ4Yi/O+iNrod5MFaGDPk2YzXytlaYcm6+Y8jnRhswEUZnOOvHsyCRAs5Q9jTP+Zas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977487; c=relaxed/simple;
	bh=GmZpefo1d3CDgwRgakp0qb0rmkXAeE/vN96MhKu4eu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBqGGkkNdP6beimnJhYbs37XEGKglMDxf0ng3oeSH9sjPAFqFASOPChtXzZjGz/GcwjVOG4T/T3IvNXkMHgYFTqkxdxJfUIGZ+Mk6AwEvP4Ey5r9z6QUfr6NQX8xPimtF9c6djUXaLAj6xC9JhEK6F0I7bb+IHqvERJoGg1WkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A66AC4CEE3;
	Fri, 14 Mar 2025 18:38:02 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	sudeep.holla@arm.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	mpe@ellerman.id.au,
	linux-arm-kernel@lists.infradead.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	pierre.gondois@arm.com,
	dietmar.eggemann@arm.com,
	Yicong Yang <yangyicong@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	morten.rasmussen@arm.com,
	msuchanek@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	xuwei5@huawei.com,
	guohanjun@huawei.com,
	sshegde@linux.ibm.com
Subject: Re: [PATCH v12 0/4] Support SMT control on arm64
Date: Fri, 14 Mar 2025 18:37:59 +0000
Message-Id: <174197746840.735682.9575626401918508908.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311075143.61078-1-yangyicong@huawei.com>
References: <20250311075143.61078-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 15:51:39 +0800, Yicong Yang wrote:
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> [...]

Applied to arm64 (for-next/smt-control), thanks!

[1/4] cpu/SMT: Provide a default topology_is_primary_thread()
      https://git.kernel.org/arm64/c/4b455f59945a
[2/4] arch_topology: Support SMT control for OF based system
      https://git.kernel.org/arm64/c/5deb9c789ae4
[3/4] arm64: topology: Support SMT control on ACPI based system
      https://git.kernel.org/arm64/c/e6b18ebfaf63
[4/4] arm64: Kconfig: Enable HOTPLUG_SMT
      https://git.kernel.org/arm64/c/eed4583bcf9a

-- 
Catalin


