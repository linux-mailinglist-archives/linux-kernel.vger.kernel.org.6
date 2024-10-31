Return-Path: <linux-kernel+bounces-390693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D19B7D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4121C209B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBC1A0BFA;
	Thu, 31 Oct 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFZZEVvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AD19F108
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386747; cv=none; b=ErkI7drQu+gUxb4Swh1WhobN8KhugSHITz4zvwYflbZI04LEq+yA45Cms4S7/ndzk6gI4XKRPAy2dyyypcbDnsKVIafq7B9Y5cBZxazjHG3yH1F261grV8Ocx8vICsrHD6GolWUQoSfxWVfMOLC5Y7ph7XUaE3J118Mn6j8ha1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386747; c=relaxed/simple;
	bh=il+vTT1zegPkNKyDOCnKcj8+KV930RuzcPTENmcImlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tPknTchz3zSC8EUnvMMrRQPGTaKQwBDXLAzfjXQ6kqey9gU+SNzQeh8FVDxMn6135vcBo4/8P6wpvLnc0/urn/s2hHfwyp/ZLesHucsvaJxvS5i9ru4CWXqHH2lC9+KB1dUodfymaIFCazJVIXspiV6wtJeHjan0h9b9z7HCONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFZZEVvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C67C4CEFA;
	Thu, 31 Oct 2024 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730386747;
	bh=il+vTT1zegPkNKyDOCnKcj8+KV930RuzcPTENmcImlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jFZZEVvBN8QeUc0pACRZm/R3/7lQ7OQymyPw5470vqCYNlKFpftXyMwVGfaaa59rA
	 hU7cS7DZ83qFPHkqks9rDdCAkEgn8gPhuZz/bf5tGzQUr+HzhPsSpELdhtrefaQkJA
	 pz7guBwWppZIFTBDMqJcqSCPq1NX73QS1SzIH2IuJRqcfpTi4pE6n8OmTK6SulnEi3
	 MaSEVltE7dmr7vVdFOwguptVVLbcvGTFc1SfL8G5HOwyFFWkC0pl6eq9/WYYEusy+E
	 3EPUpu5ssaKgr5d8YkOKbpeImKTohq0KJ4IKfpaUtLECqgTlYGWUGNX9sTvwVedBtz
	 x1wtvubofugzA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>
In-Reply-To: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
References: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] mfd: intel_soc_pmic_bxtwc: A few cleanups
Message-Id: <173038674598.1763751.11067388290170331649.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 14:59:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 16 Oct 2024 13:49:50 +0300, Andy Shevchenko wrote:
> While working on the fixes series against the driver I have noticed some
> places that can be improved using better APIs or approaches. Hence this
> mini-series. The plus statistics is due to the patch 2 that brought
> missed inclusions to the code (instead of using a proxy header).
> 
> Have been tested on Intel Joule device.
> 
> [...]

Applied, thanks!

[1/4] mfd: intel_soc_pmic_bxtwc: Switch to use ATTRIBUTE_GROUPS()
      commit: 1f9e418aafc6ee52aad25b85f1e799f031f8de67
[2/4] mfd: intel_soc_pmic_bxtwc: Don't use "proxy" headers
      commit: d2e77347ce9a4d70165f4e97d6a4133e48e678cc
[3/4] mfd: intel_soc_pmic_bxtwc: Use temporary variable for struct device
      commit: 3d6b7374f0d8b5f8945185e901a6f5e7ae887a16
[4/4] mfd: intel_soc_pmic_bxtwc: Deduplicate error messages
      commit: 4a8b3d48dad2ddbbb150602606c65bef3c2b3f8e

--
Lee Jones [李琼斯]


