Return-Path: <linux-kernel+bounces-270761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826759444EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F381C228E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDA16D4EF;
	Thu,  1 Aug 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1ZqFtVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041E16D9BE;
	Thu,  1 Aug 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495312; cv=none; b=dysf5g4OpOP/jITvxjJgdnk5H4PJgObK/1R90s0MM1IjdZj4+zJ+PT5BEk729vrzs5cb93+L4aXZ8WDV8192JUwYWWm7FkxBEJoj7pQdDVqETLW0hhMOn8qvLitVqgwnYdEoNdEPvmaVoaP9OdeC4oUrHoHgvaJgL22CD467D2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495312; c=relaxed/simple;
	bh=TbyKm3nbIWiUjuGYa2rN211etWAP2Wd52cytE+uCLAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MXGOMVBiVPjXahYn05xAEslftelOwi2W5SROAKdYW/LjnZstPnryDMKOXiGSnWuFGSE4KMoJyYr+W4O8R/M8dJAtM4QMFsBaMMm9sa/Di0v18LYeAWuLJ8Y1AV790MyeuUali6FKW1PYPgQr4xDaxwM2ykLygJWn9+A98LT/pb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1ZqFtVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B7AC4AF09;
	Thu,  1 Aug 2024 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722495311;
	bh=TbyKm3nbIWiUjuGYa2rN211etWAP2Wd52cytE+uCLAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s1ZqFtVx2Vb5RP9cHC/M9Kz8erKYAabCLo1pCzOBPKHMp7lfiPcwYWPmRM0rS8ykc
	 RRx25RWYeznVJr9UBq4V+H4mCqF28+iNpom/Br0XIQgm88DPEsw58AlRCv1F8MfGne
	 kpLWbQld7FidQTfBDP0tQa4CHLBZ3nCCkOa1Rha9SjgiOONPx8NwXhqPbQ2JMPjuQz
	 fRwVTq4rOndZMzeB0PTE+5ntAmJ9PaA59mCyzB7FNPuINa3TXk5oLY/QmyD4AXGke2
	 sZ4G/+2RTd9DJJJXvgDH/1gGls2HDTftwrXoYYN1kTtEQofTixIH6HnIIrglGxpwlr
	 9QS1PMwi6A4pw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240711152313.2364383-1-robh@kernel.org>
References: <20240711152313.2364383-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: hisilicon,hi3798cv200-combphy:
 Convert to DT schema
Message-Id: <172249530893.256913.16118366660084365289.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 12:25:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 09:23:13 -0600, Rob Herring (Arm) wrote:
> Convert the hisilicon,hi3798cv200-combphy binding to DT schema format.
> 
> Drop the example as arm/hisilicon/controller/hi3798cv200-perictrl.yaml
> already contains an example of this binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert to DT schema
      commit: dd1051f9329880a0749954e601a5ece9a07f8685

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


