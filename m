Return-Path: <linux-kernel+bounces-279103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C256C94B8FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5221FB223AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51607189516;
	Thu,  8 Aug 2024 08:27:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13281891A0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105661; cv=none; b=fzOdLMAqjlPWoD1cPPyoal4F2+neUM4HwukaoMfZzLrSHCQI2Qv7UHLJB4P0vGysI2efziyG4NbcpnkeuY5vAZvQIF89GRbUeeiwrPGDhGbqNtmUbCS0UETWW65fQ4DTK6+INhk69xbGG12Y132C8RlMX7jODaQSzoOQvqmsg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105661; c=relaxed/simple;
	bh=tZLnC3L/m01JCJl8bknigHDujuIyjyW1Q2n5KI+eLlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJmf4aYCAg20YO6/dcFtuFgqte1uodsLVY4l1DNxczWQVyiP01PtwqQeZXfH6pLzFSYrt7+4fi/PmSFDWxGqLIA0Q6LwD51hySUHvgKviZ8eDDmX/AKRy6GukPCV+/ceBYgavH0t3hjwvcXs5Gl2dlDhEtaAOY7O2KKfCNyNNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sbyUf-0000hn-Me; Thu, 08 Aug 2024 10:27:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: ukleinek@debian.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
Date: Thu,  8 Aug 2024 10:27:29 +0200
Message-Id: <172310560597.3585120.10271517594384072196.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805162052.3345768-1-heiko@sntech.de>
References: <20240805162052.3345768-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 5 Aug 2024 18:20:52 +0200, Heiko Stuebner wrote:
> Contrary to the vendor-kernel the pmu-io-domains are not enabled by
> default. This resulted in the value not being set according to the
> regulator, which in turn made the gmac0 interface that is connected
> to the vccio4 supply inoperable.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
      commit: 40cc4257169712f0ae3835820a4c5afbdd1a16ff

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

