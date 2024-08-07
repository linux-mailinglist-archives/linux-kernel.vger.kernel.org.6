Return-Path: <linux-kernel+bounces-278335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1661594AEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D26FB2978C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35813DB92;
	Wed,  7 Aug 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P12bbU/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF326BB4B;
	Wed,  7 Aug 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051612; cv=none; b=QH3FgOZT0yefPVZFfgLfuaBSa3YULMEAnbMhO7qS0FWeoGrwRsaGUFmrDOQ31PtwsiwE9vPIls/1vZe0KoKtDNOlAjRIduuoBpTwe+agv1/BdUZOYGDmZ8h68rQjDh+RjZIBUal1oQHDu6zP9cmVT0yUqTmBpq+4RJLdiYspDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051612; c=relaxed/simple;
	bh=Tnz9XK8+vxjn2lCOykMbu7fqnmKrX2LwPkHP6xxlzeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHPvzOi0Nh4CHGtVxzCYfu7r3YMCjb0dDv/N/1MNtkDVAZ81+VCDiu93J9dj1GNSk1fzMcSAV184X5wZyZUX2baYXUl6prZSNwPlcZsV+EZ+Qh/nq25hW4IEbcnpgoZy0fx1+pOlCbVPHSaohQyE0WCahFaAUZVYvSETLhvtjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P12bbU/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23311C4AF0F;
	Wed,  7 Aug 2024 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723051611;
	bh=Tnz9XK8+vxjn2lCOykMbu7fqnmKrX2LwPkHP6xxlzeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P12bbU/a2cf98ZoKxVFgTE8fXqxfApQZNXSzLMeZV20GGpsEOD3IRqor6zpOr22qB
	 BDGrTyXEeudj1IITzXEvO7kbwQDgjTI+Rez9oaT4U1lX+wgz2x4k04vRCuUHVPWXq/
	 Lco88MhQAE4XDhuQ7EG4fpvnKC22YHw1ZbMhs3fPTPNS+Z8vUpsT3e5j0pcOS3d4nJ
	 XBOYnTt0joDjt8iuesQabYy0kHruvPTDWdwVge3PNMVq8t4rC3g5ybTkAPVRcxgBgK
	 d4erbbvxiEjY9CkoOZlM7/ymIrqEiJbJO9chIffB45cwA7qJCQHlWrfGXK0SM4WWXJ
	 Ki2DTUtoBStHQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: invert Misc RISC-V SoC Support's pattern
Date: Wed,  7 Aug 2024 18:26:41 +0100
Message-ID: <20240807-overstate-diocese-e62698933f6b@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806-riding-spinach-8cae90d6e05f@spud>
References: <20240806-riding-spinach-8cae90d6e05f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=585; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=AxQjwlIcLsD4qYeMY4FeoDkbPU2GEXtOPNJVXagIvnE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmb1wXN2MJ1pqTW8tueZa4NS0wnenwOeVMVP3ONts2p7 X8dyjbv6ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBE9HMYGY5YbpPyXjXDtmz9 +UdHq1dNvb/I57DQk4ACD5PMKRrnp8UyMvRI+OrYqp45+LloyXHFpDvRUbtsuOQ0C1028zznvdr 3lxEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 06 Aug 2024 18:36:21 +0100, Conor Dooley wrote:
> There are now more directories that someone else maintains than ones I
> do, so invert the pattern to cover included, rather than included
> directories. Ditto for the bindings directory - there's more files there
> that are the responsibility of others than mine (and I get CCed on all
> bindings anyway). Remove it from the entry.
> 
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] MAINTAINERS: invert Misc RISC-V SoC Support's pattern
      https://git.kernel.org/conor/c/7d9d88890f04

Thanks,
Conor.

