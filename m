Return-Path: <linux-kernel+bounces-392637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA39B968A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2505C1F214C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84611CC177;
	Fri,  1 Nov 2024 17:29:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877A1CC158;
	Fri,  1 Nov 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482197; cv=none; b=ndsmbzWaAe2M1w/i94VxznZQR90TFVo+Q0TLy8HupOl/y2npC4QZeod5bPSQdlcIxp/t5kC40ryyQsjFlixH+fz7gjKflIdlXbtZuU8qc4TdAqjIgp7ZcSh8GGrwOLAfvvA7Xp9kJjprEksH68dn62emMkk+EIZ4q+745a5H9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482197; c=relaxed/simple;
	bh=ZqeynNd5HzdyeWU9ozRjYcvqtmaqPbVkPn7jeckelyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=honBi7eouOm1Q30XL/3oY7JLUnAWJEsqq0k7iVrq7oMvB/C5zzKOXFOpaZnh0H/LWCz919VkKPnEcE9oMt0AVqkBrHZS4cj4eRLPpwJqh0H8p4W4NwjA0NF9/QBoMqNz/HnYmtiBbBxn/2bdGs/BhXSphrP3Zc9XQidey8M9rvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA59C4CECD;
	Fri,  1 Nov 2024 17:29:55 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/gcs: Fix outdated ptrace documentation
Date: Fri,  1 Nov 2024 17:29:53 +0000
Message-Id: <173048218530.1104111.323163241768582552.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031-arm64-gcs-doc-disable-v1-1-d7f6ded62046@kernel.org>
References: <20241031-arm64-gcs-doc-disable-v1-1-d7f6ded62046@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 31 Oct 2024 19:21:38 +0000, Mark Brown wrote:
> The ptrace documentation for GCS was written prior to the implementation of
> clone3() when we still blocked enabling of GCS via ptrace. This restriction
> was relaxed as part of implementing clone3() support since we implemented
> support for the GCS not being managed by the kernel but the documentation
> still mentions the restriction. Update the documentation to reflect what
> was merged.
> 
> [...]

Applied to arm64 (for-next/gcs), thanks!

[1/1] arm64/gcs: Fix outdated ptrace documentation
      https://git.kernel.org/arm64/c/1caeda5ef251

-- 
Catalin


