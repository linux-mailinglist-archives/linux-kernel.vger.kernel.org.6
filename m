Return-Path: <linux-kernel+bounces-355258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58A994F46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B836B2289D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1351DF251;
	Tue,  8 Oct 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNI15Fnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E251DDA36;
	Tue,  8 Oct 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393517; cv=none; b=Y1qAP0UAAZXULPjJflls0ooTm+kg+ie94tLLXGuLyU9n6CW4oUZ5aRE1VhtScSLnO5gfFF+rzC1eew/zVAp7MXW7OC8VMKwpiHM79A5BtegZQ8SjGlt1tUWnsu30vX4vNMUeJYiyz2Ls22lCQgGV0AlpkzNakkbLmpHGvgmgdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393517; c=relaxed/simple;
	bh=KRJOQCpZwQ2KBAaUleuRsxQ55xjbD5SiqcjwdInXYzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V5T2IXyVJyQc8RVDCP18BxrTaSj0JSHv6ZLeH/gaTQA8n6bss3xnv/5VOsa3SRITi+dZYgK1uTCdQch8tAWOMEmcZ4u+PVcPHctFrAbT9Ew7N3+OAIylh2IC1gOUJ+BXP2Q8S98IppWIY8a/h0iM1TLtBml/yB4AxJ8btPwGPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNI15Fnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF99C4CEC7;
	Tue,  8 Oct 2024 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393517;
	bh=KRJOQCpZwQ2KBAaUleuRsxQ55xjbD5SiqcjwdInXYzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iNI15FnmDSNyxJsMrBRlvC4ApmF4JACIYKUrV1Po8O5dmjK0Wl6CyCceVZrKXmPqM
	 qyz5yGlaAaes7CadRzSfEjGuW0pkTx7VIJZmYafErb+mvFDtsNaK3b4+wEMi+8q2KA
	 ExZJ6YNYbVw8lwhQ12nm7aW2unTAF1a3wRnizBgzSgPzrvJncJjqhHpomFVLDTPJjU
	 dNk5mZMB4R1uLYmliGDxmgfSfAXAafAP1f/5q7hxQW8gn+C474xRHkF5O0wjMKZj/B
	 JD5Ij+zzaJDdzriPcRvUBBnCk+9pj4MUmi7K6i1HBkjvkKrOfqu8omePzqhj3v9ZEC
	 RMMPGobPJqshQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240930210424.1994047-1-heiko@sntech.de>
References: <20240930210424.1994047-1-heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: regulator: vctrl-regulator: convert to
 YAML
Message-Id: <172839351446.2616938.17294930287167278852.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 14:18:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 30 Sep 2024 23:04:24 +0200, Heiko Stuebner wrote:
> Convert the vctrl-regulator bindings to DT schema.
> This resolves a dtbs check warning for the rk3399-gru devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: vctrl-regulator: convert to YAML
      commit: 4e9a2c91bff44336157eefd8d80b8ceb27918737

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


