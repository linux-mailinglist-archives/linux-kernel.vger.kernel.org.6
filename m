Return-Path: <linux-kernel+bounces-241401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9146927B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B63B251E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A751F1B29C5;
	Thu,  4 Jul 2024 16:22:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEC16A95F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110140; cv=none; b=KrqZzQGkcAfj5KzKWLht2afXYH0eVnrRPO8iCmFjJ92R3+9Llj8WXKtv5c2olqevu+bKHpDeT3EGdMRDGbeawAeIZIGMmvZlTrHGhlf4KwUT9E2eIzdqCLKXavX9hra+Ym3AcYnqmWEjo5wnbbWZhmTh0nTN0J4MF3fAnBJG3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110140; c=relaxed/simple;
	bh=S/R/Vn7FHeMESAswRH+qidI0quWHkvLGHPhc8ssOsLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCa6AfJNOwSm0NwDLMDki0vKylJlwY4i+yW8jtiKJX7AB4X0e4tDUQ8F109GOQ4dGrx7fCeJmd59190nGXelNJWqFV1LBeIrA8ZlBcKmInNbPPs9SP6IpMJlLNWVfc4gXJiovnOwwRznVp7syfAKarQjBnvE3dI1qPpuWFHKHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFEBC3277B;
	Thu,  4 Jul 2024 16:22:18 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Liu Wei <liuwei09@cestc.cn>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on ARM64
Date: Thu,  4 Jul 2024 17:22:16 +0100
Message-Id: <172011012941.982727.4337603550734525246.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625030504.58025-1-liuwei09@cestc.cn>
References: <20240530015332.7305-1-liuwei09@cestc.cn> <20240625030504.58025-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 11:05:04 +0800, Liu Wei wrote:
> For varying privacy and security reasons, sometimes we would like to
> completely silence the _serial_ console, and only enable it when needed.
> 
> But there are many existing systems that depend on this _serial_ console,
> so add acpi=nospcr to disable console in ACPI SPCR table as default
> _serial_ console.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on ARM64
      https://git.kernel.org/arm64/c/f5a4af3c7527

-- 
Catalin


