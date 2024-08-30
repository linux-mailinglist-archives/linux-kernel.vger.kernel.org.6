Return-Path: <linux-kernel+bounces-308327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BDB965A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE21F26B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2616D31B;
	Fri, 30 Aug 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwH4SoDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84116C84C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006689; cv=none; b=VRou+9AZ1tkA8V/V7Ofh27QQuMkMf4SxsbPFTCiQhqQ7uCi+CkXtHF+59MClMU8ULq2q0xOZPVR8C0W1ZRX7ngEydjE5GB2yXIIZnfdWJn87Vm1Yl39whospmJZbhepstH7lOKx9Jox3EWIS6khSWWZ5xRXPx8SJcALxgKz+WO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006689; c=relaxed/simple;
	bh=Tnq4wWgwTw7MUy7MGumhkEeX3ex9ubX0/kYwuaE2elY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=in6TVLxPY0uE6otPFMnFAGh/qEAyKcHTCVlsdb4JakN8E1uhnevJi16FDiRg+Hqlulaw81uhss2B+rPzaQRx5gs3VxtldrpLkyDdIP3AEBsxUIBg+ctcxNsKM5SLBaSZsp3V7ISzPbN+KQ1dRAA9NYyy8sZZo4N39SYcdOFnK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwH4SoDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B06C4CEC2;
	Fri, 30 Aug 2024 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725006688;
	bh=Tnq4wWgwTw7MUy7MGumhkEeX3ex9ubX0/kYwuaE2elY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iwH4SoDWkFW6xstJoJgqfBV0983FRwl07sswSiXIX+cQmH+a9YdiFP0dI8sWYYQz1
	 BuqPo1mqA1lQ4pKRqf5uGrwtwHkYT47VKc+kanbNQIc2OJACsdLUTq39ENjcKBJuss
	 ATdmGzbJ9kbPK35fQz/rTQ/vNScXtyQNQT8POVArLhgP9uTYIJMPwxTod67Cwn+gsC
	 Mfb0DxCzNy86LEfxRqPsA2KQVHuy3jpYwM8X/ufACndMdb8sY4WvO5ZO4nQ/zSkY9h
	 JWcrGTEv9gV2Pk3PnOYq652bcS7LPqEI0++H4D6KdR11AFC5VlEw4a5Qa7c/aVQs+n
	 hd8Uecj+JcDWA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
References: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 0/2] mfd: intel-lpss: New LPSS PCI IDs
Message-Id: <172500668760.99474.16961346329822248125.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 09:31:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 29 Aug 2024 12:57:17 +0300, Ilpo Järvinen wrote:
> Here are a few LPSS PCI IDs for new platforms. The Arrow Lake-H one was
> sent already in the previous cycle but it might have fallen through the
> crack so resending it here.
> 
> Ilpo Järvinen (2):
>   mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
>   mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs
> 
> [...]

Applied, thanks!

[1/2] mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
      commit: f159b7c4dba9693c86a91fe18ddc3266fb337f97
[2/2] mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs
      commit: 07412bf7bf8a209e9541d115abe06ad15632cb2c

--
Lee Jones [李琼斯]


