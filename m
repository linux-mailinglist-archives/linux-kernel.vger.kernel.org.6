Return-Path: <linux-kernel+bounces-266403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73293FF68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767928473E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0E194154;
	Mon, 29 Jul 2024 20:21:23 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C7194124;
	Mon, 29 Jul 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284482; cv=none; b=afaUUGKO3Ms1SJJuXAmf7F0o2qJ4E2uyaDSivCAMSQVKVF+VJWUsx0CI5c6tlLTbAGAOS3GuImMD3zSKJqzEtrnaqaSah3wQrN/Zz+3Ugnkc+PDaB861mFviq13to1nS4XxZhTqVapsa/Tlf9Pg5esGnszT87dA4ODkr+NQLdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284482; c=relaxed/simple;
	bh=hO4groDzkhW+lZyyUil/PGS03d2zRmSpJDbeYFDKaS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9q03jMmghtxNPhxjgiSf84J7Pg4cC+HxFypEfEV530Z24/wrKrjoY5kgJiQZwXi4PBjc5yU1e5TQqgpqEEikliyIT/ZNmSKx7iTHtwJcdi0oGlboKQPaaYg9f+gtE4OiJ7ASOOkaFVNmyqoMx54uXiOK9u+pnRZ9dQmXS3frdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYWrn-0007Xp-Ut; Mon, 29 Jul 2024 22:21:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Christopher Obbard <chris.obbard@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Collabora Kernel Mailing List <kernel@collabora.com>,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/3] Add support for Firefly Core-PX30-JD4 SoM & baseboard
Date: Mon, 29 Jul 2024 22:21:01 +0200
Message-Id: <172228429362.2312452.6948912348651428897.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 09:40:23 +0100, Christopher Obbard wrote:
> This adds support for the PX30-based Core-PX30-JD4 system-on-module from
> Firefly and includes support for the SoM in combination with the
> Firefly MB-JD4-PX30 baseboard.
> 

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: Add Firefly Core-PX30-JD4 on baseboard
      commit: 0406da35b4967e3e40036495627b76a48db51113
[2/3] arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
      commit: a32b1a46502ee5748ec54268209ed539ebf675a4
[3/3] arm64: dts: rockchip: add Firefly JD4 baseboard with Core-PX30-JD4 SoM
      commit: 710a568b6ab83742c31507c96201e2cf6652562d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

