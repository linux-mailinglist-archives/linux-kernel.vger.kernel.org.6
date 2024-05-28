Return-Path: <linux-kernel+bounces-192620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4E8D1FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32B41C22121
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49685171E64;
	Tue, 28 May 2024 15:09:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AD16D9B2;
	Tue, 28 May 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908987; cv=none; b=iy/3Ct1Nxj0WwHbhHI/oyUSmdWBrQuqIQnyUxkLSzJJFpih/+mm6OSwLJ77PL7ybEfA7wPrit9BNjniUqXHnKSzJN+0xBgJhCU0NJlh3ECFh0QNLwoypuWshj56m4+SLN/wqDI+gtwOSB21z0F3CrOZ/s8KxFUlvf1+wQv9EFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908987; c=relaxed/simple;
	bh=hF89F7Sw3hhLiEBF1VvFmHwYVPp9dGnQ78d1Zg1G5HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0p8MIh9Dq/EKldLBl31/sdkvlcof7hDI7jHoyrdCHT52DUgKT+UrE7cQN7iFjzFnKuFP8eJLLPMJNkASko7L/Q5k7phfnA/uohCicz5l6tfp8whSWuN3EynpIFft+UNomFXtQ5mMk7IQiofR+UMqj3Vt55ca5wdnWcJS11TR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBySH-0004pm-Nf; Tue, 28 May 2024 17:09:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add rfkill node for M.2 Key E Bluetooth on Rock 5B
Date: Tue, 28 May 2024 17:09:21 +0200
Message-Id: <171690893337.1899981.1719888862569543396.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517122509.4626-1-alchark@gmail.com>
References: <20240517122509.4626-1-alchark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 16:25:08 +0400, Alexey Charkov wrote:
> By default the BT WAKE signal inside the M.2 key E connector on Radxa
> Rock 5B is driven low, which results in the Bluetooth function being
> disabled even if the inserted M.2 card supports it. Expose this signal
> as an RFKILL device so that it can be enabled by the userspace.
> 
> Tested with an Intel AX210 card, which connects a Bluetooth device over
> the USB 2.0 bus.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add rfkill node for M.2 Key E Bluetooth on Rock 5B
      commit: 1d3ac84d6a960baa50da4163160ae82f8dc74af6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

