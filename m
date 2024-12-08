Return-Path: <linux-kernel+bounces-436508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D69E86E5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF213281801
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B3189B83;
	Sun,  8 Dec 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB6UnM31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97C1865E5;
	Sun,  8 Dec 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677404; cv=none; b=a88fI5H2Xl+SG6fiTGM5+XI7oF4OJFi+5ixjliiY1pn6ZOTZe/Z+wkdLv5Ez7eItc2LLE5SVVXGHqBxK/cOOB61in80UTjIy7TjWoY7A3+rKv9hJOweE8PG9qs2PtDW7VZipvVo5dwNLNxIeywfmydHhpuFuUFBt8IVxFFeEe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677404; c=relaxed/simple;
	bh=OQkhVmHg4WqmUgczbEyYtY9bQLY+9YiQA/1vSnNXn7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=odhux6Kgo427v6Fa8/CqR0PwCzfeG3lSwqknRFrYPQ4r1gwO25/FiW0BaQMc0wxVQ2+yjiWVT6Y0RLTRPbfbGyFibePfX/wCHp4Nk4xLyCcAfw4CxzxXyFeoY1bhyx3GrOAgVI6M6D/xz2IyLVcGyNoC9K3F/+v7fGw5Ni00F9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB6UnM31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A28CC4CEDD;
	Sun,  8 Dec 2024 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677403;
	bh=OQkhVmHg4WqmUgczbEyYtY9bQLY+9YiQA/1vSnNXn7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aB6UnM31+8W26tb/TQGEB9kp4chVw7K+fN1hsk2+kyCzCRph0z3e/3+f1viJd0Yog
	 nq3xYt3QDjgDObDUsA3eB/pOO2Zd7wGTVtZ4j8IiHEHbu4frOIWRwkJ1k7PzcRtAbW
	 MvPhglU7ADKMPeavMaFtruBqJ7KGFFiX5eza6vBFn0SfAkxbh8GHc6NjA2JVsm7Xl4
	 5TomGWUT4SdV1xSaCJQaAk0iZuut3ZYu0OshFFQIZaWXiUNOrSYr8pzQ89NAfPjgYv
	 krs18DD4JjQKAP0aJ8JDncaNlaYdLyl82gG5Xgf+EUK1pAZJ4dFdiweRcQpfWMC7oU
	 JQ7Iog2fEsIBw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, heiko@sntech.de, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20241106021357.19782-1-frawang.cn@gmail.com>
References: <20241106021357.19782-1-frawang.cn@gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: phy: rockchip: add rk3576
 compatible
Message-Id: <173367739882.1042266.13564574904755489254.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 06 Nov 2024 10:13:56 +0800, Frank Wang wrote:
> Adds the compatible line to support RK3576 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: rockchip: add rk3576 compatible
      commit: b136e9928dbe5e71474d9e2c8911c4a094e329c2
[2/2] phy: rockchip-naneng-combo: add rk3576 support
      commit: ba8ad7eece66ac5c579dd8de39efc72770e7cf64

Best regards,
-- 
~Vinod



