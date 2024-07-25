Return-Path: <linux-kernel+bounces-261883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A274E93BD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181DDB21941
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7C171E69;
	Thu, 25 Jul 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzksCpuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153C2746C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893841; cv=none; b=M0Q1zOxuJuiqw7+9r6StecOcUO3zqtlpedim7hEDgcPOpmDsT2EyOKKbh55p9ApJ2Q9XzRQaPRm+56opVjHctRgjEBbB2pB0M2Uq/nKEBhqH27aS+Reou1kHyXUZULTRXF/cNwqNW6mvv0rpfw+pBHgGRklpjk8QDxWPlRdA1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893841; c=relaxed/simple;
	bh=u7UE1luUcIiiCdthGpXJeT1sBaHmsNt8cCi8bPyijUA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qxf9lBrF+gIeKnTwMGMTzu8xK3SBf81AXJjNw9tcqd9WX9zHaKZsAJuynJu9br2MS1xcACiyBV3n6pkL3XENXYcsCeRG6LZXgP8HfvDA6IigGHfZLLO1EnX9TmpFJQWCGx02T+RZhamalqcl8cysc0KUsMCaM2L8z55wzIeJtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzksCpuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB0C116B1;
	Thu, 25 Jul 2024 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721893841;
	bh=u7UE1luUcIiiCdthGpXJeT1sBaHmsNt8cCi8bPyijUA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FzksCpuVshp8PjzNoSbGxFmNkc9kRIUDPZ1vIn8AhwSXjHozNV2STsSDKtk1mAb0g
	 AHoOm6RI0lWcOeLOiNrHHm09wWH1OtDN7ydaCvIU2it/o0XSuXSdvPH8AffZ8JSfmu
	 jnNpVySU/0AYcQEU4FKq3uZIyWtP4DmM0Tde5uu2mtht7iJOs0BoQsd5ZaTm/qYP2z
	 4uSUBuwUfi/IhG1YfrOZ01yiOqv2MNMQNrOxb8xV2KiWCnZdAxHh6x3eHhrX9XDWYP
	 8zragP0izeadLis5etSozk1fva1MUfcez+ADfcQbPvVcQSxVRpdjuxMoVuQhYIHWzO
	 jJq05RcISculA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240707114823.9175-2-krzysztof.kozlowski@linaro.org>
References: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
 <20240707114823.9175-2-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 2/2] mfd: syscon: Simplify with cleanup.h
Message-Id: <172189383955.837660.943433218904558392.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 08:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 07 Jul 2024 13:48:23 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
> 
> 

Applied, thanks!

[2/2] mfd: syscon: Simplify with cleanup.h
      commit: c80c7dfec9d8514f1fcc34402124026e59d2e2cb

--
Lee Jones [李琼斯]


