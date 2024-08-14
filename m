Return-Path: <linux-kernel+bounces-286928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2983952084
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5E287133
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85B1BA892;
	Wed, 14 Aug 2024 16:53:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1C1B1409
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654437; cv=none; b=CiVmhzdLbzCWkCuRSj+zSJg8eVeEuQQJtkOY3VyYm5NRzSCd3dGJttF3SHbiI1V6P+ZX99HIr1OIngJG9/c+QHO/AuiGKVKWmh2C9DDQ4eBio5LNL46tzZbdOUuVRbaz211rnzDMQ0QEGYt3wbeZyVPLH7ghYlqr2muimDt/3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654437; c=relaxed/simple;
	bh=lcDVdJwAqvXQdnxQ/89f0wyCsAKNCwJvkrIcgqcBBBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7GEYYDEYXHptcQV15SWfaK/MqADWVYmDk2m2vttIQOTHgTG8gj8p7vDNM84bhb7109i0V25SU612kiSqIe/ZTenhTSDpl09wtJcAuuqKeWoH0byf1N5+cWkA5aTuQZ+8r7AtGaLoTs2gChE1wWr86jPXMojKzQHOT9+IeGiaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A53FC4AF0A;
	Wed, 14 Aug 2024 16:53:54 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>
Cc: Will Deacon <will@kernel.org>,
	xiaobo55x@gmail.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	James Morse <james.morse@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v2 1/2] RISC-V: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
Date: Wed, 14 Aug 2024 17:53:52 +0100
Message-Id: <172365442470.132931.8323822182514148315.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 11:30:23 +0800, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[2/2] arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
      https://git.kernel.org/arm64/c/a21dcf0ea856

-- 
Catalin


