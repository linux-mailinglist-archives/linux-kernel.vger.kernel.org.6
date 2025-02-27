Return-Path: <linux-kernel+bounces-535975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3394BA479ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAA73A4BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70752224249;
	Thu, 27 Feb 2025 10:15:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D606227EAE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651303; cv=none; b=mA2f8FNbWGvzC2rycuRc8ZyvTta2Sz9WQimFoOjJjROKSTCyqjiG6srfGWOpY61lGkewe5WD3o83ULjhUJfgprka8hh+HQsFkY+7+9xZZ5/L6BzFaNx5JPorceRb8gIkgS8KixeTkwHj+3UIaBPE75fTs2nVdLpxs8uhceD3tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651303; c=relaxed/simple;
	bh=IevIaMQCzfsDmg7WOYc0m5DEYfnu5ZmgBReJtOPZ1pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIbPRHx2FoGbDAwGPSUsSRz/5iWkWYCbq8MUpJB0wmBfIU+Hv67Vbua543ZVm6dRJ7KsZoY0mYB2s5/eVPmQbzug+BfnO9KRiqDnXUSOSwDN26bhenBTSH7kHlV6rQ44D+DpYjqTLC9oh5OaLS/m0Yg+Fl7BNtO2up09+FXaKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292AE2BCC;
	Thu, 27 Feb 2025 02:15:16 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FCE23F673;
	Thu, 27 Feb 2025 02:14:59 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Andrei Homescu <ahomescu@google.com>
Subject: Re: [PATCH 1/2] firmware: arm_ffa: Explicitly cast return value from FFA_VERSION before comparison
Date: Thu, 27 Feb 2025 10:14:57 +0000
Message-Id: <174065123542.2364600.7340078100778272878.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095633.506678-1-sudeep.holla@arm.com>
References: <20250221095633.506678-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 09:56:31 +0000, Sudeep Holla wrote:
> The return value ver.a0 is unsigned long type and FFA_RET_NOT_SUPPORTED
> is a negative value.
>
> Since the return value from the firmware can be just 32-bit even on
> 64-bit systems as FFA specification mentions it as int32 error code in
> w0 register, explicitly casting to s32 ensures correct sign interpretation
> when comparing against a signed error code FFA_RET_NOT_SUPPORTED.
>
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/2] firmware: arm_ffa: Explicitly cast return value from FFA_VERSION before comparison
      https://git.kernel.org/sudeep.holla/c/cecf6a504137
[2/2] firmware: arm_ffa: Explicitly cast return value from NOTIFICATION_INFO_GET
      https://git.kernel.org/sudeep.holla/c/3e282f41585c

--
Regards,
Sudeep


