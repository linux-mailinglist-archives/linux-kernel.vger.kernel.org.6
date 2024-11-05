Return-Path: <linux-kernel+bounces-396810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE19BD288
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2F5281CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333591D9A53;
	Tue,  5 Nov 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPv0yFHk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A201D90A4;
	Tue,  5 Nov 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824691; cv=none; b=jGyXgSZLSmU76gS51TO0OMiMKDEryD/Y0jYeHLZTB7nbZ0Fbt9bmbAtbis6kTgDZzUlgI0I74g5tIP9xcGqcCIDBu9bWlSsjaGcImj9AwWI6G4vN0yDwQyTSq9WADIKAFUr9CSyvnJoKT40TCNskcWWbB9wPUwOA6SSHJe0Jf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824691; c=relaxed/simple;
	bh=L4Pbz261GoCmDClvB0Y4Y96/VFFgp32O3nwSMNTEtlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ewXw30qvq5oXAup7LCFuhS1zICdnoLUhfiO7tEJBngubxxtharVxiv3dIcgPOaSfCBTYeD+zLShnVM+CTFdrVXY8IDCYoiAoqyBjW5d8xfHDihR/bdmEKqXbeyc3z9FVXj9R+MgK7xxXqGVf68LxrMU1423iac90qk4NvI+iE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPv0yFHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC428C4CECF;
	Tue,  5 Nov 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824691;
	bh=L4Pbz261GoCmDClvB0Y4Y96/VFFgp32O3nwSMNTEtlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jPv0yFHkbaIUekifVXCSYte+t2lgAbVN8O2LPai6dm0DZhGF0SVH8cOHLLN/B/PJV
	 7iXvx3ve3WPJbTSvyUhyIPlts8G/YTLj6q5pFDmULcNeNM0CCIai3+qX3AhZaPSlYb
	 IA+ipkybbGTXcwwwRbIl5nvHjTB5PSoCkqgUv/+9KipWOfLYFPRsEaviOn7eU9tshc
	 7hfi8LFkyY9TgXnU/l7fIcsg+M+xUldqVxqayAgtvMxz5s0R0JSqqE4PwUI1GTG8DF
	 TuqvGlNyCZt2WD0tYJRkA+VwtEogBvCciklFsUgr/CtiHcjQpMVrsg2FLb/USmk9s2
	 WOXyWkVzj5M2A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
References: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: sprd,pcm-platform: convert to
 YAML
Message-Id: <173082468863.77847.2522114143831566586.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 30 Oct 2024 18:48:38 +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum DMA plaform bindings to DT schema.
> Adjust filename to match compatible.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: sprd,pcm-platform: convert to YAML
      commit: a80aedeb816c81e86e3a59384f010da3414479dd
[2/2] dt-bindings: sound: sprd,sc9860-mcdt: convert to YAML
      commit: 310558120e5eaf48025c3947fc91b4d02bd90fac

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


