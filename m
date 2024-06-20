Return-Path: <linux-kernel+bounces-223490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD69113E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8CF1F2307B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA9F76041;
	Thu, 20 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIGjPa+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C97350E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917025; cv=none; b=KJ40rGsqwp8u0lrvq4keMzHbzF69MbnqxWa40l80Cf6oHduF9qqK9YvzHO4BQWi03GVgP3Qv/39lt15kJpHUyjI6b8BtGxRPfXvHhVK9zgwmQ73xG6iZrcK+GPH0qVaC6NO60l0E9AHQ0pkxY4uQYvPhp+E6C204JgoEg+r0YIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917025; c=relaxed/simple;
	bh=61970RAlg6536yooZm/sut+UKr5m7zVKXgJ3Po2xet8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JovfzDOtmJXkxGXZTEcEeQHNU2uWAhRTJIVqgsCT3IkOnate3FGn0a2Ha1cr8yE9MYZtKWdzs7kQtTesNPr+1f6ZkyGR37JQ+uEasOUo0BeVAh5MsluPpW/cawGODVOa4AQvQ5HthQr1bp9+g0JqxjKdKxgLeCzyYSMccZXvMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIGjPa+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27AFC2BD10;
	Thu, 20 Jun 2024 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718917024;
	bh=61970RAlg6536yooZm/sut+UKr5m7zVKXgJ3Po2xet8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIGjPa+gahKHjEVtrjVVPIx16brXZDVHe3bnjxsQghK1aYxo6fHDMlttAu9dD68gg
	 M6fp7pCgSMoWVlwBDM3CfFoYqf6FuOWK3M5hL3fHCznUfCZw/7lwBHiMd/bX4zCa8Y
	 gie2Fvma5OuKm89cgbWqL3lV6pz7q3PCKKIIl3ErfhLVaRwCG1CF0TqoIuBpQUqpRq
	 4DO0qQD/SZpM4TFHOXcCk2Ybc7AGwenIkSkAmv0YWdHYAUp/LQQ3QDi9VkHO38S2gD
	 T0Oy18B+2rKAr/OZ4pS7qkHdY3GcwEgKNyBW2UPpM4wp2P8aTNKz2LMfpzC/6eMzW+
	 tSRcF+ciy6nQg==
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: thead: update Maintainer
Date: Thu, 20 Jun 2024 21:53:53 +0100
Message-ID: <20240620-lantern-donut-2c125623bec0@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620162522.386-1-jszhang@kernel.org>
References: <20240620162522.386-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=493; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gWK+cfdVE5NjGcH4pttNJSDDLEdRobXFDv/rzY3plrU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkl0x5EHbi317P7gtDhujWS5VZqkRlh1xh12yxM7radu FXYmbe5o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNZ5MXwv+Rvw8z/R9lFQkMc cmP5Oj4U3vwqzevquEJ+QlXRHLFLlYwMG8wuqp9XWVpi4PpIRNbj+Z++pa8XX7KeaW9davDdI1K ZEQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 21 Jun 2024 00:25:22 +0800, Jisheng Zhang wrote:
> Due to personal reasons, I can't maintain T-Head SoCs any more. At the
> same time, I would nominate Drew Fustini as Maintainer. Drew contributed
> the sdhci support of TH1520 in the past, and is working on the clk
> parts. I believe he will look after T-Head SoCs.

Applied to riscv-dt-fixes, thanks!

[1/1] MAINTAINERS: thead: update Maintainer
      https://git.kernel.org/conor/c/e21de658f8e8

I'll include this in whatever material I send Arnd tomorrow.

As we discussed on IRC Drew, can you send a patch adding whatever tree
you're going to use to the MAINTAINERS entry? You should also mail
Stephen and get it added to linux-next once that is done.

Thanks Jisheng, I hope the new job is going well for you :)

Conor.

