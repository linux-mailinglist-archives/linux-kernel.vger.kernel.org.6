Return-Path: <linux-kernel+bounces-218328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBB90BCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72991C22B57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641CC1991B4;
	Mon, 17 Jun 2024 21:14:58 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF718C356;
	Mon, 17 Jun 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658898; cv=none; b=afkj/RQGNS+W1kGxS9QEcbPwzuZdG2fuQ2eA67CxUrgOwFZnYr6hMEPXoVRi6qaxrOo262f6gzM5g5uvuuEL4qpBtatXS4mfuFFckKK+GZK/4DfAJ6srRavOS3Bfqg9msGH05hupJ7jVIV2f/yhLFVzD6lnM7BwzLV6kTxU4z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658898; c=relaxed/simple;
	bh=MELOaPtDAOy6mc+UepGBrZcq0PN3lBP/YyyqzLQ1Ifo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwRpudR/WS6FHLef1ja0vVvTc5c1j6K/J1jPSAJmyKHWGCtOw+99issbeWw8MEN0iwG3uyCgaMeZbYvDC7K6tOD8wU5YxhDFcmJLIpVOw4yDMzFUsKE+VLMmyeACED96VnmjnCpLMuHJlCwhUL0CpwUi08majBizVoKZnfPC8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJJgi-0004LG-SS; Mon, 17 Jun 2024 23:14:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
Date: Mon, 17 Jun 2024 23:14:50 +0200
Message-Id: <171865888527.3904644.13065331422044570412.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8b229dcc-94e4-4bbc-9efc-9d5ddd694532@gmail.com>
References: <8b229dcc-94e4-4bbc-9efc-9d5ddd694532@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 20:08:10 +0200, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property,
> so add them to the 'hdmi' node for 'rk3066a.dtsi'.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
      commit: cca46f811d0000c1522a5e18ea48c27a15e45c05

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

