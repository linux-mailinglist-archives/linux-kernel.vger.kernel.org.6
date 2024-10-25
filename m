Return-Path: <linux-kernel+bounces-381130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A69AFAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C022819B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904671B395C;
	Fri, 25 Oct 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FdGmyRls"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A91B0F14;
	Fri, 25 Oct 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840422; cv=none; b=PJMSh2cUPj9r+X4aSu0QqwqargCapW9FzTHCetwpzVCN2d2bOfgo/p6u9bHaIA97FIpn+G4xsfU6qL4lZxxOOEWhMlYHuh/rOLzWQN9D8+i+/f6JL5JZG1NcKClJPM1uFI9BWy/nb5moibtRkvRn6rUKy7FHigyy2bmjPDG3XvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840422; c=relaxed/simple;
	bh=66wl4U8dHexwDZH9db8V7sku1mtSlMAtFd733pdWkfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSSs3cep4L17yE4N/maHEA16KvGdvsg4hljQYJgsluM2Rs1AS424S9baRLAEqkiMXS+SKJrGTlA1/d9T690y3FMGd5QVjKObiW0TvGkUGUvizVvZZZkMxQF3FkWBV2ijr8XHHfKCcKJVUokWhxPoTQ1NQaBsXHkhYB6jsoj3Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FdGmyRls; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NcMRAOCK2WdIg5eVULd5UeSBvZGYvkp3Bs5YKreB5s0=; b=FdGmyRlszw5UhNsOeqouMDJBWj
	k1kNRVYt+wnr4wIcexFGODDqetbNt+f56V5Gelvvm1oN2RfHLCXx2cEuCz+Jm2d37cwdPqDoK6uk1
	qnODeaOu15f0y48jlbILrTOoPTOs5ge7kUratd6JaV/XKG/KmfhJEy1JLReWsiiuVYc4kkTfsOf6H
	7WirQnCYCJvRWGvUPwmnuZXjkGvIwUH8q837kq/e+NUgZrkgRwjcFHUSI2VEGNUsTtqhQMCpoQTmk
	38ekRsuZc2ehEaL2woG0ufWnStMgre0CJlbw50/lpIdIgwJBj62lbhaeZcLcAVSXQDWh9l9cZkxeQ
	abTmrDwQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t4EVs-0002dv-01; Fri, 25 Oct 2024 09:13:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] HDMI Support for Theobroma/Cherry rk3588 boards
Date: Fri, 25 Oct 2024 09:13:33 +0200
Message-ID: <172984040933.1798677.14981981601141945936.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024151403.1748554-1-heiko@sntech.de>
References: <20241024151403.1748554-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 17:14:00 +0200, Heiko Stuebner wrote:
> This adds HDMI support for the Tiger and Jaguar boards.
> 
> Heiko Stuebner (3):
>   arm64: dts: rockchip: add HDMI pinctrl to rk3588-tiger SoM
>   arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
>   arm64: dts: rockchip: add HDMI support to rk3588-jaguar
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: add HDMI pinctrl to rk3588-tiger SoM
      commit: 16997a4aed061a369c51c698973ca6382cef3357
[2/3] arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
      commit: 913eeb75a9aa6552a54befad18880b08c1ecd8bc
[3/3] arm64: dts: rockchip: add HDMI support to rk3588-jaguar
      commit: 3cf1add5adf67641d7b0b85310819511f8fe6556

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

