Return-Path: <linux-kernel+bounces-556347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6616A5C44D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DFA1731AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6525D907;
	Tue, 11 Mar 2025 14:57:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CED25C709;
	Tue, 11 Mar 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705047; cv=none; b=Jh4ugGfF6di0MwPLhQThcp2TJx4W977KpSwoNgCpz4419WXUaG1hY3fbaOgNrx1hQDu7LYNZHz9jtZB5bjFvoRdWBn4fu3KE/H2XdXMpCgMcjT1yIQmkjQqMap0R6e2YgQxjSOZ1q6FdHTDtBa2MH0QwCRh4nK1K/RyKEwkVFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705047; c=relaxed/simple;
	bh=bwBOwE9sdIu3aQ4sb28P2ojDM7OrEkXtn83M95GZbbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSosG2ikSZeaYo93ntXo0M7hlLIX1xeKa/ZCuE9Zxvx6HB59eJt7UJNmOshT4BFR0NTKhzzYzPqHTBbYdW9yok2whMXMDQnXesICjp34eWhZgY7fk2KfUqQWFdHzI0jFnrPzuhjIY2RSznXpgOvoqnxiZKQIeWZvmWQzGy448R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE202152B;
	Tue, 11 Mar 2025 07:57:35 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 795583F694;
	Tue, 11 Mar 2025 07:57:23 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: coresight@lists.linaro.org,
	James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	yeoreum.yun@arm.com,
	Mike Leach <mike.leach@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Leo Yan <leo.yan@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
Date: Tue, 11 Mar 2025 14:57:11 +0000
Message-ID: <174170501277.145861.13343578930961537547.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210144933.295798-1-james.clark@linaro.org>
References: <20241210144933.295798-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Dec 2024 14:49:28 +0000, James Clark wrote:
> Previously the sink had to be specified, but now it auto selects one by
> default. Including a sink in the examples causes issues when copy
> pasting the command because it might not work if that sink isn't
> present. Remove the sink from all the basic examples and create a new
> section specifically about overriding the default one.
> 
> Make the text a but more concise now that it's in the advanced section,
> and similarly for removing the old kernel advice.
> 
> [...]

Applied, thanks!

[1/1] coresight: docs: Remove target sink from examples
      https://git.kernel.org/coresight/c/4a29fa26

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

