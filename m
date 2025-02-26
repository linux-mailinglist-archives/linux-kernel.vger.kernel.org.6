Return-Path: <linux-kernel+bounces-534919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C3A46CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ADB3AEA55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EF924E4B7;
	Wed, 26 Feb 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij8eWfqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659C239561;
	Wed, 26 Feb 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602896; cv=none; b=QF41ngtaiv3tm1bIjc1RJr3N19OvGX5dfm8G7Qj7XUmoN5D+CEQ1o83FonJCpoPKgN+n0JlRudQCkAXl4l71YdS28BdWJloWCDvSNQyoG8pVuplWAj8Rh32EXtWiJnboXnUSIfvDGnKZry9u3N96I5lWBJSvsQznTlU5yYXwTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602896; c=relaxed/simple;
	bh=sC5RYdaZue37P+C7M9L14ccZIaPy5L1CJK2xQlV1wYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NFYeyO5DFreW90JWkDZPMIaIic2kj619R1KDO//EhkFeShNjy3ex+p937l7RPRpDkBr2QErNfsg0qkgcWK8P47iDncPEo+SRxC9nzIZ25WO7QunVmWqqa2Cr+5Zz3T8KWDMXKzSGENL9/dbN3DoWReWLJ5GSZFu5FdnheUwU8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij8eWfqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E42C4CED6;
	Wed, 26 Feb 2025 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740602895;
	bh=sC5RYdaZue37P+C7M9L14ccZIaPy5L1CJK2xQlV1wYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ij8eWfqsxn/ZkwP5BEGm+7ER5s5vne8hqKZ/jvtuPYOddfFcDhJmn9b1lkdVKUxYB
	 NYXLIdj6P/dmSiwj3WwHEWe+d4yu8/32Ltrz5Pm/RpAAArbd5dur/hZwTqtqskhlZd
	 1xMWa97jQCF57WS9WGynp9IN5/vPGmahuvSwfE9fe0mMBP46mWfMDbyeleGHnOdPph
	 Ibxf70p0cuMNrtf+peGwevVb7k8Ryq9RnwY3q+RUiC8NNpbnXZaTbcU7V2PAZhM6W2
	 VfOjnDX9mAin2lU0RLvHB9+mtMFcuqY4S1FgBVJOPh7eCVKTrf7PmWJa14r1SZWFzz
	 67lz2oDWPD7BQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
References: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v6 0/4] xlnx: dt-bindings: Convert to json-schema
Message-Id: <174060289250.139585.8159041053673503341.b4-ty@kernel.org>
Date: Wed, 26 Feb 2025 20:48:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Feb 2025 12:23:21 +0000, Vincenzo Frascino wrote:
> This series converts the folling Xilinx device tree binding documentation:
>  - xlnx,i2s
>  - xlnx,audio-formatter
>  - xlnx,spdif
> to json-schema.
> 
> To simplify the testing a linux tree rebased on 6.13-rc4 is accessible
> at [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: xlnx,i2s: Convert to json-schema
      commit: a206376b425472c7c3a824f47a9967a4c97ae32c
[2/4] ASoC: dt-bindings: xlnx,audio-formatter: Convert to json-schema
      commit: 1b8b6dd0c91b7db58e344f01781932458ac43da3
[3/4] ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
      commit: 7ed7065dfbbac1b5405a0c8029299847e408cf97
[4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer
      commit: 55a1abd6e76ce91eb6049f32efec3a8506686748

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


