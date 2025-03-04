Return-Path: <linux-kernel+bounces-544845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D4A4E5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB538422A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782728D068;
	Tue,  4 Mar 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzp5KeuY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DB28F92D;
	Tue,  4 Mar 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104042; cv=none; b=UkgtUbmcRBzKfnhAk+7ME/pfcsgmQblnp2PyvDq9tkcc/iq1vn5cUlPLUTGZlT3KkQm6ecR5Xod+I9zQS4o7bFnrQ/bZ3vLEq3gKPuezvkzNwLFsyw+xc25mBWf3yxG34V7PB2Farwr8UnBMi06l942ha4W4gKrQPtgEJh5nZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104042; c=relaxed/simple;
	bh=0F2zNAg52IqVf8VARIvWlkAqo4vcQHul7cmg19AhclE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XR/4SOZZpR+3iRHqo6amc/PBSjhhUQG/fTC9UBjUZAH72t/lVYyu5MCJc/s2fnk4YhpuHmPkHROyBdoQbEq9kPM8uKhSXINaHJf7wHI/IexQil2rl2HegN56V72sEI7XVPryg84Yxv/jSGkQPUKEak70B65kKCS8CanrSkp+U74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzp5KeuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE51FC4CEE5;
	Tue,  4 Mar 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741104042;
	bh=0F2zNAg52IqVf8VARIvWlkAqo4vcQHul7cmg19AhclE=;
	h=Date:From:To:Cc:Subject:From;
	b=bzp5KeuYV4jR5I1XA4UVbml33KpNQCjMNlbeJROJh2+od7JQSdh1zA9DR+Ffn5uKx
	 OgX37DrIZF5+cODtLC14rjfYdE8QLvXDCdKeN09W2tSg/LBZ0unHgagjzuaLMBWwHn
	 0rClbRzyriak/seU+F5knLcqqebRpP9KAVEPKiXtqyEy7mTAiEF+wB/xvNn4B7s/cy
	 zXGo15p6jeojPZYPGVt2CKbeNCVFGYNucbzuDNv8MTA/97dAzydMCzqCr+2Mg3F56t
	 liTzxqDotghDnlDcg9itKKMuXPd9nRZQ0yJaVEu2i3j+hdwlQ7kpn7UytaG9IXmxQY
	 U7xSH6sXQ6NIQ==
Date: Tue, 4 Mar 2025 10:00:40 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fix for v6.14, part 2
Message-ID: <20250304160040.GA2690690-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this one DT fix.

Rob


The following changes since commit 038e33fcd40e59b60cdca561c2a39998e6759e08:

  dt-bindings: display: Add powertip,{st7272|hx8238a} as DT Schema description (2025-02-05 12:39:30 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-2

for you to fetch changes up to 75f1f311d883dfaffb98be3c1da208d6ed5d4df9:

  Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'" (2025-02-26 13:39:28 -0600)

----------------------------------------------------------------
Devicetree fix for 6.14, part 2:

- Revert reserved-memory 'alignment' property to use '#address-cells'
  instead of '#size-cells'. What's in use trumps the spec.

----------------------------------------------------------------
Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'"

 drivers/of/of_reserved_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

