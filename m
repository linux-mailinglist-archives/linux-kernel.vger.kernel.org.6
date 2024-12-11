Return-Path: <linux-kernel+bounces-442264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5089ED9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052052819C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20382010E2;
	Wed, 11 Dec 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJYwZtRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D226201005;
	Wed, 11 Dec 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956358; cv=none; b=oX1mEmB1F58GBXAL02OTRDxLJpscC+hqWd0dzeYTQNS/452Fv11m4cKKu9pzqm0WMBRHi60E9OBNxeXIWJwYMSZ6iltAjMQDJGt3GccF7ubWbqq0P+DST7eixRqhd3ZeWaTTwuNMguI9blI7wU3RC8NC9oKDAuBF671MwH7LYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956358; c=relaxed/simple;
	bh=41951xLtjVXmGjs6Svjr58LJJmKu/NUbbk6BSbginiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGIlSFxlMdlmhPVCVdywQdlIgQhzvjSmmqMnoZWMd4SKN2sdxLzGb+G+r1xkaHRdHB0MFAVrY+jnzo7I1uPdiOw7vUjojGM0UZLteL97IX3JZOY144GcF4ZZyyR7yRtZgTx9cqSKLwSeVPGjnimIP96rxUcL2Ogi6bv0ew1BLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJYwZtRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD067C4CED2;
	Wed, 11 Dec 2024 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956357;
	bh=41951xLtjVXmGjs6Svjr58LJJmKu/NUbbk6BSbginiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJYwZtRkhMAZVKhK4GeGTjZQfxU/bIoqAd933nrUWGIQy7g2FOyZ2+ss3NA8gvqaM
	 +xBzXUPR2stu6pOUU4ev40AG/eDA0nKLsApM13N3nTKmZk0PSn2Dtk1/EszzyQuXUE
	 N826hVKZcNeQwlZi3cnKhP2GOnzBKGO+xdqQJr1urWgOSMuFDWfQKDfAIlCm/AZBim
	 EeZZxSjrgr+yMX5AGjAwKjpYXEuFPjiNdHrVz9+KumR01P9R4JRfNi0YxUNd3AAAKe
	 z4jaQV6YkswJm1lnYHP6e0/PYcYgZ88hRONMy0E+NPBbEqaCm+7FT98xVgR2puKHC+
	 qnGpxa5Tgweqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB31B380A965;
	Wed, 11 Dec 2024 22:32:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/3] riscv: interrupt-controller: Add T-HEAD C900 ACLINT
 SSWI
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637349.1729195.7002523247012795156.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:53 +0000
References: <20241031060859.722258-1-inochiama@gmail.com>
In-Reply-To: <20241031060859.722258-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: linux-riscv@lists.infradead.org, unicorn_wang@outlook.com,
 tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 peterz@infradead.org, inochiama@outlook.com, guoren@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cyy@cyyself.name,
 apatel@ventanamicro.com, hal.feng@starfivetech.com, geert+renesas@glider.be,
 dlan@gentoo.org, looong.bin@gmail.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Thu, 31 Oct 2024 14:08:56 +0800 you wrote:
> New version of T-HEAD C920[1] implement a fully featured ACLINT device
> (This core is used by Sophgo SG2044). This ACLINT device provides a
> SSWI field to support fast S-mode IPI. This SSWI device is like the
> MSWI device in CLINT/ACLINT, but for S-mode.
> 
> Add full support for T-HEAD C900 SSWI device.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
    (no matching commit)
  - [v5,2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
    (no matching commit)
  - [v5,3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
    https://git.kernel.org/riscv/c/6da33567c0bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



