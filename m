Return-Path: <linux-kernel+bounces-273962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A994702B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E2F1C2089F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA858ABF;
	Sun,  4 Aug 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEVNVT8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B213AA2E;
	Sun,  4 Aug 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793911; cv=none; b=krhDLbUmlbO8qZ+xxE9krsT1ntufxY4gIJk64QoSRuQpaQRjaY9qE3nzo2QRy86lJ4Ke0kMUagU21/0O45gxn0/A8lz85lTOW9t0FNpq5fKoZHiTqB30LUXkJAUiJbBo0BlwCaC25PpqJQ/iHQUN2+aHm+nRQ4o6U6DzsYbD/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793911; c=relaxed/simple;
	bh=PE3Pv9++oBPBGXCqgqGH5Si2WBcaeZxbHXhQ7WW58AI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QOcP9GxBiSCQ3igxQinjyZKC362QfymRpSDluw5SJTGeBg4LdsMKPkM3Mst570y2yKsaMrojVxoFX6Z+d/AIEsAUjZY8i3AHVsr7pozvbqCUfZ+kgFL0hVefRPdDWY87a5p3aeYx8kx3uisyX+I3zUWgG2u7aDJGNFmoGib+H1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEVNVT8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33280C4AF0D;
	Sun,  4 Aug 2024 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793910;
	bh=PE3Pv9++oBPBGXCqgqGH5Si2WBcaeZxbHXhQ7WW58AI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CEVNVT8eMjdegARr5clzAyT+WUgfH1aZjYWKq2K0+n1B+eWw1Mqq1at/3GpO0zgw7
	 me+Y0ikxUK/tGdrCrxFaysYnP6K60xIci94OS7v1DSDHX6asZRI7E0es9jBtzHu0ha
	 B/ti8mgUoXKrJcQdG86df/CkVr1erUZkC5lY4o0+JX5MjOTkDTKqGao5CS/+hkZSJ3
	 KvQexq7QZuPXPh5fZNL8IA4JLwzHZz+JCdz19Mx7/aMXvWy2M8fQ9cWMm4iWx0D+LM
	 4kcgRe++XAUGM7btc5vh4LYJj9EZYnQxUtv42Wgw2c9h/z8iJzBbxxW2jB8VGZXMm6
	 p7lfF0dNM1Oyw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Jianguo Sun <sunjianguo1@huawei.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240703215905.2031038-1-robh@kernel.org>
References: <20240703215905.2031038-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: hisilicon,hi3798cv200-combphy:
 Convert to DT schema
Message-Id: <172279390783.406109.10208814683830391737.b4-ty@kernel.org>
Date: Sun, 04 Aug 2024 23:21:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Jul 2024 15:59:04 -0600, Rob Herring (Arm) wrote:
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


